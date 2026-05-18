#!/bin/bash
# Refresh the EDS Skill Catalog reference index from the latest adobe/skills repo.
# Runs weekly via GitHub Actions or manually via: ./scripts/refresh-skill-catalog.sh

set -euo pipefail

REPO_URL="https://github.com/adobe/skills.git"
TEMP_DIR=$(mktemp -d)
OUTPUT_FILE="skills/eds-skill-catalog/references/adobe-eds-skill-index.md"
TODAY=$(date +%Y-%m-%d)

echo "Cloning adobe/skills (shallow)..."
git clone --depth 1 --filter=blob:none --sparse "$REPO_URL" "$TEMP_DIR" 2>/dev/null
cd "$TEMP_DIR"
git sparse-checkout set plugins/aem/edge-delivery-services/skills plugins/aem/project-management/skills 2>/dev/null
cd - > /dev/null

echo "Scanning EDS skills..."

EDS_SKILLS_DIR="$TEMP_DIR/plugins/aem/edge-delivery-services/skills"
PM_SKILLS_DIR="$TEMP_DIR/plugins/aem/project-management/skills"

generate_skill_entry() {
    local skill_dir="$1"
    local skill_name=$(basename "$skill_dir")
    local skill_file="$skill_dir/SKILL.md"

    if [ ! -f "$skill_file" ]; then
        return
    fi

    local description=$(grep -m1 "^description:" "$skill_file" | sed 's/^description: *//' | sed 's/^"//' | sed 's/"$//' | cut -c1-120)
    echo "| **$skill_name** | $description |"
}

# Detect local skills directory (works both in CI and locally)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_SKILLS_DIR="$(dirname "$SCRIPT_DIR")/skills"

# Count skills
eds_count=$(find "$EDS_SKILLS_DIR" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
pm_count=$(find "$PM_SKILLS_DIR" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
local_count=$(find "$LOCAL_SKILLS_DIR" -maxdepth 2 -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')

echo "Found $eds_count EDS skills, $pm_count project management skills, $local_count community skills"

# Generate the index
cat > "$OUTPUT_FILE" << 'HEADER'
# Adobe EDS Skill Index

HEADER

cat >> "$OUTPUT_FILE" << EOF
> **last_updated:** $TODAY
> **source:** github.com/adobe/skills (auto-refreshed weekly)
> **total_skills:** $eds_count core EDS + $pm_count project management + $local_count community content ops

---

## Core EDS Development Skills

Official Adobe skills from \`plugins/aem/edge-delivery-services/skills/\`.

| Skill | Description |
|-------|-------------|
EOF

# Generate EDS skill entries
for dir in "$EDS_SKILLS_DIR"/*/; do
    if [ -f "$dir/SKILL.md" ]; then
        generate_skill_entry "$dir" >> "$OUTPUT_FILE"
    fi
done

cat >> "$OUTPUT_FILE" << EOF

---

## Project Management Skills

From \`plugins/aem/project-management/skills/\`.

| Skill | Description |
|-------|-------------|
EOF

# Generate PM skill entries
for dir in "$PM_SKILLS_DIR"/*/; do
    if [ -f "$dir/SKILL.md" ]; then
        generate_skill_entry "$dir" >> "$OUTPUT_FILE"
    fi
done

cat >> "$OUTPUT_FILE" << EOF

---

## Community Content Ops Skills (FocusGTS)

Located in \`plugins/aem/edge-delivery-services-content-ops/skills/\` (pending merge to adobe/skills).

| Skill | Description |
|-------|-------------|
EOF

# Generate community skill entries from local skills directory
for dir in "$LOCAL_SKILLS_DIR"/*/; do
    if [ -f "$dir/SKILL.md" ]; then
        generate_skill_entry "$dir" >> "$OUTPUT_FILE"
    fi
done

cat >> "$OUTPUT_FILE" << 'FOOTER'

---

## Skill Selection Matrix by Project Phase

| Project Phase | Essential Skills | Recommended Skills |
|---------------|-----------------|-------------------|
| **New project setup** | create-site, content-driven-development, content-modeling | block-collection-and-party, docs-search |
| **Active block development** | content-driven-development, building-blocks, testing-blocks | code-review, block-scaffolder, find-test-content |
| **Content migration** | page-import, content-migration | redirect-migration, aem-to-eds-migration |
| **Pre-launch** | go-live-checklist, performance-budget, cwv-optimizer | eds-cicd-pipeline, accessibility-fix, sitemap-audit |
| **Post-launch ops** | content-audit, link-rot-scanner, content-freshness | optel-interpreter, site-health-report, boilerplate-upgrade |
| **SEO/GEO optimization** | geo-rewrite, structured-data, image-seo | heading-optimizer, internal-linking, product-page-seo |
| **Client handover** | handover, author-onboarding | admin, development, authoring |
| **Commerce** | storefront-setup, catalog-audit | product-page-seo, experiment-designer |

---

## How to Install

### Full Adobe Skills Plugin (Recommended)
```json
{
  "plugins": [
    {
      "name": "aem-edge-delivery-services",
      "source": "adobe-skills/plugins/aem/edge-delivery-services"
    }
  ]
}
```

### Content Ops Skills (Community)
```json
{
  "plugins": [
    {
      "name": "aem-eds-content-ops",
      "source": "adobe-skills/plugins/aem/edge-delivery-services-content-ops"
    }
  ]
}
```
FOOTER

# Cleanup
rm -rf "$TEMP_DIR"

echo "Updated $OUTPUT_FILE (last_updated: $TODAY)"

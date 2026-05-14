# EDS Content Ops Skills

Content operations skills for Adobe Edge Delivery Services (EDS / aem.live). Built for AI coding agents — Claude Code, Cursor, GitHub Copilot, and any agent that supports the [agentskills.io](https://agentskills.io) specification.

**The first third-party content-ops skills for the EDS ecosystem.**

## Skills

| Skill | What it does |
|-------|-------------|
| [content-audit](skills/content-audit/) | Audit an EDS page for content quality, SEO, accessibility, performance, and EDS best practices. Produces a prioritized fix list. |
| [geo-rewrite](skills/geo-rewrite/) | Rewrite page content for AI search discoverability (GEO). Optimizes structure, factual density, and metadata for both traditional and AI-powered search. |
| [accessibility-fix](skills/accessibility-fix/) | Scan for WCAG 2.1 AA violations and generate specific fixes at the source document level (Google Docs / Word / da.live). |
| [bulk-metadata](skills/bulk-metadata/) | Audit and update metadata across multiple pages. Scans the query index, finds gaps, and generates a corrected bulk metadata spreadsheet. |
| [content-diff](skills/content-diff/) | Compare two versions of a page (preview vs live, or any two URLs) to see exactly what changed before publishing. |

## Install

### Claude Code

```
/plugin marketplace add focusgts/eds-content-ops-skills
```

### Vercel Skills (npx)

```bash
npx skills add focusgts/eds-content-ops-skills --all
```

### GitHub CLI

```bash
gh extension install ai-ecoverse/gh-upskill
gh upskill focusgts/eds-content-ops-skills --all
```

### Manual

Clone this repo into your project's `.claude/skills/` or `~/.claude/skills/` directory.

## Usage

Once installed, skills activate automatically when you describe a matching task:

- "Audit this EDS page for quality issues" → content-audit
- "Optimize this page for AI search" → geo-rewrite
- "Fix the accessibility issues on this page" → accessibility-fix
- "Check metadata across the site" → bulk-metadata
- "What changed between preview and live?" → content-diff

Or invoke directly: "Use the content-audit skill on https://main--mysite--myorg.aem.live/"

## How These Work

These are instruction files, not executables. When a skill activates, the AI agent loads the SKILL.md file and follows its step-by-step workflow. The agent uses its built-in capabilities (fetching pages, analyzing HTML, reading files) to perform the audit or transformation.

Skills that modify content produce recommendations and implementation instructions — the actual changes are applied by the user in their authoring tool (Google Docs, Word, or da.live) or by a developer in the codebase.

## Compatibility

- Works with any EDS site (document-based authoring or Universal Editor)
- Requires the agent to have web access (for fetching pages)
- No API keys or authentication required for public EDS pages
- For preview/unpublished pages, the agent needs access to `*.aem.page` URLs

## About

Built by [FocusGTS](https://focusgts.com) — Adobe partner specializing in Edge Delivery Services content operations.

## License

Apache-2.0

# Bulk Metadata Skill Test Results

**Target Site:** main--aem-boilerplate--adobe.aem.live
**Date:** 2026-05-14
**Skill Version:** 1.0.0
**Tester:** Claude (automated skill test)

---

## Part 1: Step-by-Step Skill Workflow Execution

### Step 0: Create Todo List

- [x] Fetch and parse the site query index
- [x] Audit metadata completeness for all indexed pages
- [x] Fetch current bulk metadata spreadsheet (if it exists)
- [x] Generate metadata audit report
- [x] Generate corrected bulk metadata spreadsheet
- [x] Generate implementation instructions

**Result:** PASS. The checklist step is straightforward and works as documented.

---

### Step 1: Fetch the Query Index

**URL attempted:** `https://main--aem-boilerplate--adobe.aem.live/query-index.json?limit=1000`
**HTTP status:** 404

**Alternative URLs attempted:**
| URL | Status |
|-----|--------|
| `/query-index.json?limit=1000` | 404 |
| `/query-index.json` (no params) | 404 |
| `/query-index.json?sheet=metadata` | 404 |

**Root cause investigation:** Checked the GitHub repo at `adobe/aem-boilerplate` for a `helix-query.yaml` file. It does not exist. The AEM boilerplate is a starter template and does not ship with a query index configuration. Without `helix-query.yaml`, the AEM Edge Delivery Services infrastructure has nothing to index, so the query-index.json endpoint correctly returns 404.

**How the skill handles this:** The skill's Troubleshooting table (row 1) correctly identifies this scenario: "Site may not have a query index configured" with the solution "Verify the owner, repo, and branch values; check that `helix-query.yaml` exists in the repo." This is accurate and helpful.

**Fallback behavior:** The skill does NOT provide a fallback workflow for when the query index is missing. It assumes the query index is available and all subsequent steps depend on it. To complete this test, I used the sitemap.xml (`/sitemap.xml`, returned 200) to discover pages, which yielded:
- `/` (homepage) -- lastmod 2024-04-18
- `/test-page` -- lastmod 2024-04-16

The `/test-page` URL returns HTTP 404, so it is listed in the sitemap but not actually published.

**Result:** CONDITIONAL PASS. The skill correctly documents the 404 scenario in the troubleshooting table, but has no fallback workflow. When the query index is unavailable, the skill effectively cannot proceed, and the practitioner is left without guidance on what to do next.

---

### Step 2: Audit Metadata Completeness

Since the query index was unavailable, I performed the audit using the sitemap-discovered pages. Only one live page exists (the homepage at `/`).

#### Homepage (`/`) -- Full Meta Tag Audit

| Meta Tag | Value | Assessment |
|----------|-------|------------|
| `<title>` | `Home \| AEM Boilerplate` | Present, 23 chars. Slightly short (ideal 50-60) but acceptable for a homepage. |
| `<meta name="description">` | `Use this template repository as the starting point for new AEM projects.` | Present, 73 chars. Short of ideal (150-160) but functional. |
| `<link rel="canonical">` | `https://main--aem-boilerplate--adobe.aem.live/` | Present and correct. |
| `<meta property="og:title">` | `Home \| AEM Boilerplate` | Present, matches title. |
| `<meta property="og:description">` | `Use this template repository as the starting point for new AEM projects.` | Present, matches description. |
| `<meta property="og:url">` | `https://main--aem-boilerplate--adobe.aem.live/` | Present and correct. |
| `<meta property="og:image">` | Full URL to `/media_180455b...jpg` | Present, returns HTTP 200. Valid. |
| `<meta property="og:image:secure_url">` | Same as og:image | Present. |
| `<meta name="twitter:card">` | `summary_large_image` | Present. |
| `<meta name="twitter:title">` | `Home \| AEM Boilerplate` | Present. |
| `<meta name="twitter:description">` | Matches description | Present. |
| `<meta name="twitter:image">` | Same as og:image | Present. |
| `<meta name="robots">` | Not present | Missing -- no robots directive. |
| JSON-LD structured data | Not present | Missing. |

#### Test Page (`/test-page`)

Returns HTTP 404. The 404 page has:
- `<title>Page not found</title>`
- `<meta property="og:title" content="Page not found">`
- No description, no image, no canonical, no robots.

This page is listed in the sitemap but is not actually published -- it is a stale sitemap entry.

#### Metadata Quality Checks (per skill instructions)

**Title checks:**
| Check | Homepage (`/`) | Result |
|-------|----------------|--------|
| Present? | Yes | PASS |
| Length (50-60 ideal)? | 23 chars | WARN -- under 20-char threshold borderline (23 is above the 20-char flag threshold per the skill, but below ideal) |
| Unique? | Only 1 live page, so yes | PASS |
| Meaningful? | Yes, not auto-generated | PASS |

**Description checks:**
| Check | Homepage (`/`) | Result |
|-------|----------------|--------|
| Present? | Yes | PASS |
| Length (150-160 ideal)? | 73 chars | WARN -- under 50-char floor? No, 73 is above 50. But well below the 150-160 ideal. |
| Unique? | Only 1 live page | PASS |

**Image checks:**
| Check | Homepage (`/`) | Result |
|-------|----------------|--------|
| Present? | Yes | PASS |
| Valid path? | Full URL, returns 200 | PASS |

**Duplicates:** Not applicable with only 1 live page.

**Result:** PASS. The audit criteria in the skill are clear, well-structured, and easy to apply. Each check has defined thresholds. The only note is that the skill instructions say "Flag titles under 20" but the homepage title is 23 characters, which is technically above the flag threshold yet still quite short. The skill could benefit from a "warning zone" concept (e.g., 20-30 chars = warn, <20 = critical).

---

### Step 3: Fetch Current Bulk Metadata

**URL attempted:** `https://main--aem-boilerplate--adobe.aem.live/metadata.json`
**HTTP status:** 404

No bulk metadata spreadsheet exists on this site. The skill correctly states: "If this returns a 404, there is no bulk metadata spreadsheet yet -- note this and proceed."

**Result:** PASS. The skill handles this case explicitly and the instructions are clear.

---

### Step 4: Generate Metadata Report

Following the skill's prescribed format:

#### Site Metadata Overview

| # | Path | Title | Title Len | Title OK? | Description | Desc Len | Desc OK? | Image | Issues |
|---|------|-------|-----------|-----------|-------------|----------|----------|-------|--------|
| 1 | / | Home \| AEM Boilerplate | 23 | Short | Use this template repository... | 73 | Short | /media_180455b...jpg | Description below ideal length |
| 2 | /test-page | (404 -- page not found) | -- | N/A | -- | -- | N/A | -- | Page in sitemap but returns 404 |

#### Summary Statistics

- Total pages discovered: 2 (via sitemap; query index unavailable)
- Live pages: 1 / 2 (50%)
- Pages with title: 1 / 1 (100%)
- Pages with description: 1 / 1 (100%)
- Pages with image: 1 / 1 (100%)
- Duplicate titles found: 0
- Duplicate descriptions found: 0

#### Issues by Severity

- **Critical:** None. The only live page has all required metadata.
- **High:** `/test-page` listed in sitemap returns 404. Stale sitemap entry.
- **Medium:** Homepage description is 73 characters (ideal is 150-160). Homepage title is 23 characters (ideal is 50-60). No `<meta name="robots">` tag on any page.
- **Low:** No JSON-LD structured data (not part of the skill's audit criteria, noted for completeness).

**Result:** PASS. The report format prescribed by the skill is clear and useful. One note: the skill only considers pages from the query index and has no concept of "page in sitemap but actually 404" as an issue category. This is a gap.

---

### Step 5: Generate Bulk Metadata Spreadsheet

Given the audit findings, a recommended bulk metadata spreadsheet for this site:

| URL | Title | Description | Image |
|-----|-------|-------------|-------|
| /** | AEM Boilerplate | Use this template repository as the starting point for new AEM projects. | /media_180455b829a1e29ac2451440ba27ebd9692d285ab.jpg |

This is minimal because the site has only one live page. The skill's guidance to "only include rows that serve a purpose" and "less is more" means a single site-wide default row is appropriate here. The `Robots` and `Template` columns are omitted per the rule "Only include columns that are needed."

**Result:** PASS. The skill's rules for generating the spreadsheet are clear and practical. The principle of "do not add a row for every page" is well-articulated.

---

### Step 6: Generate Implementation Instructions

The skill provides clear step-by-step instructions for both Google Drive and SharePoint workflows. The verification steps are specific and actionable (check `/metadata.json`, inspect meta tags, understand precedence).

I verified the verification step works: fetching `/metadata.json` currently returns 404, which would change to 200 after the user creates and publishes the spreadsheet. This is correct.

**Result:** PASS. Instructions are complete and accurate.

---

## Part 2: Skill Instruction Quality Assessment

### What Works Well

1. **Clear three-level precedence model.** The explanation of page > folder > bulk metadata is concise and accurate. This is the single most important concept for users to understand, and the skill leads with it.

2. **Well-defined audit criteria.** The character-length thresholds for titles (50-60 ideal, flag <20 or >70) and descriptions (150-160 ideal, flag <50 or >170) give concrete guidance. Not subjective.

3. **Pattern matching documentation.** The explanation of `/**` vs `/*` vs specific paths is clear and includes examples.

4. **Spreadsheet generation rules.** The 7 rules are practical and prevent the most common mistakes (per-page rows, wrong ordering, missing site-wide defaults).

5. **Troubleshooting table.** Covers the most likely failure modes with accurate causes and solutions.

6. **Implementation instructions.** Covers both Google Drive and SharePoint workflows with specific steps.

7. **Safety guardrails.** The "External Content Safety" section is well-thought-out for a skill that fetches live URLs.

### Issues Found

#### Issue 1: No Fallback When Query Index Is Missing (HIGH)

**Problem:** The entire skill workflow depends on the query index (`/query-index.json`). When it returns 404, the skill's troubleshooting table says to "check that `helix-query.yaml` exists in the repo" but provides no alternative workflow for discovering pages. The user is stuck.

**Impact:** Many EDS sites -- especially new or boilerplate-based ones -- will not have a query index configured. This is the most common failure mode.

**Suggested fix:** Add a fallback discovery chain in Step 1:
1. Try `/query-index.json?limit=1000`
2. If 404, try `/sitemap.xml` and parse URLs from it
3. If 404, ask the user to provide a list of page paths manually
4. Document this fallback chain explicitly

#### Issue 2: No Handling of Dead/404 Pages in Sitemap or Index (MEDIUM)

**Problem:** The skill assumes all pages returned by the query index (or sitemap) are live. It has no step for validating that discovered URLs actually return HTTP 200. In this test, `/test-page` was in the sitemap but returned 404.

**Suggested fix:** Add a validation sub-step in Step 1 or Step 2: "For each discovered URL, verify it returns HTTP 200. Flag any URLs that return 404 or redirect as stale entries."

#### Issue 3: "Deep Audit" Trigger Is Vague (LOW)

**Problem:** Step 2 says "optionally fetch individual pages' HTML to check their full `<meta>` tags... Only do this if the user requests a deep audit or the site has fewer than 50 pages." The term "deep audit" is not defined elsewhere in the skill, and it is unclear whether the agent should proactively offer it or wait for the user to use those exact words.

**Suggested fix:** Either define "deep audit" as a named mode the user can request, or change the threshold to always do the full HTML fetch for small sites (e.g., <20 pages) without requiring user opt-in.

#### Issue 4: Missing Robots Meta in Audit Criteria (LOW)

**Problem:** Step 2's audit checks cover Title, Description, and Image, but do not include `<meta name="robots">` even though the skill's spreadsheet template includes a Robots column and the skill discusses `noindex` directives in Step 5. The audit should flag the absence or presence of robots directives.

**Suggested fix:** Add a "Robots" check to Step 2: "Is a robots meta tag present? If not, note this. If `noindex` is set, flag it as intentional or potentially problematic."

#### Issue 5: No Mention of og:type (VERY LOW)

**Problem:** The skill audits og:title, og:description, and og:image but does not mention `og:type`. While not critical, `og:type` is part of the Open Graph protocol's required properties alongside og:title, og:url, and og:image.

**Suggested fix:** Optional addition to the deep audit checks.

---

## Part 3: Test Environment Observations

1. **The AEM boilerplate is an extremely minimal site.** It has one live page and no query index. This is a valid but edge-case test target. A more thorough test would use a site with 10+ pages and a configured query index.

2. **The sitemap includes a stale entry (`/test-page`).** This is a real-world scenario the skill should handle.

3. **The homepage metadata is actually quite good.** Title, description, og tags, twitter cards, canonical, and a valid og:image are all present. The only gaps are the missing robots directive and the relatively short description.

4. **No bulk metadata exists on this site.** This exercises the "404 on metadata.json" path, which the skill handles correctly.

---

## Part 4: Overall Verdict

### CONDITIONAL PASS

**Rationale:** The skill's instructions are well-written, thorough, and technically accurate for the happy path (query index exists, pages are live, metadata can be audited). The audit criteria, spreadsheet generation rules, and implementation instructions are all practical and clear.

However, the skill fails on the most basic prerequisite for this test target: the query index does not exist, and the skill provides no fallback workflow. Since many real EDS sites (especially new ones based on the boilerplate) will not have a query index, this is a significant gap. The skill should degrade gracefully rather than stopping at Step 1.

**Conditions for full PASS:**
1. Add a fallback page-discovery chain when the query index is unavailable (sitemap.xml, then manual input)
2. Add HTTP status validation for discovered URLs before auditing them

**Everything else is solid.** The metadata audit criteria, the bulk spreadsheet generation rules, the precedence explanation, the troubleshooting table, and the implementation instructions are all production-ready.

# Content Diff Skill Test Results

**Date:** 2026-05-14
**Skill:** content-diff v1.0.0
**Skill location:** `/Users/davefox/Code/eds-content-ops-skills/skills/content-diff/SKILL.md`
**Target site:** main--aem-boilerplate--adobe.aem.live
**Tested page:** / (Home)
**Comparison mode:** Preview vs Live (default mode)

---

## Test Configuration

| Parameter | Value |
|-----------|-------|
| Version A (Live) | `https://main--aem-boilerplate--adobe.aem.live/` |
| Version B (Preview) | `https://main--aem-boilerplate--adobe.aem.page/` |
| Live plain HTML | `https://main--aem-boilerplate--adobe.aem.live/index.plain.html` |
| Preview plain HTML | `https://main--aem-boilerplate--adobe.aem.page/index.plain.html` |

---

## Step-by-Step Skill Execution Results

### Step 0: Create Todo List

**Result: PASS**

The skill instructs the agent to create a checklist before starting. This is a simple organizational step. The checklist was created and tracked throughout execution:

- [x] Determine comparison mode and resolve both URLs
- [x] Fetch both page versions (full HTML and `.plain.html`)
- [x] Diff metadata between versions
- [x] Diff content sections between versions
- [x] Diff blocks between versions
- [x] Diff media between versions
- [x] Generate change report with risk assessment

**Notes:** The skill references a "Todo List" which implies use of a TodoWrite tool. This is problematic because not all agents have access to that tool (and the EDS project CLAUDE.md explicitly says "NEVER use the TodoWrite or Agent tools"). The skill should frame this as a mental checklist or markdown checklist rather than implying a specific tool.

---

### Step 1: Determine Comparison Mode

**Result: PASS**

The skill clearly documents three comparison modes: Preview vs Live (default), Two URLs, and Branch Comparison. For this test, we used the default "Preview vs Live" mode.

Given the site `main--aem-boilerplate--adobe`, the URLs resolved correctly:
- **Live:** `https://main--aem-boilerplate--adobe.aem.live/`
- **Preview:** `https://main--aem-boilerplate--adobe.aem.page/`

The instructions correctly identify the URL pattern `<branch>--<repo>--<owner>` and the `.aem.live` / `.aem.page` suffixes.

**Notes:** The skill instructions are clear and cover the common EDS URL patterns well. The note about asking for `owner`, `repo`, and `branch` when given a production URL is a smart fallback.

---

### Step 2: Fetch Both Versions

**Result: PASS**

All four URLs returned HTTP 200:

| URL | Status | Content |
|-----|--------|---------|
| Live full HTML | 200 | 180 lines, complete HTML document |
| Preview full HTML | 200 | 180 lines, complete HTML document |
| Live plain HTML | 200 | 155 lines, content-only HTML |
| Preview plain HTML | 200 | 155 lines, content-only HTML |

The `.plain.html` variant worked correctly by appending `/index.plain.html` to the root path. The plain HTML returned only the authored content (no `<html>`, `<head>`, `<header>`, or `<footer>` wrappers), confirming the skill's description of `.plain.html` behavior.

**Notes:** The skill does not explicitly mention the root-path edge case (i.e., that `/` requires `/index.plain.html` rather than `/.plain.html`). This should be documented as a tip or troubleshooting note. The tester had to know this convention independently. This is a **documentation gap** to fix.

---

### Step 3: Diff Metadata

**Result: PASS**

Metadata was extracted from the `<head>` of both full HTML versions and compared. The following differences were found:

| Property | Live (Version A) | Preview (Version B) | Significance |
|----------|-----------------|---------------------|--------------|
| `<link rel="canonical">` | `https://...aem.live/` | `https://...aem.page/` | Environment-specific, not a real content change |
| `og:url` | `https://...aem.live/` | `https://...aem.page/` | Environment-specific, not a real content change |
| `og:image` | `https://...aem.live/media_1804...` | `https://...aem.page/media_1804...` | Environment-specific domain swap, same image hash |
| `og:image:secure_url` | `https://...aem.live/media_1804...` | `https://...aem.page/media_1804...` | Environment-specific domain swap, same image hash |
| `twitter:image` | `https://...aem.live/media_1804...` | `https://...aem.page/media_1804...` | Environment-specific domain swap, same image hash |
| `<script nonce>` | `HGcKGYzevIRN1M//sWibs8Jy` | `4aQdH20ZYKalVA/F9CMMRf8f` | CSP nonce, changes per-request, not content |

**No actual content-level metadata changes detected.** All differences are environment-specific (domain swaps between `.aem.live` and `.aem.page`) or per-request artifacts (CSP nonces).

The following metadata was identical between both versions:
- `<title>`: "Home | AEM Boilerplate"
- `<meta name="description">`: "Use this template repository as the starting point for new AEM projects."
- `og:title`: "Home | AEM Boilerplate"
- `og:description`: "Use this template repository as the starting point for new AEM projects."
- `twitter:card`: "summary_large_image"
- `twitter:title`: "Home | AEM Boilerplate"
- `twitter:description`: "Use this template repository as the starting point for new AEM projects."
- `viewport`: "width=device-width, initial-scale=1"
- No `<meta name="robots">` tag present on either version

**Notes:** The skill does NOT mention that EDS automatically swaps domain names in `canonical`, `og:url`, `og:image`, and `twitter:image` between environments. This is a critical omission because a naive diff would flag these as "changes" when they are not content changes at all. The skill should add a section or note like:

> **Expected environment differences:** EDS automatically sets `canonical`, `og:url`, and image meta tags to match the serving domain. Differences in these tags between `.aem.page` and `.aem.live` are expected and do NOT represent content changes. Similarly, CSP `nonce` attributes on script tags change per-request and should be ignored.

This is the **most significant documentation gap** found in this test.

---

### Step 4: Diff Content Sections

**Result: PASS**

Using the `.plain.html` versions (which the skill correctly recommends as the cleanest comparison), a byte-for-byte diff was performed.

**The plain HTML content is 100% identical between preview and live.** No differences in:
- Section structure (3 sections: main content, highlight section, empty trailing section)
- Headings (H1: "Congrats, you are ready to go!", H2: "This is another headline here for more content", H2: "Boilerplate Highlights?")
- Paragraphs (all body text identical)
- Lists (the "One / Two / Three" list in the Columns block)
- Links (Google Drive link, aem.live tutorial link, Live/Preview links)

**Section structure identified:**
1. **Section 1 (default):** Hero image, H1, introductory paragraph, H2, Columns block
2. **Section 2 (highlight):** H2 "Boilerplate Highlights?", intro paragraph, Cards block with 7 cards
3. **Section 3 (empty):** Empty div, no content

**No content changes detected.** This confirms the page has not been modified since it was last published.

---

### Step 5: Diff Blocks

**Result: PASS**

Blocks were identified in both versions and compared:

| Block | Version A (Live) | Version B (Preview) | Status |
|-------|-----------------|---------------------|--------|
| `columns` | Present in Section 1 | Present in Section 1 | Identical |
| `cards` | Present in Section 2 | Present in Section 2 | Identical |

Both blocks have identical content, structure, and variants (no variant classes beyond the base block name). No blocks were added, removed, or modified.

**No block changes detected.**

---

### Step 6: Diff Media

**Result: PASS**

All images were cataloged and compared between versions:

| Image | Location | Status |
|-------|----------|--------|
| `media_180455b829a1e29ac2451440ba27ebd9692d285ab.jpg` | Section 1 hero | Identical |
| `media_15fdf30f54d7afe1b11ca02b1b6623d40e973f092.png` | Columns block, row 1 | Identical |
| `media_143cf1a441962c90f082d4f7dba2aeefb07f4e821.png` | Columns block, row 2 | Identical |
| `media_10c08bd43d12ec89aea76de7423a6081736b75be1.jpg` | Cards - "Unmatched speed" | Identical |
| `media_18912f31c9fe3034c15c130bd65dce423188165a9.jpg` | Cards - "Content at scale" | Identical |
| `media_1176ed1f1f1e2d0f5609baf3e5cb86cf3365b1746.jpg` | Cards - "Uncertainty eliminated" | Identical |
| `media_1ddf6066dd7065fd467e343d3fff41d4c84f21f66.jpg` | Cards - "Widen the talent pool" | Identical |
| `media_1424d0ece6a883d17872b4135a0eafbd50662bf4a.jpg` | Cards - "Low-code" | Identical |
| `media_19772223a5c78d2634d6d44041a6e651db25f2069.jpg` | Cards - "Headless is here" | Identical |
| `media_12f06823bc0c30fda34f089b48dae41a10b1cec7c.jpg` | Cards - "Peak performance" | Identical |

All 10 images use identical file hashes, dimensions, alt text (all empty), and srcset configurations. No media changes detected.

**Accessibility note:** All images on both versions have empty `alt=""` attributes. This is a pre-existing issue, not a diff concern, but worth noting.

---

### Step 7: Change Report (as the skill would produce it)

#### Change Summary

0 sections modified, 0 blocks changed, 0 metadata updates (content-level).

**Change scope:** None -- preview and live are identical. No changes pending publication.

#### Metadata Changes

No content-level metadata changes. The only differences are environment-specific domain swaps in `canonical`, `og:url`, `og:image`, `og:image:secure_url`, and `twitter:image` tags (`.aem.live` vs `.aem.page`) and per-request CSP nonces on script tags. These are expected EDS behaviors, not content changes.

#### Content Changes

No content changes detected. The `.plain.html` output is byte-for-byte identical between preview and live.

#### Block Changes

No block changes.

#### Media Changes

No media changes.

#### Risk Assessment

No SEO, performance, or accessibility risks identified from the diff (since there are no changes).

**Pre-existing observation:** All 10 images on the page have empty `alt=""` attributes. While not a diff concern, this would be flagged as an accessibility issue in an audit.

---

## Skill Instruction Quality Assessment

### What Worked Well

1. **Step structure is logical and complete.** The 7-step workflow (plus Step 0) covers all the right dimensions: metadata, content, blocks, media, and risk.
2. **`.plain.html` recommendation is excellent.** This correctly identifies the cleanest comparison surface. The content diff on `.plain.html` was byte-for-byte identical, confirming its reliability.
3. **Environment model documentation is accurate.** The explanation of preview (.aem.page), live (.aem.live), and production (custom domain) is correct and clearly written.
4. **Comparison mode options are well thought out.** Preview vs Live, Two URLs, and Branch Comparison cover the real-world use cases.
5. **Author-friendly language guidance is strong.** The "Key Principles" section correctly instructs the agent to focus on content meaning rather than HTML structure.
6. **Troubleshooting table is practical.** The "Preview and live are identical" case is exactly what we encountered, and the guidance ("Confirm with the user; this means there is nothing new to publish") is correct.
7. **Risk assessment categories are comprehensive.** SEO, performance, and accessibility are the right categories to flag.
8. **External Content Safety section is a good practice.** Sets appropriate guardrails for fetching external URLs.

### Issues Found

#### Issue 1: Missing guidance on environment-specific metadata differences (HIGH)

**Problem:** When comparing `.aem.page` vs `.aem.live`, EDS automatically sets `canonical`, `og:url`, `og:image`, `og:image:secure_url`, and `twitter:image` to use the serving domain. A naive agent following Step 3 would flag these as metadata "changes" when they are expected EDS behavior.

**Recommendation:** Add a note to Step 3:

> **Note:** EDS automatically sets `canonical`, `og:url`, and image-referencing meta tags (`og:image`, `og:image:secure_url`, `twitter:image`) to match the serving domain. When comparing preview (`.aem.page`) vs live (`.aem.live`), differences in these URL domains are expected and should NOT be reported as content changes. Similarly, CSP `nonce` attributes on `<script>` tags are generated per-request and should be ignored.

#### Issue 2: Missing root-path `.plain.html` convention (MEDIUM)

**Problem:** The skill says to "append `.plain.html` to the page path (e.g., `/about.plain.html`)." For the root path `/`, the correct URL is `/index.plain.html`, not `/.plain.html`. The skill does not mention this.

**Recommendation:** Add an example or note:

> For the root/home page, use `/index.plain.html` (not `/.plain.html`). For other pages, append `.plain.html` to the path: `/about` becomes `/about.plain.html`.

#### Issue 3: Step 0 implies TodoWrite tool dependency (LOW)

**Problem:** "Create a Todo List" with checkbox syntax implies a TodoWrite or similar tool. Some agent configurations (including the EDS project config) explicitly prohibit TodoWrite. The step works fine as a mental/markdown checklist, but the phrasing could cause confusion.

**Recommendation:** Rephrase to: "Track progress through the following steps:" or "Use the following checklist to track progress (as a markdown list in your working notes)."

#### Issue 4: No guidance on per-request artifacts like nonces (LOW)

**Problem:** The `<script>` tags contain `nonce` attributes that change on every request. These will always differ and should be excluded from comparison. The skill does not mention this.

**Recommendation:** Note this either in Step 3 (metadata) or in a general "Noise Reduction" section: "Ignore per-request artifacts like CSP `nonce` attributes, which change on every page load and are not content."

#### Issue 5: No mention of fetching nav/footer separately (LOW)

**Problem:** EDS loads `<header>` and `<footer>` content via JavaScript from `/nav.plain.html` and `/footer.plain.html`. The full HTML shows empty `<header></header>` and `<footer></footer>` tags. The skill correctly steers toward `.plain.html` (which excludes these), but if someone wanted to compare navigation or footer changes, the skill does not explain how.

**Recommendation:** Add an optional step or note: "To compare navigation or footer changes, fetch `/nav.plain.html` and `/footer.plain.html` separately. These are loaded via JavaScript and do not appear in the server-rendered HTML."

#### Issue 6: Section identification could be more explicit about EDS structure (LOW)

**Problem:** Step 4 says "sections are `<div>` wrappers separated by `<hr>` (horizontal rules) in the source document." In the rendered `.plain.html`, sections appear as top-level `<div>` elements (sometimes with class names like `highlight`), but there are no `<hr>` tags visible. The `<hr>` is a source-document concept (Google Docs/Word), not an HTML output concept. This could confuse an agent looking for `<hr>` in the HTML.

**Recommendation:** Clarify: "In the source document (Google Docs/Word), sections are separated by horizontal rules. In the rendered `.plain.html`, each section appears as a top-level `<div>` element, optionally with a class name derived from a section metadata table."

---

## Overall Verdict: CONDITIONAL PASS

The content-diff skill successfully guided a complete comparison workflow against a live EDS site. All seven steps were executable, the correct URLs were fetched, and the skill correctly identified this as an "identical preview and live" scenario.

The skill earns a **CONDITIONAL PASS** rather than a full PASS because of two issues that would cause incorrect results in real-world use:

1. **Environment-specific metadata differences (Issue 1)** would be falsely reported as content changes if the agent follows Step 3 literally. On a page with actual content differences, these false positives would pollute the report and confuse content authors.

2. **Missing root-path `.plain.html` convention (Issue 2)** would cause a fetch failure (`/.plain.html` would likely 404) if the agent does not independently know to use `/index.plain.html`.

Both issues are straightforward to fix with documentation additions. Once addressed, the skill would earn a full PASS.

### Conditions for Full PASS

- [ ] Add environment-specific metadata filtering guidance to Step 3
- [ ] Document the `/index.plain.html` convention for root paths in Step 2
- [ ] (Optional) Address Issues 3-6 for polish

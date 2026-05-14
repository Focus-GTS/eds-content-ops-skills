# Accessibility Fix Skill -- Test Results

**Target URL:** https://main--aem-boilerplate--adobe.aem.live/
**Date:** 2026-05-14
**Skill Version:** 1.0.0
**Auditor:** Claude (automated, following SKILL.md instructions exactly)

---

## Part 1: Full Accessibility Audit Output

### Step 0: Audit Checklist

- [x] Fetch and parse the published page
- [x] Image accessibility (alt text, decorative images)
- [x] Heading hierarchy (H1 presence, logical order)
- [x] Link accessibility (descriptive text, duplicates)
- [x] Color contrast (CSS custom properties, text/background ratios)
- [x] EDS button accessibility (strong/em pattern, descriptive text)
- [x] Document structure (language, title, landmarks, lists, tables)
- [x] Block-specific checks (cards, columns, header)
- [x] Generate fix report

---

### Step 1: Page Structure Identified

**Sections found:**
- Section 1 (default content): Hero image, H1, body paragraph, H2, Columns block
- Section 2 (highlight class): H2 "Boilerplate Highlights?", introductory paragraph, Cards block (7 cards)
- Section 3: Empty div

**Blocks found:**
- `div.columns` -- Columns block with 2 rows, each with text + image
- `div.cards` -- Cards block with 7 cards, each with image + text

**Header:** Loaded via JS from `nav.plain.html`. Contains site title link, nav menu with 3 top-level items and dropdowns, and a search icon.

**Footer:** Loaded via JS from `footer.plain.html`. Contains copyright text and 5 links (Privacy, Terms, Cookie preferences, Do not sell, AdChoices).

**CSS:** Fetched from `/styles/styles.css`. All custom properties extracted and analyzed.

---

### Step 2: Image Accessibility

**Total images found:** 10 (1 hero image, 2 in columns block, 7 in cards block)

**Finding: ALL 10 images have `alt=""` (empty alt).**

Analysis of each image:

| # | Location | alt attribute | Assessment |
|---|----------|---------------|------------|
| 1 | Hero section (top of page) | `alt=""` | ISSUE: This is the page's main hero image. It appears to be an informational image based on being the og:image and the first visual a user encounters. It should have descriptive alt text. |
| 2 | Columns block, row 1 right | `alt=""` | Needs review: Image paired with "Columns block" text and a list. Likely informational, should describe what is shown. |
| 3 | Columns block, row 2 left | `alt=""` | Needs review: Image paired with "Or you can just view the preview" text. Likely informational. |
| 4 | Cards: "Unmatched speed" | `alt=""` | ISSUE: Card image illustrating speed/publishing concept. Should have alt text describing the image. |
| 5 | Cards: "Content at scale" | `alt=""` | ISSUE: Card image illustrating content scaling. Should have alt text. |
| 6 | Cards: "Uncertainty eliminated" | `alt=""` | ISSUE: Card image illustrating predictability. Should have alt text. |
| 7 | Cards: "Widen the talent pool" | `alt=""` | ISSUE: Card image illustrating authoring simplicity. Should have alt text. |
| 8 | Cards: "Low-code developer productivity" | `alt=""` | ISSUE: Card image illustrating developer experience. Should have alt text. |
| 9 | Cards: "Headless is here" | `alt=""` | ISSUE: Card image illustrating headless/forms capability. Should have alt text. |
| 10 | Cards: "Peak performance" | `alt=""` | ISSUE: Card image illustrating performance/architecture. Should have alt text. |

**Note:** It is possible the author intentionally marked these as decorative (`alt=""`), which is valid if the images are purely atmospheric and the adjacent text conveys all the information. However, the hero image and card images appear to be informational content images -- they are prominent, context-setting, and would leave a gap in understanding if absent. These should be flagged for author review.

---

### Step 3: Heading Hierarchy

**Headings found (in order):**
1. `<h1>` -- "Congrats, you are ready to go!"
2. `<h2>` -- "This is another headline here for more content"
3. `<h2>` -- "Boilerplate Highlights?"

**Assessment:**
- Exactly one H1: PASS
- H1 is the first heading on the page: PASS
- Logical heading order (H1 -> H2 -> H2, no skipped levels): PASS
- Headings describe content purpose: The H1 and H2s are placeholder/demo text, not real content -- acceptable for a boilerplate demo.

No heading hierarchy violations found.

---

### Step 4: Link Accessibility

**Links in main content:**

| # | Link Text | href | Assessment |
|---|-----------|------|------------|
| 1 | "Google Drive" | https://drive.google.com/drive/folders/... | PASS -- descriptive, makes sense in context |
| 2 | "https://www.aem.live/tutorial" | https://bit.ly/3aImqUL | ISSUE: Link text is a bare URL. Should be descriptive text like "AEM tutorial" or "getting started tutorial". Also, the display text does not match the actual href (displays aem.live URL, links to bit.ly shortener). |
| 3 | "Live" | / | ISSUE: Single word "Live" is vague when read out of context. A screen reader listing all links would see just "Live" with no indication of destination. |
| 4 | "Preview" | / | ISSUE: Single word "Preview" is vague when read out of context. |

**Links in navigation (header):**

| # | Link Text | href | Assessment |
|---|-----------|------|------------|
| 5 | "Boilerplate" | / | PASS -- site title/home link, acceptable |
| 6 | "Default Content" | / | Minor: points to same URL as home |
| 7 | "Build your first site" | / | PASS -- descriptive |
| 8 | "Preview and publish content" | / | PASS -- descriptive |
| 9 | "Organize your content" | / | PASS -- descriptive |
| 10 | "Architecture" | / | PASS -- descriptive |
| 11 | "Sidekick" | / | PASS -- descriptive |

**Note:** All nav links point to `/` (homepage). This is expected for a boilerplate demo with placeholder content. In a real site, these would be distinct destinations.

**Links in footer:**

| # | Link Text | href | Assessment |
|---|-----------|------|------------|
| 12 | "Privacy" | https://www.adobe.com/privacy.html | PASS |
| 13 | "Terms of Use" | https://www.adobe.com/legal/terms.html | PASS |
| 14 | "Cookie preferences" | /footer#consent | PASS |
| 15 | "Do not sell my personal information" | https://www.adobe.com/privacy/ca-rights.html | PASS |
| 16 | "AdChoices" | https://www.adobe.com/privacy/opt-out.html#interest-based-ads | PASS |

**Duplicate link check:** Multiple nav links and the "Live"/"Preview" buttons all point to `/`. These have different text, so technically they pass 2.4.4, but on a real site this would indicate incomplete content.

**External link indication:** Links to google.com, bit.ly, and adobe.com domains do not indicate they leave the site. Flagged as Minor.

---

### Step 5: Color Contrast

**CSS custom properties extracted from `styles.css`:**

| Variable | Value |
|----------|-------|
| --background-color | white (#ffffff) |
| --light-color | #f8f8f8 |
| --dark-color | #505050 |
| --text-color | #131313 |
| --link-color | #3b63fb |
| --link-hover-color | #1d3ecf |

**Contrast ratio calculations:**

| Pair | Foreground | Background | Ratio | Required | Result |
|------|-----------|------------|-------|----------|--------|
| Body text on white | #131313 | #ffffff | 18.58:1 | 4.5:1 | PASS |
| Link text on white | #3b63fb | #ffffff | 4.81:1 | 4.5:1 | PASS |
| Link hover on white | #1d3ecf | #ffffff | 7.95:1 | 4.5:1 | PASS |
| Text on light/highlight section | #131313 | #f8f8f8 | 17.50:1 | 4.5:1 | PASS |
| Link on light/highlight section | #3b63fb | #f8f8f8 | 4.53:1 | 4.5:1 | PASS (marginal) |
| Dark color on white | #505050 | #ffffff | 8.06:1 | 4.5:1 | PASS |
| Dark color on light | #505050 | #f8f8f8 | 7.59:1 | 4.5:1 | PASS |
| Primary button (white on dark) | #ffffff | #131313 | 18.58:1 | 4.5:1 | PASS |
| Primary button hover | #f8f8f8 | #505050 | 7.59:1 | 4.5:1 | PASS |
| Secondary button | #131313 | #ffffff | 18.58:1 | 4.5:1 | PASS |
| Accent button (white on blue) | #ffffff | #3b63fb | 4.81:1 | 4.5:1 | PASS |
| Accent button hover | #ffffff | #1d3ecf | 7.95:1 | 4.5:1 | PASS |

**Assessment:** All color contrast pairs pass WCAG AA minimums. The link color on the light/highlight background (#3b63fb on #f8f8f8 = 4.53:1) is marginal -- passes 4.5:1 but only barely. Recommend monitoring if the light-color value changes.

No contrast violations found.

---

### Step 6: EDS Button Accessibility

**Buttons found:**

| # | Pattern | Text | href | Assessment |
|---|---------|------|------|------------|
| 1 | `<strong><a>` (primary) | "Live" | / | ISSUE: Button text "Live" does not clearly describe the action. Should be "View live site" or "Go to live page". |
| 2 | `<em><a>` (secondary) | "Preview" | / | ISSUE: Button text "Preview" is vague without context. Should be "Preview site" or "View preview". |

**Check: buttons have accessible names:** PASS -- both have text content.
**Check: button text describes the action:** FAIL for both -- single-word labels lack sufficient context.
**Check: adjacent button visual distinction:** The primary (bold/strong) and secondary (italic/em) buttons appear in separate column rows, not side-by-side, so this is not applicable here.

---

### Step 7: Document Structure

| Check | Status | Detail |
|-------|--------|--------|
| `lang` attribute on `<html>` | FAIL | `<html>` has no `lang` attribute. Should be `lang="en"`. |
| Page `<title>` | PASS | Title is "Home \| AEM Boilerplate" -- descriptive and present. |
| `<header>` landmark | PASS | `<header>` element present. |
| `<main>` landmark | PASS | `<main>` element present. |
| `<footer>` landmark | PASS | `<footer>` element present. |
| List markup | PASS | Lists use proper `<ul>`/`<li>` markup (columns block list, nav menu). |
| Skip navigation link | FAIL | No skip-to-main-content link found in header or page source. |
| Navigation uses `<nav>` | UNKNOWN | The header block is loaded via JS; the nav.plain.html fragment uses `<div>` and `<ul>` but whether it gets wrapped in `<nav>` depends on the header block JS. Flagged for verification. |

---

### Step 8: Block-Specific Checks

#### Cards Block

| Check | Status | Fix Type | Detail |
|-------|--------|----------|--------|
| Card images have alt text | FAIL | Document | All 7 card images have `alt=""`. These are paired with descriptive headings ("Unmatched speed", "Content at scale", etc.) so the images may be considered supportive, but they appear to be informational photographs, not purely decorative. |
| Card links make sense out of context | N/A | -- | Cards do not contain standalone links; the card headings are bold text, not links. |
| Single interactive element per card | PASS | -- | No redundant link patterns detected in the card markup. |

#### Columns Block

| Check | Status | Fix Type | Detail |
|-------|--------|----------|--------|
| Linear reading order logical | PASS | -- | Content reads logically when linearized: text then image, image then text. |
| Column images accessible | FAIL | Document | Both column images have `alt=""`. |

#### Header / Navigation Block

| Check | Status | Fix Type | Detail |
|-------|--------|----------|--------|
| Keyboard accessibility | UNKNOWN | Code | Cannot verify JS behavior from static HTML. Requires manual testing. |
| Mobile hamburger menu keyboard-operable | UNKNOWN | Code | Requires manual testing. |
| `<nav>` element or `role="navigation"` | UNKNOWN | Code | Depends on header block JS implementation. |
| Search icon accessible name | FAIL | Code | Search icon is `<span class="icon icon-search">` with no text alternative. Needs `aria-label="Search"` or equivalent. |

---

### Step 9: Fix Report

#### Findings Table

| # | WCAG Criterion | Severity | Element | Issue | Fix (Document) | Fix (Code) |
|---|---|---|---|---|---|---|
| 1 | 3.1.1 Language of Page | Major | `<html>` element | Missing `lang` attribute | -- | In `head.html`, change `<html>` to `<html lang="en">` |
| 2 | 2.4.1 Bypass Blocks | Major | Header/page | No skip-to-main-content link | -- | Add a visually hidden skip link as the first child of `<body>` in `head.html` or header block JS: `<a href="#main" class="skip-to-main">Skip to main content</a>` with appropriate CSS |
| 3 | 1.1.1 Non-text Content | Major | Hero image | `alt=""` on the hero image -- appears informational, not decorative | In the source document (Google Docs), right-click the hero image > Alt text. Add descriptive alt text, e.g.: "Aerial view of a modern workspace with team collaborating" (adjust to match actual image content) | -- |
| 4 | 1.1.1 Non-text Content | Major | Cards block (7 images) | All card images have `alt=""`. These accompany informational content cards and appear to be photographs illustrating each card's topic. | In Google Docs, right-click each card image > Alt text. Add alt text that describes what the photo shows. E.g., for "Unmatched speed" card: "Developer publishing content rapidly from a laptop". For "Content at scale" card: "Team managing multiple content streams simultaneously". (Adjust to match actual image content.) | -- |
| 5 | 1.1.1 Non-text Content | Minor | Columns block (2 images) | `alt=""` on both column images. If these are screenshots or informational images, they need alt text. If purely decorative, `alt=""` is correct. | Review each image. If informational, right-click in Google Docs > Alt text and describe what the image shows. If decorative, leave as-is. | -- |
| 6 | 2.4.4 Link Purpose | Major | Bare URL link | Link text is "https://www.aem.live/tutorial" (a bare URL) and the href is a bit.ly shortener. Text does not match destination. | Change the link text from the bare URL to descriptive text: "AEM getting started tutorial". Update the href from the bit.ly shortener to the direct URL. | -- |
| 7 | 2.4.4 Link Purpose | Major | "Live" button link | Button text "Live" is vague when read out of context by a screen reader. | Change the bold link text in Google Docs from "Live" to "View live site" | -- |
| 8 | 2.4.4 Link Purpose | Major | "Preview" button link | Button text "Preview" is vague when read out of context. | Change the italic link text in Google Docs from "Preview" to "View site preview" | -- |
| 9 | 4.1.2 Name, Role, Value | Major | Search icon in header | Search icon (`span.icon.icon-search`) has no accessible name. Screen readers cannot identify its purpose. | -- | In the header block JS, add `aria-label="Search"` to the search icon's parent interactive element, or add visually hidden text "Search" inside the element. |
| 10 | 2.4.4 Link Purpose | Minor | External links (Google Drive, adobe.com links in footer) | Links to external domains do not indicate they leave the site. | Consider appending "(opens in new window)" text or adding an external link icon with alt text where links open externally. | -- |
| 11 | 1.4.3 Contrast | Minor | Link on highlight section | Link color #3b63fb on #f8f8f8 background achieves 4.53:1 -- technically passing but marginal at 4.5:1. | -- | Monitor this ratio. If --light-color changes to anything darker, this pair will fail. Consider changing --link-color to #3559e0 (~5.2:1) for more headroom. |

#### Summary

The AEM Boilerplate demo page has **0 Critical issues**, **7 Major issues**, and **4 Minor issues**. The primary accessibility gaps are: (1) a missing `lang` attribute on the HTML element, (2) no skip navigation link, (3) images that appear informational but are marked as decorative with empty alt text, and (4) vague link/button text that does not convey purpose when read out of context. Color contrast is solid across all pairs. The heading hierarchy is clean. The page has good structural landmarks.

#### Document Fixes (for content author in Google Docs)

**Hero section:**
- Add alt text to the hero image via right-click > Alt text. Describe what the image shows (e.g., "Aerial view of a collaborative workspace" -- adjust to match the actual image).

**Body content (Section 1):**
- Change the bare URL link text "https://www.aem.live/tutorial" to "AEM getting started tutorial".
- Change the "Live" button text (bold link) to "View live site".
- Change the "Preview" button text (italic link) to "View site preview".
- Review both Columns block images. If they are informational (screenshots, illustrations), add alt text via right-click > Alt text. If purely decorative, leave as-is.

**Highlight section (Cards):**
- Add alt text to all 7 card images. Each image should describe what the photograph shows, not repeat the card heading. Examples:
  - "Unmatched speed" card image: "Developer publishing a webpage in seconds"
  - "Content at scale" card image: "Team reviewing content across multiple screens"
  - (Adjust all to match actual image content)

**Footer:**
- Consider adding "(external site)" or similar indication to links that navigate to adobe.com.

#### Code Fixes (for developer)

**`head.html`:**
- Add `lang="en"` to the `<html>` element.

**Header block JS (or `head.html`):**
- Add a skip-to-main-content link as the first focusable element on the page. Example:
  ```html
  <a href="#main" class="skip-to-main">Skip to main content</a>
  ```
  With CSS to visually hide it until focused:
  ```css
  .skip-to-main {
    position: absolute;
    left: -10000px;
    top: auto;
    width: 1px;
    height: 1px;
    overflow: hidden;
  }
  .skip-to-main:focus {
    position: static;
    width: auto;
    height: auto;
  }
  ```
  Ensure `<main>` has `id="main"` as the target.

- Add `aria-label="Search"` to the search icon element (or wrap it in a `<button>` with that label).

- Verify that the navigation is wrapped in a `<nav>` element with an appropriate `aria-label` (e.g., `aria-label="Main navigation"`).

**`styles.css` (optional improvement):**
- Consider changing `--link-color` from `#3b63fb` to `#3559e0` for more contrast headroom on light backgrounds (current ratio is 4.53:1, just above the 4.5:1 threshold).

#### Compliance Score

**Conditional Pass** -- No Critical issues were found, but there are 7 Major issues that need attention before the page can be considered WCAG 2.1 AA compliant. The most impactful are the missing `lang` attribute, missing skip navigation, and informational images without alt text.

---

## Part 2: Skill Evaluation (Test Report)

### Did every step work as written?

**Yes, with minor caveats.** Every step in the SKILL.md was followable and produced meaningful output. The 9-step structure (Step 0 through Step 9) provided a clear, sequential workflow that was easy to execute.

Specific notes per step:

| Step | Worked? | Notes |
|------|---------|-------|
| Step 0: Create Todo List | Yes | The instruction says "create a checklist" which is clear. The skill says to use a todo list, which I tracked and checked off as I went. |
| Step 1: Fetch and Parse | Yes | Fetching the page and CSS worked. The skill correctly identifies the EDS structural elements to look for (sections, blocks, default content, header, footer). |
| Step 2: Image Accessibility | Yes | Instructions were thorough. The distinction between informational and decorative images was well-explained. The EDS-specific fix locations (Google Docs right-click > Alt text) were precise and actionable. |
| Step 3: Heading Hierarchy | Yes | Clear checks. Easy to execute against the parsed HTML. |
| Step 4: Link Accessibility | Yes | Comprehensive checks. The list of flagged terms ("click here", "read more", bare URLs) was useful. |
| Step 5: Color Contrast | Yes | Instructions to extract CSS custom properties and calculate ratios were clear. Required an external calculation (I used Python) since contrast ratio math is not trivial. |
| Step 6: EDS Button Accessibility | Yes | The EDS button pattern (strong/a = primary, em/a = secondary) was correctly documented and matched what was found on the page. |
| Step 7: Document Structure | Yes | All checks were clear and executable. |
| Step 8: Block-Specific Checks | Mostly | The checks for Cards and Columns blocks were applicable and useful. The Header/Nav checks require JS execution (keyboard testing) which cannot be done from a static fetch -- the skill acknowledges this implicitly but could be more explicit about it. |
| Step 9: Generate Fix Report | Yes | The table format and report sections (Summary, Document Fixes, Code Fixes, Compliance Score) were well-structured and produced a useful deliverable. |

### Were any instructions unclear or impossible to follow?

1. **Step 1 -- Fetching the header/footer:** The skill says to identify the header and footer blocks, but on EDS sites these are loaded via JavaScript from separate fragment files (`nav.plain.html`, `footer.plain.html`). The initial HTML shows empty `<header></header>` and `<footer></footer>` tags. The skill does not explicitly instruct to fetch these fragments separately. I fetched them because I knew the EDS pattern, but a less experienced user of the skill might miss them. **Recommendation:** Add a note in Step 1 saying: "If `<header>` and `<footer>` are empty in the initial HTML, fetch the nav and footer fragments at `/nav.plain.html` and `/footer.plain.html` to audit their content."

2. **Step 5 -- Contrast calculation:** The skill says "Calculate contrast ratios for key pairs" but does not provide the formula or suggest a tool. A human following the skill would need a contrast checker tool. An AI agent needs to compute relative luminance and contrast ratios programmatically. This worked fine but the step assumes the reader knows how to calculate WCAG contrast ratios. **Recommendation:** Consider adding a note: "Use the WCAG relative luminance formula or a tool like WebAIM's contrast checker."

3. **Step 8 -- JS-dependent checks:** The Header/Navigation checks (keyboard accessibility, hamburger menu, nav element) and any interactive block checks require JavaScript execution and keyboard testing. A static HTML fetch cannot verify these. The skill does not explicitly say "if you cannot execute JavaScript, flag these as requiring manual verification." **Recommendation:** Add a note: "If auditing from static HTML without a browser, flag interactive behavior checks as 'Requires manual testing' rather than marking them pass or fail."

4. **Step 2 -- Image analysis without viewing images:** The skill says to "infer what the image likely shows" based on context, but we cannot actually view the images to verify our guesses. The suggested alt text might be inaccurate. The skill should note this limitation more clearly. **Recommendation:** Add: "When suggesting alt text based on inference, clearly mark it as suggested/approximate and instruct the author to verify against the actual image."

### Did the skill produce useful, actionable output?

**Yes.** The output is a structured fix report with clear separation between document-level fixes (for content authors) and code-level fixes (for developers). Each finding includes the WCAG criterion, severity, specific element, the issue, and a concrete fix instruction. A content author could take the "Document Fixes" section and execute every fix without developer help. A developer could take the "Code Fixes" section and implement each change independently.

The compliance score (Pass / Conditional Pass / Fail) is a useful summary metric. The severity levels (Critical / Major / Minor) provide clear prioritization.

### Bugs, gaps, or improvements needed in the SKILL.md

| Issue | Type | Detail | Suggested Fix |
|-------|------|--------|---------------|
| Header/footer fragments not mentioned | Gap | EDS loads header/footer via JS; the initial HTML has empty elements. Skill does not instruct to fetch the nav/footer fragments. | Add a note in Step 1 about fetching `/nav.plain.html` and `/footer.plain.html` when header/footer are empty. |
| Contrast calculation method unspecified | Gap | Step 5 says to "calculate contrast ratios" but does not specify how. | Add a brief note about using the WCAG luminance formula or a tool like WebAIM Contrast Checker. |
| JS-dependent checks have no fallback guidance | Gap | Interactive checks (keyboard nav, ARIA states) cannot be verified from static HTML. | Add a note in Step 8: "If testing from static HTML, flag interactive checks as 'Requires manual testing'." |
| Image alt text inference accuracy | Gap | Skill says to infer alt text from context, but suggested text might not match the actual image. | Add a note: "Mark inferred alt text as approximate and instruct the author to verify." |
| Search icon pattern not covered | Gap | The nav fragment has a `span.icon.icon-search` pattern which is common in EDS headers. Step 8 Header checks do not mention icon-only interactive elements. | Add a check in Step 8 Header section: "Do icon-only interactive elements (search, hamburger) have accessible names (aria-label or visually hidden text)?" |
| Empty sections not mentioned | Minor | The page has an empty `<div></div>` section at the end of `<main>`. This is harmless but could be noted. | Optional: mention that empty sections are benign and do not create accessibility issues. |
| No mention of `<picture>` element handling | Minor | All images use `<picture>` with `<source>` elements. The skill mentions `<picture>` in Step 2 but does not note that alt text goes on the `<img>` inside `<picture>`, not on `<picture>` itself. | Add a clarification: "In EDS, images use the `<picture>` element. The alt attribute is on the `<img>` tag inside `<picture>`." |
| Fix report table could note "Requires author review" | Minor | For images that might legitimately be decorative, the severity is ambiguous. | Allow a "Needs Review" severity or a note column in the findings table for ambiguous cases. |

### Overall Skill Assessment

**Rating: Strong -- ready for use with minor improvements.**

The skill is well-structured, comprehensive, and produces genuinely useful output. The 9-step process covers all major WCAG 2.1 AA criteria relevant to EDS sites. The separation of document fixes from code fixes is the skill's strongest feature -- it respects the EDS authoring workflow where content authors and developers have distinct responsibilities.

The gaps identified are mostly edge cases and clarifications, not fundamental problems. The skill worked end-to-end on a real EDS page and produced a professional-grade accessibility audit report. The recommended improvements would make the skill more robust for less experienced users and for automated tooling that cannot execute JavaScript.

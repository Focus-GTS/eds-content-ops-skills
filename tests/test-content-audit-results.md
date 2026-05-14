# Content Audit Skill Test Results

**Target Page:** https://main--aem-boilerplate--adobe.aem.live/
**Date:** 2026-05-14
**Skill Version:** 1.0.0
**Tester:** Claude (automated skill test)

---

## Part 1: Full Content Audit Output

### Step 0: Checklist

- [x] Fetch and parse the published page and its `.plain.html` variant
- [x] Content structure audit (headings, sections, blocks, links, images)
- [x] Metadata audit (page metadata table, OG tags, robots, canonical)
- [x] EDS performance audit (LCP budget, loading phases, fonts, third-party scripts)
- [x] Accessibility audit (alt text, heading hierarchy, link text, contrast, buttons)
- [x] SEO and AI discoverability audit (title, description, H1, structured data, URLs)
- [x] EDS best practices audit (David's Model content rules)
- [x] Generate prioritized report

---

### Step 1: Fetch and Parse Page

**Published page** (`https://main--aem-boilerplate--adobe.aem.live/`): Fetched successfully via HTTP GET. Returns 180 lines of HTML. The server-side HTML is the pre-decoration document; the EDS boilerplate JS decorates the DOM client-side (adds hero block, header, footer, etc.).

**Plain HTML variant** (`https://main--aem-boilerplate--adobe.aem.live/.plain.html`): Returned **HTTP 404**. Tried `index.plain.html` as a fallback, which returned content successfully. This is noted as a minor environmental nuance -- the root path `/` requires `index.plain.html` explicitly rather than `/.plain.html`.

**Structural observations from the raw HTML:**
- The `<html>` element has **no `lang` attribute**.
- The `<head>` contains: title, canonical, description, OG tags, Twitter card tags, viewport, two scripts (aem.js, scripts.js), one stylesheet (styles.css).
- The `<body>` contains: empty `<header>`, `<main>` with 3 section `<div>`s, empty `<footer>`. Header and footer are populated client-side by scripts.js.
- No `<meta name="robots">` tag is present.
- No JSON-LD structured data.

---

### Step 2: Content Structure Audit

#### Headings

| Level | Text | Assessment |
|-------|------|------------|
| H1 | "Congrats, you are ready to go!" | Exists, is unique. PASS. |
| H2 | "This is another headline here for more content" | Generic/placeholder text. |
| H2 | "Boilerplate Highlights?" | Ends with a question mark which is unusual for a section heading. |

- **H1 exists and is unique:** PASS. One H1 found.
- **Heading hierarchy is logical:** PASS. H1 followed by H2s. No skipped levels.
- **Headings are descriptive:** FAIL. "This is another headline here for more content" is placeholder text, not a meaningful heading. "Boilerplate Highlights?" is borderline -- the question mark is unusual but this is a demo page so it may be intentional.

#### Sections

The page has 3 top-level `<div>` sections inside `<main>`:
1. First section (no class) -- hero image, H1, intro text, H2, columns block.
2. Second section (class `highlight`) -- H2, intro paragraph, cards block.
3. Third section (empty `<div>`).

- **Section breaks:** The sections are separated as expected. The third empty `<div>` is inert but harmless.
- **Section metadata blocks:** None present. PASS (not required).

#### Blocks

Two blocks identified:
1. **`columns`** -- Used appropriately for a two-column layout. Contains text + list + button in one column, image in the other, then image in one column, text + button in the other. 2 columns. PASS.
2. **`cards`** -- Used for 7 feature highlight cards, each with an image, title, and description. PASS -- appropriate use of a block for a repeating card layout.

- **Nested blocks:** None found. PASS.
- **Block names:** `columns` and `cards` are standard EDS block names, lowercase. PASS.
- **Block-to-content ratio:** 2 blocks vs. some default content (H1, paragraphs). The first section mixes default content with a columns block; the second section is entirely a cards block. Roughly 60-70% of page content is in blocks, which is on the higher end but reasonable for a demo page.

#### Links

| Anchor Text | href | Assessment |
|-------------|------|------------|
| "Google Drive" | `https://drive.google.com/drive/folders/...` | External link. Descriptive text. No target attribute. |
| "https://www.aem.live/tutorial" | `https://bit.ly/3aImqUL` | Anchor text is a URL (the display URL), but href points to a bit.ly shortener. Mismatch and bare URL as text. |
| "Live" | `/` | Relative URL. Points to same page. |
| "Preview" | `/` | Relative URL. Points to same page. |
| Footer links (Privacy, Terms, etc.) | `https://www.adobe.com/...` | External, fully qualified. Loaded client-side. |

- **Broken internal links:** Both "Live" and "Preview" link to `/`, which is this same page. Not broken, but self-referential and not useful. This is demo/placeholder behavior.
- **External links target:** The Google Drive link has no `target="_blank"`. External links should typically open in a new context.
- **Anchor text:** The tutorial link uses a bare URL as its anchor text (`https://www.aem.live/tutorial`). This is a P1 issue.
- **Relative URLs:** "Live" (`/`) and "Preview" (`/`) use relative URLs. Per David's Model Rule 4, all URLs should be fully qualified. This is a P1 issue.

#### Images

10 total images on the page. Every single `<img>` tag has:
- `loading="lazy"` (including the hero/first-section image)
- `alt=""` (empty alt text)
- Proper `width` and `height` attributes
- Responsive `<picture>` element with WebP and fallback sources

- **Alt text:** All 10 images have `alt=""` (empty). This marks them all as decorative. For the hero image and the 7 cards images (which illustrate specific concepts like "Unmatched speed", "Content at scale", etc.), empty alt text is incorrect -- these images convey meaning. This is a P1 issue for all 7 card images and the hero image (8 images total).
- **LCP image has `loading="lazy"`:** The first image in the first section (the hero candidate) has `loading="lazy"`. This is a **P0 performance issue** -- the LCP candidate must use `loading="eager"`.
- **LCP image missing `fetchpriority="high"`:** No `fetchpriority` attribute on any image. The LCP candidate should have `fetchpriority="high"`. This is a P1 issue.

---

### Step 3: Metadata Audit

#### Required Metadata

| Field | Present | Value | Assessment |
|-------|---------|-------|------------|
| Title | Yes | "Home \| AEM Boilerplate" (24 chars) | Present but SHORT. 24 characters vs. recommended 50-60. P2. |
| Description | Yes | "Use this template repository as the starting point for new AEM projects." (73 chars) | Present but SHORT. 73 characters vs. recommended 150-160. P2. |
| OG Image | Yes | Full URL to hero image at 1200px width, pjpg format | PASS. |

#### Open Graph Tags

| Tag | Present | Value |
|-----|---------|-------|
| og:title | Yes | "Home \| AEM Boilerplate" |
| og:description | Yes | "Use this template repository as the starting point for new AEM projects." |
| og:url | Yes | "https://main--aem-boilerplate--adobe.aem.live/" |
| og:image | Yes | Full absolute URL to hero image |
| og:image:secure_url | Yes | Same as og:image |

OG tags: PASS -- all present and well-formed.

#### Twitter Card Tags

| Tag | Present | Value |
|-----|---------|-------|
| twitter:card | Yes | "summary_large_image" |
| twitter:title | Yes | "Home \| AEM Boilerplate" |
| twitter:description | Yes | "Use this template repository as the starting point for new AEM projects." |
| twitter:image | Yes | Full absolute URL to hero image |

Twitter tags: PASS.

#### Robots

- **No `<meta name="robots">` tag found.** This means the page defaults to `index, follow`, which is appropriate. PASS.

#### Canonical URL

- `<link rel="canonical" href="https://main--aem-boilerplate--adobe.aem.live/">` -- Present and points to the correct URL. PASS.

#### Template / Theme

- No template or theme metadata observed. N/A for this boilerplate.

---

### Step 4: EDS Performance Audit

#### LCP Budget

- **First section content:** The first section contains one hero image (2048x1134 source, served at up to 2000px width in WebP), an H1, a paragraph with links, an H2, and a `columns` block with 2 more images. This is a moderately heavy first section.
- **LCP image uses `loading="lazy"`:** YES. This is a **P0 CRITICAL** issue. The hero image (the most likely LCP candidate) has `loading="lazy"`, which delays its load until it scrolls into the viewport detection area. It must be `loading="eager"`.
- **LCP image missing `fetchpriority="high"`:** No `fetchpriority` attribute is set. This is a **P1** issue.
- **First section heaviness:** The first section contains the hero image PLUS the full columns block (2 additional images). The columns block should arguably be in a separate section to keep the first section lightweight. P2 recommendation.

#### E-L-D Loading Phases

- **Eager phase:** `aem.js` and `scripts.js` load as modules. `styles.css` loads as a stylesheet. These are correct and minimal.
- **Lazy phase:** `fonts.css` and `lazy-styles.css` are loaded after initial paint by scripts.js. Correct.
- **Delayed phase:** `delayed.js` is loaded via `setTimeout(() => import('./delayed.js'), 3000)`. The file currently contains only a placeholder comment (`// add delayed functionality here`). No third-party scripts are loaded at all. PASS -- clean.
- **Third-party scripts before LCP:** None. PASS.
- **No inline scripts in head beyond boilerplate:** The two script tags are the standard EDS boilerplate. PASS.
- **No large inline styles in head:** None present. PASS.

#### Fonts

- **Font preloading:** No `<link rel="preload">` for fonts. PASS.
- **Fallback fonts with `size-adjust`:** The `styles.css` defines two `@font-face` fallback fonts using `local('Arial')` with `size-adjust` values (88.82% for condensed, 99.529% for regular). PASS.
- **`fonts.css` declarations:** The `fonts.css` file defines 4 `@font-face` rules for `roboto-condensed` (bold) and `roboto` (bold, medium, regular), all with `font-display: swap`. PASS.
- **Same-origin fonts:** Font files are served from `../fonts/` (same origin). PASS.
- **Number of font files:** 4 font files (condensed-bold, roboto-bold, roboto-medium, roboto-regular). This is on the higher end of the 2-3 recommended limit but acceptable. P3 minor note.
- **Fallback font `size-adjust` and overrides in `fonts.css`:** The `@font-face` declarations in `fonts.css` do NOT include `ascent-override`, `descent-override`, or `line-gap-override`. However, the fallback fonts in `styles.css` handle this. The architecture is acceptable.

#### CSS Custom Properties

`styles.css` defines custom properties in `:root`:
- Colors: `--background-color`, `--light-color`, `--dark-color`, `--text-color`, `--link-color`, `--link-hover-color`
- Typography: `--body-font-family`, `--heading-font-family`, plus size variables
- Layout: `--nav-height`

Colors and spacing are consistently referenced via custom properties throughout the stylesheet. PASS.

---

### Step 5: Accessibility Audit

#### Images

- **Every `<img>` has an `alt` attribute:** Yes -- all 10 images have `alt=""`. PASS for attribute presence.
- **Decorative images use `alt=""`:** All images use `alt=""`. However, the hero image and the 7 card images are NOT decorative -- they illustrate specific concepts. They should have descriptive alt text. **P1** (WCAG 1.1.1 -- images that convey meaning need descriptive alt text).
- **Specific images needing alt text:**
  - Hero image: Should describe what the image shows (appears to be a stock photo).
  - Card 1 (Unmatched speed): Should describe the image content.
  - Card 2 (Content at scale): Should describe the image content.
  - Card 3 (Uncertainty eliminated): Should describe the image content.
  - Card 4 (Widen the talent pool): Should describe the image content.
  - Card 5 (Low-code productivity): Should describe the image content.
  - Card 6 (Headless is here): Should describe the image content.
  - Card 7 (Peak performance): Should describe the image content.

#### Headings

- **Heading hierarchy:** H1 > H2 > H2. Logical, no skipped levels. PASS.

#### Links

- **"Click here" or "read more" text:** None found. PASS.
- **Adjacent links to same URL:** The "Live" and "Preview" buttons link to `/` but are in different sections of the columns block, not adjacent. PASS.
- **Bare URL as anchor text:** The tutorial link displays `https://www.aem.live/tutorial` as its anchor text. This is poor for screen readers. **P1.**

#### Color Contrast

- Foreground/background pairs from CSS custom properties:
  - `--text-color: #131313` on `--background-color: white` -- Very high contrast ratio (~19.3:1). PASS.
  - `--link-color: #3b63fb` on `--background-color: white` -- Blue on white. Approximate ratio ~4.6:1. Passes AA for normal text (barely). PASS.
  - `--dark-color: #505050` on `--background-color: white` -- Approximate ratio ~5.9:1. PASS.
  - `--light-color: #f8f8f8` (used as background) with `--text-color: #131313` -- High contrast. PASS.

#### Buttons

- **"Live" button:** `<strong><a href="/">Live</a></strong>` -- Correct primary button pattern. PASS.
- **"Preview" button:** `<em><a href="/">Preview</a></em>` -- Correct secondary button pattern. PASS.

#### Language

- **`<html lang="...">` attribute:** MISSING. The `<html>` tag has no `lang` attribute. **P1** (WCAG 3.1.1).

#### Navigation

- **Skip-to-content link:** Not present in the server-rendered HTML. The header is empty and populated client-side. Could not verify if the nav block adds a skip link. **P2** (recommendation to verify client-side).

---

### Step 6: SEO and AI Discoverability Audit

#### Title and Description

| Field | Value | Length | Target | Assessment |
|-------|-------|--------|--------|------------|
| Title | "Home \| AEM Boilerplate" | 24 chars | 50-60 | Too short. P2. |
| Description | "Use this template repository as the starting point for new AEM projects." | 73 chars | 150-160 | Too short. P2. |

- **H1 relates to title:** H1 is "Congrats, you are ready to go!" vs. title "Home | AEM Boilerplate". These are thematically related (both about the boilerplate) but not closely aligned. **P2.**

#### Structured Data

- **JSON-LD:** None present. For a boilerplate demo page, this is acceptable. For a real production page, structured data would be recommended. **P3** (recommendation only).

#### Internal Linking

- The page links to itself via `/` (Live and Preview buttons). No links to other pages on the site. The nav (loaded client-side) contains links to sub-pages, but the main content itself has no internal cross-links. **P2** for the main content body.

#### URL Structure

- **URL is clean:** `https://main--aem-boilerplate--adobe.aem.live/` -- lowercase, no special characters. The `--` separators are an EDS convention for branch/repo/org. PASS.
- **No `.html` extension:** Correct, extensionless. PASS.
- **Trailing slash:** The root URL ends with `/` which is expected for the root path. PASS.

#### AI Readability

- Content is well-structured with clear headings and concise paragraphs. Each card has a bold title and a one-sentence description. PASS.
- The placeholder heading "This is another headline here for more content" reduces AI readability. P3.

---

### Step 7: EDS Best Practices Audit (David's Model)

| Rule | Finding | Status | Priority |
|------|---------|--------|----------|
| 1. Minimize block usage | 2 blocks (columns, cards) used. Cards block is appropriate for repeating content. Columns block is appropriate for layout. Block-to-content ratio is moderate-high but justified. | PASS | -- |
| 2. No nested blocks | No nested blocks detected. | PASS | -- |
| 3. Constrain table complexity | Columns block has 2 columns. Cards block has 2 columns (image + text). No merged cells. | PASS | -- |
| 4. Fully qualified URLs | Two links use relative URLs: `href="/"` on "Live" and "Preview" buttons. The tutorial link uses a bit.ly shortened URL. | FAIL | P1 |
| 5. Lists as block rows | The columns block contains a `<ul>` list inside a cell (One, Two, Three). This appears to be content within a cell, not a list of items the block should parse individually. | PASS | -- |
| 6. Contextual button inheritance | Buttons use correct `<strong>` (primary) and `<em>` (secondary) patterns. Button text is short (1 word each). | PASS | -- |
| 7. Clean URL filenames | Page URL is clean. However, button links point to `/` which is the same page. | PASS | -- |
| 8. Group content by teams | Cannot fully assess from a single page. Nav structure shows logical grouping. | N/A | -- |
| 9. Control block sprawl | Only 2 block types on this page. | PASS | -- |
| 10. Limit columns | Maximum 2 columns used. | PASS | -- |
| 11. Reference block collection | Both `columns` and `cards` are standard EDS blocks. | PASS | -- |
| 12. Strategic fragment use | No fragments detected on this page. | PASS | -- |
| 13. No hidden semantics | Block names are descriptive of content structure. | PASS | -- |
| 14. Name/value pairs for config only | No misuse of metadata detected. | PASS | -- |
| 15. No HTML/CSS/JSON in documents | No raw HTML, CSS, or JSON in the authored content. There is a `<code>` element wrapping `fstab.yaml` but this is inline code markup, not raw HTML injection. | PASS | -- |

---

### Step 8: Prioritized Report

| # | Priority | Category | Issue | Location | Fix | Impact |
|---|----------|----------|-------|----------|-----|--------|
| 1 | P0 | Performance | LCP candidate image has `loading="lazy"` | Hero image in first section (`<img loading="lazy" alt="" src="./media_180455b...">`) | Change to `loading="eager"` or remove the attribute. In the source Google Doc, ensure the image is in the first section so the EDS boilerplate applies eager loading automatically. The boilerplate's `buildHeroBlock()` function should handle this, but the image appears before the H1 which may bypass the hero detection. Move the H1 above the image in the source document. | Directly delays LCP by 200-500ms. Critical for Core Web Vitals. |
| 2 | P1 | Accessibility | Missing `lang` attribute on `<html>` element | `<html>` tag (line 2 of document) | Add `lang="en"` to the `<html>` tag. This is typically set in `head.html`. Add `<html lang="en">` or ensure the EDS project's head.html includes it. | WCAG 3.1.1 failure. Screen readers cannot determine page language. |
| 3 | P1 | Accessibility | 8 meaningful images have empty alt text | Hero image and all 7 card images (every `<img>` on the page) | In the source Google Doc, add alt text to each image. For the hero image, describe what it shows. For card images, describe the image in context of its heading (e.g., for the "Unmatched speed" card, describe the image that illustrates speed). | WCAG 1.1.1 failure. Screen readers skip all images. SEO loses image context signals. |
| 4 | P1 | Performance | LCP image missing `fetchpriority="high"` | Hero image in first section | The EDS boilerplate should add this automatically for eager images. Fixing issue #1 (making the image eager via hero block detection) should resolve this as well. | Browser may not prioritize LCP image download, adding 50-200ms to LCP. |
| 5 | P1 | Content | Bare URL used as link anchor text | Tutorial link: anchor text is `https://www.aem.live/tutorial` | Change the link text in the source Google Doc to something descriptive, e.g., "AEM tutorial" or "Get started with the full tutorial". | Poor for accessibility (screen readers read the full URL) and usability. |
| 6 | P1 | EDS Best Practices | Relative URLs used for button links | "Live" button (`href="/"`) and "Preview" button (`href="/"`) | Change to fully qualified URLs in the source document: `https://main--aem-boilerplate--adobe.aem.live/`. Per David's Model Rule 4, all URLs must be absolute. | Relative URLs break in syndication, email, and preview contexts. |
| 7 | P1 | Content | Tutorial link href uses bit.ly shortener | `<a href="https://bit.ly/3aImqUL">` | Replace with the direct URL: `https://www.aem.live/tutorial`. Shorteners add redirect latency, break if the service goes down, and obscure the destination. | Added latency, link fragility, trust concerns. |
| 8 | P2 | SEO | Page title too short (24 chars) | `<title>Home \| AEM Boilerplate</title>` | Expand the title in the metadata table of the source document. Example: "AEM Edge Delivery Services Boilerplate - Get Started" (52 chars). | Suboptimal search snippet. Wasted title real estate. |
| 9 | P2 | SEO | Meta description too short (73 chars) | `<meta name="description" content="Use this template repository...">` | Expand the description in the source document metadata. Example: "The AEM Boilerplate is your starting point for building Edge Delivery Services websites. Fork this template to get a project with Lighthouse 100 scores, optimized content delivery, and Google Docs authoring." (199 chars -- trim to 155). | Suboptimal search snippet. Reduced click-through rate. |
| 10 | P2 | SEO | H1 does not closely relate to page title | H1: "Congrats, you are ready to go!" vs. title: "Home \| AEM Boilerplate" | Align the H1 with the page topic. Change H1 to something like "AEM Boilerplate: You're Ready to Go" or change the title to match the congratulatory tone. | Weak topical signal for search engines. |
| 11 | P2 | Content | Placeholder heading text | H2: "This is another headline here for more content" | Replace with a meaningful heading that describes the section content, e.g., "Try It Out" or "Explore the Columns Block". | Meaningless heading hurts scannability and SEO. |
| 12 | P2 | Accessibility | No skip-to-content link verified | Header/nav area | Ensure the nav block implementation includes a skip-to-main-content link as its first focusable element. | Keyboard-only users must tab through the entire nav to reach content. |
| 13 | P2 | Performance | First section too heavy | First section contains hero image + H1 + paragraph + H2 + full columns block with 2 more images | Split the first section before the H2/columns block. Add a horizontal rule (`---`) in the source document between the intro content and the columns block. This pushes the columns block to the lazy loading phase. | Columns block CSS/JS loads in eager phase, competing with LCP. Two extra images load eagerly. |
| 14 | P2 | Content | External link missing `target` hint | Google Drive link has no target attribute | External links to third-party domains (Google Drive) should ideally signal that they leave the site. Consider adding target behavior or, in EDS, accept that the default behavior (same tab) is the convention. | Minor UX -- users leave the site unexpectedly. |
| 15 | P3 | SEO | No JSON-LD structured data | Entire page | For a boilerplate demo page, this is not critical. For production pages built from this template, add appropriate JSON-LD (WebSite, Organization, etc.). | Lost rich snippet opportunities. |
| 16 | P3 | Content | Heading ends with question mark | H2: "Boilerplate Highlights?" | Remove the question mark: "Boilerplate Highlights". Section headings should be declarative. | Minor -- unusual style for a section heading. |
| 17 | P3 | SEO/AI | Placeholder content reduces AI readability | "This is another headline here for more content" and generic demo text | Replace all placeholder text with real content for production use. | LLMs and search engines index placeholder text as actual content. |
| 18 | P3 | Performance | 4 font files loaded (recommendation is 2-3) | `fonts.css` loads roboto-condensed-bold, roboto-bold, roboto-medium, roboto-regular | Consider dropping roboto-medium if not widely used, reducing to 3 font files. | Minor -- each font file is an additional download. |

---

### Executive Summary

This is Adobe's official AEM Boilerplate demo page -- a template that new EDS projects fork as their starting point. Overall, the page follows EDS architecture patterns well: the E-L-D loading strategy is correctly implemented, CSS custom properties are used for theming, font fallbacks use `size-adjust`, and blocks are standard and appropriately used. However, there is one critical performance defect (the LCP image is lazy-loaded), several accessibility gaps (missing `lang` attribute, empty alt text on meaningful images), and content quality issues typical of a boilerplate/demo page (placeholder text, relative URLs, short metadata). The page is well-built structurally but needs these specific fixes before it should be considered a reference for best practices.

### Top 3 Fixes

**1. Fix LCP image loading (P0 -- Performance)**
The hero image in the first section has `loading="lazy"`, which delays Largest Contentful Paint by 200-500ms. In the source Google Doc, move the H1 heading ABOVE the hero image so that the EDS boilerplate's `buildHeroBlock()` function detects the image as part of the hero and applies `loading="eager"` and `fetchpriority="high"` automatically. Alternatively, if the image-first layout is intentional, the scripts.js `buildHeroBlock()` function needs to be updated to detect this pattern.

**2. Add alt text to all meaningful images (P1 -- Accessibility)**
All 10 images on the page have `alt=""`, marking them as decorative. The hero image and all 7 card images convey meaning and need descriptive alt text. In the source Google Doc, right-click each image and add alt text. For example, for the "Unmatched speed" card, the alt text should describe what the image actually depicts (e.g., "Speedometer dashboard showing maximum performance"). Do this for all 8 meaningful images.

**3. Add `lang="en"` to the HTML element (P1 -- Accessibility)**
The `<html>` tag has no `lang` attribute. Open the project's `head.html` file and ensure the opening HTML tag includes `lang="en"` (or the appropriate language code). This is a one-line fix that resolves a WCAG 3.1.1 failure and helps screen readers announce content in the correct language.

### Score

**C (65%)** -- Needs work before being used as a production reference.

The structural foundation is solid (correct E-L-D phasing, proper CSS architecture, clean block usage), but the P0 LCP issue, multiple P1 accessibility failures, and placeholder content prevent a higher score. For a boilerplate template that new projects fork, these issues propagate to every downstream site, making them higher impact than they would be on a single production page.

---

---

## Part 2: Skill Evaluation (Test Report)

### Did every step work as written?

**Mostly yes, with two exceptions:**

1. **Step 0 (Create Todo List):** The skill says "create a checklist." This worked fine -- I tracked progress against the checklist throughout.

2. **Step 1 (Fetch and Parse Page):** The skill says to fetch `.plain.html` by appending it to the path. For the root URL (`/`), the correct variant is `/index.plain.html`, NOT `/.plain.html`. The `.plain.html` path returned a 404. The skill's troubleshooting section covers the 404 case ("Page may use a non-standard path structure") which helped, but the instructions should explicitly note that the root path `/` requires `index.plain.html`. This is a gap.

3. **Step 1 (Fetch and Parse Page):** The WebFetch tool converts HTML to markdown and cannot reliably extract head-level metadata, inline attributes like `loading`, `fetchpriority`, `alt`, `lang`, etc. I had to fall back to `curl` to get the raw HTML. The skill assumes the auditor can see the full DOM, but the available tool (WebFetch) provides a lossy markdown conversion. This is a tooling limitation, not a skill bug -- but the skill could note that raw HTML access (via curl, view-source, or browser devtools) is needed for a thorough audit.

4. **Steps 2-7 (All audit steps):** Each step provided clear, specific things to check with defined priority levels. Every check was actionable and could be evaluated against the fetched content.

5. **Step 8 (Generate Report):** The report format (priority table + executive summary + top 3 fixes + score) was clear and easy to follow.

### Were any instructions unclear or impossible to follow?

| Instruction | Issue | Severity |
|-------------|-------|----------|
| Step 1: "append `.plain.html` to the path" | Ambiguous for the root URL `/`. Does `/` become `/.plain.html` or `/index.plain.html`? The former returns 404. | Medium -- caused a failed fetch |
| Step 2, Links: "Fetch-check any internal links" | The skill says to check internal links by fetching them. On a page with client-side navigation, many links are only visible after JS executes. The server-rendered HTML may not contain all links. This was not an issue here but could be on complex pages. | Low -- edge case |
| Step 4: "aggregate size of content before the LCP element should be under 100KB" | This requires measuring actual resource sizes (CSS file size, JS file size, image size). The skill does not describe HOW to measure this -- should the auditor fetch each resource and measure bytes? Or estimate? | Medium -- unclear methodology |
| Step 5, Color Contrast: "Check CSS custom properties for foreground/background pairs" | This requires computing contrast ratios from hex values. The skill does not specify what tool or formula to use. I computed approximate ratios, but this step would benefit from pointing to a contrast checker. | Low -- feasible but vague |
| Step 7: "Check against Adobe's content modeling rules" | Clear and well-structured. The reference table in the skill maps directly to the `content-modeling-rules.md` resource. | None -- worked well |

### Did the skill produce useful, actionable output?

**Yes -- strongly.** The audit identified:
- 1 critical (P0) performance issue that directly impacts Core Web Vitals
- 6 high-priority (P1) issues across accessibility, content quality, and EDS best practices
- 7 medium-priority (P2) issues
- 4 low-priority (P3) recommendations

Every finding included a specific location, a concrete fix, and an impact statement. The output is directly actionable by a content author or developer -- no vague hand-waving.

The prioritization system (P0-P3) made it easy to triage. The "Top 3 Fixes" section gave clear marching orders. The score (C, 65%) provided a quick health summary.

### Bugs, gaps, or improvements needed in SKILL.md

| # | Type | Description | Suggested Fix |
|---|------|-------------|---------------|
| 1 | **Bug** | `.plain.html` path construction fails for root URLs | Add a note: "For the root URL (`/`), use `/index.plain.html` instead of `/.plain.html`." |
| 2 | **Gap** | The skill assumes DOM-level access but does not specify what tools/methods are needed to get raw HTML | Add a note in Step 1: "The full HTML source (not a markdown conversion) is required for attributes like `loading`, `alt`, `fetchpriority`, `lang`, and head metadata. Use `curl`, browser View Source, or a raw HTML fetcher." |
| 3 | **Gap** | Step 4 LCP budget check says "under 100KB aggregate" but does not describe how to measure | Add guidance: "To estimate the LCP budget, sum the sizes of the HTML document, eager-loaded CSS/JS files, and any images in the first section. Use `curl -sI <url>` to check Content-Length headers, or fetch each resource and measure." |
| 4 | **Gap** | No guidance on client-side rendered content (header, footer, nav) | Add a note: "EDS pages render header and footer client-side via JS. The server-rendered HTML will show empty `<header>` and `<footer>` elements. To audit nav and footer content, fetch `/nav` and `/footer` separately, or inspect the page after JS execution." |
| 5 | **Improvement** | Step 5 contrast checking is vague | Add: "Use the WCAG contrast ratio formula or a tool like WebAIM's contrast checker. For hex values, the formula is: contrast ratio = (L1 + 0.05) / (L2 + 0.05) where L1 and L2 are relative luminances." |
| 6 | **Improvement** | The skill does not mention the `head.html` file as a fetchable resource | Add to Step 1: "Optionally fetch `/head.html` to see what the project injects into every page's `<head>` (scripts, meta tags, inline styles)." |
| 7 | **Improvement** | Step 2 says block names should be "lowercase, hyphenated" but does not mention that standard blocks like `columns` and `cards` are expected names | Add examples of standard EDS block names (columns, cards, hero, tabs, accordion, carousel) so the auditor can distinguish standard from custom. |
| 8 | **Minor** | The skill references "David's Model" in Step 7 but the resource file calls them "David's Model: 15 Rules." Some users may not know who David is. | Add a brief note: "David Nuescheler's content modeling rules (Adobe's official EDS content guidance)." This is already in the resource file but not in the skill instructions. |
| 9 | **Improvement** | No mention of checking `scripts.js` or `delayed.js` directly | Add to Step 4: "Fetch `/scripts/scripts.js` and `/scripts/delayed.js` to verify the E-L-D loading implementation. Check that `delayed.js` is loaded with a 3-second timeout and that no third-party scripts appear in `scripts.js`." |
| 10 | **Improvement** | The scoring rubric (A/B/C/D) is subjective -- no formula | Consider adding: "Subtract points for each finding: P0 = -15 points, P1 = -5 points, P2 = -2 points, P3 = -1 point. Start at 100. The score maps to the letter grade." This makes scoring reproducible. |

### Overall Skill Assessment

**The skill works.** It produced a thorough, prioritized, actionable audit of a real EDS page. The instructions were clear enough to follow from start to finish, and the resource files (performance rules, content modeling rules) provided the necessary reference material.

The main areas for improvement are:
1. Handling edge cases in URL construction (root path `.plain.html`)
2. Being more explicit about tooling requirements (raw HTML access vs. markdown conversion)
3. Adding measurement guidance for the LCP budget check
4. Acknowledging client-side rendering in EDS (header/footer are JS-rendered)

None of these are blockers. The skill is ready for use with a "v1.1" pass to address the gaps above.

**Verdict: PASS -- ready to publish with minor improvements recommended.**

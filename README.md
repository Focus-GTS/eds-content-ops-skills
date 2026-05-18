# EDS Content Ops Skills

Content operations skills for Adobe Edge Delivery Services (EDS / aem.live). Built for AI coding agents — Claude Code, Cursor, GitHub Copilot, and any agent that supports the [agentskills.io](https://agentskills.io) specification.

**42 skills across 9 categories — content ops, SEO, accessibility, blocks, migration, commerce, DevOps, analytics, and client deliverables.**

---

## Featured: EDS Skill Catalog

> **Not sure which skills you need?** Start here.

| Skill | What it does |
|-------|-------------|
| [eds-skill-catalog](skills/eds-skill-catalog/) | Scans your project, indexes all available Adobe EDS skills (official + community), and recommends which to activate. Auto-refreshes nightly from the adobe/skills repo. |

Run it once at project setup and it tells you exactly which skills to install based on your project's maturity, block count, and current work patterns.

---

## Skills

### Project Health & Planning

| Skill | What it does |
|-------|-------------|
| [eds-skill-catalog](skills/eds-skill-catalog/) | Index all Adobe EDS skills and recommend which to activate for your project. Auto-refreshes nightly. |
| [eds-project-health](skills/eds-project-health/) | Comprehensive codebase audit — boilerplate currency, CSS scoping, block structure, performance patterns, configuration. |

### Content Quality & Auditing

| Skill | What it does |
|-------|-------------|
| [content-audit](skills/content-audit/) | Audit an EDS page for content quality, SEO, accessibility, performance, and EDS best practices. |
| [content-diff](skills/content-diff/) | Compare two versions of a page (preview vs live) to see exactly what changed before publishing. |
| [content-freshness](skills/content-freshness/) | Flag stale or outdated content across an EDS site using the query index and Last-Modified dates. |
| [reading-level](skills/reading-level/) | Score readability and suggest simplifications (Flesch-Kincaid, passive voice, jargon detection). |
| [brand-voice-check](skills/brand-voice-check/) | Check page content against a brand style guide for term usage, tone, and formatting rules. |

### SEO & Discovery

| Skill | What it does |
|-------|-------------|
| [geo-rewrite](skills/geo-rewrite/) | Rewrite page content for AI search discoverability (GEO). Optimizes structure and factual density. |
| [structured-data](skills/structured-data/) | Generate JSON-LD structured data for EDS pages based on content and metadata analysis. |
| [heading-optimizer](skills/heading-optimizer/) | Audit and optimize headings for search intent, hierarchy, and consistency across pages. |
| [image-seo](skills/image-seo/) | Audit images for alt text quality, missing dimensions, lazy loading, and fetch priority. |
| [internal-linking](skills/internal-linking/) | Analyze internal link structure, identify orphan pages, and generate linking recommendations. |
| [sitemap-audit](skills/sitemap-audit/) | Validate sitemap.xml against actual site content and the query index. |

### Accessibility & Performance

| Skill | What it does |
|-------|-------------|
| [accessibility-fix](skills/accessibility-fix/) | Scan for WCAG 2.1 AA violations and generate fixes at the source document level. |
| [performance-budget](skills/performance-budget/) | Deep analysis of the EDS 100KB LCP budget — inventories critical-path resources and E-L-D phases. |
| [cwv-optimizer](skills/cwv-optimizer/) | Diagnose and fix Core Web Vitals issues (LCP, CLS, INP) specific to EDS architecture. |

### Publishing & Launch

| Skill | What it does |
|-------|-------------|
| [publish-readiness](skills/publish-readiness/) | Pre-publish gate combining content quality, accessibility, and change review into a go/no-go checklist. |
| [go-live-checklist](skills/go-live-checklist/) | Full site launch readiness check — DNS, HTTPS, robots.txt, metadata, performance, analytics, redirects. |
| [redirect-manager](skills/redirect-manager/) | Audit the EDS redirects spreadsheet for chains, loops, broken destinations, and SEO issues. |

### Site Operations

| Skill | What it does |
|-------|-------------|
| [bulk-metadata](skills/bulk-metadata/) | Audit and update metadata across multiple pages via the query index and bulk metadata spreadsheet. |
| [query-index-optimizer](skills/query-index-optimizer/) | Audit and optimize the EDS query index configuration (helix-query.yaml). |
| [localization-audit](skills/localization-audit/) | Audit multi-language EDS sites for content parity, missing translations, and hreflang issues. |
| [link-rot-scanner](skills/link-rot-scanner/) | Crawl and validate all internal and external links across an EDS site. |
| [author-onboarding](skills/author-onboarding/) | Interactive training coach for new EDS content authors — walks through document-based authoring fundamentals. |

### Block Development

| Skill | What it does |
|-------|-------------|
| [block-scaffolder](skills/block-scaffolder/) | Generate boilerplate files for new EDS blocks following best practices. |
| [block-testing](skills/block-testing/) | Generate test suites for EDS blocks covering variants, responsiveness, accessibility. |
| [block-migration](skills/block-migration/) | Migrate blocks between EDS projects with dependency resolution. |
| [block-accessibility](skills/block-accessibility/) | Audit blocks for keyboard navigation, ARIA, screen reader, and focus management. |

### Migration

| Skill | What it does |
|-------|-------------|
| [aem-to-eds-migration](skills/aem-to-eds-migration/) | Plan and execute migration from traditional AEM Sites to Edge Delivery Services. |
| [content-migration](skills/content-migration/) | Bulk migrate content pages between EDS projects or from external sources. |
| [redirect-migration](skills/redirect-migration/) | Generate redirect maps for domain/path migrations preserving SEO equity. |

### Commerce

| Skill | What it does |
|-------|-------------|
| [storefront-setup](skills/storefront-setup/) | Configure EDS Commerce (Dropin) storefront with catalog integration. |
| [product-page-seo](skills/product-page-seo/) | Optimize product pages for search with structured data, schema, and content patterns. |
| [catalog-audit](skills/catalog-audit/) | Audit product catalog pages for completeness, consistency, and SEO readiness. |

### DevOps

| Skill | What it does |
|-------|-------------|
| [eds-cicd-pipeline](skills/eds-cicd-pipeline/) | Set up CI/CD pipelines (GitHub Actions) for EDS projects with Lighthouse, linting, PSI. |
| [environment-management](skills/environment-management/) | Manage EDS environment configurations across dev, stage, and production. |
| [boilerplate-upgrade](skills/boilerplate-upgrade/) | Analyze and apply upstream boilerplate updates safely without breaking customizations. |

### Analytics & Experimentation

| Skill | What it does |
|-------|-------------|
| [optel-interpreter](skills/optel-interpreter/) | Analyze Operational Telemetry (OpTel) data to identify performance and engagement patterns. |
| [experiment-designer](skills/experiment-designer/) | Design A/B and multivariate experiments using EDS built-in experimentation framework. |

### Client Deliverables

| Skill | What it does |
|-------|-------------|
| [site-health-report](skills/site-health-report/) | Generate client-facing site health reports with scores, trends, and recommendations. |
| [roi-narrative](skills/roi-narrative/) | Build ROI narratives from EDS performance data for stakeholder presentations. |
| [launch-retrospective](skills/launch-retrospective/) | Generate post-launch retrospective reports covering performance, issues, and wins. |

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

- "Which skills should I use for this project?" → eds-skill-catalog
- "Audit this EDS project's codebase" → eds-project-health
- "Audit this EDS page for quality issues" → content-audit
- "Optimize this page for AI search" → geo-rewrite
- "Fix the accessibility issues on this page" → accessibility-fix
- "Check metadata across the site" → bulk-metadata
- "What changed between preview and live?" → content-diff
- "Is this page ready to publish?" → publish-readiness
- "Check the site before launch" → go-live-checklist
- "Find broken links on the site" → link-rot-scanner
- "Scaffold a new EDS block" → block-scaffolder
- "Migrate this site from AEM to EDS" → aem-to-eds-migration
- "Set up a commerce storefront" → storefront-setup
- "Set up CI/CD for this EDS project" → eds-cicd-pipeline
- "Analyze the OpTel data" → optel-interpreter
- "Generate a site health report for the client" → site-health-report

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

Built by [FocusGTS](https://focusgts.com) — Adobe Silver Solution Partner specializing in Edge Delivery Services. Try [EDS Score](https://www.focusgts.com/eds-score/) — our free site health analyzer for EDS sites.

## License

Apache-2.0

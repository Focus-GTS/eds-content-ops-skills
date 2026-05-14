# LinkedIn Post — Final

---

Adobe built 20 AI skills for developing Edge Delivery Services sites.

Nobody built skills for operating them.

So we did.

After Summit, I kept thinking about the gap. Adobe shipped MCP servers for AEM, launched CX Enterprise, and made it clear: the future of content management is agentic. They built skills to help AI agents create sites, build blocks, and import pages. All developer-focused.

But what about the people who actually run live EDS sites? The content teams publishing 50 pages a week. The marketers asking: "Is this page accessible? Is the metadata right? What changed since the last publish? Will this rank in AI search?"

Nobody built tools for them. Until now.

We just open-sourced 5 content operations skills for EDS — the first from any third party:

1. content-audit — Audit any EDS page against 40+ checks across SEO, accessibility, performance, and EDS best practices. Get a prioritized fix list with specific steps.

2. geo-rewrite — Optimize content for AI search (GEO). AI-powered search engines favor content that directly answers questions, eliminates filler, and is structured for extraction. This skill scores your content and rewrites it.

3. accessibility-fix — Scan for WCAG 2.1 AA violations. With the European Accessibility Act in force, this isn't optional. Generates fixes at the source document level — in the Google Doc or Word file where your authors actually work.

4. bulk-metadata — Scan your entire site's query index, find pages with missing or weak metadata, and generate a corrected bulk metadata spreadsheet.

5. content-diff — Compare preview vs live to see exactly what changed before you hit publish. Flags changes that could impact SEO, performance, or accessibility.

Every skill is built specifically for EDS — blocks, sections, the E-L-D loading pattern, the 100KB LCP budget, metadata spreadsheets, Sidekick workflows, document-based authoring. Not generic web tools. EDS-native.

Works in Claude Code and Cursor. Apache-2.0. Free forever.

github.com/focusgts/eds-content-ops-skills

This is just the start. We're building the autonomous content operations layer for Edge Delivery Services. More coming soon.

#AdobeEDS #EdgeDeliveryServices #AEM #ContentOps #AI #AgentSkills #WCAG #GEO

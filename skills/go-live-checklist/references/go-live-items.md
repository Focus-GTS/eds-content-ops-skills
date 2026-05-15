# Go-Live Checklist Items

Comprehensive list of items to verify before launching an AEM Edge Delivery Services site on its production domain.

## DNS and Infrastructure

- [ ] Production domain resolves to EDS CDN
- [ ] HTTPS is configured and certificate is valid
- [ ] HTTP-to-HTTPS redirect is in place
- [ ] Apex domain redirects to canonical form (e.g., example.com -> www.example.com)
- [ ] All domain variants redirect to canonical (http/https, www/non-www)
- [ ] CDN cache headers are correct for static assets
- [ ] No `x-robots-tag: noindex` on production responses

## Robots and Crawling

- [ ] Production robots.txt does NOT block crawlers (`Disallow: /`)
- [ ] robots.txt includes `Sitemap:` directive pointing to production URL
- [ ] `/drafts/` and `/tools/` paths are disallowed (if they exist)
- [ ] `.aem.page` and `.aem.live` environments block crawlers (default EDS behavior)

## Sitemap

- [ ] sitemap.xml is accessible at production domain
- [ ] Sitemap URLs use the production domain (not `.aem.live`)
- [ ] All important pages are included in the sitemap
- [ ] No broken URLs in the sitemap

## Metadata (per key page)

- [ ] Title tag exists and is 50-60 characters
- [ ] Meta description exists and is 150-160 characters
- [ ] Canonical URL points to production domain
- [ ] og:title, og:description, og:image are present
- [ ] og:url uses production domain
- [ ] No unintentional `noindex` meta tags

## Performance

- [ ] LCP image does NOT have `loading="lazy"`
- [ ] LCP image has `fetchpriority="high"`
- [ ] First section is lightweight (under 100KB aggregate)
- [ ] Third-party scripts are in `delayed.js` (not in head or inline)
- [ ] No font preloading (`<link rel="preload" as="font">`)
- [ ] Fallback fonts use `size-adjust` in CSS
- [ ] No excessive inline styles or scripts in head.html

## Analytics

- [ ] Analytics/tag manager scripts load via `delayed.js`
- [ ] Analytics scripts are NOT in `<head>` or inline HTML
- [ ] Analytics data is flowing in the platform dashboard (manual check)
- [ ] Cookie consent banner is present (if required by jurisdiction)

## Branding and Social

- [ ] Favicon is present and loads correctly
- [ ] Apple-touch-icon is present
- [ ] og:image is accessible and appropriately sized (1200x630 recommended)
- [ ] Twitter/X card meta tags are configured
- [ ] JSON-LD structured data on homepage (Organization or WebSite)

## Content

- [ ] Homepage loads correctly with all blocks rendering
- [ ] Navigation (header) loads and links work
- [ ] Footer loads with correct content
- [ ] No placeholder text (Lorem ipsum, TBD, TODO)
- [ ] Contact information is accurate
- [ ] Legal pages are linked (Privacy Policy, Terms)
- [ ] 404 page is configured and branded

## Migration (if applicable)

- [ ] Old domain homepage redirects to new domain (301)
- [ ] Key old URLs redirect to corresponding new URLs (301)
- [ ] Redirects spreadsheet covers high-traffic old URLs
- [ ] Google Search Console Change of Address submitted
- [ ] Both old and new domains added to Search Console
- [ ] Old domain SSL certificate remains valid during redirect period

## Post-Launch Monitoring

- [ ] Monitor Google Search Console for crawl errors (first 48 hours)
- [ ] Monitor analytics for traffic patterns
- [ ] Check Core Web Vitals in Search Console after data populates
- [ ] Verify key pages appear in search results within 1-2 weeks
- [ ] Monitor 404 reports for missed redirects

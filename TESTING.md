# Pre-launch test checklist

- [ ] Check every page link on desktop and mobile.
- [ ] Confirm all real company contact details and approved portfolio items.
- [ ] Review starter prices, equipment add-ons, urgent timeline adjustment, taxes and revision policy.
- [ ] Test quote form validation and confirm the reference is returned only after the database insert succeeds.
- [ ] Confirm the owner notification email arrives and contains no unnecessary sensitive data.
- [ ] Test admin login, session expiry, status updates, logout and invalid credentials.
- [ ] Confirm database tables have RLS enabled and no public policies.
- [ ] Confirm secrets are only in the deployment environment and `.env` is not committed.
- [ ] Configure and verify payments server-side before showing a live Pay button.
- [ ] Add real AI provider only after implementing server-side structured output and price validation.
- [ ] Review privacy policy, terms, accessibility, SEO metadata and performance.

# SRS Vision Official Website — Advanced Starter

A responsive, multi-page creative agency website with a pastel white/lavender/blue visual system, separate URLs, a guided quotation estimator, and a private owner-admin starter.

## Pages included

- Home, Services, Portfolio, About, Team, Process, Pricing, Contact, FAQ
- Individual service pages: Web Development, UI/UX Design, Logo Design, Graphic Design, Social Media Management, Video Editing
- AI-assisted quotation workflow (currently rule-based estimate logic; an AI provider is **not connected yet**)
- Request Quote, Booking, Client Portal, Project Status, Payments, Invoices, Payment Status
- Resources, Blog, Careers, Partnerships, Newsletter, Privacy, Terms
- Owner Admin page at `/admin.html`

## Important before launch

This is a working starter project, not a fully configured live production service. Do not claim payments, push notifications, AI-generated quotes, client login, or page-content editing are live until configured and tested. Prices are editable starter estimates in `assets/js/quotation.js` and `backend/server.js`; confirm your real pricing before publishing. Equipment charges are indicative and should be reviewed. The quote range is preliminary, not a binding offer.

## Run locally

1. Install Node.js 20 or later.
2. Open a terminal in `backend/` and run `npm install`.
3. Copy `backend/.env.example` to `backend/.env` and fill in server-only secrets.
4. Run the SQL in `database/schema.sql` in your Supabase SQL Editor.
5. Start with `npm start` from `backend/`.
6. Open `http://localhost:3000`.

## Configure owner login

Generate a password hash:

```bash
node -e "require('bcryptjs').hash('USE-A-STRONG-UNIQUE-PASSWORD',12).then(console.log)"
```

Put the hash in `ADMIN_PASSWORD_HASH`, your owner email in `ADMIN_EMAIL`, and a long random value in `JWT_SECRET`. Do not commit `backend/.env`. Use HTTPS in production. The owner login is only available when these environment variables are configured.

## Configure database and email alerts

- Set `SUPABASE_URL` and the Supabase **service role key** in backend environment variables only. Never put the service-role key in browser code or GitHub.
- Run `database/schema.sql` first.
- Configure SMTP values and `OWNER_NOTIFICATION_EMAIL` to send an email when a quotation request is stored.
- The browser currently submits to `/api/quotations`; if the backend is not running and configured, it will explain that the request was not sent.

## AI quotations

The current estimate engine uses a server/client rule-based price table. To use a real AI model, add a server-side provider integration that returns a structured explanation while the server remains authoritative for the actual price calculation. Never let an AI model invent final prices or directly confirm a binding quote. Store the provider key only in backend environment variables.

## Payments and notifications

Razorpay or another provider is **not connected** in this starter. Add server-created orders, signature verification and webhook verification before enabling live payment. Email alerts require SMTP configuration. Browser push alerts require HTTPS, a service worker, user permission, and a push provider; they are not enabled yet.

## Owner controls

`admin.html` is a private management UI starter with server-authenticated login, quotation status management, and website settings. It is not a complete visual CMS yet: full page-by-page editing and saving service-price changes need to be completed and tested before promising that every slot can be modified. Protect admin routes, configure backups, and test security before using with real customer information.

## Deploy

Deploy the full project with a Node-capable host (for example Render, Railway, or a VPS). Configure environment variables in the host dashboard, attach your custom domain after deployment, enforce HTTPS, and test all flows using dummy data before publishing.

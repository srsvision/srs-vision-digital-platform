-- Run in Supabase SQL Editor. Backend uses service-role key server-side only.
create extension if not exists pgcrypto;
create table if not exists public.quotations (
 id uuid primary key default gen_random_uuid(), reference text unique not null,
 name text not null, email text not null, phone text not null, company text default '',
 service text not null, scope text not null check (scope in ('basic','standard','advanced')),
 deadline text default 'flexible', equipment jsonb not null default '[]'::jsonb,
 details text default '', estimate_low integer not null default 0, estimate_high integer not null default 0,
 status text not null default 'new' check (status in ('new','reviewing','quoted','closed')),
 source text default 'website', created_at timestamptz not null default now()
);
create index if not exists quotations_created_at_idx on public.quotations(created_at desc);
create index if not exists quotations_status_idx on public.quotations(status);
create table if not exists public.site_settings (
 key text primary key, value text not null, updated_at timestamptz not null default now()
);
create table if not exists public.service_prices (
 service_key text primary key, display_name text not null,
 basic_price integer not null default 0, standard_price integer not null default 0, advanced_price integer not null default 0,
 active boolean not null default true, updated_at timestamptz not null default now()
);
create table if not exists public.site_pages (
 slug text primary key, title text not null, hero_text text default '', body jsonb not null default '{}'::jsonb,
 published boolean not null default false, updated_at timestamptz not null default now()
);
-- Keep all tables private to clients. Requests and admin reads/writes go through the backend only.
alter table public.quotations enable row level security;
alter table public.site_settings enable row level security;
alter table public.service_prices enable row level security;
alter table public.site_pages enable row level security;
-- Do not create anon/authenticated policies for these tables. Server-side service role bypasses RLS.
insert into public.site_settings(key,value) values
 ('companyName','SRS Vision'),('contactEmail',''),('contactPhone',''),('accent','#6d4aff'),
 ('heroHeadline','We turn your ideas into digital reality.'),
 ('footerMessage','Creative thinking, thoughtful design and digital solutions to help businesses move forward.')
on conflict(key) do nothing;
insert into public.service_prices(service_key,display_name,basic_price,standard_price,advanced_price) values
 ('web-development','Web Development',8000,18000,35000),('ui-ux-design','UI/UX Design',5000,12000,25000),
 ('logo-design','Logo Design',1500,3500,7000),('graphic-design','Graphic Design',1500,5000,12000),
 ('social-media','Social Media Management',4000,8000,16000),('video-editing','Video Editing',2000,6000,14000),
 ('multiple-services','Multiple Services',10000,25000,50000)
on conflict(service_key) do nothing;

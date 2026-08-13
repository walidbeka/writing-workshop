-- Run this in Supabase SQL Editor.
create table if not exists public.workshop_prices (
  course text primary key check (course in ('offline','live','recorded')),
  price integer not null check (price >= 0),
  updated_at timestamptz not null default now()
);
insert into public.workshop_prices(course,price) values
('offline',2100),('live',1700),('recorded',950)
on conflict (course) do nothing;

alter table public.workshop_prices enable row level security;
drop policy if exists "public can read prices" on public.workshop_prices;
create policy "public can read prices" on public.workshop_prices for select using (true);

drop policy if exists "authenticated can update prices" on public.workshop_prices;
create policy "authenticated can update prices" on public.workshop_prices for update to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');

drop policy if exists "authenticated can insert prices" on public.workshop_prices;
create policy "authenticated can insert prices" on public.workshop_prices for insert to authenticated with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');

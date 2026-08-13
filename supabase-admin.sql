-- Run this once in Supabase > SQL Editor
create table if not exists public.workshop_prices (
  id bigint primary key generated always as identity,
  course_key text unique not null,
  course_name text not null,
  current_price numeric not null,
  old_price numeric not null,
  updated_at timestamptz not null default now()
);

insert into public.workshop_prices (course_key, course_name, current_price, old_price)
values
('offline','ورشة الكتابة الأوفلاين',2100,3000),
('live','ورشة الكتابة الأونلاين Live',1700,2500),
('recorded','كورس الكتابة المسجل',950,1500)
on conflict (course_key) do nothing;

alter table public.workshop_prices enable row level security;

drop policy if exists "public can read prices" on public.workshop_prices;
create policy "public can read prices"
on public.workshop_prices for select
to anon, authenticated
using (true);

drop policy if exists "authenticated admins can update prices" on public.workshop_prices;
create policy "authenticated admins can update prices"
on public.workshop_prices for update
to authenticated
using ((auth.jwt() ->> 'email') = 'wmr77077@gmail.com')
with check ((auth.jwt() ->> 'email') = 'wmr77077@gmail.com');

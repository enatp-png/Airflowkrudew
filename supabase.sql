-- Air Flow Mission Modern
-- Run in Supabase SQL Editor

create extension if not exists "pgcrypto";

create table if not exists public.student_groups (
  id uuid primary key default gen_random_uuid(),
  group_name text not null unique,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  group_id uuid references public.student_groups(id) on delete cascade,
  student_no text,
  student_code text,
  student_name text not null,
  is_active boolean not null default true,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.submissions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid references public.students(id) on delete set null,
  group_id uuid references public.student_groups(id) on delete set null,
  student_name text not null,
  student_no text,
  student_code text,
  group_name text,
  mission_no int not null check (mission_no between 1 and 5),
  explanation text,
  image_path text,
  image_url text,
  score numeric,
  teacher_comment text,
  created_at timestamptz not null default now()
);

alter table public.student_groups enable row level security;
alter table public.students enable row level security;
alter table public.submissions enable row level security;

drop policy if exists "public read groups" on public.student_groups;
drop policy if exists "public insert groups" on public.student_groups;
drop policy if exists "public update groups" on public.student_groups;
drop policy if exists "public delete groups" on public.student_groups;

drop policy if exists "public read students" on public.students;
drop policy if exists "public insert students" on public.students;
drop policy if exists "public update students" on public.students;
drop policy if exists "public delete students" on public.students;

drop policy if exists "public read submissions" on public.submissions;
drop policy if exists "public insert submissions" on public.submissions;
drop policy if exists "public update submissions" on public.submissions;
drop policy if exists "public delete submissions" on public.submissions;

create policy "public read groups" on public.student_groups for select using (true);
create policy "public insert groups" on public.student_groups for insert with check (true);
create policy "public update groups" on public.student_groups for update using (true) with check (true);
create policy "public delete groups" on public.student_groups for delete using (true);

create policy "public read students" on public.students for select using (true);
create policy "public insert students" on public.students for insert with check (true);
create policy "public update students" on public.students for update using (true) with check (true);
create policy "public delete students" on public.students for delete using (true);

create policy "public read submissions" on public.submissions for select using (true);
create policy "public insert submissions" on public.submissions for insert with check (true);
create policy "public update submissions" on public.submissions for update using (true) with check (true);
create policy "public delete submissions" on public.submissions for delete using (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.student_groups to anon, authenticated;
grant select, insert, update, delete on public.students to anon, authenticated;
grant select, insert, update, delete on public.submissions to anon, authenticated;

insert into public.student_groups (group_name, sort_order)
values
('ม.4/2', 1),
('ม.4/4', 2),
('ม.4/6', 3),
('ม.4/8', 4),
('ม.4/10', 5),
('ม.6/6', 6),
('ม.6/7', 7)
on conflict (group_name) do nothing;

insert into storage.buckets (id, name, public)
values ('airflow-images', 'airflow-images', true)
on conflict (id) do update set public = true;

drop policy if exists "public read airflow images" on storage.objects;
drop policy if exists "public insert airflow images" on storage.objects;
drop policy if exists "public update airflow images" on storage.objects;
drop policy if exists "public delete airflow images" on storage.objects;

create policy "public read airflow images"
on storage.objects for select
using (bucket_id = 'airflow-images');

create policy "public insert airflow images"
on storage.objects for insert
with check (bucket_id = 'airflow-images');

create policy "public update airflow images"
on storage.objects for update
using (bucket_id = 'airflow-images')
with check (bucket_id = 'airflow-images');

create policy "public delete airflow images"
on storage.objects for delete
using (bucket_id = 'airflow-images');

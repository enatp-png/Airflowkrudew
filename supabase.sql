-- Air Flow Mission Group v4
-- รันใน Supabase SQL Editor

create extension if not exists "pgcrypto";

drop table if exists public.submissions cascade;
drop table if exists public.prompt_maps cascade;
drop table if exists public.students cascade;
drop table if exists public.student_groups cascade;

create table public.student_groups (
  id uuid primary key default gen_random_uuid(),
  group_name text not null unique,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

create table public.students (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.student_groups(id) on delete cascade,
  student_no text,
  student_code text,
  student_name text not null,
  is_active boolean not null default true,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

create table public.prompt_maps (
  id uuid primary key default gen_random_uuid(),
  group_id uuid references public.student_groups(id) on delete cascade,
  mission_no int not null check (mission_no between 1 and 5),
  title text,
  image_path text,
  image_url text,
  created_at timestamptz not null default now(),
  unique(group_id, mission_no)
);

create table public.submissions (
  id uuid primary key default gen_random_uuid(),
  group_id uuid references public.student_groups(id) on delete set null,
  group_name text not null,
  members text,
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
alter table public.prompt_maps enable row level security;
alter table public.submissions enable row level security;

create policy "student_groups_all" on public.student_groups for all using (true) with check (true);
create policy "students_all" on public.students for all using (true) with check (true);
create policy "prompt_maps_all" on public.prompt_maps for all using (true) with check (true);
create policy "submissions_all" on public.submissions for all using (true) with check (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.student_groups to anon, authenticated;
grant select, insert, update, delete on public.students to anon, authenticated;
grant select, insert, update, delete on public.prompt_maps to anon, authenticated;
grant select, insert, update, delete on public.submissions to anon, authenticated;

insert into public.student_groups (group_name, sort_order)
values
('กลุ่ม 1', 1),
('กลุ่ม 2', 2),
('กลุ่ม 3', 3),
('กลุ่ม 4', 4),
('กลุ่ม 5', 5),
('กลุ่ม 6', 6)
on conflict (group_name) do nothing;

insert into storage.buckets (id, name, public)
values ('airflow-images', 'airflow-images', true)
on conflict (id) do update set public = true;

drop policy if exists "airflow_images_select" on storage.objects;
drop policy if exists "airflow_images_insert" on storage.objects;
drop policy if exists "airflow_images_update" on storage.objects;
drop policy if exists "airflow_images_delete" on storage.objects;
drop policy if exists "public read airflow images" on storage.objects;
drop policy if exists "public insert airflow images" on storage.objects;
drop policy if exists "public update airflow images" on storage.objects;
drop policy if exists "public delete airflow images" on storage.objects;

create policy "airflow_images_select" on storage.objects for select using (bucket_id = 'airflow-images');
create policy "airflow_images_insert" on storage.objects for insert with check (bucket_id = 'airflow-images');
create policy "airflow_images_update" on storage.objects for update using (bucket_id = 'airflow-images') with check (bucket_id = 'airflow-images');
create policy "airflow_images_delete" on storage.objects for delete using (bucket_id = 'airflow-images');

-- supabase.sql
-- ใช้รันใน Supabase SQL Editor
create extension if not exists "pgcrypto";

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  student_code text,
  fullname text not null,
  classroom text not null,
  number_no integer,
  created_at timestamptz default now()
);

create table if not exists public.missions (
  id integer primary key,
  title text not null,
  level_name text,
  max_score integer default 10
);

insert into public.missions (id, title, level_name, max_score)
values
  (1, 'ด่าน 1: อากาศร้อน–อากาศเย็น', 'ง่าย', 10),
  (2, 'ด่าน 2: ความกดอากาศสูง–ต่ำ', 'พื้นฐาน', 10),
  (3, 'ด่าน 3: แผนที่จำลองประเทศไทย', 'ปานกลาง', 10),
  (4, 'ด่าน 4: สถานการณ์กึ่งจริง', 'ท้าทาย', 10),
  (5, 'ด่าน 5: แผนที่อากาศจริง', 'ประยุกต์ใช้จริง', 10)
on conflict (id) do update set title=excluded.title, level_name=excluded.level_name, max_score=excluded.max_score;

create table if not exists public.submissions (
  id uuid primary key default gen_random_uuid(),
  student_name text not null,
  classroom text not null,
  student_no text,
  mission_no integer not null references public.missions(id),
  explanation text not null,
  image_path text,
  image_url text,
  score numeric(5,2),
  teacher_comment text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists submissions_set_updated_at on public.submissions;
create trigger submissions_set_updated_at
before update on public.submissions
for each row execute function public.set_updated_at();

alter table public.students enable row level security;
alter table public.missions enable row level security;
alter table public.submissions enable row level security;

drop policy if exists "students_select_all" on public.students;
create policy "students_select_all" on public.students for select to anon, authenticated using (true);
drop policy if exists "students_insert_all" on public.students;
create policy "students_insert_all" on public.students for insert to anon, authenticated with check (true);
drop policy if exists "missions_select_all" on public.missions;
create policy "missions_select_all" on public.missions for select to anon, authenticated using (true);
drop policy if exists "submissions_select_all" on public.submissions;
create policy "submissions_select_all" on public.submissions for select to anon, authenticated using (true);
drop policy if exists "submissions_insert_all" on public.submissions;
create policy "submissions_insert_all" on public.submissions for insert to anon, authenticated with check (true);
drop policy if exists "submissions_update_all" on public.submissions;
create policy "submissions_update_all" on public.submissions for update to anon, authenticated using (true) with check (true);
drop policy if exists "submissions_delete_all" on public.submissions;
create policy "submissions_delete_all" on public.submissions for delete to anon, authenticated using (true);

insert into storage.buckets (id, name, public)
values ('airflow-images', 'airflow-images', true)
on conflict (id) do update set public = true;

drop policy if exists "airflow_images_select" on storage.objects;
create policy "airflow_images_select" on storage.objects for select to anon, authenticated using (bucket_id = 'airflow-images');
drop policy if exists "airflow_images_insert" on storage.objects;
create policy "airflow_images_insert" on storage.objects for insert to anon, authenticated with check (bucket_id = 'airflow-images');
drop policy if exists "airflow_images_update" on storage.objects;
create policy "airflow_images_update" on storage.objects for update to anon, authenticated using (bucket_id = 'airflow-images') with check (bucket_id = 'airflow-images');
drop policy if exists "airflow_images_delete" on storage.objects;
create policy "airflow_images_delete" on storage.objects for delete to anon, authenticated using (bucket_id = 'airflow-images');

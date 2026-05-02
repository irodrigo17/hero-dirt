-- Run this in the Supabase SQL Editor (supabase.com > your project > SQL Editor)

create table places (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  lat double precision not null,
  lon double precision not null,
  name text not null,
  custom_name text,
  created_at timestamptz default now() not null
);

create index places_user_id_idx on places(user_id);
create unique index places_user_lat_lon_idx on places(user_id, lat, lon);

alter table places enable row level security;

create policy "Users can read their own places"
  on places for select
  using (auth.uid() = user_id);

create policy "Users can insert their own places"
  on places for insert
  with check (auth.uid() = user_id);

create policy "Users can update their own places"
  on places for update
  using (auth.uid() = user_id);

create policy "Users can delete their own places"
  on places for delete
  using (auth.uid() = user_id);

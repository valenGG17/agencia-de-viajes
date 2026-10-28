-- Pegar en Supabase > SQL Editor > Run

create table public.solicitudes (
  id uuid primary key default gen_random_uuid(),
  creado timestamptz not null default now(),
  nombre text not null check (char_length(nombre) between 1 and 120),
  telefono text not null check (char_length(telefono) between 8 and 20),
  email text check (char_length(email) <= 200),
  destino text not null check (char_length(destino) between 1 and 120),
  fecha text,
  viajeros int check (viajeros between 1 and 100),
  comentarios text check (char_length(comentarios) <= 2000)
);

create table public.reservas (
  id uuid primary key default gen_random_uuid(),
  creado timestamptz not null default now(),
  producto text not null check (char_length(producto) <= 300),
  total numeric,
  pasajeros int check (pasajeros between 1 and 100),
  ida date,
  vuelta date,
  nombre text not null check (char_length(nombre) between 1 and 120),
  telefono text not null check (char_length(telefono) between 8 and 20)
);

-- Seguridad: el público SOLO puede agregar filas, nunca leerlas.
alter table public.solicitudes enable row level security;
alter table public.reservas enable row level security;

create policy "publico_inserta" on public.solicitudes for insert to anon with check (true);
create policy "publico_inserta" on public.reservas   for insert to anon with check (true);

grant insert on public.solicitudes to anon;
grant insert on public.reservas to anon;

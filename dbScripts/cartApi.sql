create type status_type as enum ('OPEN', 'ORDERED');
create type order_status_type as enum ('IN_PROGRESS', 'ORDERED');

create extension if not exists "uuid-ossp";

create table users (
  id text not null default uuid_generate_v4() primary key,
  name text not null,
  email text not null,
  password text not null
);

create table cart (
  id uuid not null default uuid_generate_v4() primary key,
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP,
  status status_type not null default 'OPEN'
);

alter table cart add column user_id text references users(id);

create table cart_item (
  id uuid not null default uuid_generate_v4() primary key,
  product_id text default null,
  count numeric not null
);

alter table cart_item add column cart_id uuid references cart(id);

create table orders (
  id uuid not null default uuid_generate_v4() primary key,
  payment JSON not null,
  delivery JSON not null,
  comments text default null,
  status order_status_type not null default 'IN_PROGRESS',
  total numeric not null
);

alter table orders add column cart_id uuid references cart(id);

alter table orders add column user_id text references users(id);

insert into users (id, name, email, password) values ('user1', 'Weider', 'wer@gmail.com', 'weider1234');
insert into users (id, name, email, password) values ('user2', 'Hans', 'han@gmail.com', 'han1234');
insert into users (id, name, email, password) values ('user3', 'Nicky', 'nick@gmail.com', 'nick1234');
insert into users (id, name, email, password) values ('user4', 'Christina', 'chri@gmail.com', 'chri1234');

insert into cart (user_id, status) values ('user1', 'OPEN');
insert into cart (user_id, status) values ('user2', 'ORDERED');
insert into cart (user_id, status) values ('user3', 'OPEN');
insert into cart (user_id, status) values ('user4', 'ORDERED');

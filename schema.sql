create table country(
  id bigint not null,
  code varchar(255) null,
  label varchar(255) null,
  primary key (id)
);
create table permission(
  id bigint not null,
  code varchar(255) null,
  label varchar(255) null,
  primary key (id)
);
create table role(
  id bigint not null,
  code varchar(255) null,
  label varchar(255) null,
  primary key (id)
);
create table role_to_permission(
  role_id bigint not null,
  permission_id bigint not null,
  primary key (
    role_id, 
    permission_id
  )
);
create table user_award(
  id bigint not null,
  code varchar(255) null,
  description varchar(255) null,
  label varchar(255) null,
  primary key (id)
);
create table user(
  id bigint not null auto_increment,
  alias varchar(255) not null,
  avatar_link varchar(255) null,
  biography varchar(255) null,
  disabled boolean not null,
  discord_id varchar(255) null,
  email varchar(255) not null,
  git_url varchar(255) null,
  hash_password varchar(255) not null,
  join_date bigint not null,
  country_id bigint null,
  role_id bigint null,
  primary key (id)
);
create table user_to_permission(
  user_id bigint not null,
  permission_id bigint not null,
  primary key (
    user_id, 
    permission_id
  )
);
create table user_to_user_award(
  user_id bigint not null,
  user_award_id bigint not null,
  primary key (
    user_id, 
    user_award_id
  )
);
alter table role_to_permission
  add constraint fkc9fvvy6i3kwqbn3smrjf2mbwk
    foreign key (permission_id)
    references permission;
alter table role_to_permission
  add constraint fkqfp31u3h3h23odisophicjwcr
    foreign key (role_id)
    references role;
alter table user
  add constraint fkge8lxibk9q3wf206s600otk61
    foreign key (country_id)
    references country;
alter table user
  add constraint fkn82ha3ccdebhokx3a8fgdqeyy
    foreign key (role_id)
    references role;
alter table user_to_permission
  add constraint fk6gip26de7n8n227myqoanrt09
    foreign key (permission_id)
    references permission;
alter table user_to_permission
  add constraint fkwabgwk1psd2mrnrm7j45ng80
    foreign key (user_id)
    references user;
alter table user_to_user_award
  add constraint fki5uspohcoxkvq11ugl8olluae
    foreign key (user_award_id)
    references user_award;
alter table user_to_user_award
  add constraint fk3n2mbd92bjlp9nspexm6k5scq
    foreign key (user_id)
    references user;

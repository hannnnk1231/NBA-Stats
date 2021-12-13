drop table if exists Play_at;
drop table if exists Celebrities;
drop table if exists Crimes;
drop table if exists Injuries;
drop table if exists Awards;
drop table if exists Position;
drop table if exists Period;
drop table if exists NBA_Players;
drop table if exists Match;
drop table if exists Match_type;
drop table if exists Date; 
drop table if exists Teams;
drop table if exists Arenas;
drop table if exists Countries;

create table Countries (
  name varchar(32) primary key,
  continent varchar(32)
);

create table Arenas (
  name varchar(32) primary key,
  city varchar(16) not null,
  capacity integer
);

create table Teams (
  name varchar(64) primary key,
  abbr varchar(16),
  division varchar(16) not null,
  arena varchar(32) not null,
  logo varchar(128),
  foreign key (arena) references Arenas(name)
);

create table Date (
  date date primary key
);

create table Match_type (
  name varchar(32) primary key
);

create table Match (
  host varchar(64),
  guest varchar(64),
  m_date date,
  primary key(host, guest, m_date),
  score_host integer,
  score_guest integer,
  m_type varchar(32) not null,
  arena varchar(32) not null,
  foreign key (m_type) references Match_type(name),
  foreign key (host) references Teams(name),
  foreign key (guest) references Teams(name),
  foreign key (m_date) references Date(date),
  foreign key (arena) references Arenas(name)
);

create table NBA_Players (
  name varchar(32),
  dob date,
  status boolean not null,
  college varchar(64),
  draft integer,
  APG real,
  RPG real,
  PPG real,
  weight real,
  height real,
  age integer,
  nationality varchar(32) not null,
  img varchar(128),
  t_name varchar(64) not null,
  primary key (name, dob),
  foreign key (nationality) references Countries(name),
  foreign key (t_name) references Teams(name)
);

create table Position (
  name varchar(16) primary key,
  abbr varchar(8) unique not null
);

create table Period (
  from_date integer not null,
  to_date integer not null,
  player_name varchar(32) not null,
  player_dob date not null,
  t_name varchar(64) not null,
  number integer,
  salary integer,
  position varchar(8),
  primary key (from_date, to_date, player_name, player_dob, t_name),
  foreign key (t_name) references Teams(name),
  foreign key (player_name, player_dob) references NBA_Players(name, dob)
);

create table Play_at (
  player_name varchar(32) not null,
  player_dob date,
  position_name varchar(16) not null,
  primary key(player_name, player_dob, position_name),
  foreign key (player_name, player_dob) references NBA_Players(name, dob),
  foreign key (position_name) references Position(abbr)
);


create table Awards (
  name varchar(64),
  year integer,
  t_name varchar(64),
  p_name varchar(32),
  p_dob date,
  primary key (name, year, p_name, p_dob),
  foreign key (t_name) references Teams(name),
  foreign key (p_name, p_dob) references NBA_Players(name, dob)
);


create table Celebrities (
  name varchar(32),
  age integer,
  sex char(1),
  speciality varchar(32),
  date date,
  player_name varchar(32),
  player_dob date,
  primary key (name, date, player_name, player_dob),
  foreign key (player_name, player_dob) references NBA_Players (name, dob) on delete cascade
);

create table Crimes (
  name varchar(32),
  date date,
  player_name varchar(32),
  player_dob date,
  primary key (name, date, player_name, player_dob),
  foreign key (player_name, player_dob) references NBA_Players (name, dob) on delete cascade
);

create table Injuries (
  name varchar(32),
  level varchar(32),
  date date,
  player_name varchar(32),
  player_dob date,
  primary key (name, date, player_name, player_dob),
  foreign key (player_name, player_dob) references NBA_Players (name, dob) on delete cascade
);


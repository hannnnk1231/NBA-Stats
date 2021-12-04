drop table if exists Play_at;
drop table if exists Celebrities;
drop table if exists Crimes;
drop table if exists Injuries;
drop table if exists Awards;
drop table if exists Position;
drop table if exists Period;
drop table if exists NBA_Players;
drop table if exists match;
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
  foreign key (arena) references Arenas(name)
);

create table Date (
  date date primary key
);

create table match (
  host varchar(64),
  guest varchar(64),
  m_date date,
  primary key(host, guest, m_date),
  score_host integer,
  score_guest integer,
  arena varchar(32) not null,
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
  draft date,
  APG real,
  RPG real,
  PPG real,
  weight real,
  height real,
  age integer,
  nationality varchar(32) not null,
  p_name varchar(64) not null,
  primary key (name, dob),
  foreign key (nationality) references Countries(name),
  foreign key (p_name) references Teams(name)
);

create table Position (
  name varchar(16) primary key,
  abbr varchar(32)
);

create table Period (
  from_date date not null,
  to_date date not null,
  number integer,
  salary integer,
  primary key (from_date, to_date)
);

create table Play_at (
  player_name varchar(32) not null,
  player_dob date,
  position_name varchar(16) not null,
  from_date date,
  to_date date,
  primary key(player_name, player_dob, position_name, from_date, to_date),
  foreign key (from_date, to_date) references Period(from_date, to_date),
  foreign key (player_name, player_dob) references NBA_Players(name, dob),
  foreign key (position_name) references Position(name)
);


create table Awards (
  name varchar(32) primary key,
  date date,
  t_name varchar(64),
  p_name varchar(32) not null,
  p_dob date not null,
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

insert into Countries (name, continent) values ('USA', 'North America');
insert into Countries (name, continent) values ('Canada', 'North America');
insert into Countries (name, continent) values ('Australia', 'Australia');

insert into Arenas (name, city, capacity) values ('Staples Center', 'Los Angeles', 18997);
insert into Arenas (name, city, capacity) values ('Barclays Center', 'Brooklyn', 17732);

insert into Teams (name, abbr, division, arena) values ('Brooklyn Nets', 'BKN', 'Atlantic', 'Barclays Center');
insert into Teams (name, abbr, division, arena) values ('Los Angeles Lakers', 'LAL', 'Pacific', 'Staples Center');

insert into Date (date) values ('2021-10-03');
insert into Date (date) values ('2022-01-25');

insert into match (host, guest, m_date, score_host, score_guest, arena) values ('Los Angeles Lakers', 'Brooklyn Nets', '2021-10-03', 97, 123, 'Staples Center');
insert into match (host, guest, m_date, arena) values ('Brooklyn Nets', 'Los Angeles Lakers', '2022-01-25', 'Barclays Center');

insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, p_name) values ('Kevin Durant', '1988-09-29', TRUE, 'The University of Texas at Austin', '2007-06-28', 5.0, 10.0, 29.8, 240, 2.08, 33, 'USA', 'Brooklyn Nets');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, p_name) values ('LeBron James', '1984-12-30', TRUE, 'St. Vincent-St. Mary High School', '2003-06-26', 5.3, 6.3, 26.0, 250, 2.06, 36, 'USA', 'Los Angeles Lakers');

insert into Position (name, abbr) values ('Small forward', 'SF');
insert into Position (name, abbr) values ('Power forward', 'PF');
insert into Position (name, abbr) values ('Point guard', 'PG');
insert into Position (name, abbr) values ('Shooting guard', 'SG');
insert into Position (name, abbr) values ('Center', 'C');

insert into Period (from_date, to_date, number, salary) values ('2003-9-02', '2021-10-29', 23, 5000);
insert into Period (from_date, to_date, number, salary) values ('2007-9-02', '2021-10-29', 7, 4000);

insert into Play_at (player_name, player_dob, position_name, from_date, to_date) values ('LeBron James', '1984-12-30', 'Small forward', '2003-9-02', '2021-10-29');
insert into Play_at (player_name, player_dob, position_name, from_date, to_date) values ('Kevin Durant', '1988-09-29', 'Power forward', '2007-9-02', '2021-10-29');

insert into Awards (name, date, t_name, p_name, p_dob) values ('2019-2020 NBA Championship', '2020-10-11', 'Los Angeles Lakers', 'LeBron James', '1984-12-30');
insert into Awards (name, date, t_name, p_name, p_dob) values ('2019-2020 NBA Final MVP', '2020-10-11', null, 'LeBron James', '1984-12-30');

insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) values ('Scarlett Johansson', 36, 'F', 'Actress', '2011-01-16', 'Kevin Durant', '1988-09-29');

insert into Injuries (name, date, player_name, player_dob) values ('Right Ankle', '2021-10-25', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-25', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-16', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Thigh', '2021-04-18', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Rest', '2021-04-14', 'Kevin Durant', '1988-09-29');
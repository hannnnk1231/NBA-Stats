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
  draft date,
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


-- tables:
-- Countries, Arenas, Teams, Date, Match, NBA_Players, Position, Period, Play_at, Awards, Celebrities, Crimes, Injuries

insert into Countries (name, continent) values ('USA', 'North America');
insert into Countries (name, continent) values ('Canada', 'North America');
insert into Countries (name, continent) values ('Australia', 'Australia');
insert into Countries (name, continent) values ('Bosnia and Herzegovina', 'Europe');
insert into Countries (name, continent) values ('Argentina', 'South America');
insert into Countries (name, continent) values ('Serbia', 'Europe');
insert into Countries (name, continent) values ('Croatia', 'Europe');
insert into Countries (name, continent) values ('Germany', 'Europe');
insert into Countries (name, continent) values ('Austria', 'Europe');
insert into Countries (name, continent) values ('Cameroon', 'Africa');
insert into Countries (name, continent) values ('United Kingdom', 'Europe');
insert into Countries (name, continent) values ('France', 'Europe');
insert into Countries (name, continent) values ('Czech Republic', 'Europe');
insert into Countries (name, continent) values ('Lithuania', 'Europe');
insert into Countries (name, continent) values ('Slovenia', 'Europe');
insert into Countries (name, continent) values ('Latvia', 'Europe');


-- insert into Arenas (name, city, capacity) values ('Barclays Center', 'Brooklyn', 17732);

insert into Arenas (name, city, capacity) values ('Capital One Arena', 'Washington, D.C.', 20356);
insert into Arenas (name, city, capacity) values ('Chase Center', 'San Francisco', 18064);
insert into Arenas (name, city, capacity) values ('Moda Center', 'Portland', 19441);
insert into Arenas (name, city, capacity) values ('Target Center', 'Minneapolis', 18978);
insert into Arenas (name, city, capacity) values ('Paycom Center', 'Oklahoma City', 18203);
insert into Arenas (name, city, capacity) values ('Footprint Center', 'Phoenix', 18055);
insert into Arenas (name, city, capacity) values ('AT&T Center', 'San Antonio', 18418);
insert into Arenas (name, city, capacity) values ('Toyota Center', 'Houston', 18055);
insert into Arenas (name, city, capacity) values ('Scotiabank Arena', 'Toronto', 19800);
insert into Arenas (name, city, capacity) values ('Little Caesars Arena', 'Detroit', 20332);
insert into Arenas (name, city, capacity) values ('Smoothie King Center', 'New Orleans', 16867);
insert into Arenas (name, city, capacity) values ('Gainbridge Fieldhouse', 'Indianapolis', 17923);
insert into Arenas (name, city, capacity) values ('Ball Arena', 'Denver', 19520);
insert into Arenas (name, city, capacity) values ('American Airlines Center', 'Dallas', 19200);
insert into Arenas (name, city, capacity) values ('Staples Center', 'Los Angeles', 18997);
insert into Arenas (name, city, capacity) values ('Barclays Center', 'Brooklyn', 17732);
insert into Arenas (name, city, capacity) values ('Wells Fargo Center', 'Philadelphia', 20478);
insert into Arenas (name, city, capacity) values ('Rocket Mortgage FieldHouse', 'Cleveland', 19432);
insert into Arenas (name, city, capacity) values ('FTX Arena', 'Miami', 19600);
insert into Arenas (name, city, capacity) values ('Vivint Arena', 'Salt Lake City', 18306);
insert into Arenas (name, city, capacity) values ('Fiserv Forum', 'Milwaukee', 17341);
insert into Arenas (name, city, capacity) values ('United Center', 'Chicago', 20917);
insert into Arenas (name, city, capacity) values ('TD Garden', 'Boston', 19156);
insert into Arenas (name, city, capacity) values ('FedExForum', 'Memphis', 18119);
insert into Arenas (name, city, capacity) values ('State Farm Arena', 'Atlanta', 16600);
insert into Arenas (name, city, capacity) values ('Spectrum Center', 'Charlotte', 19077);
insert into Arenas (name, city, capacity) values ('Golden 1 Center', 'Sacramento', 17608);
insert into Arenas (name, city, capacity) values ('Madison Square Garden', 'New York', 19812);
insert into Arenas (name, city, capacity) values ('Amway Center', 'Orlando', 18846);

-- insert into Teams (name, abbr, division, arena) values ('Brooklyn Nets', 'BKN', 'Atlantic', 'Barclays Center');

insert into Teams (name, abbr, division, arena, logo) values ('Brooklyn Nets', 'BKN', 'Atlantic', 'Barclays Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/bkn.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Los Angeles Lakers', 'LAL', 'Pacific', 'Staples Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/lal.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Washington Wizards', 'WAS', 'Southeast', 'Capital One Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/was.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Golden State Warriors', 'GSW', 'Pacific', 'Chase Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/gsw.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Portland Trail Blazers', 'POR', 'Northwest', 'Moda Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/por.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Minnesota Timberwolves', 'MIN', 'Northwest', 'Target Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/min.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Oklahoma City Thunder', 'OKC', 'Northwest', 'Paycom Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/okc.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Phoenix Suns', 'PHX', 'Pacific', 'Footprint Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/phx.gif');
insert into Teams (name, abbr, division, arena, logo) values ('San Antonio Spurs', 'SAS', 'Southwest', 'AT&T Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/sas.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Houston Rockets', 'HOU', 'Southwest', 'Toyota Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/hou.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Toronto Raptors', 'TOR', 'Atlantic', 'Scotiabank Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/tor.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Detroit Pistons', 'DET', 'Central', 'Little Caesars Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/det.gif');
insert into Teams (name, abbr, division, arena, logo) values ('New Orleans Pelicans', 'NOP', 'Southwest', 'Smoothie King Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/nop.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Indiana Pacers', 'IND', 'Central', 'Gainbridge Fieldhouse', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/ind.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Denver Nuggets', 'DEN', 'Northwest', 'Ball Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/den.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Dallas Mavericks', 'DAL', 'Southwest', 'American Airlines Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/dal.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Philadelphia 76ers', 'PHI', 'Atlantic', 'Wells Fargo Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/phi.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Cleveland Cavaliers', 'CLE', 'Central', 'Rocket Mortgage FieldHouse', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/cle.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Miami Heat', 'MIA', 'Southeast', 'FTX Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/mia.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Utah Jazz', 'UTA', 'Northwest', 'Vivint Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/uta.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Milwaukee Bucks', 'MIL', 'Central', 'Fiserv Forum', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/mil.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Chicago Bulls', 'CHI', 'Central', 'United Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/chi.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Boston Celtics', 'BOS', 'Atlantic', 'TD Garden', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/bos.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Los Angeles Clippers', 'LAC', 'Pacific', 'Staples Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/lac.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Memphis Grizzlies', 'MEM', 'Southwest', 'FedExForum', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/mem.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Atlanta Hawks', 'ATL', 'Southeast', 'State Farm Arena', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/atl.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Charlotte Hornets', 'CHA', 'Southeast', 'Spectrum Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/cha.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Sacramento Kings', 'SAC', 'Pacific', 'Golden 1 Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/sac.gif');
insert into Teams (name, abbr, division, arena, logo) values ('New York Knicks', 'NYK', 'Atlantic', 'Madison Square Garden', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/nyk.gif');
insert into Teams (name, abbr, division, arena, logo) values ('Orlando Magic', 'ORL', 'Southeast', 'Amway Center', 'https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_80x64/orl.gif');

-- insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, p_name) 
--  values ('Kevin Durant', '1988-09-29', TRUE, 'The University of Texas at Austin', '2007-06-28', 5.0, 10.0, 29.8, 240, 2.08, 33, 'USA', 'Brooklyn Nets');

insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Bradley Beal', '1993-06-28', TRUE, 'University of Florida', '2012-06-28', 5.9, 5.0, 22.3, 207, 1.93, 28, 'USA', 'Washington Wizards', 'https://cdn.nba.com/headshots/nba/latest/260x190/203078.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Kyle Kuzma', '1995-07-24', TRUE, 'The University of Utah', '2017-06-28', 2.8, 8.7, 13.0, 221, 2.06, 26, 'USA', 'Washington Wizards', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628398.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Stephen Curry', '1988-03-14', TRUE, 'Davidson College', '2009-06-28', 6.5, 5.6, 27.6, 185, 1.88, 33, 'USA', 'Golden State Warriors', 'https://cdn.nba.com/headshots/nba/latest/260x190/201939.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Andrew Wiggins', '1995-02-23', TRUE, 'Kansas University', '2014-06-28', 1.6, 4.5, 18.6, 197, 2.01, 26, 'Canada', 'Golden State Warriors', 'https://cdn.nba.com/headshots/nba/latest/260x190/203952.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Damian Lillard', '1990-07-15', TRUE, 'Weber State University', '2012-06-28', 7.8, 4.0, 21.5, 195, 1.88, 33, 'USA', 'Portland Trail Blazers', 'https://cdn.nba.com/headshots/nba/latest/260x190/203081.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Jusuf Nurkic', '1994-08-23', TRUE, 'Cedevita', '2014-06-28', 2.3, 10.6, 12.4, 290, 2.11, 27, 'Bosnia and Herzegovina', 'Portland Trail Blazers', 'https://cdn.nba.com/headshots/nba/latest/260x190/203994.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Anthony Edwards', '2001-08-05', TRUE, 'Georgia', '2020-06-28', 3.6, 6.3, 22.0, 225, 1.93, 20, 'USA', 'Minnesota Timberwolves', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630162.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Leandro Bolmaro', '2000-09-11', TRUE, 'FC Barcelona', '2020-06-28', 0.5, 2.0, 1.8, 200, 1.98, 21, 'Argentina', 'Minnesota Timberwolves', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630195.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Aleksej Pokusevski', '2001-12-26', TRUE, 'Olympiacos', '2020-06-28', 1.3, 4.0, 4.6, 190, 2.13, 19, 'Serbia', 'Oklahoma City Thunder', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630197.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Luguentz Dort', '1999-04-19', TRUE, 'Arizona State University', null, 2.0, 4.0, 16.8, 215, 1.91, 22, 'Canada', 'Oklahoma City Thunder', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629652.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Dario Saric', '1994-04-08', TRUE, 'Anadolu Efes', '2014-06-28', 1.3, 3.8, 8.7, 225, 2.08, 27, 'Croatia', 'Phoenix Suns', 'https://cdn.nba.com/headshots/nba/latest/260x190/203967.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Devin Booker', '1996-10-30', TRUE, 'Kentucky University', '2015-06-28', 4.5, 4.9, 23.2, 206, 1.96, 25, 'USA', 'Phoenix Suns', 'https://cdn.nba.com/headshots/nba/latest/260x190/1626164.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Jakob Poeltl', '1995-10-15', TRUE, 'The University of Utah', '2016-06-28', 2.0, 9.3, 12.6, 245, 2.16, 26, 'Austria', 'San Antonio Spurs', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627751.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Derrick White', '1994-07-02', TRUE, 'Colorado University', '2017-06-28', 5.2, 3.6, 12.1, 190, 1.93, 27, 'USA', 'San Antonio Spurs', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628401.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Daniel Theis', '1992-04-04', TRUE, 'Brose Bamberg', null, 0.8, 4.9, 8.1, 245, 2.06, 29, 'Germany', 'Houston Rockets', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628464.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('John Wall', '1990-09-06', TRUE, 'Kentucky University', '2010-06-28', 6.9, 3.2, 20.6, 210, 1.91, 31, 'USA', 'Houston Rockets', 'https://cdn.nba.com/headshots/nba/latest/260x190/202322.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Pascal Siakam', '1994-04-02', TRUE, 'New Mexico State', '2016-06-28', 3.8, 7.2, 18.1, 230, 2.03, 27, 'Cameroon', 'Toronto Raptors', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627783.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('OG Anunoby', '1997-07-17', TRUE, 'Indiana University', '2017-06-28', 2.7, 5.4, 20.1, 232, 2.01, 24, 'United Kingdom', 'Toronto Raptors', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628384.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Isaiah Stewart', '2001-05-22', TRUE, 'Washington', '2020-06-28', 1.1, 8.0, 7.7, 250, 2.03, 20, 'USA', 'Detroit Pistons', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630191.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Killian Hayes', '2001-07-27', TRUE, 'Ratiopharm Ulm', '2020-06-28', 3.6, 3.8, 6.2, 195, 1.96, 20, 'France', 'Detroit Pistons', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630165.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Zion Williamson', '2000-07-06', TRUE, 'Duke University', '2019-06-28', 3.7, 7.2, 27.0, 284, 1.98, 21, 'USA', 'New Orleans Pelicans', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629627.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Tomas Satoransky', '1991-10-30', TRUE, 'FC Barcelona', '2012-06-28', 2.2, 2.1, 2.8, 210, 2.01, 30, 'Czech Republic', 'New Orleans Pelicans', 'https://cdn.nba.com/headshots/nba/latest/260x190/203107.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Domantas Sabonis', '1996-05-03', TRUE, 'Gonzaga', '2016-06-28', 4.0, 12.1, 17.4, 240, 2.11, 25, 'Lithuania', 'Indiana Pacers', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627734.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Myles Turner', '1996-03-24', TRUE, 'Texas-Austin', '2015-06-28', 1.0, 7.5, 12.9, 250, 2.11, 25, 'USA', 'Indiana Pacers', 'https://cdn.nba.com/headshots/nba/latest/260x190/1626167.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Nikola Jokic', '1995-02-19', TRUE, 'Mega Basket', '2014-06-28', 6.4, 13.6, 26.1, 284, 2.11, 26, 'Serbia', 'Denver Nuggets', 'https://cdn.nba.com/headshots/nba/latest/260x190/203999.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Jamal Murray', '1997-02-23', TRUE, 'Kentucky University', '2016-06-28', 4.8, 4.0, 21.2, 215, 1.91, 24, 'Canada', 'Denver Nuggets', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627750.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Kyrie Irving', '1992-03-23', TRUE, 'Duke University', '2011-06-28', 6.0, 4.8, 26.9, 195, 1.88, 29, 'Australia', 'Brooklyn Nets', 'https://cdn.nba.com/headshots/nba/latest/260x190/202681.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Blake Griffin', '1989-03-16', TRUE, 'Oklahoma University', '2009-06-28', 2.0, 4.9, 5.5, 250, 2.06, 32, 'USA', 'Brooklyn Nets', 'https://cdn.nba.com/headshots/nba/latest/260x190/201933.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Luka Doncic', '1999-02-28', TRUE, 'Real Madrid', '2018-06-28', 8.5, 8.1, 25.4, 230, 2.01, 22, 'Slovenia', 'Dallas Mavericks', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629029.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Kristaps Porzingis', '1995-08-02', TRUE, 'Cajasol Sevilla', '2015-06-28', 1.9, 8.0, 19.7, 240, 2.21, 26, 'Latvia', 'Dallas Mavericks', 'https://cdn.nba.com/headshots/nba/latest/260x190/204001.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Kevin Durant', '1988-09-29', TRUE, 'The University of Texas at Austin', '2007-06-28', 5.0, 10.0, 29.8, 240, 2.08, 33, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/201142.png','Brooklyn Nets');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('LeBron James', '1984-12-30', TRUE, 'St. Vincent-St. Mary High School', '2003-06-26', 5.3, 6.3, 26.0, 250, 2.06, 36, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/2544.png', 'Los Angeles Lakers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Georges Niang', '1993-06-17', TRUE, 'Iowa State', '2016-06-28', 1.7, 2.7, 11.3, 230, 2.01, 28, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627777.png', 'Philadelphia 76ers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Tyrese Maxey', '2000-04-11', TRUE, 'Kentucky', '2020-06-28', 4.9, 3.8, 17.2, 200, 1.88, 21, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630178.png', 'Philadelphia 76ers');


insert into Date (date) values ('2021-06-10');
insert into Date (date) values ('2021-10-03');
insert into Date (date) values ('2021-10-19');
insert into Date (date) values ('2022-01-25');

insert into Match_type (name) values ('preseason');
insert into Match_type (name) values ('regular season');
insert into Match_type (name) values ('postseason');
insert into Match_type (name) values ('NBA Finals');

insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Los Angeles Lakers', 'Brooklyn Nets', '2021-10-03', 97, 123, 'preseason','Staples Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Los Angeles Lakers', 'Golden State Warriors', '2021-10-19', 114, 121, 'regular season','Staples Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Milwaukee Bucks', 'Brooklyn Nets', '2021-10-19', 127, 104, 'regular season','Fiserv Forum');

insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Milwaukee Bucks', 'Brooklyn Nets', '2021-06-10', 86, 83, 'postseason','Fiserv Forum');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Utah Jazz', 'Los Angeles Clippers', '2021-06-10', 117, 111, 'postseason','Vivint Arena');

insert into Match (host, guest, m_date, m_type, arena) 
  values ('Brooklyn Nets', 'Los Angeles Lakers', '2022-01-25', 'regular season', 'Barclays Center');


insert into Position (name, abbr) values ('Small forward', 'SF');
insert into Position (name, abbr) values ('Power forward', 'PF');
insert into Position (name, abbr) values ('Point guard', 'PG');
insert into Position (name, abbr) values ('Shooting guard', 'SG');
insert into Position (name, abbr) values ('Center', 'C');


insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2003, 2010, 'LeBron James', '1984-12-30', 'Cleveland Cavaliers', 23, 5000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2010, 2012, 'LeBron James', '1984-12-30', 'Miami Heat', 6, 5000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2012, 2014, 'LeBron James', '1984-12-30', 'Miami Heat', 6, 5000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2018, 'LeBron James', '1984-12-30', 'Cleveland Cavaliers', 23, 5000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2022, 'LeBron James', '1984-12-30', 'Los Angeles Lakers', 23, 5000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2008, 2016, 'Kevin Durant', '1988-09-29', 'Oklahoma City Thunder', 35, 4000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2019, 'Kevin Durant', '1988-09-29', 'Golden State Warriors', 35, 4000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Kevin Durant', '1988-09-29', 'Brooklyn Nets', 7, 4000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2017, 'Georges Niang', '1993-06-17', 'Indiana Pacers', 32, 4000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2021, 'Georges Niang', '1993-06-17', 'Utah Jazz', 31, 4000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Georges Niang', '1993-06-17', 'Philadelphia 76ers', 20, 4000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Tyrese Maxey', '2000-04-11', 'Philadelphia 76ers', 0, 4000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2012, 2022, 'Bradley Beal', '1993-06-28', 'Washington Wizards', 3, 4000, 'SG');


insert into Play_at (player_name, player_dob, position_name) values ('LeBron James', '1984-12-30', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Kevin Durant', '1988-09-29', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Bradley Beal', '1993-06-28', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Georges Niang', '1993-06-17', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Tyrese Maxey', '2000-04-11', 'SG');


insert into Awards (name, date, t_name, p_name, p_dob) 
  values ('2019-2020 NBA Championship', '2020-10-11', 'Los Angeles Lakers', 'LeBron James', '1984-12-30');
insert into Awards (name, date, t_name, p_name, p_dob) 
  values ('2019-2020 NBA Final MVP', '2020-10-11', null, 'LeBron James', '1984-12-30');


insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Scarlett Johansson', 36, 'F', 'Actress', '2011-01-16', 'Kevin Durant', '1988-09-29');


insert into Injuries (name, date, player_name, player_dob) values ('Right Ankle', '2021-10-25', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-25', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-16', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Thigh', '2021-04-18', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Rest', '2021-04-14', 'Kevin Durant', '1988-09-29');
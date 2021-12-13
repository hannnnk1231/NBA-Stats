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
insert into Countries (name, continent) values ('Greece', 'Europe');
insert into Countries (name, continent) values ('Spain', 'Europe');
insert into Countries (name, continent) values ('Dominican Republic', 'North America');
insert into Countries (name, continent) values ('New Zealand', 'Oceania');

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
  values ('Bradley Beal', '1993-06-28', TRUE, 'University of Florida', 2012, 4.1, 4.1, 22.0, 207, 1.93, 28, 'USA', 'Washington Wizards', 'https://cdn.nba.com/headshots/nba/latest/260x190/203078.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Kyle Kuzma', '1995-07-24', TRUE, 'The University of Utah', 2017, 2.0, 5.9, 15.0, 221, 2.06, 26, 'USA', 'Washington Wizards', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628398.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Stephen Curry', '1988-03-14', TRUE, 'Davidson College', 2009, 6.5, 4.6, 24.3, 185, 1.88, 33, 'USA', 'Golden State Warriors', 'https://cdn.nba.com/headshots/nba/latest/260x190/201939.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Andrew Wiggins', '1995-02-23', TRUE, 'Kansas University', 2014, 2.3, 4.4, 19.5, 197, 2.01, 26, 'Canada', 'Golden State Warriors', 'https://cdn.nba.com/headshots/nba/latest/260x190/203952.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Damian Lillard', '1990-07-15', TRUE, 'Weber State University', 2012, 6.7, 4.2, 24.6, 195, 1.88, 33, 'USA', 'Portland Trail Blazers', 'https://cdn.nba.com/headshots/nba/latest/260x190/203081.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Jusuf Nurkic', '1994-08-23', TRUE, 'Cedevita', 2014, 2.1, 8.3, 11.8, 290, 2.11, 27, 'Bosnia and Herzegovina', 'Portland Trail Blazers', 'https://cdn.nba.com/headshots/nba/latest/260x190/203994.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Anthony Edwards', '2001-08-05', TRUE, 'Georgia', 2020, 3.6, 6.3, 22.0, 225, 1.93, 20, 'USA', 'Minnesota Timberwolves', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630162.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Leandro Bolmaro', '2000-09-11', TRUE, 'FC Barcelona', 2020, 0.5, 2.0, 1.8, 200, 1.98, 21, 'Argentina', 'Minnesota Timberwolves', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630195.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Aleksej Pokusevski', '2001-12-26', TRUE, 'Olympiacos', 2020, 1.3, 4.0, 4.6, 190, 2.13, 19, 'Serbia', 'Oklahoma City Thunder', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630197.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Luguentz Dort', '1999-04-19', TRUE, 'Arizona State University', null, 2.0, 4.0, 16.8, 215, 1.91, 22, 'Canada', 'Oklahoma City Thunder', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629652.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Dario Saric', '1994-04-08', TRUE, 'Anadolu Efes', 2014, 2.0, 5.9, 11.7, 225, 2.08, 27, 'Croatia', 'Phoenix Suns', 'https://cdn.nba.com/headshots/nba/latest/260x190/203967.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Devin Booker', '1996-10-30', TRUE, 'Kentucky University', 2015, 4.6, 3.8, 23.0, 206, 1.96, 25, 'USA', 'Phoenix Suns', 'https://cdn.nba.com/headshots/nba/latest/260x190/1626164.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Jakob Poeltl', '1995-10-15', TRUE, 'The University of Utah', 2016, 1.2, 5.6, 6.3, 245, 2.16, 26, 'Austria', 'San Antonio Spurs', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627751.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Derrick White', '1994-07-02', TRUE, 'Colorado University', 2017, 3.6, 3.2, 11.0, 190, 1.93, 27, 'USA', 'San Antonio Spurs', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628401.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Daniel Theis', '1992-04-04', TRUE, 'Brose Bamberg', null, 1.3, 4.9, 7.5, 245, 2.06, 29, 'Germany', 'Houston Rockets', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628464.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('John Wall', '1990-09-06', TRUE, 'Kentucky University', 2010, 9.1, 4.3, 19.1, 210, 1.91, 31, 'USA', 'Houston Rockets', 'https://cdn.nba.com/headshots/nba/latest/260x190/202322.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Pascal Siakam', '1994-04-02', TRUE, 'New Mexico State', 2016, 2.7, 5.9, 14.5, 230, 2.03, 27, 'Cameroon', 'Toronto Raptors', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627783.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('OG Anunoby', '1997-07-17', TRUE, 'Indiana University', 2017, 2.5, 5.8, 19.1, 232, 2.01, 24, 'United Kingdom', 'Toronto Raptors', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628384.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Isaiah Stewart', '2001-05-22', TRUE, 'Washington', 2020, 1.1, 8.0, 7.7, 250, 2.03, 20, 'USA', 'Detroit Pistons', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630191.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Killian Hayes', '2001-07-27', TRUE, 'Ratiopharm Ulm', 2020, 3.6, 3.8, 6.2, 195, 1.96, 20, 'France', 'Detroit Pistons', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630165.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Zion Williamson', '2000-07-06', TRUE, 'Duke University', 2019, 3.7, 7.2, 27.0, 284, 1.98, 21, 'USA', 'New Orleans Pelicans', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629627.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Tomas Satoransky', '1991-10-30', TRUE, 'FC Barcelona', 2012, 4.1, 2.9, 7.2, 210, 2.01, 30, 'Czech Republic', 'New Orleans Pelicans', 'https://cdn.nba.com/headshots/nba/latest/260x190/203107.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Domantas Sabonis', '1996-05-03', TRUE, 'Gonzaga', 2016, 3.4, 8.9, 13.8, 240, 2.11, 25, 'Lithuania', 'Indiana Pacers', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627734.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Myles Turner', '1996-03-24', TRUE, 'Texas-Austin', 2015, 1.2, 6.7, 12.7, 250, 2.11, 25, 'USA', 'Indiana Pacers', 'https://cdn.nba.com/headshots/nba/latest/260x190/1626167.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Nikola Jokic', '1995-02-19', TRUE, 'Mega Basket', 2014, 6.4, 13.6, 26.1, 284, 2.11, 26, 'Serbia', 'Denver Nuggets', 'https://cdn.nba.com/headshots/nba/latest/260x190/203999.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Jamal Murray', '1997-02-23', TRUE, 'Kentucky University', 2016, 4.8, 4.0, 21.2, 215, 1.91, 24, 'Canada', 'Denver Nuggets', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627750.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Kyrie Irving', '1992-03-23', TRUE, 'Duke University', 2011, 5.7, 3.8, 22.8, 195, 1.88, 29, 'Australia', 'Brooklyn Nets', 'https://cdn.nba.com/headshots/nba/latest/260x190/202681.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Blake Griffin', '1989-03-16', TRUE, 'Oklahoma University', 2009, 4.3, 8.5, 20.6, 250, 2.06, 32, 'USA', 'Brooklyn Nets', 'https://cdn.nba.com/headshots/nba/latest/260x190/201933.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Luka Doncic', '1999-02-28', TRUE, 'Real Madrid', 2018, 8.5, 8.1, 25.4, 230, 2.01, 22, 'Slovenia', 'Dallas Mavericks', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629029.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, t_name, img) 
  values ('Kristaps Porzingis', '1995-08-02', TRUE, 'Cajasol Sevilla', 2015, 1.9, 8.0, 19.7, 240, 2.21, 26, 'Latvia', 'Dallas Mavericks', 'https://cdn.nba.com/headshots/nba/latest/260x190/204001.png');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Kevin Durant', '1988-09-29', TRUE, 'The University of Texas at Austin', 2007, 4.2, 7.1, 27.1, 240, 2.08, 33, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/201142.png','Brooklyn Nets');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('LeBron James', '1984-12-30', TRUE, 'St. Vincent-St. Mary High School', 2003, 7.4, 7.4, 27.0, 250, 2.06, 36, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/2544.png', 'Los Angeles Lakers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Georges Niang', '1993-06-17', TRUE, 'Iowa State', 2016, 1.7, 2.7, 11.3, 230, 2.01, 28, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627777.png', 'Philadelphia 76ers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Tyrese Maxey', '2000-04-11', TRUE, 'Kentucky', 2020, 4.9, 3.8, 17.2, 200, 1.88, 21, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630178.png', 'Philadelphia 76ers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Giannis Antetokounmpo', '1994-12-06', TRUE, 'Filathlitikos', 2013, 4.5, 9.2, 21.1, 242, 2.11, 26, 'Greece', 'https://cdn.nba.com/headshots/nba/latest/260x190/203507.png', 'Milwaukee Bucks');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Jrue Holiday', '1990-06-12', TRUE, 'UCLA', 2009, 6.4, 4.0, 16.0, 205, 1.91, 31, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/201950.png', 'Milwaukee Bucks');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('DeMar DeRozan', '1989-08-07', TRUE, 'Southern California', 2009, 3.8, 4.4, 20.3, 220, 1.98, 32, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/201942.png', 'Chicago Bulls');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Zach LaVine', '1995-03-10', TRUE, 'UCLA', 2014, 3.9, 5.4, 25.6, 200, 1.96, 26, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/203897.png', 'Chicago Bulls');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Ricky Rubio', '1990-10-21', TRUE, 'FC Barcelona', 2009, 7.6, 4.1, 11.1, 190, 1.88, 31, 'Spain', 'https://cdn.nba.com/headshots/nba/latest/260x190/201937.png', 'Cleveland Cavaliers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Darius Garland', '2000-01-26', TRUE, 'Vanderbilt', 2019, 7.3, 2.9, 19.1, 192, 1.85, 21, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629636.png', 'Cleveland Cavaliers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Jayson Tatum', '1998-03-03', TRUE, 'Duke', 2017, 3.7, 8.8, 25.2, 210, 2.03, 23, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628369.png', 'Boston Celtics');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Al Horford', '1986-06-03', TRUE, 'Florida', 2007, 3.3, 8.2, 13.9, 240, 2.06, 35, 'Dominican Republic', 'https://cdn.nba.com/headshots/nba/latest/260x190/201143.png', 'Boston Celtics');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Paul George', '1990-05-02', TRUE, 'Fresno State', 2010, 3.6, 6.4, 20.4, 220, 2.03, 31, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/202331.png', 'Los Angeles Clippers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Ivica Zubac', '1997-03-18', TRUE, 'Mega Basket', 2016, 1.2, 8.2, 10.3, 240, 2.13, 24, 'Croatia', 'https://cdn.nba.com/headshots/nba/latest/260x190/1627826.png', 'Los Angeles Clippers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Ja Morant', '1999-08-10', TRUE, 'Murray State', 2019, 6.8, 5.6, 24.1, 174, 1.91, 22, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629630.png', 'Memphis Grizzlies');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Steven Adams', '1993-07-20', TRUE, 'Pittsburgh', 2013, 1.3, 7.7, 9.5, 265, 2.11, 28, 'New Zealand', 'https://cdn.nba.com/headshots/nba/latest/260x190/203500.png', 'Memphis Grizzlies');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Trae Young', '1998-09-19', TRUE, 'Oklahoma', 2018, 8.9, 3.9, 24.3, 164, 1.85, 23, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1629027.png', 'Atlanta Hawks');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('John Collins', '1997-09-23', TRUE, 'Wake Forest', 2017, 2.2, 7.9, 17.1, 226, 2.06, 24, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628381.png', 'Atlanta Hawks');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Jimmy Butler', '1989-09-14', TRUE, 'Marquette', 2011, 4.0, 5.3, 17.5, 230, 2.01, 32, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/202710.png', 'Miami Heat');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Bam Adebayo', '1997-07-18', TRUE, 'Kentucky', 2017, 3.2, 10.2, 18.7, 255, 20.6, 24, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628389.png', 'Miami Heat');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Miles Bridges', '1998-03-21', TRUE, 'Michigan State', 2018, 3.2, 7.3, 20.4, 225, 2.01, 23, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628970.png', 'Charlotte Hornets');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('LaMelo Ball', '2001-08-22', TRUE, 'Illawarra', 2020, 8.3, 7.7, 20.0, 180, 2.01, 20, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630163.png', 'Charlotte Hornets');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Donovan Mitchell', '1996-09-07', TRUE, 'Louisville', 2017, 5.1, 4.1, 24.2, 215, 1.85, 25, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628378.png', 'Utah Jazz');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Bojan Bogdanovic', '1989-04-18', TRUE, 'Fenerbahce', 2011, 1.6, 3.6, 14.7, 226, 2.01, 32, 'Croatia', 'https://cdn.nba.com/headshots/nba/latest/260x190/202711.png', 'Utah Jazz');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Richaun Holmes', '1993-10-15', TRUE, 'Bowling Green', 2015, 1.1, 5.8, 9.8, 235, 2.08, 28, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1626158.png', 'Sacramento Kings');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('DeAaron Fox', '1997-12-20', TRUE, 'Kentucky', 2017, 5.5, 3.7, 20.1, 185, 1.91, 23, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1628368.png', 'Sacramento Kings');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Julius Randle', '1994-11-29', TRUE, 'Kentucky', 2014, 5.3, 10.0, 20.1, 150, 2.03, 27, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/203944.png', 'New York Knicks');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Alec Burks', '1991-07-20', TRUE, 'Colorado', 2011, 1.9, 3.4, 10.5, 214, 1.98, 30, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/202692.png', 'New York Knicks');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Cole Anthony', '2000-05-15', TRUE, 'North Carolina', 2020, 6.0, 6.6, 20.2, 185, 1.91, 21, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630175.png', 'Orlando Magic');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Jalen Suggs', '2001-06-03', TRUE, 'Gonzaga', 2021, 3.6, 3.4, 12.3, 205, 1.96, 20, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/1630591.png', 'Orlando Magic');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Carmelo Anthony', '1984-05-29', TRUE, 'Syracuse', 2003, 2.8, 6.3, 22.8, 238, 2.01, 37, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/2546.png', 'Los Angeles Lakers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Anthony Davis', '1993-03-11', TRUE, 'Kentucky', 2012, 2.3, 10.2, 23.9, 253, 2.08, 28, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/203076.png', 'Los Angeles Lakers');
insert into NBA_Players (name, dob, status, college, draft, APG, RPG, PPG, weight, height, age, nationality, img, t_name) 
  values ('Russell Westbrook', '1988-11-12', TRUE, 'UCLA', 2008, 8.5, 7.4, 23.1, 200, 1.91, 33, 'USA', 'https://cdn.nba.com/headshots/nba/latest/260x190/201566.png', 'Los Angeles Lakers');


insert into Date (date) values ('2021-06-10');
insert into Date (date) values ('2021-10-03');
insert into Date (date) values ('2021-10-19');
insert into Date (date) values ('2022-01-25');
insert into Date (date) values ('2021-12-10');
insert into Date (date) values ('2021-12-11');
insert into Date (date) values ('2016-06-02');
insert into Date (date) values ('2016-06-05');
insert into Date (date) values ('2016-06-08');
insert into Date (date) values ('2016-06-10');
insert into Date (date) values ('2016-06-13');
insert into Date (date) values ('2016-06-16');
insert into Date (date) values ('2016-06-19');


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

insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Charlotte Hornets', 'Sacramento Kings', '2021-12-10', 124, 123, 'regular season','Spectrum Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Indiana Pacers', 'Dallas Mavericks', '2021-12-10', 106, 93, 'regular season','Gainbridge Fieldhouse');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Toronto Raptors', 'New York Knicks', '2021-12-10', 90, 87, 'regular season','Scotiabank Arena');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Atlanta Hawks', 'Brooklyn Nets', '2021-12-10', 105, 113, 'regular season','State Farm Arena');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('New Orleans Pelicans', 'Detroit Pistons', '2021-12-10', 109, 93, 'regular season','Smoothie King Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Minnesota Timberwolves', 'Cleveland Cavaliers', '2021-12-10', 106, 123, 'regular season', 'Target Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Oklahoma City Thunder', 'Los Angeles Lakers', '2021-12-10', 95, 116, 'regular season','Paycom Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Houston Rockets', 'Milwaukee Bucks', '2021-12-10', 114, 123, 'regular season','Toyota Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Phoenix Suns', 'Boston Celtics', '2021-12-10', 111, 90, 'regular season','Footprint Center');

insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Los Angeles Clippers', 'Orlando Magic', '2021-12-11', 106, 104, 'regular season','Staples Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Washington Wizards', 'Utah Jazz', '2021-12-11', 98, 123, 'regular season','Capital One Arena');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Miami Heat', 'Chicago Bulls', '2021-12-11', 118, 92, 'regular season', 'FTX Arena');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Memphis Grizzlies', 'Houston Rockets', '2021-12-11', 113, 106, 'regular season','FedExForum');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Cleveland Cavaliers', 'Sacramento Kings', '2021-12-11', 117, 103, 'regular season','Rocket Mortgage FieldHouse');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Philadelphia 76ers', 'Golden State Warriors', '2021-12-11', 102, 93, 'regular season', 'Wells Fargo Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('San Antonio Spurs', 'Denver Nuggets', '2021-12-11', 112, 127, 'regular season','AT&T Center');

insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Golden State Warriors', 'Cleveland Cavaliers', '2016-06-02', 104, 89, 'NBA Finals', 'Chase Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Golden State Warriors', 'Cleveland Cavaliers', '2016-06-05', 110, 77, 'NBA Finals', 'Chase Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Cleveland Cavaliers', 'Golden State Warriors', '2016-06-08', 120, 90, 'NBA Finals', 'Rocket Mortgage FieldHouse');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Cleveland Cavaliers', 'Golden State Warriors', '2016-06-10', 97, 108, 'NBA Finals', 'Rocket Mortgage FieldHouse');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Golden State Warriors', 'Cleveland Cavaliers', '2016-06-13', 97, 112, 'NBA Finals', 'Chase Center');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Cleveland Cavaliers', 'Golden State Warriors', '2016-06-16', 115, 101, 'NBA Finals', 'Rocket Mortgage FieldHouse');
insert into Match (host, guest, m_date, score_host, score_guest, m_type, arena) 
  values ('Golden State Warriors', 'Cleveland Cavaliers', '2016-06-19', 89, 93, 'NBA Finals', 'Chase Center');


insert into Position (name, abbr) values ('Small forward', 'SF');
insert into Position (name, abbr) values ('Power forward', 'PF');
insert into Position (name, abbr) values ('Point guard', 'PG');
insert into Position (name, abbr) values ('Shooting guard', 'SG');
insert into Position (name, abbr) values ('Center', 'C');


insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2003, 2010, 'LeBron James', '1984-12-30', 'Cleveland Cavaliers', 23, 62020283, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2010, 2012, 'LeBron James', '1984-12-30', 'Miami Heat', 6, 27396159, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2012, 2014, 'LeBron James', '1984-12-30', 'Miami Heat', 6, 36612500, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2018, 'LeBron James', '1984-12-30', 'Cleveland Cavaliers', 23, 107864059, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2022, 'LeBron James', '1984-12-30', 'Los Angeles Lakers', 23, 153491118, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2008, 2016, 'Kevin Durant', '1988-09-29', 'Oklahoma City Thunder', 35, 101472033, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2019, 'Kevin Durant', '1988-09-29', 'Golden State Warriors', 35, 81540100, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Kevin Durant', '1988-09-29', 'Brooklyn Nets', 7, 115839413, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2017, 'Georges Niang', '1993-06-17', 'Indiana Pacers', 32, 750000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2021, 'Georges Niang', '1993-06-17', 'Utah Jazz', 31, 4870084, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Georges Niang', '1993-06-17', 'Philadelphia 76ers', 20, 3300000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Tyrese Maxey', '2000-04-11', 'Philadelphia 76ers', 0, 5081760, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2012, 2022, 'Bradley Beal', '1993-06-28', 'Washington Wizards', 3, 177854712, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2013, 2022, 'Giannis Antetokounmpo', '1994-12-06', 'Milwaukee Bucks', 34, 146344870, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2009, 2013, 'Jrue Holiday', '1990-06-12', 'Philadelphia 76ers', 11, 7218068, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2013, 2017, 'Jrue Holiday', '1990-06-12', 'New Orleans Pelicans', 11, 41499804, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2020, 'Jrue Holiday', '1990-06-12', 'New Orleans Pelicans', 11, 77894089, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2021, 'Jrue Holiday', '1990-06-12', 'Milwaukee Bucks', 11, 27026111, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Jrue Holiday', '1990-06-12', 'Milwaukee Bucks', 11, 32431333, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2009, 2018, 'DeMar DeRozan', '1989-08-07', 'Toronto Raptors', 10, 92973650, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2021, 'DeMar DeRozan', '1989-08-07', 'San Antonio Spurs', 10, 81486177, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'DeMar DeRozan', '1989-08-07', 'Chicago Bulls', 11, 26000000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2015, 'Zach LaVine', '1995-03-10', 'Minnesota Timberwolves', 8, 2055840, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2015, 2017, 'Zach LaVine', '1995-03-10', 'Minnesota Timberwolves', 8, 4400000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'Zach LaVine', '1995-03-10', 'Chicago Bulls', 8, 79983468, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2011, 2017, 'Ricky Rubio', '1990-10-21', 'Minnesota Timberwolves', 9, 40766408, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2019, 'Ricky Rubio', '1990-10-21', 'Utah Jazz', 3, 28900000, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2020, 'Ricky Rubio', '1990-10-21', 'Phoenix Suns', 11, 15187500, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2021, 'Ricky Rubio', '1990-10-21', 'Minnesota Timberwolves', 9, 17000000, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Ricky Rubio', '1990-10-21', 'Cleveland Cavaliers', 3, 17800000, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Darius Garland', '2000-01-26', 'Cleveland Cavaliers', 3, 20162520, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'Jayson Tatum', '1998-03-03', 'Boston Celtics', 0, 57867445, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2007, 2016, 'Al Horford', '1986-06-03', 'Atlanta Hawks', 15, 75183554, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2019, 'Al Horford', '1986-06-03', 'Boston Celtics', 42, 83203214, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2020, 'Al Horford', '1986-06-03', 'Philadelphia 76ers', 42, 26250000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2021, 'Al Horford', '1986-06-03', 'Oklahoma City Thunder', 15, 27500000, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Al Horford', '1986-06-03', 'Boston Celtics', 15, 27000000, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2010, 2017, 'Paul George', '1990-05-02', 'Indiana Pacers', 24, 61391831, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2019, 'Paul George', '1990-05-02', 'Oklahoma City Thunder', 13, 50069658, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Paul George', '1990-05-02', 'Los Angeles Clippers', 13, 105738021, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2019, 'Ivica Zubac', '1997-03-18', 'Los Angeles Lakers', 40, 3342620, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Ivica Zubac', '1997-03-18', 'Los Angeles Clippers', 40, 21144805, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Ja Morant', '1999-08-10', 'Memphis Grizzlies', 12, 27500400, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2013, 2020, 'Steven Adams', '1993-07-20', 'Oklahoma City Thunder', 12, 80552138, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2021, 'Steven Adams', '1993-07-20', 'New Orleans Pelicans', 12, 27528088, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Steven Adams', '1993-07-20', 'Memphis Grizzlies', 4, 17073171, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2022, 'Trae Young', '1998-09-19', 'Atlanta Hawks', 11, 26135649, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'John Collins', '1997-09-23', 'Atlanta Hawks', 20, 33891952, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2011, 2017, 'Jimmy Butler', '1989-09-14', 'Chicago Bulls', 21, 43082461, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2019, 'Jimmy Butler', '1989-09-14', 'Minnesota Timberwolves', 23, 20186978, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2019, 'Jimmy Butler', '1989-09-14', 'Philadelphia 76ers', 23, 16051567, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Jimmy Butler', '1989-09-14', 'Miami Heat', 22, 101090925, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'Bam Adebayo', '1997-07-18', 'Miami Heat', 13, 41903392, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2022, 'Miles Bridges', '1998-03-21', 'Charlotte Hornets', 0, 16083141, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'LaMelo Ball', '2001-08-22', 'Charlotte Hornets', 2, 16071720, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'Donovan Mitchell', '1996-09-07', 'Utah Jazz', 45, 42440286, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2017, 'Bojan Bogdanovic', '1989-04-18', 'Brooklyn Nets', 44, 9383275, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2017, 'Bojan Bogdanovic', '1989-04-18', 'Washington Wizards', 44, 1208521, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2019, 'Bojan Bogdanovic', '1989-04-18', 'Indiana Pacers', 44, 21000000, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Bojan Bogdanovic', '1989-04-18', 'Utah Jazz', 44, 52487500, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2015, 2018, 'Richaun Holmes', '1993-10-15', 'Philadelphia 76ers', 22, 3571382, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2019, 'Richaun Holmes', '1993-10-15', 'Phoenix Suns', 21, 1600520, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Richaun Holmes', '1993-10-15', 'Sacramento Kings', 22, 19858913, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'DeAaron Fox', '1997-12-20', 'Sacramento Kings', 5, 52276460, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2018, 'Julius Randle', '1994-11-29', 'Los Angeles Lakers', 30, 13545962, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2019, 'Julius Randle', '1994-11-29', 'New Orleans Pelicans', 30, 8641000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Julius Randle', '1994-11-29', 'New York Knicks', 30, 55575000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2011, 2019, 'Alec Burks', '1991-07-20', 'Utah Jazz', 10, 42178938, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2020, 'Alec Burks', '1991-07-20', 'Philadelphia 76ers', 20, 10000000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Alec Burks', '1991-07-20', 'New York Knicks', 18, 15536000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Cole Anthony', '2000-05-15', 'Orlando Magic', 50, 6734520, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Jalen Suggs', '2001-06-03', 'Orlando Magic', 4, 6593040, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2003, 2011, 'Carmelo Anthony', '1984-05-29', 'Denver Nuggets', 15, 75489227, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2010, 2017, 'Carmelo Anthony', '1984-05-29', 'New York Knicks', 7, 125631432, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2018, 'Carmelo Anthony', '1984-05-29', 'Oklahoma City Thunder', 7, 26243760, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2019, 'Carmelo Anthony', '1984-05-29', 'Houston Rockets', 7, 1338954, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2021, 'Carmelo Anthony', '1984-05-29', 'Portland Trail Blazers', 0, 4588843, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Carmelo Anthony', '1984-05-29', 'Los Angeles Lakers', 7, 2641691, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2012, 2013, 'Anthony Davis', '1993-03-11', 'Charlotte Hornets', 23, 5144280, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2013, 2019, 'Anthony Davis', '1993-03-11', 'New Orleans Pelicans', 23, 89380249, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Anthony Davis', '1993-03-11', 'Los Angeles Lakers', 3, 93503065, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2008, 2019, 'Russell Westbrook', '1988-11-12', 'Oklahoma City Thunder', 0, 166908558, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2020, 'Russell Westbrook', '1988-11-12', 'Houston Rockets', 0, 37303152, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2021, 'Russell Westbrook', '1988-11-12', 'Washington Wizards', 4, 40158814, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Russell Westbrook', '1988-11-12', 'Los Angeles Lakers', 0, 44211146, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2021, 'Kyle Kuzma', '1995-07-24', 'Los Angeles Lakers', 0, 8526766, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Kyle Kuzma', '1995-07-24', 'Washington Wizards', 33, 13000000, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2009, 2022, 'Stephen Curry', '1988-03-14', 'Golden State Warriors', 30, 254736348, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2020, 'Andrew Wiggins', '1995-02-23', 'Minnesota Timberwolves', 22, 66944586, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Andrew Wiggins', '1995-02-23', 'Golden State Warriors', 22, 70279898, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2012, 2022, 'Damian Lillard', '1990-07-15', 'Portland Trail Blazers', 0, 191215866, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2014, 2017, 'Jusuf Nurkic', '1994-08-23', 'Denver Nuggets', 27, 4859189, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2022, 'Jusuf Nurkic', '1994-08-23', 'Portland Trail Blazers', 27, 54535991, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Anthony Edwards', '2001-08-05', 'Minnesota Timberwolves', 1, 20002920, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Leandro Bolmaro', '2000-09-11', 'Minnesota Timberwolves', 9, 2353320, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Aleksej Pokusevski', '2001-12-26', 'Oklahoma City Thunder', 17, 6078000, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Luguentz Dort', '1999-04-19', 'Oklahoma City Thunder', 5, 3456249, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2019, 'Dario Saric', '1994-04-08', 'Philadelphia 76ers', 9, 5097738, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2019, 'Dario Saric', '1994-04-08', 'Minnesota Timberwolves', 36, 2169942, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Dario Saric', '1994-04-08', 'Phoenix Suns', 20, 21024362, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2015, 2022, 'Devin Booker', '1996-10-30', 'Phoenix Suns', 1, 96683253, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2018, 'Jakob Poeltl', '1995-10-15', 'Toronto Raptors', 42, 5529600, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2022, 'Jakob Poeltl', '1995-10-15', 'San Antonio Spurs', 25, 23319378, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'Derrick White', '1994-07-02', 'San Antonio Spurs', 4, 23592940, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2021, 'Daniel Theis', '1992-04-04', 'Boston Celtics', 27, 10066289, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2021, 'Daniel Theis', '1992-04-04', 'Chicago Bulls', 27, 1815068, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Daniel Theis', '1992-04-04', 'Houston Rockets', 27, 8280351, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2010, 2019, 'John Wall', '1990-09-06', 'Washington Wizards', 2, 145959625, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'John Wall', '1990-09-06', 'Houston Rockets', 1, 83178323, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2022, 'Pascal Siakam', '1994-04-02', 'Toronto Raptors', 43, 69821587, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'OG Anunoby', '1997-07-17', 'Toronto Raptors', 3, 25680792, 'SF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Isaiah Stewart', '2001-05-22', 'Detroit Pistons', 28, 6398160, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Killian Hayes', '2001-07-27', 'Detroit Pistons', 7, 10879800, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Zion Williamson', '2000-07-06', 'New Orleans Pelicans', 1, 30126480, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2019, 'Tomas Satoransky', '1991-10-30', 'Washington Wizards', 31, 9000000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2021, 'Tomas Satoransky', '1991-10-30', 'Chicago Bulls', 31, 19375000, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2021, 2022, 'Tomas Satoransky', '1991-10-30', 'New Orleans Pelicans', 31, 10000000, 'SG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2017, 'Domantas Sabonis', '1996-05-03', 'Oklahoma City Thunder', 3, 2440200, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2022, 'Domantas Sabonis', '1996-05-03', 'Indiana Pacers', 11, 48118758, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2015, 2022, 'Myles Turner', '1996-03-24', 'Indiana Pacers', 33, 64176804, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2015, 2022, 'Nikola Jokic', '1995-02-19', 'Denver Nuggets', 15, 117435159, 'C');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2016, 2022, 'Jamal Murray', '1997-02-23', 'Denver Nuggets', 27, 70985709, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2011, 2017, 'Kyrie Irving', '1992-03-23', 'Cleveland Cavaliers', 2, 56239811, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2019, 'Kyrie Irving', '1992-03-23', 'Boston Celtics', 11, 38967813, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Kyrie Irving', '1992-03-23', 'Brooklyn Nets', 11, 98809675, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2010, 2018, 'Blake Griffin', '1989-03-16', 'Los Angeles Clippers', 32, 113712751, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2017, 2021, 'Blake Griffin', '1989-03-16', 'Detroit Pistons', 23, 138180711, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2020, 2022, 'Blake Griffin', '1989-03-16', 'Brooklyn Nets', 2, 3871367, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2018, 2022, 'Luka Doncic', '1999-02-28', 'Dallas Mavericks', 77, 31987541, 'PG');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2015, 2018, 'Kristaps Porzingis', '1995-08-02', 'New York Knicks', 6, 16397022, 'PF');
insert into Period (from_date, to_date, player_name, player_dob, t_name, number, salary, position) 
  values (2019, 2022, 'Kristaps Porzingis', '1995-08-02', 'Dallas Mavericks', 6, 88951160, 'PF');


insert into Play_at (player_name, player_dob, position_name) values ('LeBron James', '1984-12-30', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Kevin Durant', '1988-09-29', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Bradley Beal', '1993-06-28', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Georges Niang', '1993-06-17', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Tyrese Maxey', '2000-04-11', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Giannis Antetokounmpo', '1994-12-06', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Jrue Holiday', '1990-06-12', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('DeMar DeRozan', '1989-08-07', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Zach LaVine', '1995-03-10', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Ricky Rubio', '1990-10-21', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Darius Garland', '2000-01-26', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Jayson Tatum', '1998-03-03', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Al Horford', '1986-06-03', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Paul George', '1990-05-02', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Ivica Zubac', '1997-03-18', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Ja Morant', '1999-08-10', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Steven Adams', '1993-07-20', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Trae Young', '1998-09-19', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('John Collins', '1997-09-23', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Jimmy Butler', '1989-09-14', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Bam Adebayo', '1997-07-18', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Miles Bridges', '1998-03-21', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('LaMelo Ball', '2001-08-22', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Donovan Mitchell', '1996-09-07', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Bojan Bogdanovic', '1989-04-18', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Richaun Holmes', '1993-10-15', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('DeAaron Fox', '1997-12-20', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Julius Randle', '1994-11-29', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Alec Burks', '1991-07-20', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Cole Anthony', '2000-05-15', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Jalen Suggs', '2001-06-03', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Carmelo Anthony', '1984-05-29', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Anthony Davis', '1993-03-11', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Russell Westbrook', '1988-11-12', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Kyle Kuzma', '1995-07-24', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Stephen Curry', '1988-03-14', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Andrew Wiggins', '1995-02-23', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Damian Lillard', '1990-07-15', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Jusuf Nurkic', '1994-08-23', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Anthony Edwards', '2001-08-05', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Leandro Bolmaro', '2000-09-11', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Aleksej Pokusevski', '2001-12-26', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Luguentz Dort', '1999-04-19', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Dario Saric', '1994-04-08', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Devin Booker', '1996-10-30', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Jakob Poeltl', '1995-10-15', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Derrick White', '1994-07-02', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Daniel Theis', '1992-04-04', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('John Wall', '1990-09-06', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Pascal Siakam', '1994-04-02', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('OG Anunoby', '1997-07-17', 'SF');
insert into Play_at (player_name, player_dob, position_name) values ('Isaiah Stewart', '2001-05-22', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Killian Hayes', '2001-07-27', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Zion Williamson', '2000-07-06', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Tomas Satoransky', '1991-10-30', 'SG');
insert into Play_at (player_name, player_dob, position_name) values ('Domantas Sabonis', '1996-05-03', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Myles Turner', '1996-03-24', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Nikola Jokic', '1995-02-19', 'C');
insert into Play_at (player_name, player_dob, position_name) values ('Jamal Murray', '1997-02-23', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Kyrie Irving', '1992-03-23', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Blake Griffin', '1989-03-16', 'PF');
insert into Play_at (player_name, player_dob, position_name) values ('Luka Doncic', '1999-02-28', 'PG');
insert into Play_at (player_name, player_dob, position_name) values ('Kristaps Porzingis', '1995-08-02', 'PF');


insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2020, 'Los Angeles Lakers', 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2016, 'Cleveland Cavaliers', 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2013, 'Miami Heat', 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2012, 'Miami Heat', 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Final MVP', 2020, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Final MVP', 2016, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Final MVP', 2013, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Final MVP', 2012, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2013, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2012, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2010, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2009, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Rookie of the Year', 2004, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA All-Rookie First Team', 2004, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Olympic gold medalist', 2008, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Olympic gold medalist', 2012, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('USA Basketball Male Athlete of the Year', 2012, null, 'LeBron James', '1984-12-30');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Rookie of the Year', 2011, null, 'Blake Griffin', '1989-03-16');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA All-Rookie First Team', 2011, null, 'Blake Griffin', '1989-03-16');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Slam Dunk Champion', 2011, null, 'Blake Griffin', '1989-03-16');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2016, 'Cleveland Cavaliers', 'Kyrie Irving', '1992-03-23');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Rookie of the Year', 2012, null, 'Kyrie Irving', '1992-03-23');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA All-Rookie First Team', 2012, null, 'Kyrie Irving', '1992-03-23');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Three-Point Contest', 2013, null, 'Kyrie Irving', '1992-03-23');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2018, 'Golden State Warriors', 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Championship', 2017, 'Golden State Warriors', 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Final MVP', 2018, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Final MVP', 2017, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Rookie of the Year', 2008, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA All-Rookie First Team', 2008, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2014, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Olympic gold medalist', 2012, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Olympic gold medalist', 2016, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Olympic gold medalist', 2020, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Olympic MVP', 2020, null, 'Kevin Durant', '1988-09-29');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Champion', 2021, 'Milwaukee Bucks', 'Giannis Antetokounmpo', '1994-12-06');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Finals MVP', 2021, null, 'Giannis Antetokounmpo', '1994-12-06');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2019, null, 'Giannis Antetokounmpo', '1994-12-06');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA MVP', 2020, null, 'Giannis Antetokounmpo', '1994-12-06');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Defensive Player of the Year', 2020, null, 'Giannis Antetokounmpo', '1994-12-06');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('NBA Most Improved Player', 2017, null, 'Giannis Antetokounmpo', '1994-12-06');
insert into Awards (name, year, t_name, p_name, p_dob) 
  values ('Euroscar European Player of the Year', 2018, null, 'Giannis Antetokounmpo', '1994-12-06');


insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Scarlett Johansson', 36, 'F', 'Actress', '2011-01-16', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Apryl Jones', 34, 'F', 'Actress', '2017-01-01', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Cassandra Anderson', 31, 'F', 'Realtor', '2018-09-16', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Brittney Elena', 32, 'F', 'Actress', '2017-08-11', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Jasmine Shine', 18, 'F', null, '2017-02-09', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Monica Wright', 33, 'F', 'American basketball coach', '2015-02-18', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Dai Frazier', 18, 'F', 'Model', '2018-11-16', 'Kevin Durant', '1988-09-29');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Carmen Ortega', 35, 'F', 'Model', '2013-08-20', 'LeBron James', '1984-12-30');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Savannah Brinson', 35, 'F', 'Wife', '2013-07-19', 'LeBron James', '1984-12-30');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Meagan Good', 40, 'F', 'Actress', '2004-11-16', 'LeBron James', '1984-12-30');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Adrienne Bailon', 38, 'F', 'TV Host', '2003-04-06', 'LeBron James', '1984-12-30');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Marlene Golden Wilkerson', 28, 'F', 'Blogger', '2003-04-06', 'Kyrie Irving', '1992-03-23');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Chantel Jeffries', 29, 'F', 'Model', '2018-06-21', 'Kyrie Irving', '1992-03-23');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Gabrielle Lexa', null, 'F', 'Actress', '2017-03-25', 'Kyrie Irving', '1992-03-23');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Kehlani Parrish', 26, 'F', 'Singer', '2016-04-06', 'Kyrie Irving', '1992-03-23');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Mariah Riddlesprigger', 29, 'F', 'Volleyball player', '2019-10-01', 'Giannis Antetokounmpo', '1994-12-06');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Madison Beer', 22, 'F', 'Singer', '2018-10-01', 'Blake Griffin', '1989-03-16');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Brynn Cameron', 35, 'F', 'Actress', '2013-08-01', 'Blake Griffin', '1989-03-16');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Kendall Jenner', 26, 'F', 'Model', '2017-08-13', 'Blake Griffin', '1989-03-16');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Sabrina Maserati', null, 'F', null, '2011-01-01', 'Blake Griffin', '1989-03-16');
insert into Celebrities (name, age, sex, speciality, date, player_name, player_dob) 
  values ('Kate Upton', 29, 'F', 'Model', '2013-10-01', 'Blake Griffin', '1989-03-16');

insert into Injuries (name, date, player_name, player_dob) values ('Right Ankle', '2021-10-25', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-25', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-16', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-02', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-05-01', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-03-20', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-03-19', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-03-17', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-03-11', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Rest', '2021-03-03', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Left Ankle', '2021-01-24', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-01-22', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Left Ankle', '2021-01-09', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Groin', '2021-10-09', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Right Groin', '2021-10-05', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Illness', '2021-01-11', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Elbow', '2019-12-14', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Knee', '2019-03-23', 'LeBron James', '1984-12-30');
insert into Injuries (name, date, player_name, player_dob) values ('Rest', '2021-12-08', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Shoulder', '2021-11-19', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Injury Management', '2021-04-30', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Thigh', '2021-04-18', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Rest', '2021-04-14', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Hamstring', '2021-02-14', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Health And Safety Protocols', '2021-02-05', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Injury Recovery-Rest', '2021-01-29', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Achilles Injury Recovery', '2021-01-22', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Health And Safety Protocols', '2021-01-09', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Health And Safety Protocols', '2021-01-04', 'Kevin Durant', '1988-09-29');
insert into Injuries (name, date, player_name, player_dob) values ('Calf', '2021-12-03', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Undisclosed', '2021-12-02', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Right Ankle', '2021-11-11', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Left Knee', '2021-11-01', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Knee', '2021-06-29', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Calf', '2021-06-28', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Calf', '2021-06-26', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Groin', '2021-05-28', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-04-29', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Ankle', '2021-04-28', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Knee', '2021-04-03', 'Giannis Antetokounmpo', '1994-12-06');
insert into Injuries (name, date, player_name, player_dob) values ('Knee', '2021-03-27', 'Giannis Antetokounmpo', '1994-12-06');


insert into Crimes (name, date, player_name, player_dob) values ('flagrant 2 foul', '2021-11-21', 'LeBron James', '1984-12-30');
insert into Crimes (name, date, player_name, player_dob) values ('leave Cleveland', '2010-07-21', 'LeBron James', '1984-12-30');
insert into Crimes (name, date, player_name, player_dob) values ('fly over John Lucas head', '2012-01-29', 'LeBron James', '1984-12-30');
insert into Crimes (name, date, player_name, player_dob) values ('come back from 1-3 defcit', '2016-06-19', 'LeBron James', '1984-12-30');
insert into Crimes (name, date, player_name, player_dob) values ('unbelievable chase down block', '2016-06-19', 'LeBron James', '1984-12-30');
insert into Crimes (name, date, player_name, player_dob) values ('Championship during lockdown', '2020-09-19', 'LeBron James', '1984-12-30');
insert into Crimes (name, date, player_name, player_dob) values ('sign with Warriors', '2016-07-04', 'Kevin Durant', '1988-09-29');
insert into Crimes (name, date, player_name, player_dob) values ('sign with Nets', '2019-07-10', 'Kevin Durant', '1988-09-29');
insert into Crimes (name, date, player_name, player_dob) values ('10 turnovers', '2021-10-28', 'Russell Westbrook', '1988-11-12');
insert into Crimes (name, date, player_name, player_dob) values ('conflict with KD', '2017-11-23', 'Russell Westbrook', '1988-11-12');
insert into Crimes (name, date, player_name, player_dob) values ('slam dunk over car', '2011-02-20', 'Blake Griffin', '1989-03-16');
insert into Crimes (name, date, player_name, player_dob) values ('dunk over Gasol', '2012-04-05', 'Blake Griffin', '1989-03-16');
insert into Crimes (name, date, player_name, player_dob) values ('12 three-pointers', '2016-02-28', 'Stephen Curry', '1988-03-14');
insert into Crimes (name, date, player_name, player_dob) values ('62 points in a game', '2021-01-03', 'Stephen Curry', '1988-03-14');
insert into Crimes (name, date, player_name, player_dob) values ('refuse receive covid vaccine', '2021-07-10', 'Kyrie Irving', '1992-03-23');
insert into Crimes (name, date, player_name, player_dob) values ('fatal three pointer', '2016-06-19', 'Kyrie Irving', '1992-03-23');
insert into Crimes (name, date, player_name, player_dob) values ('possession of marijuana', '2004-11-23', 'Carmelo Anthony', '1984-05-29');
insert into Crimes (name, date, player_name, player_dob) values ('fight in th court', '2006-12-17', 'Carmelo Anthony', '1984-05-29');
insert into Crimes (name, date, player_name, player_dob) values ('arrested drunk driving', '2008-04-14', 'Carmelo Anthony', '1984-05-29');
insert into Crimes (name, date, player_name, player_dob) values ('fight with KG', '2013-01-09', 'Carmelo Anthony', '1984-05-29');



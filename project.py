
from collections import OrderedDict
import psycopg2
import streamlit as st
from configparser import ConfigParser
import pandas as pd
import numpy as np
import altair as alt
from time import gmtime, strftime

st.set_page_config(layout="wide")

@st.cache
def get_config(filename="database.ini", section="postgresql"):
    parser = ConfigParser()
    parser.read(filename)
    return {k: v for k, v in parser.items(section)}
 

@st.cache(allow_output_mutation=True)
def query_db(sql: str):
    #print(f"Running query_db(): {sql}")

    db_info = get_config()

    # Connect to an existing database
    conn = psycopg2.connect(**db_info)

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    cur.execute(sql)

    # Obtain data
    data = cur.fetchall()

    column_names = [desc[0] for desc in cur.description]

    # Make the changes to the database persistent
    conn.commit()

    # Close communication with the database
    cur.close()
    conn.close()

    df = pd.DataFrame(data=data, columns=column_names)

    return df

def human_format(num):
    magnitude = 0
    while abs(num) >= 1000:
        magnitude += 1
        num /= 1000.0
    # add more suffixes if you need them
    return '%.2f%s' % (num, ['', 'K', 'M', 'G', 'T', 'P'][magnitude])

def render_player_page(name, dob, img, logo, pos):
    sql_player_info = f"SELECT * FROM nba_players WHERE name = '{name}' AND dob = '{dob}';"
    sql_crimes = f"SELECT name, date FROM crimes WHERE player_name = '{name}' AND player_dob = '{dob}' ORDER BY 2 DESC,1;"
    sql_injuries = f"SELECT name, date FROM injuries WHERE player_name = '{name}' AND player_dob = '{dob}' ORDER BY 2 DESC,1;"
    sql_celebrities = f"SELECT name, age, sex, speciality, date FROM celebrities WHERE player_name = '{name}' AND player_dob = '{dob}' ORDER BY date DESC, name;"
    sql_history = f"SELECT from_date, to_date, t_name AS team, logo, number, position, salary FROM period p, teams t WHERE player_name = '{name}' AND player_dob = '{dob}' AND t_name = name ORDER BY 1;"

    player_info = query_db(sql_player_info)
    crimes = query_db(sql_crimes)
    injuries = query_db(sql_injuries)
    celebrities = query_db(sql_celebrities)
    history = query_db(sql_history)
    history['period'] = history['from_date'].astype(str) + "-" + history['to_date'].astype(str)

    st.image(logo)
    st.image(img)
    st.write("# {}, {}".format(name, pos))
    st.markdown(f"""
        ## :memo: Info
        * Height: {player_info['height'].values[0]}
        * Weight: {player_info['weight'].values[0]}
        * Birthday: {player_info['dob'].values[0]}
        * Age: {player_info['age'].values[0]}
        * Nationality: {player_info['nationality'].values[0]}
        * Draft: {player_info['draft'].values[0]}
        * College: {player_info['college'].values[0]}
        """)

    st.write("## :chart_with_upwards_trend: Career Stats")

    position_c = st.selectbox("{} career state compares to:".format(name), ["All Positions"]+query_db("SELECT abbr FROM position ORDER BY 1")["abbr"].tolist())
    if position_c == "All Positions":
        sql_career_stat = f"SELECT * FROM (SELECT name, ppg, apg, rpg, PERCENT_RANK() OVER (ORDER BY ppg) AS ppg_p, PERCENT_RANK() OVER (ORDER BY apg) AS apg_p,PERCENT_RANK() OVER (ORDER BY rpg) AS rpg_p from nba_players) as tmp where name ='{name}';"
    else:
        sql_career_stat = f"SELECT * FROM (SELECT name, ppg, apg, rpg, PERCENT_RANK() OVER (ORDER BY ppg) AS ppg_p, PERCENT_RANK() OVER (ORDER BY apg) AS apg_p,PERCENT_RANK() OVER (ORDER BY rpg) AS rpg_p from nba_players, play_at WHERE player_name = name AND (position_name = '{position_c}' OR player_name = '{name}')) as tmp where name ='{name}';"
    career_stat = query_db (sql_career_stat)

    col1, col2, col3= st.columns([1,3,15])
    col2.metric(label="Points per game", value=player_info['ppg'].values[0])
    col2.metric(label="Ribaunds per game", value=player_info['rpg'].values[0])
    col2.metric(label="Assists per game", value=player_info['apg'].values[0])

    ppg_p = pd.DataFrame({'stat': ['PPG'],'percentile':[int(career_stat['ppg_p'].values[0]*100)]})
    rpg_p = pd.DataFrame({'stat': ['RPG'],'percentile':[int(career_stat['rpg_p'].values[0]*100)]})
    apg_p = pd.DataFrame({'stat': ['APG'],'percentile':[int(career_stat['apg_p'].values[0]*100)]})
    c = alt.Chart(ppg_p).mark_circle(size=150).encode(y=alt.Y('stat', axis=alt.Axis(labels=False, title='')), x=alt.X('percentile', scale=alt.Scale(domain=[0, 100])), tooltip=['percentile'])
    col3.altair_chart(c, use_container_width=True)
    c = alt.Chart(rpg_p).mark_circle(size=150).encode(y=alt.Y('stat', axis=alt.Axis(labels=False, title='')), x=alt.X('percentile', scale=alt.Scale(domain=[0, 100])), tooltip=['percentile'])
    col3.altair_chart(c, use_container_width=True)
    c = alt.Chart(apg_p).mark_circle(size=150).encode(y=alt.Y('stat', axis=alt.Axis(labels=False, title='')), x=alt.X('percentile', scale=alt.Scale(domain=[0, 100])), tooltip=['percentile'])
    col3.altair_chart(c, use_container_width=True)

    st.write("## :book: History")
    history_table = "\n| YEAR | TEAM | NO. | POSITION | SALARY |\n| :-----------: | :-----------: | :-----------: | :-----------: | :-----------: |\n"
    for i in range(len(history)):
        history_table += "| {} | ![]({}) {} | {} | {} | ${} |\n".format(history['period'].values[i], history['logo'].values[i], history['team'].values[i], history['number'].values[i], history['position'].values[i], history['salary'].values[i])
    st.markdown(history_table)
    st.write(" ")
    position_s = st.selectbox("{} salary compare To:".format(name), ["All Positions"]+query_db("SELECT abbr FROM position")["abbr"].tolist())
    if position_s == "All Positions":
        sql_salary = f"SELECT * FROM (SELECT player_name, total, avg, PERCENT_RANK() OVER (ORDER BY total) AS total_p, PERCENT_RANK() OVER (ORDER BY avg) AS avg_p FROM (SELECT player_name, SUM(salary) as total, ROUND(SUM(salary)/(MAX(to_date)-MIN(from_date))) as avg FROM period GROUP BY player_name) AS tmp1) AS tmp2 where player_name ='{name}';"
    else:
        sql_salary = f"SELECT * FROM (SELECT player_name, total, avg, PERCENT_RANK() OVER (ORDER BY total) AS total_p, PERCENT_RANK() OVER (ORDER BY avg) AS avg_p FROM (SELECT p.player_name, SUM(salary) as total, ROUND(SUM(salary)/(MAX(to_date)-MIN(from_date))) as avg FROM period p, play_at pa WHERE p.player_name = pa.player_name AND (position_name = '{position_s}' OR pa.player_name = '{name}')GROUP BY p.player_name) AS tmp1) AS tmp2 where player_name ='{name}';"
    
    col1, col2, col3= st.columns([1,3,15])
    salary = query_db(sql_salary)
    col2.metric(label="Total salary (USD)", value=human_format(int(salary['total'].values[0])))
    col2.metric(label="Average salary (USD)", value=human_format(int(salary['avg'].values[0])))

    total_p = pd.DataFrame({'stat': ['TOTAL'],'percentile':[int(salary['total_p'].values[0]*100)]})
    avg_p = pd.DataFrame({'stat': ['AVG'],'percentile':[int(salary['avg_p'].values[0]*100)]})
    c = alt.Chart(total_p).mark_circle(size=150).encode(y=alt.Y('stat', axis=alt.Axis(labels=False, title='')), x=alt.X('percentile', scale=alt.Scale(domain=[0, 100])), tooltip=['percentile'])
    col3.altair_chart(c, use_container_width=True)
    c = alt.Chart(avg_p).mark_circle(size=150).encode(y=alt.Y('stat', axis=alt.Axis(labels=False, title='')), x=alt.X('percentile', scale=alt.Scale(domain=[0, 100])), tooltip=['percentile'])
    col3.altair_chart(c, use_container_width=True)

    st.write("## :trophy: Awards")
    awards_min_max = query_db(f"SELECT MAX(year), MIN(year) FROM awards WHERE p_name = '{name}' AND p_dob = '{dob}'")
    if (awards_min_max.iloc[0,1] is not None) and (int(awards_min_max.iloc[0,1])<int(awards_min_max.iloc[0,0])):
        year = st.slider("Award Year Range:", min_value = int(awards_min_max.iloc[0,1]), max_value = int(awards_min_max.iloc[0,0]), value = [int(awards_min_max.iloc[0,1]), int(awards_min_max.iloc[0,0])])
        awards = query_db(f"SELECT name, year FROM awards WHERE p_name = '{name}' AND p_dob = '{dob}' AND year BETWEEN {year[0]} AND {year[1]} ORDER BY year DESC, name;")
        awards_cnt = query_db(f"SELECT name, COUNT(*) AS cnt FROM awards WHERE p_name = '{name}' AND p_dob = '{dob}' AND year BETWEEN {year[0]} AND {year[1]} GROUP BY name ORDER BY name;")
    else:
        awards = query_db(f"SELECT name, year FROM awards WHERE p_name = '{name}' AND p_dob = '{dob}' ORDER BY year DESC, name;")
        awards_cnt = query_db(f"SELECT name, COUNT(*) AS cnt FROM awards WHERE p_name = '{name}' AND p_dob = '{dob}' GROUP BY name ORDER BY name;")
    col1, col2 = st.columns(2)
    col1.dataframe(awards)
    for i in range(len(awards_cnt)):
        col2.metric(label=awards_cnt.iloc[i,0], value=int(awards_cnt.iloc[i,1]))

    st.write("## :collision: Injuries")
    st.dataframe(injuries)
    
    st.write("## :smiling_imp: Gossips")
    st.dataframe(celebrities)
    
    st.write("## :cop: Crimes")
    st.write(crimes)

def matches():
    sql_team = "SELECT name FROM Teams ORDER BY name;"
    sql_date = "SELECT date FROM Date ORDER BY date desc;"
    sql_arena = "SELECT name FROM Arenas ORDER BY name;"
    sql_match_type = "SELECT name FROM Match_type ORDER BY name;"
    sql_continents = "SELECT DISTINCT continent FROM Countries ORDER BY continent"
    tmp_date = []
    tmp_date.append("All Dates")
    st.sidebar.write("-------------------------")
    m_date = st.sidebar.multiselect("Date", ["All Dates"] + query_db(sql_date)["date"].tolist(), default = tmp_date)
    team = st.sidebar.selectbox("Team", ["All Teams"] + query_db(sql_team)["name"].tolist())
    arena = st.sidebar.selectbox("Arenas", ["All Arenas"] + query_db(sql_arena)["name"].tolist())
    match_type = st.sidebar.selectbox("Match type", ["All types"] + query_db(sql_match_type)["name"].tolist())
    score = st.sidebar.number_input(label = "Match score", min_value = 0, max_value = 200, value = 0, step = 1)
    st.sidebar.write("-------------------------")
    continent = st.sidebar.selectbox("Continent (Independent)", ["All Continents"]+query_db(sql_continents)["continent"].tolist())
    st.sidebar.write("-------------------------")
    playerName = st.sidebar.text_input("Player Name (Independent)")
    sql_matches = "SELECT m.host, t1.abbr, m.score_host, m.m_date, m.score_guest, t2.abbr, m.guest, t1.logo, t2.logo, m.m_type, m.arena FROM Match m, Teams t1, Teams t2 WHERE m.host = t1.name AND m.guest = t2.name"
    conditions = []
    if playerName:
        sql_matches = "SELECT m.host, t1.abbr, m.score_host, m.m_date, m.score_guest, t2.abbr, m.guest, t1.logo, t2.logo, m.m_type, m.arena FROM Match m, Teams t1, Teams t2 WHERE m.host = t1.name AND m.guest = t2.name AND (m.host in "
        sql_players_team = "(SELECT p.t_name FROM NBA_Players p WHERE " + "p.name LIKE '%{}%')".format(playerName)
        sql_matches = sql_matches + sql_players_team
        sql_matches = sql_matches + "OR m.guest in "
        sql_matches = sql_matches + sql_players_team + ")"
        sql_matches += " ORDER BY m.m_date DESC, m.host"
    elif continent != "All Continents":
        sql_matches = "SELECT m.host, t1.abbr, m.score_host, m.m_date, m.score_guest, t2.abbr, m.guest, t1.logo, t2.logo, m.m_type, m.arena FROM Match m, Teams t1, Teams t2 WHERE m.host = t1.name AND m.guest = t2.name AND (m.host in "
        sql_continent = "(SELECT DISTINCT p.t_name FROM NBA_Players p, Countries c WHERE p.nationality = c.name AND " + " c.continent = '{}')".format(continent)
        sql_matches = sql_matches + sql_continent
        sql_matches = sql_matches + "OR m.guest in "
        sql_matches = sql_matches + sql_continent + ")"
        sql_matches += " ORDER BY m.m_date DESC, m.host"
    else:
        tmp_date = []
        tmp_date.append("All Dates")
        if m_date != tmp_date and len(m_date) != 0:
            if "All Dates" not in m_date:
                if len(m_date) == 1:
                    conditions.append("m.m_date = '{}'".format(m_date[0]))
                else:
                    strdate = "("
                    for i in range(len(m_date)):
                        if i < len(m_date) - 1:
                            strdate += "m.m_date = '{}' or ".format(m_date[i])
                        else:
                            strdate += "m.m_date = '{}' )".format(m_date[i])
                    conditions.append(strdate)
        if team != "All Teams":
            conditions.append("(m.host = '{}'".format(team) + "or m.guest = '{}')".format(team))
        if arena != "All Arenas":
            conditions.append("m.arena = '{}'".format(arena))
        if match_type != "All types":
            conditions.append("m.m_type = '{}'".format(match_type))
        if score:
            conditions.append("(m.score_host >= '{}'".format(score) + "or m.score_guest >= '{}')".format(score))
        if conditions:
            sql_matches += " AND " + " AND ".join(conditions)
        sql_matches += " ORDER BY m.m_date DESC, m.host"

    sql_statistics = "SELECT avg(m.score_host) avg_host,  avg(m.score_guest) avg_guest FROM Match m, Teams t1, Teams t2 WHERE " + sql_matches.split("WHERE", 1)[1].split("ORDER BY")[0] 
    df_statistics = query_db(sql_statistics)
    col1, col2, col3, col4, col5, col6 = st.columns([2, 6, 6, 4, 2, 4])

    if (pd.isna(df_statistics.iloc[0,0]) == False):
        col1.image("https://cdn.nba.com/next/75-teaser/player-list/logo.png")
        col2.metric(f"Host Average Score", value = '{:.2f}'.format(df_statistics.iloc[0,0]))
        col3.metric("date", value = strftime("%Y-%m-%d", gmtime()))
        col4.metric(f"Guest Average Score", value = '{:.2f}'.format(df_statistics.iloc[0,1]))
        col5.image("https://cdn.nba.com/next/75-teaser/player-list/logo.png")
        my_expander = col6.expander("more", expanded = False)
        with my_expander:
            st.balloons()
        st.write("-------------------------")

    df = query_db(sql_matches)
    for i in range(len(df)):
        scorehost, scoreguest = df.iloc[i,2], df.iloc[i,4]
        hostname, hostabbr, matchdate, guestname, guestabbr = df.iloc[i,0], df.iloc[i,1], df.iloc[i,3], df.iloc[i,6], df.iloc[i,5]
        col1, col2, col3, col4, col5, col6 = st.columns([2, 6, 6, 4, 2, 4])
        col1.image(df.iloc[i,-4])
        col2.metric(f"{hostname}, {hostabbr}", value = '{:d}'.format(int((scorehost, 0)[pd.isna(scorehost)])), delta = int(0 if pd.isna(scorehost) or scorehost is None else (scorehost - scoreguest)))
        col3.metric("date", f"{matchdate}")
        col4.metric(f"{guestname}, {guestabbr}", value = '{:d}'.format(int((scoreguest, 0)[pd.isna(scoreguest)])), delta = int(0 if pd.isna(scoreguest) or scoreguest is None else (scoreguest - scorehost)))
        col5.image(df.iloc[i,-3])
        my_expander = col6.expander("more", expanded = False)
        with my_expander:
            st.write(f"Arena: {df.iloc[i,-1]}")
            st.write(f"This is a {df.iloc[i,-2]} game")

def players():
    sql_team_names = "SELECT name FROM teams ORDER BY 1;"
    sql_positions = "SELECT name FROM position ORDER BY 1"
    sql_countries = "SELECT name FROM countries ORDER BY 1"
    playerName = st.sidebar.text_input("Player Name")
    team = st.sidebar.selectbox("Team", ["All Teams"]+query_db(sql_team_names)["name"].tolist())
    position = st.sidebar.selectbox("Position", ["All Positions"]+query_db(sql_positions)["name"].tolist())
    country = st.sidebar.selectbox("Country", ["All Countries"]+query_db(sql_countries)["name"].tolist())
    sql_players = "SELECT p.name, p.dob, p.img, t.abbr, t.logo, po.abbr FROM nba_players p, teams t, play_at pa, position po WHERE p.t_name = t.name AND p.name = pa.player_name AND pa.position_name = po.abbr"
    conditions = []
    if playerName:
        conditions.append("p.name LIKE '%{}%'".format(playerName))
    if team != "All Teams":
        conditions.append("p.t_name = '{}'".format(team))
    if position != "All Positions":
        conditions.append("po.name = '{}'".format(position))
    if country != "All Countries":
        conditions.append("p.nationality = '{}'".format(country))
    if conditions:
        sql_players += " AND " + " AND ".join(conditions)
    sql_players += " ORDER BY 1, 4;" 
    df = query_db(sql_players)
    for i in range(len(df)):
        st.image(df.iloc[i,2], width=100)
        my_expander = st.expander("{}, {}".format(df.iloc[i,0], df.iloc[i,3]), expanded=False)
        with my_expander:
            render_player_page(df.iloc[i,0], df.iloc[i,1], df.iloc[i,2], df.iloc[i,4], df.iloc[i,5])
            
def leaderboard():
    metric = st.sidebar.selectbox("Choose a metric:", [
        "Total Salary",
        "Average Salary",
        "Points per Game",
        "Ribaunds per Game",
        "Assists per Game"
        ], 0)
    st.sidebar.write("Filters:")
    sql_team_names = "SELECT name FROM teams ORDER BY 1;"
    sql_positions = "SELECT abbr FROM position ORDER BY 1"
    sql_countries = "SELECT name FROM countries ORDER BY 1"
    team = st.sidebar.selectbox("Team", ["All Teams"]+query_db(sql_team_names)["name"].tolist())
    position = st.sidebar.selectbox("Position", ["All Positions"]+query_db(sql_positions)["abbr"].tolist())
    country = st.sidebar.selectbox("Country", ["All Countries"]+query_db(sql_countries)["name"].tolist())
    conditions = []
    if team != "All Teams":
        conditions.append("p.t_name = '{}'".format(team))
    if position != "All Positions":
        conditions.append("pa.position_name = '{}'".format(position))
    if country != "All Countries":
        conditions.append("p.nationality = '{}'".format(country))
    if conditions:
        conditions = " AND " + " AND ".join(conditions)
    else:
        conditions = ""
    col1, col2, col3, col4 = st.columns([1,2,10,10])
    col1.write('## RANK')
    col2.write('## .')
    col3.write('## PLAYER')
    col4.write("## "+metric)
    if metric == "Total Salary":
        sql_metric = f"SELECT p.name, p.img, SUM(pd.salary) FROM nba_players p, period pd, play_at pa WHERE p.name = pd.player_name AND p.dob = pd.player_dob AND p.name = pa.player_name AND p.dob = pa.player_dob {conditions} GROUP BY p.name, p.img ORDER BY 3 DESC;"
        df = query_db(sql_metric)
        for i in range(len(df)):
            col1.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(i+1), unsafe_allow_html=True)
            col2.image(df.iloc[i,1])
            col3.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,0]), unsafe_allow_html=True)
            col4.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(human_format(df.iloc[i,2])), unsafe_allow_html=True)
    elif metric == "Average Salary":
        sql_metric = f"SELECT p.name, p.img, ROUND(SUM(pd.salary)/(MAX(pd.to_date)-MIN(pd.from_date))) FROM nba_players p, period pd, play_at pa WHERE p.name = pd.player_name AND p.name = pa.player_name AND p.dob = pa.player_dob {conditions} GROUP BY p.name, p.img ORDER BY 3 DESC;"
        df = query_db(sql_metric)
        for i in range(len(df)):
            col1.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(i+1), unsafe_allow_html=True)
            col2.image(df.iloc[i,1])
            col3.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,0]), unsafe_allow_html=True)
            col4.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(human_format(df.iloc[i,2])), unsafe_allow_html=True)
    elif metric == "Points per Game":
        sql_metric = f"SELECT p.name, p.img, p.ppg FROM nba_players p, play_at pa WHERE p.name = pa.player_name AND p.dob = pa.player_dob {conditions} ORDER BY 3 DESC;"
        df = query_db(sql_metric)
        for i in range(len(df)):
            col1.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(i+1), unsafe_allow_html=True)
            col2.image(df.iloc[i,1])
            col3.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,0]), unsafe_allow_html=True)
            col4.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,2]), unsafe_allow_html=True)
    elif metric == "Ribaunds per Game":
        sql_metric = f"SELECT p.name, p.img, p.rpg FROM nba_players p, play_at pa WHERE p.name = pa.player_name AND p.dob = pa.player_dob {conditions} ORDER BY 3 DESC;"
        df = query_db(sql_metric)
        for i in range(len(df)):
            col1.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(i+1), unsafe_allow_html=True)
            col2.image(df.iloc[i,1])
            col3.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,0]), unsafe_allow_html=True)
            col4.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,2]), unsafe_allow_html=True)
    elif metric == "Assists per Game":
        sql_metric = f"SELECT p.name, p.img, p.apg FROM nba_players p, play_at pa WHERE p.name = pa.player_name AND p.dob = pa.player_dob {conditions} GROUP ORDER BY 3 DESC;"
        df = query_db(sql_metric)
        for i in range(len(df)):
            col1.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(i+1), unsafe_allow_html=True)
            col2.image(df.iloc[i,1])
            col3.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,0]), unsafe_allow_html=True)
            col4.markdown('<p style= "font-size: 31.6px;">{}</p>'.format(df.iloc[i,2]), unsafe_allow_html=True)


PAGES = OrderedDict([
    ("Matches", matches),
    ("Players", players),
    ("Leaderboard", leaderboard)
    ])

def run():
    page_name = st.sidebar.selectbox("Choose a page", list(PAGES.keys()), 0)
    page = PAGES[page_name]
    st.write("# {}".format(page_name))
    page()

if __name__ == "__main__":
    run()
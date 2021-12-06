
from collections import OrderedDict
import psycopg2
import streamlit as st
from configparser import ConfigParser
import pandas as pd
import numpy as np

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

def render_player_page(name, dob, img):
    sql_player_info = f"SELECT * FROM nba_players WHERE name = '{name}' AND dob = '{dob}';"
    sql_crimes = f"SELECT name, date FROM crimes WHERE player_name = '{name}' AND player_dob = '{dob}';"
    sql_injuries = f"SELECT name, date FROM injuries WHERE player_name = '{name}' AND player_dob = '{dob}';"
    sql_celebrities = f"SELECT name, age, sex, speciality, date FROM celebrities WHERE player_name = '{name}' AND player_dob = '{dob}';"
    player_info = query_db(sql_player_info)
    crimes = query_db(sql_crimes)
    injuries = query_db(sql_injuries)
    celebrities = query_db(sql_celebrities)

    st.image(img)
    st.write("# {}".format(name))
    st.markdown(f"""
        ## Info
        * Height: {player_info['height'].values[0]}
        * Weight: {player_info['weight'].values[0]}
        * Birthday: {player_info['dob'].values[0]}
        * Age: {player_info['age'].values[0]}
        * Nationality: {player_info['nationality'].values[0]}
        * Draft: {player_info['draft'].values[0]}
        * College: {player_info['college'].values[0]}

        ## Stats
        * APG: {player_info['apg'].values[0]}
        * RPG: {player_info['rpg'].values[0]}
        * PPG: {player_info['ppg'].values[0]}

        """)
    st.write("## Injuries")
    st.dataframe(injuries)
    st.write("## Gossips")
    st.dataframe(celebrities)
    st.write("## Crimes")
    st.write(crimes)

def matches():
    sql_team = "SELECT name FROM Teams ORDER BY name;"
    sql_date = "SELECT date FROM Date ORDER BY date desc;"
    m_date = st.sidebar.selectbox("Date", ["All Dates"] + query_db(sql_date)["date"].tolist())
    team = st.sidebar.selectbox("Team", ["All Teams"] + query_db(sql_team)["name"].tolist())
    sql_matches = "SELECT DISTINCT m.host, t1.abbr, m.score_host, m.m_date, m.score_guest, t2.abbr, m.guest, t1.logo, t2.logo, m.m_type, m.arena FROM Match m, Teams t1, Teams t2, NBA_Players p WHERE m.host = t1.name AND m.guest = t2.name"
    conditions = []
    if m_date != "All Dates":
        conditions.append("m.m_date = '{}'".format(m_date))
    if team != "All Teams":
        conditions.append("m.host = '{}'".format(team))
    if conditions:
        sql_matches += " AND " + " AND ".join(conditions)
    sql_matches += " ORDER BY m.m_date DESC, m.host"
    df = query_db(sql_matches)
    for i in range(len(df)):
        scorehost, scoreguest = df.iloc[i,2], df.iloc[i,4]
        hostname, hostabbr, matchdate, guestname, guestabbr = df.iloc[i,0], df.iloc[i,1], df.iloc[i,3], df.iloc[i,6], df.iloc[i,5]
        col1, col2, col3, col4, col5, col6 = st.columns([2, 6, 6, 4, 2, 4])
        col1.image(df.iloc[i,-4])
        col2.metric(f"{hostname}, {hostabbr}", '{:d}'.format(int((scorehost, 0)[pd.isna(scorehost)])))
        col3.metric("date", f"{matchdate}")
        col4.metric(f"{guestname}, {guestabbr}", '{:d}'.format(int((scoreguest, 0)[pd.isna(scoreguest)])))
        col5.image(df.iloc[i,-3])
        my_expander = col6.expander("more", expanded = False)
        with my_expander:
            st.write(f"Arena: {df.iloc[i,-1]}")
            st.write(f"A {df.iloc[i,-2]} game")

def players():
    sql_team_names = "SELECT name FROM teams;"
    sql_positions = "SELECT name FROM position"
    sql_countries = "SELECT name FROM countries"
    playerName = st.sidebar.text_input("Player Name")
    team = st.sidebar.selectbox("Team", ["All Teams"]+query_db(sql_team_names)["name"].tolist())
    position = st.sidebar.selectbox("Position", ["All Positions"]+query_db(sql_positions)["name"].tolist())
    country = st.sidebar.selectbox("Country", ["All Countries"]+query_db(sql_countries)["name"].tolist())
    sql_players = "SELECT p.name, p.dob, p.img, t.abbr FROM nba_players p, teams t, play_at pa, position po WHERE p.t_name = t.name AND p.name = pa.player_name AND pa.position_name = po.abbr"
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
        col1, col2 = st.columns([1,19])
        col1.image(df.iloc[i,2])
        my_expander = col2.expander("{}, {}".format(df.iloc[i,0], df.iloc[i,-1]), expanded=False)
        with my_expander:
            render_player_page(df.iloc[i,0], df.iloc[i,1], df.iloc[i,2])
            
def news():
    pass


PAGES = OrderedDict([
    ("Matches", matches),
    ("Players", players),
    ("News", news)
    ])

def run():
    page_name = st.sidebar.selectbox("Choose a page", list(PAGES.keys()), 0)
    page = PAGES[page_name]
    st.write("# {}".format(page_name))
    page()

if __name__ == "__main__":
    run()
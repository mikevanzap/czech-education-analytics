import streamlit as st
import pandas as pd
from trino.dbapi import connect

st.title("🎓 Czech Education Insights")

@st.cache_data
def load_data():
    conn = connect(host='localhost', port=8080, user='admin', catalog='hive', schema='analytics')
    return pd.read_sql("SELECT * FROM fct_regional_education", conn)

df = load_data()

st.subheader("Regional Summary")
st.dataframe(df)

st.subheader("Graduates vs Institutions")
st.scatter_chart(df, x='institution_count', y='total_graduates')

st.subheader("Map (simplified)")
st.map(df.assign(lat=df['region_code'].map({'CZ010': 50.0755, 'CZ052': 50.2065}).fillna(49.8175),
                 lon=df['region_code'].map({'CZ010': 14.4378, 'CZ052': 15.8148}).fillna(15.4730)))
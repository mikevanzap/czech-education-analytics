import pandas as pd
from trino.dbapi import connect
from sklearn.cluster import KMeans
import plotly.express as px

# Connect to Trino
conn = connect(host='localhost', port=8080, user='admin', catalog='iceberg', schema='testnamespace')
df = pd.read_sql("SELECT * FROM fct_regional_education", conn)

# Correlation
print("Correlation:\n", df[['institution_count', 'total_graduates']].corr())

# Clustering
kmeans = KMeans(n_clusters=3)
df['cluster'] = kmeans.fit_predict(df[['institution_count', 'total_graduates']].fillna(0))

# Plot
fig = px.scatter(df, x='institution_count', y='total_graduates', color='cluster',
                 hover_data=['region_code'], title="Czech Regions: Institution vs Graduates")
fig.write_html("region_clusters.html")
print("✅ ML analysis saved to region_clusters.html")
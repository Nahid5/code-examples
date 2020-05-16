#!/usr/bin/env python3
import psycopg2
from psycopg2.extras import Json, DictCursor

conn = None
try:
    # Connection location and password 
    connection_str = "dbname='SOMEDB' user='postgres' host='localhost' password='postgres'"

    conn = psycopg2.connect(connection_str)

    # Create cursor that can execute queries
    cursor = conn.cursor(cursor_factory=DictCursor)
    
    # Example query
    cursor.execute("SELECT datname FROM pg_database;")

    # Execute the command
    conn.commit()
    
    # Get output of the command
    rows = cursor.fetchall()


    cursor.close()
    conn.close()
    print("PostgreSQL connection is closed")

except Exception as error :
    print ("Error while connecting to PostgreSQL", error)
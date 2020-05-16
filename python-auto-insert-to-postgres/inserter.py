#!/usr/bin/env python3
import psycopg2
from psycopg2.extras import Json, Dictonary

conn = None
try:
    # Connection location and password 
    connection_str = "dbname='SOMEDB' user='postgres' host='localhost' password='postgres'"

    conn = psycopg2.connect(connection_str)

    # Create cursor that can execute queries
    cursor = conn.cursor(cursor_factor=DictCursor)
    
    # Example query
    cursor.execute("SELECT datname FROM pg_database;")

    # Execute the command
    conn.commit()
    
    # Get output of the command
    rows = cursor.fetchall()

except (Exception, psycopg2.Error) as error :
    print ("Error while connecting to PostgreSQL", error)
finally:
    #closing database connection.
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
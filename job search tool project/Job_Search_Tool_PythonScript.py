#!/usr/bin/env python
# coding: utf-8

# In[2]:


import mysql.connector
#
from mysql.connector import Error
#
try:
    connection = mysql.connector.connect(host='localhost',
                                         database='job_posting_project',
                                         user='root',
                                         password='Amruta@0205',
                                         auth_plugin = 'mysql_native_password')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("Your connected to database: ", record)
#
        sql_select_Query = "select * from job_listing"
        cursor = connection.cursor()
        cursor.execute(sql_select_Query)
        records = cursor.fetchall()
        print("JobID with company Myworks:\n")
        for row in records:
            print('Jobid =',row[0],"\n")
#
except Error as e:
    print("Error while connecting to MySQL", e)
#finally:
   # if (connection.is_connected()):
       # cursor.close()
        #connection.close()
       # print("MySQL connection is closed")


# In[6]:


sql_select_Query = "select * from job_listing limit 10"
        cursor = connection.cursor()
        cursor.execute(sql_select_Query)
        records = cursor.fetchall()
        print("JobID with company Myworks:\n")
        for row in records:
            print('Jobid =',row[0],"\n")


# In[2]:


pip install mysql-connector-python


# In[3]:


import pandas as pd

job_listing = pd.read_sql('SELECT * FROM job_listing', connection)

job_listing.head()


# In[9]:


#What is the distribution of job listings by location?
import numpy as np
import seaborn as sns

import matplotlib.pyplot as plt
query = """
SELECT location, COUNT(*) AS num_listings
FROM job_listing
GROUP BY location
ORDER BY num_listings DESC
limit 20
"""

# Execute the query and store the results in a Pandas dataframe
df = pd.read_sql(query, connection)

# Visualize the distribution using a bar plot
sns.barplot(x='location', y='num_listings', data=df)
plt.title('Distribution of Job Listings by Location')
plt.xlabel('Location')
plt.ylabel('Number of Job Listings')
plt.xticks(rotation=90)
plt.show()


# In[19]:


#Which job titles have the highest average salary?
query1 = '''
SELECT job_title, AVG(salary) AS avg_salary
FROM job_listing
GROUP BY job_title
ORDER BY avg_salary DESC
'''

df1 = pd.read_sql(query1, connection)
df1.head(10)


# In[20]:


#How many job listings have been posted by each employer
query2 = '''
        SELECT JP.EmployerID, COUNT(J.JobID) as TotalJobListings
        FROM Job_listing J
        JOIN JobPosts JP ON J.jobID = JP.JobID
        GROUP BY JP.EmployerID
        '''

df2 = pd.read_sql(query2, connection)
df2.head(10)


# In[21]:


query3= '''
       SELECT job_title, COUNT(*) as num_applicants 
       FROM applicants 
       INNER JOIN job_listing ON applicants.jobid = job_listing.jobid 
       GROUP BY job_title 
     ORDER BY num_applicants DESC
     '''
df3 = pd.read_sql(query3, connection)
df3.head(10)


# In[12]:


import matplotlib.pyplot as plt
query4 = '''
        SELECT Employer.EmployerName, COUNT(*) AS JobListings
        FROM JobPosts
        left join Employer
        ON JobPosts.EmployerId = Employer.EmployerId
        GROUP BY Employer.EmployerName
        ORDER BY JobListings DESC
        limit 10
'''

# Execute the query and store the results in a DataFrame
df = pd.read_sql(query4, connection)

# Create the bar chart
plt.bar(df['EmployerName'], df['JobListings'])
plt.xticks(rotation=90)
plt.xlabel('Employer Name')
plt.ylabel('Number of Job Listings')
plt.title('Job Listings by Employer')
plt.show()


# In[17]:


import numpy as np
df = pd.read_sql("SELECT Salary FROM Job_listing WHERE Job_Title='Account coordinator'", connection)

# Create a histogram to visualize salary distribution
n, bins, patches = plt.hist(df['Salary'], bins=10, alpha=0.5, density=True)

# Add a line showing the mean salary
mean = np.mean(df['Salary'])
plt.axvline(mean, color='r', linestyle='dashed', linewidth=1)

# Add labels and title
plt.xlabel('Salary ($)')
plt.ylabel('Frequency')
plt.title('Salary Distribution for Account Coordinators')

# Show the plot
plt.show()


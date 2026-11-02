DBAS 5115 - Tech Check 2 - SQL DML and Jupyter Notebooks
Setup Instructions:
Open this repository in the default GitHub Codespace as shown in class.
When satisfied that you have completed all the required changes to the repository folder, commit & push the entire folder's contents up to GitHub as shown in class.
You must ensure that your solution has been pushed to GitHub in order to get credit for the Tech Check.
Please show your solution to the instructor within class time to get full 10/10 credit for the Tech Check (see Marking Scheme below) or commit what you have done by the end of class to finish within 12-hours for 8/10
More Setup Instructions
Run the following commands at the Terminal:
sudo apt-get update
sudo apt-get install postgresql-client
psql -d postgres -h localhost -U postgres –W [then enter postgres password] 
In the psql client command-line application, run the following commands:
\dt [should show no tables]
\i ./chinook/Chinook_PostgreSql_SerialPKs.sql
\dt [should show 11 tables]
exit
Install the following VS Code Extensions:
SQLTools
SQLTools PostgreSQL/Cockroach Driver
Now create a connection to the database using SQLTools as shown in class
You should be able to see the 11 tables in the SQLTools explorer
Please refer to the Chinook ERD, before continuing:
as a reference, refer to the following while completing the Tech Check: Chinook ERD
be aware the naming scheme in the ERD differs a bit from the actual database i.e. the PK of the Artist table is actually artist_id and NOT ArtistId
Part A: DML
Part A - Instructions
NOTE: You can complete Part A in the existing Chinook_DML.sql file that already has comments for the following 10 steps.

Have a DML script file to perform the following tasks:

Add a New Customer
Add a new customer named Jane Doe who lives in Toronto, Canada. Use any appropriate values for other required fields.
Modify the Customer Information
Update Jane Doe’s city to Vancouver.
NOTE: You can do so by her PK value, even if it might need to change when run again.
Remove the Customer
Delete the customer record for Jane Doe.
NOTE: You can do so by her PK value, even if it might need to change when run again.
Album Information
List all albums with their titles and corresponding artist IDs.
Find Bach's Tracks
Find all tracks where the composer is Johann Sebastian Bach.
Five Longest Tracks
List the top 5 longest tracks by duration. Show the track name, album title, and duration in milliseconds.
Order the results from longest to shortest.
Number of Tracks in Each Genre
Count how many tracks exist in each genre. Display the genre name and the count.
Genres with Lots of Tracks
Show all genres that have more than 30 tracks.
Playlists and Tracks
List all playlists and the names of tracks in each playlist. Include the playlist name and track name.
Artists with Most Albums
Show the top 10 artists with the most albums. Display the artist ID, artist name, and the number of albums (named as album_count).
Part B: Jupyter Notebook
Part B: Even More Setup Instructions
Create a file called Chinook.ipynb.
When prompted to add Install/Enable Suggested Extensions: Python/Jupyter, please do so.
When asked to select a Python kernel, choose Python Environments: base (Python 3.11.7) /opt/conda/bin/python
Part B - Instructions
In the Chinook.ipynb Jupyter Notebook:
Link in our usual libraries. Make sure to get necessary ones for talking to a an RDBMS.
Install the necessary packages for talking to a an RDBMS*
Load the data from your last query from Part A into a Pandas DataFrame
Output basic information and stats about the DataFrame
Try to produce a Matplotlib chart that looks like the example in the image below (i.e. the 10 artists with the most albums)
Make sure to have good Markdown around each code cell for each section
Part B: Sample Output
Sample Output

Marking Scheme
Final Grade	Requirement
10/10	Tech check is correct (all tasks working) and is completed within the allotted in-class time. You must be present in class to qualify for this.
8/10	Tech check is correct (all tasks working) and is completed within a 12-hour grace period beginning immediately following the end of in-class time. You must be present in class & commit your progress at the end of class to qualify for this.
6/10	Tech check is correct (all tasks working) and is completed and submitted completely outside of class and/or after the 12-hour grace period has elapsed.
0/10	Tech check is not submitted or does not fully work.
Written with StackEdit.

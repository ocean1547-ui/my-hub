DBAS 5115 - Tech Check 3 - MongoDB and Jupyter Notebooks
Setup Instructions:
Open this repository in the default GitHub Codespace as shown in class.
When satisfied that you have completed all the required changes to the repository folder, commit & push the entire folder's contents up to GitHub as shown in class.
You must ensure that your solution has been pushed to GitHub in order to get credit for the Tech Check.
Please show your solution to the instructor within class time to get full 10/10 credit for the Tech Check (see Marking Scheme below) or commit what you have done by the end of class to finish within 12-hours for 8/10
More Setup Instructions
Run the following commands at the Terminal so we can use ipyleaflet:
sudo apt-get update
sudo apt-get install nodejs
sudo apt-get install npm
Part A: Shipwreck Map
Part A - Instructions
We want to use the sample_geospatial sample MongoDB database which should already be loaded into our clusters on MongoDb Atlas. We will be talking to its sole collection, which is shipwrecks.

We want to get visible shipwrecks around Hawaii, specifically the Maui and Oahu islands. You will want to filter the results based on a feature_type of "Wrecks - Visible" and look only for shipwrecks in the following ranges of corordinates: longitude (between -154.8 and -160.3) and latitude (between 22.3 and 18.8). In my case, this resulted in 14 shipwrecks. At least a couple of these should probably be in Pearl Harbor.

When you create your map you can center it on the following coordinates: 21.1, -157.1. Play with the zoom factor to get results similar to my example below.

Part A: Sample Output
Sample Part A Output

Part A: Reminder Notes
If you receive a message like the following in VS Code when running the map in Jupyter Notebooks, click OK:

"Widgets require us to download supporting files from a 3rd party website."

We may need the extra line after installing ipyleaflet for the map to display in VSCode if we are running our Notebook there:

  !pip install ipyleaflet
  !pip install --upgrade ipywidgets ipykernel jupyter_client jupyter_core
If displaying the map gets “Access Blocked” error that says a referrer is required by the tile usage policy, try changes below:

  from ipyleaflet import Map, Marker, **basemaps**

  m = Map(center=statenIslandCenter, zoom=12, **basemap=basemaps.Esri.WorldStreetMap**)
Part B: Inspection Types Chart
Part B - Instructions
We want to use the sample_training sample MongoDB database which should already be loaded into our clusters on MongoDb Atlas. We will be talking to one of its collections, which is inspections.

We want to get a count of inspections with the 5 most common result statuses. So, you will want to group the collection on the result field, sort the results in descending order, and then just get the first 5.

You should then chart a pie chart using matplotlib and try to get results similar to my example below.

Part B: Sample Output
Sample Part B Output

Marking Scheme
Final Grade	Requirement
10/10	Tech check is correct (all tasks working) and is completed within the allotted in-class time. You must be present in class to qualify for this.
8/10	Tech check is correct (all tasks working) and is completed within a 12-hour grace period beginning immediately following the end of in-class time. You must be present in class & commit your progress at the end of class to qualify for this.
6/10	Tech check is correct (all tasks working) and is completed and submitted completely outside of class and/or after the 12-hour grace period has elapsed.
0/10	Tech check is not submitted or does not fully work.
Written with StackEdit.
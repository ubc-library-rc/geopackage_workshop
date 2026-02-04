---
layout: default
title: Windows installation 
parent: Setting up DB Browser
nav_order: -4 
---

# Windows installation instructions

*1*{: .circle .circle-blue}
Download and install [DB Browser for SQLite](https://sqlitebrowser.org/dl/)

*2*{: .circle .circle-blue}
Download and uncompress [**libspatialite**](https://www.gaia-gis.it/gaia-sins). Use the "current stable version", either 64 or 32 bit. You will only need `mod_spatialite`. You may need to install [7-zip](https://www.7-zip.org/) or a utility which supports .7z archives to uncompress the files. Place the contents somewhere permanent where you can find them.

*2a*{: .circle .circle-blue}
Optional raster support.  Install [**librasterlite2**](https://www.gaia-gis.it/fossil/librasterlite2/index). You will need to compile this yourself, which goes well beyond the scope of this workshop. However, you don't actually *need* rasterlite2 for the workshop. You only need it if at some indefinite time in the future you want to work with imagery.

*3*{: .circle .circle-blue}
Add extensions. In DB Browser for SQLite, go to Preferences/Extensions. Under _Select extensions to load for every database_, select the puzzle piece with the plus symbol (the top icon), navigate to `mod_spatialite.dll`, select it then Save.

![DB Browser Preferences](../assets/images/windows_db_browser_prefs.png)

For rasterlite support, do the same thing with the rasterlite file (which you laboriously compiled), which will (probably) be called something like `mod_rasterlite2.dll`.

*3a*{: .circle .circle-blue}

Install **proj**. In the same directory that contains `mod_spatialite.dll` you should (ideally) see a file called `proj.db`. If, *and only if*, you do not see `proj.db`, you will need to install `proj` manually.  Installation instructions are available here: <https://proj.org/en/stable/install.html>{:target="_blank"}


*3b*{: .circle .circle-blue}
Optional: To set DB Browser to open GeoPackage files by default:

* Go to Preferences/General/**DB File Extensions** near the bottom of the window and select **Manage**.  
![DB Browser General Preferences](../assets/images/windows_db_browser_general_prefs.png)
* On the next screen, select **Add**.
![DB Browser set extension](../assets/images/windows_db_browser_set_ext.png)
* Double-click on **description** and type **GeoPackage**.
* Double-click on **\*.extension** and type __\*.gpkg__.
* When it looks like the above, hit OK.
* Save your changes.

*4*{: .circle .circle-blue}
Set Windows environment variables

Environment variables are buried deep in the Windows operating system. There are many ways to navigate to the environment variables window but the fastest is:

* In the search box, start typing **Environment**, then select **Edit the system environment variables**

![Find environment variables](../assets/images/windows_search_env.png)

* In the System Properties window, at the bottom right corner, click the **Environment Variables . . .** button.

![System Properties select environment variables](../assets/images/windows_system_prop.png)

* The Environment Variables window will pop up. You will now add variables to make yours look similar to the screenshot.

There are (at least) three environment variables you will need to add/edit. **PATH, PROJ_DATA** and **PROJ_LIB**. You will need two values, which may be the same. The path (ie, the directory contains) `mod_spatialite.dll` and `proj.db`.



![Environment variables](../assets/images/windows_environment_var.png)

*4.1*{: .circle .circle-red}
Edit **PATH** 

Your **PATH** display will almost certainly not be the same, but what's important is adding to your **PATH**.

* First, edit the **PATH** variable. Select the **PATH** user variable and select **Edit**. On the subsequent screen, select **New**. Add the directory which contains `mod_spatialite.dll`

![Edit path](../assets/images/windows_edit_path.png)

Once you're done, select **OK** to close the window


*4.2*{: .circle .circle-red}
Add other environment variables

Now, you will need to add new variables, called **PROJ_DATA** and **PROJ_LIB**

* In the top section of the Environment Variables window, **User variables for [account]**, Select **New**.
* In the **New User Variable** window:
    * In **Variable name**, type **PROJ_DATA**.
    * In **Variable value**, add the path to the directory which contains `proj.db`.
    * Hit OK.
* Repeat this procedure for a variable called **PROJ_LIB**

![Add environment varriable window](../assets/images/windows_add_env_var.png)

* Once you've done adding and editing variables hit OK until all the windows disappear.

There are [other ways](https://www.digitalcitizen.life/remove-edit-clear-environment-variables/) to set and unset environment variables.

*4.3*{: .circle .circle-red}
Optional: relax the security when you run DB Browser.

{: .important}
>If you want to export some kinds of data, such as GeoJSON files, you must set the `SPATIALITE_SECURITY` environment variable to `relaxed`. This will allow DB Browser to write to your system from within an SQL session. The functions that require this setting are noted in the Spatialite documentation 
>
>Note that both ArcGIS and QGIS support Well-Known Text (WKT) imports, so if your intention is to export to a GIS system you don't *have* to do this. But for pure GeoJSON exports and Shapefile Exports, you do.

* In the top section of the Environment Variables window, **User variables for [account]**, Select **New**.
* In the **New User Variable** window:
    * In **Variable name**, type **SPATIALITE_SECURITY**.
    * In **Variable value**, type **relaxed**.

{: .important}
To **unset** the variable, go through this procedure again, except this time **Edit** the variable and replace **relaxed** with something else, typically nothing. Or, to get rid of it entirely, delete the environment variable.

*5*{: .circle .circle-blue}
Restart DB Browser for SQLite

If DB Browser is open, close it and reopen it. You need to do this because if you set the environment variables after opening it, they haven't been read.

---

Now you can start working with [GeoPackages](premade_geopackages.html).

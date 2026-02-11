---
layout: default
nav_order: 1.2
title: Data sources 
parent: Introduction
---

## Data sources

All of the data and SQL in this workshop are available to you, as is this workshop itself. Everything, including this page, is hosted on the Github repository, which is at:

<https://github.com/ubc-library-rc/geopackage_workshop>{:target="_blank"}

All of the data (including links to the original sources) can be found at: 

<https://github.com/ubc-library-rc/geopackage_workshop/tree/main/src/data>{:target="_blank"}

SQL files are here:
 
<https://github.com/ubc-library-rc/geopackage_workshop/tree/main/src/sql>{:target="_blank"} 

You can easily copy SQL from the tutorial itself by clicking on the clipboard icon on the top right of a SQL block which sends the text to your computer's clipboard. All but the most rudimentary of the SQL is in the `src/sql` directory in the Github repository, and the file name is at the very top of a SQL block. For example:

```sql
--import_csv_data_and_make_geometry.sql
/*You should have already performed these steps

SELECT enableGpkgMode();
[TRUNCATED]
```

The full version of this SQL file would be at `src/sql/import_csv_data_and_make_geometry.sql`.

### Cloning the repository

If you are familiar with Git, you can create a local copy of everything with the terminal command `git clone <https://github.com/ubc-library-rc/geopackage_workshop`. And if you have [Jekyll](https://jekyllrb.com/){:target="_blank"}, you can even run a local version of this workshop with `jekyll serve`.

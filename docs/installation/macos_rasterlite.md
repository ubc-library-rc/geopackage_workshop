---
layout: default
title: Compiling Rasterlite2 for MacOS 
parent: MacOS installation 
nav_order: 2 
---

## Compiling **Rasterlite2** for MacOS

If you need raster imagery support for GeoPackages, you can add the **Rasterlite2** extension, in the same way you added the Spatialite extension. However, as of the end of February 2026, you may find that the [Homebrew](https://brew.sh) version of **Rasterlite2** now generates an error. The solution to this problem, is, unfortunately, to compile **Rasterlite2** yourself.

These instructions, while for MacOS, are also broadly applicable to all platforms, although you probably won't have to edit the C++ source code in that instance.

### Prequisites

You will need to install all the prerequisites for compilation, including, but not necessarily limited to, the [dependencies for librasterlite2](https://formulae.brew.sh/formula/librasterlite2). They are listed below for convenience, but the information in the link should be considered canonical if there is a difference.

*1*{: .circle .circle-blue} **Download prerequisites**

Install the items below using `brew install`.

|Paakage name| description|
|cairo  | Vector graphics library with cross-device output support|
|fontconfig  | XML-based font configuration API for X Windows|
|freetype  | Software library to render fonts|
|freexl  | Library to extract data from Excel .xls files|
|geos  | Geometry Engine|
|giflib  | Library and utilities for processing GIFs|
|jpeg-turbo  | JPEG image codec that aids compression and decompression|
|libgeotiff  | Library and tools for dealing with GeoTIFF|
|libpng  | Library for manipulating PNG images|
|librttopo  | RT Topology Library|
|libspatialite  | Adds spatial SQL capabilities to SQLite|
|libtiff  | TIFF library and utilities|
|libxml2  | GNOME XML library|
|lz4  | Extremely Fast Compression algorithm|
|minizip  | C library for zip/unzip via zLib|
|openjpeg  | Library for JPEG-2000 image manipulation|
|pixman  | Low-level library for pixel manipulation|
|proj  | Cartographic Projections Library|
|sqlite  | Command-line interface for SQLite|
|webp  | Image format providing lossless and lossy compression for web images|
|xz  | General-purpose data compression with high compression ratio|
|zstd  | Zstandard is a real-time compression algorithm|
|pkgconf  | Package compiler and linker metadata toolkit|

{: .note}
There may be even more prerequisites; if you have compilation errors you will see what they are. The yak must be shaved.

*2*{: .circle .circle-blue} **Download the code**

You can obtain the librasterlite2 source code from <https://www.gaia-gis.it/fossil/librasterlite2/>. Download and uncompress it somewhere convenient.

*3*{: .circle .circle-blue} **Edit the source code**

Locate the file called `rasterlite2_private.h`, which should be found in the `headers` directory. Open it in a text editor. Scroll past the licence text and look for a line reading `#include "config.h"`. If you're using [vim](https://vim.org), this should get you very near the correct place.

```
vim headers/rasterlite2_private.h +49
```

Add this line somewhere before the `ifdef` statement:

```
#include <time.h>
```

Save and close the file.

*4*{: .circle .circle-blue} **Set up the build environment**

Open a terminal and move to the folder where you unzipped the source code (ie, the top level where the `config` file and `README` live.

To ensure correct compilation, copy the following into your shell:

```
export CC="/usr/bin/clang -m64"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
```
{: .note}
You may not need to use the `clang` compiler.

*5*{: .circle .circle-blue} **Compile**

The step we've all been waiting for.

Firstly:
```./configure```

This may take a while. Ideally it will succeed for you on the first run, but if it does not, you may need to install extra libraries to ensure successful compilation. This is left as an exercise for the reader. Assuming this step is successful, secondly:

```make```

If this step finishes, you have succcessfully compiled librasterlite2. You may note that you see nothing different. At this stage you can:

* ```make install```. This will copy your compiled versions to (probably) `/usr/local/` There's nothing inherently wrong with doing this, and you can do so if you wish. You will need to poke around `/usr/local` (or perhaps `opt`) to find out where `mod_rasterlite2.1.so` lives.

* The compiled files are in `src/.libs`, which is a *hidden* directory. You can copy the `.dylib` and `.so` files to whatever directory is convenient for you.

*6*{: .circle .circle-blue} **Enable the extension**

In the same way you enabled Spatialite, in the extensions manager in **DB Browser for SQLite**, select and enable the `mod_rasterlite2.1.so` (or whichever version is now current, 2.1 as of this writing).

*7*{: .circle .circle-blue} **Ensure it works**

Load up a database, and in the SQL editor try this query:

```SELECT RL2_Version();```

You should see output showing you which version of **Rasterlite2** has been (successfully) installed.

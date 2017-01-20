# nam218
A simple [R language](https://www.r-project.org/) interface to [NOMADS NAM](https://www.ncdc.noaa.gov/data-access/model-data/model-datasets/north-american-mesoscale-forecast-system-nam) forecasts and archives.


#### Requirements

+ [R](https://www.r-project.org/) version 3.0 or higher

+ [raster](https://cran.r-project.org/web/packages/raster/index.html) R package

+ [ncdf4](https://cran.r-project.org/web/packages/ncdf4/index.html) R package

+ [threddscrawler](https://github.com/BigelowLab/threddscrawler) R package

#### Installation

It's fairly easy to install using Hadley Wickham's [devtools](http://cran.r-project.org/web/packages/devtools/index.html).

```r
library(devtools)
install_github('BigelowLab/nam218')
```

#### Examples

Finding data with a query...

```R
library(nam218)
dataset <- nam_query(what = 'analysis', day = '20080704', time = '1200')
dataset
# Reference Class: "DatasetsRefClass"
#   verbose_mode: FALSE
#   url: https://nomads.ncdc.noaa.gov/thredds/catalog/namanl/200807/20080704/namanl_218_20080704_1200_000.grb
#   children: dataSize date
#   datasets: NA
```

Once you have identified the resource then you can instantiate a NAM reference class to get data.

```R
# extract an OPeNDAP url
uri <- nam_url(dataset, what = 'OPeNDAP')
uri
# [1] "https://nomads.ncdc.noaa.gov/thredds/dodsC/namanl/200807/20080704/namanl_218_20080704_1200_000.grb"

# create the NetCDF handler 
X <- NAM218(uri)

# retrieve a layer and show it
RH <- X$get_layer("Relative_humidity")

library(raster)
raster::spplot(RH)
```

As a convenience a spatial subset can be requested with a bounding box specified as [left, right, bottom, top].  Note that the retrieved is projected to `+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0`.

```R
BBOX <- c(-72,-63,39,46)
RH <- X$get_layer("Relative_humidity", bb = BBOX)
RH
# class       : RasterLayer 
# dimensions  : 115, 110, 12650  (nrow, ncol, ncell)
# resolution  : 0.14, 0.104  (x, y)
# extent      : -74.72739, -59.32739, 36.42884, 48.38884  (xmin, xmax, ymin, ymax)
# coord. ref. : +proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0 
# data source : in memory
# names       : layer 
# values      : 56.33741, 100.045  (min, max)
```
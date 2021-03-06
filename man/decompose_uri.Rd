% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/query.R
\name{decompose_uri}
\alias{decompose_uri}
\title{Decompose a NAM218 filename into constituent parts.
The directory name is not retained.}
\usage{
decompose_uri(
  x = c("201702/20170225/namanl_218_20040331_1800_000.grb",
    "201702/20170225/namanl_218_20040331_1800_006.grb")
)
}
\arguments{
\item{x}{character vector}
}
\value{
a tibble with the following
\itemize{
 \item{D POSIXct date}
 \item{Y character year as YYYY}
 \item{m character month as mm}
 \item{d character day as dd}
 \item{p character forecast period in hours as HHHH, aka 'ftime'}
 \item{a character forecast time ahead in hours as hhh, aka 'ahead'}
 \item{n character name of parameter}
 \item{f character the basename of the input file}
}
}
\description{
Decompose a NAM218 filename into constituent parts.
The directory name is not retained.
}

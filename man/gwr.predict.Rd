\name{gwr.predict}
\alias{gwr.predict}
\alias{gw.reg1}
\title{GWR used as a spatial predictor}
\description{
This function implements basic GWR as a spatial predictor. The GWR prediction function is able to do leave-out-one predictions (when the observation locations are used for prediction) and
predictions at a set-aside data set(when the new locations are used for prediction). It is also able to reproduce the global OLS regression prediction results.
}
\usage{
gwr.predict(formula, data, predictdata, bw, kernel="bisquare",adaptive=FALSE, p=2,
           theta=0, longlat=F,dMat1, dMat2)}

\arguments{
  \item{formula}{Regression model formula of a \link{formula} object }
  \item{data}{a Spatial*DataFrame, i.e. SpatialPointsDataFrame or SpatialPolygonsDataFrame as defined in package \pkg{sp}}
  \item{predictdata}{a Spatial*DataFrame object to provide prediction locations, i.e. SpatialPointsDataFrame or SpatialPolygonsDataFrame as defined in package \pkg{sp}}
  \item{bw}{bandwidth used in the weighting function, possibly calculated by \link{bw.gwr};fixed (distance) or adaptive bandwidth(number of nearest neighbours)}
  \item{kernel}{function chosen as follows:
  
                gaussian: wgt = exp(-.5*(vdist/bw)^2);
                
                exponential: wgt = exp(-vdist/bw);
                
                bisquare: wgt = (1-(vdist/bw)^2)^2 if vdist < bw, wgt=0 otherwise;
                
                tricube: wgt = (1-(vdist/bw)^3)^3 if vdist < bw, wgt=0 otherwise; 
                
                boxcar: wgt=1 if dist < bw, wgt=0 otherwise}
  \item{adaptive}{if TRUE calculate an adaptive kernel where the bandwidth (bw) corresponds to the number of nearest neighbours (i.e. adaptive distance); default is FALSE, where a fixed kernel is found (bandwidth is a fixed distance)}
  \item{p}{the power of the Minkowski distance, default is 2, i.e. the Euclidean distance}
  \item{theta}{an angle in radians to rotate the coordinate system, default is 0}
  \item{longlat}{if TRUE, great circle distances will be calculated}
  \item{dMat1}{a pre-specified distance matrix between data points and prediction locations; if not given, it will be calculated by the given parameters}
  \item{dMat2}{a pre-specified sysmetric distance matrix between data points; if not given, it will be calculated by the given parameters}
}
\value{
A list of class \dQuote{gwrm.pred}:
  \item{GW.arguments}{a list of geographically weighted arguments}
  \item{SDF}{a SpatialPointsDataFrame (may be gridded) or SpatialPolygonsDataFrame object (see package "sp") with GWR coefficients, predictions and prediction variances in its "data" slot.}
  \item{this.call}{the function call used.}
}
\references{
Harris P, Fotheringham AS, Crespo R, Charlton M (2010) The use of geographically weighted regression for spatial 
prediction: an evaluation of models using simulated data sets. Mathematical Geosciences 42:657-680

Harris P, Juggins S (2011) Estimating freshwater critical load exceedance data for Great Britain 
using space-varying relationship models. Mathematical Geosciences 43: 265-292

Harris P, Brunsdon C, Fotheringham AS (2011) Links, comparisons and extensions of the geographically 
weighted regression model when used as a spatial predictor.  Stochastic Environmental Research and Risk Assessment 25:123-138

}
\author{Binbin Lu \email{binbinlu@whu.edu.cn}}
\examples{
\dontrun{
data(LondonHP)
gwr.pred<-gwr.predict(PURCHASE~FLOORSZ, data=londonhp, bw=2000,kernel = "gaussian")
gwr.pred
#########Global regression  Compare with gstat
if(require("gstat"))
{
  mlr.g <- gstat(id = "xx1", formula = PURCHASE~FLOORSZ,data=londonhp)
  mlr.g1 <- predict(mlr.g, newdata = londonhp, BLUE = TRUE)
  mlr.g1
}
############
ols.pred<-gwr.predict(PURCHASE~FLOORSZ, data=londonhp, bw=100000000000000000000000)
ols.pred$SDF
}
}
\keyword{GWR, prediction}


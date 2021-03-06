\name{ModelSelection.Phase}
\alias{ModelSelection.Phase}

\title{Construct sets of well-fitting models as proposed by Cox, D. R. & Battey, H. S. (2017)}
\description{
This function tests low dimensional subsests of the set of retained variables from the reduction phase and any squared or interaction terms suggested at the exploratory phase. Lists of well-fitting models of each dimension are returned.
}
\usage{
ModelSelection.Phase(X,Y, list.reduction, family=gaussian,
                      signif=0.01, sq.terms=NULL, in.terms=NULL,
                      modelSize=NULL, Cox.Hazard = FALSE)
}

\arguments{
  \item{X}{Design matrix.}
  \item{Y}{Response vector.}
  \item{list.reduction}{Indices of variables that where chosen at the reduction phase.}
  \item{family}{A description of the error distribution and link function to be used in the model. For glm this can be a character string naming a family function, a family function or the result of a call to a family function. See \code{\link{family}} for more details.}
  \item{signif}{Significance level of the likelihood ratio test against the comprehensive model. The default is 0.01.}
  \item{sq.terms}{Indices of squared terms suggested at the exploratory phase (See \code{\link{Exploratory.Phase}}).}
  \item{in.terms}{Indices of pairs of variables suggested at the exploratory phase (See \code{\link{Exploratory.Phase}}).}
  \item{modelSize}{Maximum size of the models to be tested. Curently the maximum is 7. If not provided a default is used.}
  \item{Cox.Hazard}{If TRUE fits proportional hazards regression model. The family argument will be ignored if Cox.Hazard=TRUE.}
}

\value{
\item{goodModels}{List of models that are in the confidence set of size 1 to modelSize. An interaction term between, say, variables x_1 and x_2 is displayed as “x_1 * x_2”; a squared term in, say, variable x_1 is displayed as “x_1 ^2”. If an interaction term is present without the corresponding main effects, the main effects should be added.}
}

\references{
Cox, D. R. and Battey, H. S. (2017). Large numbers of explanatory variables, a semi-descriptive analysis. \emph{Proceedings of the National Academy of Sciences}, 114(32), 8592-8595.

Battey, H. S. and Cox, D. R. (2018). Large numbers of explanatory variables: a probabilistic assessment. \emph{Proceedings of the Royal Society of London, A.}, 474(2215), 20170631.

Hoeltgebaum, H., & Battey, H. S. (2019). HCmodelSets: An R Package for Specifying Sets of Well-fitting Models in High Dimensions. \emph{The R Journal}, 11(2), 370-379.
}
\author{
Hoeltgebaum, H. H.
}

\section{Acknowledgement}{The work was supported by the UK Engineering and Physical Sciences Research Council under grant number EP/P002757/1.}

\seealso{
\code{\link{Reduction.Phase}}, \code{\link{Exploratory.Phase}}
}
\examples{
\donttest{
## Generates a random DGP
dgp = DGP(s=5, a=3, sigStrength=1, rho=0.9, n=100, intercept=5, noise=1,
          var=1, d=1000, DGP.seed = 2018)

#Reduction Phase using only the first 70 observations
outcome.Reduction.Phase =  Reduction.Phase(X=dgp$X[1:70,],Y=dgp$Y[1:70],
                                           family=gaussian, seed.HC = 1012)

# Exploratory Phase using only the first 70 observations, choosing the variables which
# were selected at least two times in the third dimension reduction

idxs = outcome.Reduction.Phase$List.Selection$`Hypercube with dim 2`$numSelected1
outcome.Exploratory.Phase =  Exploratory.Phase(X=dgp$X[1:70,],Y=dgp$Y[1:70],
                                               list.reduction = idxs,
                                               family=gaussian, signif=0.01)

# Model Selection Phase using only the remainer observations
sq.terms = outcome.Exploratory.Phase$mat.select.SQ
in.terms = outcome.Exploratory.Phase$mat.select.INTER

MS = ModelSelection.Phase(X=dgp$X[71:100,],Y=dgp$Y[71:100], list.reduction = idxs,
                          sq.terms = sq.terms,in.terms = in.terms, signif=0.01)
}

\dontshow{
dgp = DGP(s=5, a=3, sigStrength=1, rho=0.9, n=20, intercept=5, noise=1,
          var=1, d=50, DGP.seed = 2019)

#Reduction Phase using only the first 70 observations
outcome.Reduction.Phase =  Reduction.Phase(X=dgp$X[1:10,],Y=dgp$Y[1:10],
                                           dmHC = 2, family=gaussian, seed.HC = 1093)

# Exploratory Phase using only the first 70 observations, choosing the variables which
# were selected at least two times in the third dimension reduction

idxs = outcome.Reduction.Phase$List.Selection$`Hypercube with dim 2`$numSelected2
outcome.Exploratory.Phase =  Exploratory.Phase(X=dgp$X[1:10,],Y=dgp$Y[1:10],
                                               list.reduction = idxs,
                                               family=gaussian, signif=0.01)

# Model Selection Phase using only the remainer observations
sq.terms = outcome.Exploratory.Phase$mat.select.SQ
in.terms = outcome.Exploratory.Phase$mat.select.INTER

MS = ModelSelection.Phase(X=dgp$X[11:20,],Y=dgp$Y[11:20], list.reduction = idxs,
                          sq.terms = sq.terms,in.terms = in.terms, signif=0.01)
}
}

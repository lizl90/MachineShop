% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metrics.R
\name{metrics}
\alias{metrics}
\alias{accuracy}
\alias{brier}
\alias{cindex}
\alias{cross_entropy}
\alias{f_score}
\alias{kappa2}
\alias{mae}
\alias{mse}
\alias{npv}
\alias{ppv}
\alias{pr_auc}
\alias{precision}
\alias{r2}
\alias{recall}
\alias{rmse}
\alias{roc_auc}
\alias{roc_index}
\alias{sensitivity}
\alias{specificity}
\alias{weighted_kappa2}
\title{Performance Metrics}
\usage{
accuracy(observed, predicted, cutoff = 0.5, ...)

brier(observed, predicted, times = numeric(), ...)

cindex(observed, predicted, ...)

cross_entropy(observed, predicted, ...)

f_score(observed, predicted, cutoff = 0.5, beta = 1, ...)

kappa2(observed, predicted, cutoff = 0.5, ...)

mae(observed, predicted, ...)

mse(observed, predicted, ...)

npv(observed, predicted, cutoff = 0.5, ...)

ppv(observed, predicted, cutoff = 0.5, ...)

pr_auc(observed, predicted, ...)

precision(observed, predicted, cutoff = 0.5, ...)

r2(observed, predicted, ...)

recall(observed, predicted, cutoff = 0.5, ...)

rmse(observed, predicted, ...)

roc_auc(observed, predicted, times = numeric(), ...)

roc_index(observed, predicted, cutoff = 0.5, f = function(sens, spec)
  sens + spec, ...)

sensitivity(observed, predicted, cutoff = 0.5, ...)

specificity(observed, predicted, cutoff = 0.5, ...)

weighted_kappa2(observed, predicted, power = 1, ...)
}
\arguments{
\item{observed}{observed responses.}

\item{predicted}{predicted responses.}

\item{cutoff}{threshold above which probabilities are classified as success
for binary responses.}

\item{...}{arguments passed to or from other methods.}

\item{times}{numeric vector of follow-up times at which survival events
were predicted.}

\item{beta}{relative importance of recall to precision in the calculation of
\code{f_score} [default: F1 score].}

\item{f}{function to calculate a desired sensitivity-specificity tradeoff.}

\item{power}{power to which positional distances of off-diagonals from the
main diagonal in confusion matrices are raised to calculate
\code{weighted_kappa2}.}
}
\description{
Compute measures of agreement between observed and predicted responses.
}
\seealso{
\code{\link{metricinfo}}, \code{\link{modelmetrics}}
}

#' Generalized Boosted Regression Model
#' 
#' Fits generalized boosted regression models.
#'
#' @param distribution either a character string specifying the name of the
#' distribution to use or a list with a component \code{name} specifying the
#' distribution and any additional parameters needed.  Set automatically
#' according to the class type of the response variable.
#' @param n.trees total number of trees to fit.
#' @param interaction.depth maximum depth of variable interactions.
#' @param n.minobsinnode minimum number of observations in the trees terminal
#' nodes.
#' @param shrinkage shrinkage parameter applied to each tree in the expansion.
#' @param bag.fraction fraction of the training set observations randomly
#' selected to propose the next tree in the expansion.
#' 
#' @details
#' \describe{
#' \item{Response Types:}{\code{factor}, \code{numeric}, \code{Surv}}
#' }
#' 
#' Default values for the \code{NULL} arguments and further model details can be
#' found in the source link below.
#' 
#' @return \code{MLModel} class object.
#' 
#' @seealso \code{\link[gbm]{gbm}}, \code{\link{fit}}, \code{\link{resample}},
#' \code{\link{tune}}
#' 
#' @examples
#' fit(Species ~ ., data = iris, model = GBMModel())
#'
GBMModel <- function(distribution = NULL, n.trees = 100,
                     interaction.depth = 1, n.minobsinnode = 10,
                     shrinkage = 0.1, bag.fraction = 0.5) {
  
  MLModel(
    name = "GBMModel",
    packages = "gbm",
    types = c("factor", "numeric", "Surv"),
    params = params(environment()),
    nvars = function(data) nvars(data, design = "terms"),
    fit = function(formula, data, weights, distribution = NULL, ...) {
      environment(formula) <- environment()
      if (is.null(distribution)) {
        distribution <- switch_class(response(formula, data),
                                     "factor" = "multinomial",
                                     "numeric" = "gaussian",
                                     "Surv" = "coxph")
      }
      gbm::gbm(formula, data = data, weights = weights,
               distribution = distribution, ...)
    },
    predict = function(object, newdata, fitbits, times, ...) {
      if (object$distribution$name == "coxph") {
        new_neg_risk <- -exp(predict(object, newdata = newdata,
                                     n.trees = object$n.trees, type = "link"))
        if (length(times)) {
          y <- response(fitbits)
          risk <- exp(predict(object, n.trees = object$n.trees, type = "link"))
          cumhaz <- basehaz(y, risk, times)
          exp(new_neg_risk %o% cumhaz)
        } else {
          new_neg_risk
        }
      } else {
        predict(object, newdata = newdata, n.trees = object$n.trees,
                type = "response")
      }
    },
    varimp = function(object, ...) {
      gbm::relative.influence(object, n.trees = object$n.trees)
    }
  )
  
}

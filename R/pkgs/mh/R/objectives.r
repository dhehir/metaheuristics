###### Manipulate objective calculators

#' Calculate the score of a given system configuration 
#'
#' Calculate the score of a given system configuration 
#'
#' @param objectiveEvaluator an objective calculator (implements at least IObjectiveEvaluator)
#' @param pSet the system configuration that the calculator accept to calculate a goodness of fit. (implements at least ISystemConfiguration)
#' @return a list of length two: a named numeric vector, with one or more objective values, and a representation of the parameters (possibly as a data frame)
#' @export
getScore <- function(objectiveEvaluator, pSet) {
  a <- clrCall(objectiveEvaluator, 'EvaluateScore', pSet)
  n <- clrGet(a, "ObjectiveCount")
  objectives <- lapply( as.integer(1:n-1), function(i) {clrCall(a, "GetObjective" , i)})
  valObj <- sapply(objectives, function(x) { clrGet(x, "Value") })
  namesObj <- sapply(objectives, function(x) { clrGet(x, "Name") })
  names(valObj) <- namesObj
  list(scores=valObj, sysconfig=pSetAsDataFrame(clrGet(a,"SystemConfiguration")))
}






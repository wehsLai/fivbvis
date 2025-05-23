% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/statistics.R
\name{v_get_volley_statistic_list}
\alias{v_get_volley_statistic_list}
\title{Get a list of volleyball statistic}
\usage{
v_get_volley_statistic_list(
  parent = list(Fields = paste0(v_fields("Volleyball Statistic"), collapse = " ")),
  children
)
}
\arguments{
\item{parent}{list: List of named charactor vectors. Specify attributes of Request Node.}

\item{children}{list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.}
}
\value{
A data.frame
}
\description{
Get a list of volleyball statistic
}
\details{
Because there are a great number of statistical data, you cannot request all of them, so you must use the statistics filter and the filter must not be empty.
You can use the MatchesToUse property of the filter to specify whether only the finished matches are included in the result or if also the matches in progress must be included.

By default, the web service returns only the statistics for the players, if you're interested by the teams' statistics or the total by teams, you can use the Include parameter to specify what the web service must return. The value must be a combination of the following values: Players, PlayersSumByTeam or Teams.
By default, the web service returns the statictics by match. If you're interested by the details by set or the total by tournament, you can use the SumBy parameter to specify what the web service must return. The value must be a combination of the following values: Set, Match or Tournament.
}
\examples{
\dontrun{
  pl <- list(Fields = paste(v_fields("Volleyball Statistic"), collapse = " "))
  cl <- list(
    Filter = c(NoTournaments = s_tournament$no, MatchesToUse = "MatchesFinished"),
    Relation = c(Name = "Match", Fields = "NoInTournament DateLocal TeamACode TeamBCode MatchResult"),
    Relation = c(Name = "Team", Fields = "Code Name"),
    Relation = c(Name = "Player", Fields = "TeamName FirstName LastName VolleyPosition")
  )
  vb_statistics <- v_get_volley_statistic_list(parent = pl, children = cl)
}

}
\references{
\url{https://www.fivb.org/VisSDK/VisWebService/VolleyStatistic.html}
\url{https://www.fivb.org/VisSDK/Fivb.Vis.DataWPF/Fivb.Vis.DataWPF~Fivb.Vis.Volley.GetVolleyStatisticListRequest.html}
}

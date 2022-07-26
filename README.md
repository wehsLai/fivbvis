
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fivbvis

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![openvolley](https://img.shields.io/badge/openvolley-darkblue.svg?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMTAiIGhlaWdodD0iMjEwIj48cGF0aCBkPSJNOTcuODMzIDE4Ny45OTdjLTQuNTUtLjM5Ni0xMi44MTItMS44ODYtMTMuNTgxLTIuNDQ5LS4yNDItLjE3Ny0xLjY5Mi0uNzUzLTMuMjIyLTEuMjgxLTI4LjY5Ni05Ljg5NS0zNS4xNy00NS45ODctMTMuODY4LTc3LjMyMyAyLjY3Mi0zLjkzIDIuNTc5LTQuMTktMS4zOTQtMy45MDYtMTIuNjQxLjktMjcuMiA2Ljk1Mi0zMy4wNjYgMTMuNzQ1LTUuOTg0IDYuOTI3LTcuMzI3IDE0LjUwNy00LjA1MiAyMi44NjIuNzE2IDEuODI2LS45MTgtLjE3LTEuODktMi4zMS03LjM1Mi0xNi4xNzQtOS4xODEtMzguNTYtNC4zMzctNTMuMDc0LjY5MS0yLjA3IDEuNDE1LTMuODY2IDEuNjEtMy45ODkuMTk0LS4xMjMuNzgyLTEuMDUzIDEuMzA3LTIuMDY2IDMuOTQ1LTcuNjE3IDkuNDU4LTEyLjg2MiAxNy44MzktMTYuOTcgMTIuMTcyLTUuOTY4IDI1LjU3NS01LjgyNCA0MS40My40NDUgNi4zMSAyLjQ5NSA4LjgwMiAzLjgwMSAxNi4wNDcgOC40MTMgNC4zNCAyLjc2MiA0LjIxMiAyLjg3NCAzLjU5NC0zLjE3My0yLjgyNi0yNy42ODEtMTYuOTA3LTQyLjE4NS0zNi4wNjgtMzcuMTUxLTQuMjU0IDEuMTE3IDUuMjQtMy4zMzggMTEuNjYtNS40NzMgMTMuMTgtNC4zOCAzOC45MzctNS43NzIgNDYuMDc0LTEuNDg4IDEuMjQ3LjU0NyAyLjIyOCAxLjA5NSAzLjI3NSAxLjYzIDQuMjkgMi4xMDcgMTEuNzMzIDcuNjk4IDE0LjI2NSAxMS40MjcuNDA3LjYgMS4yNyAxLjg2NiAxLjkxNyAyLjgxNCAxMS4zMDggMTYuNTY1IDguNjIzIDQxLjkxLTYuODM4IDY0LjU1Mi0zLjI0OSA0Ljc1OC0zLjI1OCA0Ljc0MiAyLjQ1IDQuMDE4IDMyLjQ4Mi00LjEyMiA0OC41MTUtMjEuOTM1IDM5LjU3OC00My45NzQtMS4xNC0yLjgwOSAxLjU2NiAxLjA2IDMuNTE4IDUuMDMyIDI5LjY5MyA2MC40MTctMjIuNTggMTA3Ljg1My03OS40OTggNzIuMTQzLTUuMDg0LTMuMTktNS4xMjMtMy4xNTItMy45MDIgMy44ODMgNC43MjEgMjcuMjIgMjUuNzgzIDQzLjU2MiA0NC4wODkgMzQuMjEgMS4zNjItLjY5NiAyLjIxLS43NSAyLjIxLS4xNDMtNi43NiAzLjg1Ny0xNi4wMTggNi41NTMtMjMuMTI2IDguMDkxLTcuNTU1IDEuNTQ3LTE4LjM2NiAyLjE3Mi0yNi4wMiAxLjUwNnoiIGZpbGw9IiNmZmYiLz48ZWxsaXBzZSBjeD0iMTA1Ljk3NSIgY3k9IjEwNC40NDEiIHJ4PSI5NC44NCIgcnk9IjkyLjU0MiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjEwLjc0Ii8+PC9zdmc+)
<!-- badges: end -->

fivbvis provides an R client to the [FIVB VIS web service
system](https://www.fivb.org/VisSDK/VisWebService/#Introduction.html).

## Installation

You can install the development version of fivbvis like so:

``` r
install.packages("remotes") ## if needed
remotes::install_github("wehsLai/fivbvis")
```

## Example

This is a basic example which shows you how to get data:

By default, results are cached in a per-session cache, so if we make the
same request again the local results are used, rather than
re-downloading.

### 1. Tournaments List with Filter

``` r
library(fivbvis) # load package

pl <- list(Fields = "No ShortNameOrName Season DefaultPlayersRanking")
cl <- list(Filter = c(Seasons = "2021"))
vb_tournaments <- v_get_volley_tournament_list(parent = pl, children = cl)
vb_tournaments
#> # A tibble: 46 × 4
#>       no shortNameOrName                                 season defaultPlayersR…
#>    <int> <chr>                                            <int>            <int>
#>  1  1182 Tokyo Olympic Games - Women's Tournament          2021               NA
#>  2  1183 Tokyo Olympic Games - Men's Tournament            2021               NA
#>  3  1216 FIVB VNL WOMEN                                    2021              187
#>  4  1217 FIVB VNL MEN                                      2021              188
#>  5  1225 M FISU 2021                                       2021               NA
#>  6  1226 W FISU 2021                                       2021               NA
#>  7  1227 Volleyball Games - Tokyo Challenge 2021 Women     2021               NA
#>  8  1228 Volleyball Games - Tokyo Challenge 2021 Men       2021               NA
#>  9  1230 FIVB Volleyball Challenger Cup - Men (Cancelle…   2021               NA
#> 10  1231 FIVB Volleyball Challenger Cup - Women (Cancel…   2021               NA
#> # … with 36 more rows
```

### 2. Matches List with Filter

``` r
s_tournament <- vb_tournaments[vb_tournaments$shortNameOrName == "FIVB VNL MEN", ]
pl <- list(Fields = "DateTimeLocal PoolName, TeamAName TeamBName MatchResultText")
cl <- list(Filter = c(NoTournament = s_tournament$no))
v_get_volley_match_list(parent = pl, children = cl)
#> # A tibble: 124 × 4
#>    dateTimeLocal       teamAName   teamBName matchResultText
#>    <dttm>              <chr>       <chr>     <chr>          
#>  1 2021-05-28 10:00:00 France      Bulgaria  3-0            
#>  2 2021-05-28 12:00:00 Germany     Australia 3-0            
#>  3 2021-05-28 13:00:00 Japan       Iran      3-0            
#>  4 2021-05-28 15:00:00 Serbia      Slovenia  3-1            
#>  5 2021-05-28 16:00:00 Netherlands Russia    1-3            
#>  6 2021-05-28 18:00:00 USA         Canada    3-0            
#>  7 2021-05-28 19:30:00 Poland      Italy     3-0            
#>  8 2021-05-28 21:00:00 Brazil      Argentina 3-0            
#>  9 2021-05-29 10:00:00 Germany     France    2-3            
#> 10 2021-05-29 12:00:00 Iran        Russia    1-3            
#> # … with 114 more rows
```

### 3. Pools List with Filter

``` r
pl <- list(Fields = "Name RoundName")
cl <- list(Filter = c(NoTournament = s_tournament$no, ForRanking = NULL))
v_get_volley_pool_list(parent=pl, children = cl)
#> # A tibble: 9 × 2
#>   name              roundName        
#>   <chr>             <chr>            
#> 1 Week 1            Preliminary Round
#> 2 Week 2            Preliminary Round
#> 3 Week 3            Preliminary Round
#> 4 Week 4            Preliminary Round
#> 5 Week 5            Preliminary Round
#> 6 Round robin - Men Preliminary Round
#> 7 Semifinals        Final Round      
#> 8 Final 3-4         Final Round      
#> 9 Final 1-2         Final Round
```

### 4. Teams List with Filter

``` r
pl <- list(Fields = "Code Name")
cl <- list(Filter = c(NoTournament = s_tournament$no))
v_get_volley_team_list(parent = pl, children = cl)
#> # A tibble: 16 × 2
#>    code  name       
#>    <chr> <chr>      
#>  1 ARG   Argentina  
#>  2 AUS   Australia  
#>  3 BRA   Brazil     
#>  4 BUL   Bulgaria   
#>  5 CAN   Canada     
#>  6 FRA   France     
#>  7 GER   Germany    
#>  8 IRI   Iran       
#>  9 ITA   Italy      
#> 10 JPN   Japan      
#> 11 NED   Netherlands
#> 12 POL   Poland     
#> 13 RUS   Russia     
#> 14 SLO   Slovenia   
#> 15 SRB   Serbia     
#> 16 USA   USA
```

### 5. Players List with Filter

``` r
pl <- list(Fields = "Team NoShirt FirstNamePlayer LastNamePlayer Position")
cl <- list(Filter = c(NoTournament = s_tournament$no))
v_get_volley_player_list(parent = pl, children = cl)
#> # A tibble: 271 × 4
#>    noShirt firstNamePlayer lastNamePlayer position
#>      <int> <chr>           <chr>          <chr>   
#>  1       8 Wallace         De Souza       OP      
#>  2       5 Tatsuya         Fukuzawa       OH      
#>  3       6 Mitja           Gasparini      OP      
#>  4       9 Dejan           Vincic         S       
#>  5      17 Tine            Urnaut         OH      
#>  6       2 Alen            Pajenk         MB      
#>  7      12 Grzegorz        Lomacz         S       
#>  8       6 Bartosz         Kurek          OP      
#>  9      13 Michal          Kubiak         OH      
#> 10       8 Marcus          Böhme          MB      
#> # … with 261 more rows
```

### 6. Statistics List with Filter, Relation

``` r
pl <- list(Fields = "BlockPoint BlockFault BlockContinue BlockTotal",
           SumBy = "Tournament")
cl <- list(Filter = c(NoTournaments = s_tournament$no, MatchesToUse="MatchesFinished"),
           Relation = c(Name="Match", Fields="NoInTournament DateLocal TeamACode TeamBCode MatchResult"),
           Relation = c(Name="Team", Fields="Code Name"),
           Relation = c(Name="Player", Fields="TeamName FirstName LastName VolleyPosition"))
v_get_volley_statistic_list(parent = pl, children = cl)
#> # A tibble: 279 × 11
#>    blockPoint blockFault blockContinue blockTotal match team.code team.name
#>         <int>      <int>         <int>      <int> <lgl> <chr>     <chr>    
#>  1         23         67            45        135 NA    <NA>      <NA>     
#>  2          8         27            22         57 NA    <NA>      <NA>     
#>  3          3         14            14         31 NA    <NA>      <NA>     
#>  4          9         14            13         36 NA    <NA>      <NA>     
#>  5          1          1             0          2 NA    <NA>      <NA>     
#>  6         17         19            21         57 NA    <NA>      <NA>     
#>  7         10         17            17         44 NA    <NA>      <NA>     
#>  8         28         34            46        108 NA    <NA>      <NA>     
#>  9         11         29            23         63 NA    <NA>      <NA>     
#> 10         15         21            13         49 NA    <NA>      <NA>     
#> # … with 269 more rows, and 4 more variables: player.teamName <chr>,
#> #   player.firstName <chr>, player.lastName <chr>, player.volleyPosition <chr>
```

### 7. Pool Ranking

``` r
pl <- list(Fields = "No")
cl <- list(Filter = c(NoTournament = s_tournament$no, ForRanking=TRUE))
vb_pools_frk <- v_get_volley_pool_list(parent=pl, children = cl)
if(length(vb_pools_frk) > 0) {
  pl <- list(NoPool = vb_pools_frk$no[1], 
             Fields = "RankTextWithRepeat TeamCode MatchPoints MatchesWon MatchesLost Matches")
  v_get_volley_pool_ranking(parent = pl)
}
#> # A tibble: 16 × 6
#>    rankTextWithRepeat teamCode matchPoints matchesWon matchesLost matches
#>                 <int> <chr>          <int>      <int>       <int>   <int>
#>  1                  1 BRA               38         13           2      15
#>  2                  2 POL               37         12           3      15
#>  3                  3 SLO               34         12           3      15
#>  4                  4 FRA               34         11           4      15
#>  5                  5 RUS               34         11           4      15
#>  6                  6 SRB               28         10           5      15
#>  7                  7 USA               24          8           7      15
#>  8                  8 CAN               21          7           8      15
#>  9                  9 ARG               20          7           8      15
#> 10                 10 ITA               19          7           8      15
#> 11                 11 JPN               19          7           8      15
#> 12                 12 IRI               18          5          10      15
#> 13                 13 GER               14          4          11      15
#> 14                 14 NED               11          3          12      15
#> 15                 15 BUL                7          2          13      15
#> 16                 16 AUS                2          1          14      15
```

### 8. Tournament Ranking

``` r
pl <- list(NoTournament = s_tournament$no, 
           Fields = "RankTextWithRepeat TeamName")
v_get_volley_tournament_ranking(parent = pl)
#> # A tibble: 16 × 2
#>    rankTextWithRepeat teamName   
#>                 <int> <chr>      
#>  1                  1 Brazil     
#>  2                  2 Poland     
#>  3                  3 France     
#>  4                  4 Slovenia   
#>  5                  5 Russia     
#>  6                  6 Serbia     
#>  7                  7 USA        
#>  8                  8 Canada     
#>  9                  9 Argentina  
#> 10                 10 Italy      
#> 11                 11 Japan      
#> 12                 12 Iran       
#> 13                 13 Germany    
#> 14                 14 Netherlands
#> 15                 15 Bulgaria   
#> 16                 16 Australia
```

### 9. Player Spike Ranking

``` r
if(!is.na(s_tournament$defaultPlayersRanking)) {
  pl <- list(No = s_tournament$defaultPlayersRanking, 
             NumberOfScorers = 10, NumberOfPlayers = 10, Skills = "Spike")
  vb_players_ranking <- v_get_volley_player_ranking(parent = pl)
  vb_players_ranking$Spike[c("TeamCode", "FirstName", "LastName", "Successes", "Faults", "Continues", "TotalAttempts", "Note")]
}
#> # A tibble: 10 × 8
#>    TeamCode FirstName    LastName Successes Faults Continues TotalAttempts Note 
#>    <chr>    <chr>        <chr>    <chr>     <chr>  <chr>     <chr>         <chr>
#>  1 BRA      Wallace      De Souza 150       39     69        258           58.14
#>  2 IRI      Meisam       Salehi   138       44     68        250           55.20
#>  3 JPN      Yuki         Ishikawa 149       28     93        270           55.19
#>  4 NED      Nimir        Abdel-A… 218       77     113       408           53.43
#>  5 BRA      Ricardo Luc… Souza    131       38     79        248           52.82
#>  6 SRB      Marko        Ivovic   158       35     111       304           51.97
#>  7 RUS      Maxim        Mikhayl… 167       45     111       323           51.70
#>  8 SRB      Drazen       Luburic  133       46     81        260           51.15
#>  9 BRA      Yoandy       Leal Hi… 139       39     94        272           51.10
#> 10 ITA      Alessandro   Michiel… 152       27     125       304           50.00
```

## Troubleshooting

Known issues:

### `internal error: Huge input lookup`

This indicates that the XML response from the FIVB server is too large
or deeply nested and is causing the parser to fail. By default the
parser restricts the nesting level that it allows, in order to prevent
crashes or other undesirable behaviour. But you can remove this
restriction by:

``` r
v_options(huge_xml = TRUE)
```

and then try your request again.

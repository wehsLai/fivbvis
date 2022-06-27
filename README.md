
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fivbvis

<!-- badges: start -->
<!-- badges: end -->

R package for getting data from [FIVB VIS web
server](https://www.fivb.org/VisSDK/VisWebService/#Introduction.html)

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
re-downloading:

### 1. Get Tournaments List with Filter Seasons

``` r
library(purrr)
library(dplyr)
#> 
#> è¼‰å…¥å¥—ä»¶ï¼š'dplyr'
#> ä¸‹åˆ—ç‰©ä»¶è¢«é®æ–·è‡ª 'package:stats':
#> 
#>     filter, lag
#> ä¸‹åˆ—ç‰©ä»¶è¢«é®æ–·è‡ª 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(fivbvis)

Sys.setlocale(category = 'LC_ALL', locale = 'English_United States.1252')
#> Warning in Sys.setlocale(category = "LC_ALL", locale = "English_United
#> States.1252"): using locale code page other than 65001 ("UTF-8") may cause
#> problems
#> [1] "LC_COLLATE=English_United States.1252;LC_CTYPE=English_United States.1252;LC_MONETARY=English_United States.1252;LC_NUMERIC=C;LC_TIME=English_United States.1252"
v_options(verbose = TRUE)

cl <- list(Filter = c(Seasons = "2021"))
vb_tournaments <- v_get_volley_tournament_list(children = cl)[c("no", "shortNameOrName", "season", "defaultPlayersRanking")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/938b7b83fa168d850027781ac9ad0c62.rds
vb_tournaments
#> # A tibble: 46 x 4
#>       no shortNameOrName                                 season defaultPlayersR~
#>    <int> <chr>                                            <int>            <int>
#>  1  1182 Tokyo Olympic Games - Women's Tournament          2021               NA
#>  2  1183 Tokyo Olympic Games - Men's Tournament            2021               NA
#>  3  1216 FIVB VNL WOMEN                                    2021              187
#>  4  1217 FIVB VNL MEN                                      2021              188
#>  5  1225 M FISU 2021                                       2021               NA
#>  6  1226 W FISU 2021                                       2021               NA
#>  7  1227 Volleyball Games - Tokyo Challenge 2021 Women     2021               NA
#>  8  1228 Volleyball Games - Tokyo Challenge 2021 Men       2021               NA
#>  9  1230 FIVB Volleyball Challenger Cup - Men (Cancelle~   2021               NA
#> 10  1231 FIVB Volleyball Challenger Cup - Women (Cancel~   2021               NA
#> # ... with 36 more rows
```

### 2. Get Matches List with Filter NoTournament

``` r
s_tournament <- vb_tournaments %>% filter(shortNameOrName == "FIVB VNL MEN")
cl <- list(Filter = c(NoTournament = s_tournament$no),
           Relation = c(Name="Pool", Fields="Name RoundName"))
v_get_volley_match_list(children = cl)[c("dateTimeLocal", "pool.name", "teamAName", "teamBName", "matchResultText")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/88b6fedaaa4e5eeaa98102c7d1b8c71d.rds
#> # A tibble: 124 x 5
#>    dateTimeLocal       pool.name teamAName   teamBName matchResultText
#>    <dttm>              <chr>     <chr>       <chr>     <chr>          
#>  1 2021-05-28 10:00:00 Week 1    France      Bulgaria  3-0            
#>  2 2021-05-28 12:00:00 Week 1    Germany     Australia 3-0            
#>  3 2021-05-28 13:00:00 Week 1    Japan       Iran      3-0            
#>  4 2021-05-28 15:00:00 Week 1    Serbia      Slovenia  3-1            
#>  5 2021-05-28 16:00:00 Week 1    Netherlands Russia    1-3            
#>  6 2021-05-28 18:00:00 Week 1    USA         Canada    3-0            
#>  7 2021-05-28 19:30:00 Week 1    Poland      Italy     3-0            
#>  8 2021-05-28 21:00:00 Week 1    Brazil      Argentina 3-0            
#>  9 2021-05-29 10:00:00 Week 1    Germany     France    2-3            
#> 10 2021-05-29 12:00:00 Week 1    Iran        Russia    1-3            
#> # ... with 114 more rows
```

### 3. Pools List with Filter NoTournament

``` r
pl <- list(Fields = paste0(v_fields("Volleyball Pool"), collapse = " "))
cl <- list(Filter = c(NoTournament = s_tournament$no), ForRanking = NULL)
v_get_volley_pool_list(parent=pl, children = cl)[c("name", "roundName")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/8beed89bcbe6d83f7f1705c47b699a25.rds
#> # A tibble: 9 x 2
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

### 4. Teams List with Filter NoTournament

``` r
cl <- list(Filter = c(NoTournament = s_tournament$no))
v_get_volley_team_list(children = cl)[c("code", "name")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/5377dc95bce122b9adecd8236e406e21.rds
#> # A tibble: 16 x 2
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

### 5. Players List with Filter NoTournament, Relation Player

``` r
cl <- list(Filter = c(NoTournament = s_tournament$no), Relation = c(Name="Player", Fields="TeamName FirstName LastName"), Relation = c(Name="Team", Fields="code"))
v_get_volley_player_list(children = cl)[c("team", "noShirt", "position","player.firstName", "player.lastName")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/abfa2426fa91efaa620f3ca2d7db88b5.rds
#> # A tibble: 271 x 5
#>    team  noShirt position       player.firstName player.lastName
#>    <chr>   <int> <chr>          <chr>            <chr>          
#>  1 BRA         8 OppositeSpiker Wallace          De Souza       
#>  2 JPN         5 WingSpiker     Tatsuya          Fukuzawa       
#>  3 SLO         6 OppositeSpiker Mitja            Gasparini      
#>  4 SLO         9 Setter         Dejan            Vincic         
#>  5 SLO        17 WingSpiker     Tine             Urnaut         
#>  6 SLO         2 MiddleBlocker  Alen             Pajenk         
#>  7 POL        12 Setter         Grzegorz         Lomacz         
#>  8 POL         6 OppositeSpiker Bartosz          Kurek          
#>  9 POL        13 WingSpiker     Michal           Kubiak         
#> 10 GER         8 MiddleBlocker  Marcus           Böhme          
#> # ... with 261 more rows
```

### 6. Statistics List with Filter NoTournament

``` r
pl <- list(Fields = paste(v_fields("Volleyball Statistic"), collapse = " "),
           Include = "Teams", SumBy="Tournament")
cl <- list(Filter = c(NoTournaments = s_tournament$no, MatchesToUse="MatchesStarted"),
           Relation = c(Name="Match", Fields="NoInTournament DateLocal TeamACode TeamBCode MatchResult"),
           Relation = c(Name="Team", Fields="Code"),
           Relation = c(Name="Player", Fields="TeamName FirstName LastName VolleyPosition")
           )
v_get_volley_statistic_list(parent = pl, children = cl)[c("player.teamName","blockPoint", "blockFault", "blockContinue","blockTotal")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/19fb2d577498749e6e618e58e6f06206.rds
#> # A tibble: 279 x 5
#>    player.teamName blockPoint blockFault blockContinue blockTotal
#>    <chr>                <int>      <int>         <int>      <int>
#>  1 Chinenyeze              23         67            45        135
#>  2 Patry                    8         27            22         57
#>  3 Toniutti                 3         14            14         31
#>  4 Tillie                   9         14            13         36
#>  5 Lyneel                   1          1             0          2
#>  6 Brizard                 17         19            21         57
#>  7 Boyer                   10         17            17         44
#>  8 Le Goff                 28         34            46        108
#>  9 Bultor                  11         29            23         63
#> 10 Clevenot                15         21            13         49
#> # ... with 269 more rows
```

### 7. Pool Ranking

``` r
pl <- list(Fields = paste0(v_fields("Volleyball Pool"), collapse = " "))
cl <- list(Filter = c(NoTournament = s_tournament$no, ForRanking=TRUE))
vb_pools_frk <- v_get_volley_pool_list(parent=pl, children = cl)
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/e9eb82762fac89d3dd224a763aed276d.rds
pl <- list(NoPool = vb_pools_frk$no[1], Fields = paste(v_fields("Volleyball Pool Ranking"), collapse = " "))
v_get_volley_pool_ranking(parent = pl)[c("rankTextWithRepeat", "teamCode", "matchPoints", "matchesWon", "matchesLost", "matches", "setsRatioText", "pointsRatioText")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/76682a590f64a9423a672067f3dbf6a1.rds
#> # A tibble: 16 x 8
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
#> # ... with 2 more variables: setsRatioText <dbl>, pointsRatioText <dbl>
```

### 8. Tournament Ranking

``` r
pl <- list(NoTournament = s_tournament$no, Fields = paste(v_fields("Volleyball Tournament Ranking"), collapse = " "))
v_get_volley_tournament_ranking(parent = pl)[c("rankTextWithRepeat", "teamName")]
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/5acc0dd3500882bca3779acd2dd4c869.rds
#> # A tibble: 16 x 2
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

### 9. Player Ranking

``` r
if(!is.na(s_tournament$defaultPlayersRanking)) {
    pl <- list(No=s_tournament$defaultPlayersRanking, NumberOfScorers=10, NumberOfPlayers=10, Skills = "Scorer Spike Block Service Dig Set Reception Libero")
    vb_players_ranking <- v_get_volley_player_ranking(parent=pl)
    vb_players_ranking$Spike[c("TeamCode", "FirstName", "LastName", "Successes", "Faults", "Continues", "TotalAttempts", "Note")]
}
#> making  request
#> caching to C:\Users\user\AppData\Local\Temp\RtmpAvViAk\file5c0c1d07eb7/8d8e82067709454d3ef520097f6295df.rds
#> # A tibble: 10 x 8
#>    TeamCode FirstName    LastName Successes Faults Continues TotalAttempts Note 
#>    <chr>    <chr>        <chr>    <chr>     <chr>  <chr>     <chr>         <chr>
#>  1 BRA      Wallace      De Souza 150       39     69        258           58.14
#>  2 IRI      Meisam       Salehi   138       44     68        250           55.20
#>  3 JPN      Yuki         Ishikawa 149       28     93        270           55.19
#>  4 NED      Nimir        Abdel-A~ 218       77     113       408           53.43
#>  5 BRA      Ricardo Luc~ Souza    131       38     79        248           52.82
#>  6 SRB      Marko        Ivovic   158       35     111       304           51.97
#>  7 RUS      Maxim        Mikhayl~ 167       45     111       323           51.70
#>  8 SRB      Drazen       Luburic  133       46     81        260           51.15
#>  9 BRA      Yoandy       Leal Hi~ 139       39     94        272           51.10
#> 10 ITA      Alessandro   Michiel~ 152       27     125       304           50.00
```

<!-- What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so:


```r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->

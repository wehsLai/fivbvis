## helper function to remap values
##
## @param x data.frame: the data frame
## @param col string: the column name to remap
## @param scheme string: the schema name to apply, see v_schema
## @param from string: the column in the schema to map from
## @param to string: the column in the schema to map to
v_remap <- function(x, col, schema, from = "from", to = "to") {
  this_schema <- v_schema(schema)
  if (col %in% names(x)) x[[col]] <- dmapvalues(x[[col]], this_schema[[from]], this_schema[[to]])
  x
}

## define data schema so that values can be remapped
v_schema <- function(type) {
  switch(type,
    ## https://www.fivb.org/VisSDK/VisWebService/PressReleaseSourceCategory.html
    "Press Release Source Category" = tribble(
      ~from, ~to, ~description,
      0L, "None", "No source",
      1L, "F\ueevb", "FIVB",
      2L, "Confederation", "Confederation",
      3L, "Federation", "Federation",
      4L, "Other", "Other"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/PressReleaseCategory.html
    "Press Release Special Type" = tribble(
      ~from, ~to, ~description,
      0L, "None", "Not a special release",
      1L, "MatchPreview", "Preview information for a match",
      2L, "MatchFlash", "Flash information or description for a match",
      3L, "MatchPressConference", "Press conference for a match",
      4L, "TeamProfile", "Profile for a team",
      5L, "PlayerProfile", "Profile for a player",
      6L, "OfficialProfile", "Profile for an official",
      7L, "Features", "Features"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/PressReleaseCategory.html
    "Press Release Category" = tribble(
      ~from, ~to, ~description,
      0L, "None", "No category",
      1L, "Fivb", "Global FIVB information",
      2L, "Volleyball", "Release about volleyball",
      3L, "Beach", "Release about beach volleyball",
      4L, "Development", "Release about development",
      5L, "Refereeing", "Release about refereeing",
      6L, "Rules", "Release about the rules",
      7L, "Technical", "Release with technical information",
      8L, "Coach", "Release about coaches",
      9L, "Medical", "Release with medical information",
      10L, "President", "Release about the president"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/#EventType.html
    "Event Type" = tribble(
      ~from, ~to, ~description,
      1L, "Courses", "One or more courses in a session",
      2L, "Meeting", "Meeting",
      3L, "Sport", "Sport Event"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachTeamType.html
    "Beach Team Type" = tribble(
      ~from, ~to, ~description,
      0L, "Normal", "Normal",
      1L, "WildCard", "The team has received a wild card",
      2L, "TechnicalWildCard", "The team has received a technical wild card",
      3L, "LateEntry", "This is a late entry team",
      4L, "Reserve", "This is a reserve team",
      5L, "HostTeam", "This is a team from the host country",
      6L, "QualificationWildCard", "The team has received a qualification tournament wild card",
      7L, "Confederation", "The team is selected by the confederation",
      8L, "FederationSpot", "This is not a real team, but an indication that this spot is reserved for a team from a federation selection round",
      9L, "ConfederationSpot", "This is not a real team, but an indication that this spot is reserved for a team from a confederation selection round",
      10L, "OrganizerVacancy", "The team has been selected because its federation organizes a tournament in the World Tour"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachTeamStatus.html
    "Player Beach Team Status" = tribble(
      ~from, ~to, ~description,
      0L, "Registered", "Registered",
      1L, "Deleted", "The team has been deleted",
      2L, "Withdrawn", "The team is withdrawn",
      3L, "WithdrawnWithMedicalCert", "The team is withdrawn, but with a medical certificate"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachRoundPhase.html
    "Beach Round Phase" = tribble(
      ~from, ~to, ~description,
      1L, "ConfederationQuota", "Confederation quota round",
      2L, "FederationQuota", "Federation quota round",
      3L, "Qualification", "Qualification round",
      4L, "MainDraw", "Main draw"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachMatchStatus.html
    "Beach Match Status" = tribble(
      ~from, ~to, ~description,
      1L, "Scheduled", "Match scheduled",
      2L, "ReadyToStart", "Match is ready to start",
      3L, "InSet1", "Set 1 is running",
      4L, "Set1Finished", "Set 1 is finished",
      5L, "InSet2", "Set 2 is running",
      6L, "Set2Finished", "Set 2 is finished",
      7L, "InSet3", "Set 3 is running",
      8L, "Set3Finished", "Set 3 is finished",
      9L, "InSet4", "Set 4 is running",
      10L, "Set4Finished", "Set 4 is finished",
      11L, "InSet5", "Set 5 is running",
      12L, "Finished", "Match is finished",
      13L, "OfficialResult", "The match result is official",
      14L, "Corrected", "The match result has been corrected",
      15L, "Closed", "Closed: nothing more can be changed"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachRoundPhase.html
    "Beach Match Round Phase" = tribble(
      ~from, ~to, ~description,
      1L, "ConfederationQuota", "Confederation quota round",
      2L, "FederationQuota", "Federation quota round",
      3L, "Qualification", "Qualification round",
      4L, "MainDraw", "Main draw"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachMatchResultType.html
    "Beach Match Result Type" = tribble(
      ~from, ~to, ~description,
      0L, "Normal", "The match ends normally",
      1L, "ForfeitA", "Forfeit for team A",
      2L, "ForfeitB", "Forfeit for team B",
      3L, "ForfeitBoth", "Forfeit for both teams",
      4L, "InjuryA", "Injury for team A",
      5L, "InjuryB", "Injury for team B",
      6L, "InjuryBoth", "Injury for both teams",
      7L, "OutA", "Team A out of tournament",
      8L, "OutB", "Team B out of tournament",
      9L, "OutBoth", "Both teams out of tournament",
      10L, "DisqualifiedA", "Team A has been disqualified",
      11L, "DisqualifiedB", "Team B has been disqualified",
      12L, "DisqualifiedBoth", "Both teams have been disqualified"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/VolleyMatchAcquisitionMethod.html
    "Beach Match Acquisition Method" = tribble(
      ~from, ~to, ~description,
      1L, "Vba_Ruby", "The acquisition is made using the VBA method, with the Ruby script converting the data,",
      2L, "DataVolley_Vba_Ruby", "The acquisition is made using the DataVolley application that send information compatible with VBA, with the Ruby script converting the data",
      3L, "Vis", "The acquisition is made with the VIS method",
      4L, "Vba_Vis", "The acquisition is made using the VBA method, with the VIS web service converting the data,",
      5L, "DataVolley_Vba_Vis", "The acquisition is made using the DataVolley application that send information compatible with VBA",
      6L, "DataVolley_Vis", "The acquisition is made using the DataVolley application that send information compatible with VIS",
      7L, "OG2016", "The acquisition is made using the 2016 Olympic Games method",
      8L, "None", "There is no acquisition of live data for the match"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachOlympicTeamStatus.html
    "Beach Olympic Team Status" = tribble(
      ~from, ~to, ~description,
      1L, "Selected", "Team selected",
      2L, "SelectedMinHostQuota", "Team selected because of the host quota There is a minimum number of teams for the Olympic Games host country",
      3L, "SelectedMinConfederationQuota", "Team selected because of the confederation quota There is a minimum number of teams for each confederation",
      4L, "Tie", "Team not selected, but tied with another one",
      5L, "NotEnoughTournaments", "Team not selected because it has not played enough tournaments during the selection period",
      6L, "CountryQuota", "Team not selected because of the country quota There is a maximum number of teams for each country",
      7L, "NotRegistered", "Team not selected because it has not been registered for the Olympic Games tournament",
      8L, "NotEnoughPoints", "Team not selected because it has not enough points"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachTournamentStatus.html
    "Beach Tournament Status" = tribble(
      ~from, ~to, ~description,
      0L, "NotOpen", "Not opened",
      1L, "Open", "Open",
      6L, "Running", "Running: no more changes are allowed",
      7L, "Finished", "Finished",
      8L, "PaymentPending", "Players payments are pending",
      9L, "Paid", "All the payments are done"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/OrganizerType.html
    "Organizer Type" = tribble(
      ~from, ~to, ~description,
      0L, "Unknown", "Unknown or not defined",
      1L, "Fivb", "FIVB",
      2L, "Confederation", "Confederation",
      3L, "MultiSports", "Multiple sports event",
      4L, "Other", "Other recognized FIVB event",
      5L, "Federation", "Federation"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/EventGender.html
    "Event Gender" = tribble(
      ~from, ~to, ~description,
      0L, "M", "Men",
      1L, "W", "Women",
      2L, "MW", "Men and women",
      3L, "Mixed", "Mixed teams"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachTournamentDispatchStatus.html
    "Beach Tournament Dispatch Status" = tribble(
      ~from, ~to, ~description,
      0L, "None", "Nothing calculated for the dispatching",
      1L, "EntryPointsCalculated", "The entry points are calculated",
      2L, "TeamsDispatched", "The teams are dispatched",
      3L, "SeedPointsCalculated", "The seed points are calculated"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachMatchFormat.html
    "Beach Match Format" = tribble(
      ~from, ~to, ~description,
      1L, "Set3-Points12", "Set3-Points12",
      2L, "Set3-Points21", "Set3-Points21",
      3L, "Set3-Points25-15", "Set3-Points25-15",
      4L, "Set3-Points21-15", "Set3-Points21-15",
      5L, "Set1-Points15", "Set1-Points15",
      6L, "Set5-Points11", "Set5-Points11",
      14L, "Set5-Points15-7", "Set5-Points15-7",
      72L, "Set3-Points15", "Set3-Points15",
      75L, "Set3-Points11", "Set3-Points11"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/BeachTournamentType.html
    "Beach Tournament Type" = tribble(
      ~from, ~to, ~description,
      0L, "GrandSlam", "Grand slam",
      1L, "Open", "Open",
      2L, "Challenger", "Challenger",
      3L, "WorldSeries", "World series",
      4L, "WorldChamp", "World championship",
      5L, "OlympicGames", "Olympic games",
      6L, "Satellite", "Satellite",
      7L, "ContinentalChamp", "Continental championship",
      8L, "OtherContinental", "Other continental",
      9L, "Other", "Other",
      10L, "Masters", "CEV Masters",
      11L, "ContinentalCup", "Continental cup",
      12L, "ContinentalTour", "Continental tour",
      13L, "JuniorWorldChamp", "Junior world championship",
      14L, "YouthWorldChamp", "Youth world championship",
      15L, "NationalTour", "National tour",
      16L, "NationalTourU23", "National tour (under 23 years)",
      17L, "NationalTourU21", "National tour (under 21 years)",
      18L, "NationalTourU19", "National tour (under 19 years)",
      19L, "NationalTourU20", "National tour (under 20 years)",
      20L, "NationalTourU17", "National tour (under 17 years)",
      21L, "NationalTourU15", "National tour (under 15 years)",
      22L, "ContinentalChampU22", "Continental championship (under 22 years)",
      23L, "ContinentalChampU20", "Continental championship (under 20 years)",
      24L, "ContinentalChampU18", "Continental championship (under 18 years)",
      25L, "WorldChampU23", "World championship (under 23 years)",
      26L, "WorldChampU21", "World championship (under 21 years)",
      27L, "WorldChampU19", "World championship (under 19 years)",
      28L, "NationalTourU14", "National tour (under 14 years)",
      29L, "NationalTourU16", "National tour (under 16 years)",
      30L, "NationalTourU18", "National tour (under 18 years)",
      31L, "WorldChampU17", "World championship (under 17 years)",
      32L, "MajorSeries", "Major Series",
      33L, "WorldTourFinals", "World Tour Finals",
      34L, "ZonalTour", "Zonal Tour",
      35L, "Test", "Test",
      36L, "SnowVolleyball", "Snow Volleyball",
      37L, "ContinentalCupFinal", "Continental Cup Final",
      38L, "WorldTour5Star", "World Tour 5*",
      39L, "WorldTour4Star", "World Tour 4*",
      40L, "WorldTour3Star", "World Tour 3*",
      41L, "WorldTour2Star", "World Tour 2*",
      42L, "WorldTour1Star", "World Tour 1*",
      43L, "YouthOlympicGames", "Youth Olympic Games",
      44L, "MultiSports", "Multiple sports",
      45L, "NationalSnow", "National snow volleyball",
      46L, "NationalTourU22", "National Tour (under 22 years)",
      47L, "ContinentalChampU21", "Continental championship (under 21 years)",
      48L, "ContinentalChampU19", "Continental championship (under 19 years)",
      49L, "OlympicGamesQualification", "Qualification tournament for Olympic Games",
      50L, "KingOfTheCourt", "King of the Court"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/PlayerVolleyPosition.html
    "Player Volley Position" = tribble(
      ~from, ~to, ~description,
      0L, "Unknown", "Unknown",
      1L, "Setter", "Setter",
      2L, "WingSpiker", "Wing spiker",
      3L, "MiddleBlocker", "Middle blocker",
      4L, "Libero", "Libero",
      5L, "Universal", "Universal",
      6L, "OppositeSpiker", "Opposite spiker"
    ),
    ## Short version
    "Player Volley Pos" = tribble(
      ~from, ~to, ~description,
      0L, "_", "Unknown",
      1L, "S", "Setter",
      2L, "OH", "Wing spiker",
      3L, "MB", "Middle blocker",
      4L, "L", "Libero",
      5L, "U", "Universal",
      6L, "OP", "Opposite spiker"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/PlayerBeachPosition.html
    "Player Beach Position" = tribble(
      ~from, ~to, ~description,
      0L, "Unknown", "Unknown",
      1L, "RightBlocker", "Right blocker",
      2L, "LeftBlocker", "Left blocker",
      3L, "RightDefender", "Right defender",
      4L, "LeftDefender", "Left defender",
      5L, "Right", "Right",
      6L, "Left", "Left",
      7L, "Universal", "Universal"
    ),
    ## https://www.fivb.org/VisSDK/Fivb.Vis.DataWPF/Fivb.Vis.DataWPF~Fivb.Vis.Volley.VolleyTournamentStatus.html
    "Volley Tournament Status" = tribble(
      ~from, ~to, ~description,
      1L, "Scheduled", "Is scheduled",
      2L, "Confirmed", "Is confirmed to be played",
      3L, "Running", "Is running",
      4L, "Finished", "Is finished",
      5L, "Canceled", "Is canceled"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/VolleyMatchResultType.html
    "Volley Match Result Type" = tribble(
      ~from, ~to, ~description,
      0L, "Normal", "Normally finished",
      1L, "ForfeitA", "Forfeit for team A",
      2L, "ForfeitB", "Forfeit for team B",
      3L, "ForfeitBoth", "Forfeit for both teams"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/VolleyMatchStatus.html
    "Volley Match Status" = tribble(
      ~from, ~to, ~description,
      1L, "Scheduled", "Match scheduled",
      2L, "RosterDefined", "The roster has been defined",
      3L, "ReadyToStart", "Match is ready to start",
      4L, "Set1Ready", "Set 1 is ready to start",
      5L, "InSet1", "Set 1 is running",
      6L, "Set1Finished", "Set 1 is finished",
      7L, "Set2Ready", "Set 2 is ready to start",
      8L, "InSet2", "Set 2 is running",
      9L, "Set2Finished", "Set 2 is finished",
      10L, "Set3Ready", "Set 3 is ready to start",
      11L, "InSet3", "Set 3 is running",
      12L, "Set3Finished", "Set 3 is finished",
      13L, "Set4Ready", "Set 4 is ready to start",
      14L, "InSet4", "Set 4 is running",
      15L, "Set4Finished", "Set 4 is finished",
      16L, "Set5Ready", "Set 5 is ready to start",
      17L, "InSet5", "Set 5 is running",
      18L, "Set5Finished", "Set 5 is finished",
      19L, "Set6Ready", "Set 6 is ready to start",
      20L, "InSet6", "Set 6 is running",
      21L, "Set6Finished", "Set 6 is finished",
      22L, "Set7Ready", "Set 7 is ready to start",
      23L, "InSet7", "Set 7 is running",
      24L, "Finished", "Match is finished",
      25L, "OfficialResult", "The result is official",
      26L, "Corrected", "The result has been corrected",
      27L, "Closed", "Closed: nothing more can be changed"
    ),
    ## https://www.fivb.org/VisSDK/VisWebService/#FederationCode.html
    "Federation Code" = tribble(
      ~code, ~federation,
      "ALB", "Albania",
      "AFG", "Afghanistan",
      "AGU", "Anguilla",
      "AHO", "Netherlands Antilles",
      "ALG", "Algeria",
      "AND", "Andorra",
      "ANG", "Angola",
      "ANT", "Antigua and Barbuda",
      "ARG", "Argentina",
      "ARM", "Armenia",
      "ARU", "Aruba",
      "ASA", "American Samoa",
      "AUS", "Australia",
      "AUT", "Austria",
      "AZE", "Azerbaijan",
      "BAH", "Bahamas",
      "BAN", "Bangladesh",
      "BAR", "Barbados",
      "BDI", "Burundi",
      "BEL", "Belgium",
      "BEN", "Benin",
      "BER", "Bermuda",
      "BHU", "Bhutan",
      "BIH", "Bosnia and Herzegovina",
      "BIZ", "Belize",
      "BLR", "Belarus",
      "BOL", "Bolivia",
      "BON", "Bonaire",
      "BOT", "Botswana",
      "BRA", "Brazil",
      "BRN", "Bahrain",
      "BRU", "Brunei Darussalam",
      "BUL", "Bulgaria",
      "BUR", "Burkina Faso",
      "CAF", "Central African Republic",
      "CAM", "Cambodia",
      "CAN", "Canada",
      "CAY", "Cayman Islands",
      "CGO", "Congo",
      "CHA", "Chad",
      "CHI", "Chile",
      "CHN", "China",
      "CIV", "C\uf4te d'Ivoire",
      "CMR", "Cameroon",
      "COD", "Congo, the Democratic Republic of the",
      "COK", "Cook Islands",
      "COL", "Colombia",
      "COM", "Comoros",
      "CPV", "Cape Verde",
      "CRC", "Costa Rica",
      "CRO", "Croatia",
      "CUB", "Cuba",
      "CUR", "Cura\ue7ao",
      "CYP", "Cyprus",
      "CZE", "Czech Republic",
      "DEN", "Denmark",
      "DJI", "Djibouti",
      "DMA", "Dominica",
      "DOM", "Dominican Republic",
      "ECU", "Ecuador",
      "EGY", "Egypt",
      "ENG", "England",
      "ERT", "Eritrea",
      "ESA", "El Salvador",
      "ESP", "Spain",
      "EST", "Estonia",
      "ETH", "Ethiopia",
      "EUX", "Sint Eustatius",
      "FER", "Faroe Islands",
      "FGU", "French Guiana",
      "FIJ", "Fiji",
      "FIN", "Finland",
      "FIV", "FIVB", ## Not a federation, but is used as some special cases.
      "FRA", "France",
      "FSM", "Micronesia, Federated States of",
      "GAB", "Gabon",
      "GAM", "Gambia",
      "GBR", "Great Britain", ## Not a federation, but must be used for some events, such as the Olympic Games, because they are working with countries.
      "GBS", "Guinea-Bissau",
      "GDP", "Guadeloupe",
      "GEO", "Georgia",
      "GEQ", "Equatorial Guinea",
      "GER", "Germany",
      "GHA", "Ghana",
      "GIB", "Gibraltar",
      "GRE", "Greece",
      "GRL", "Greenland",
      "GRN", "Grenada",
      "GUA", "Guatemala",
      "GUI", "Guinea",
      "GUM", "Guam",
      "GUY", "Guyana",
      "HAI", "Haiti",
      "HKG", "Hong Kong",
      "HON", "Honduras",
      "HUN", "Hungary",
      "INA", "Indonesia",
      "IND", "India",
      "IRI", "Iran",
      "IRL", "Ireland",
      "IRQ", "Iraq",
      "ISL", "Iceland",
      "ISR", "Israel",
      "ISV", "Virgin Islands, U.S.",
      "ITA", "Italy",
      "IVB", "Virgin Islands, British",
      "JAM", "Jamaica",
      "JOR", "Jordan",
      "JPN", "Japan",
      "KAZ", "Kazakhstan",
      "KEN", "Kenya",
      "KGZ", "Kyrgyzstan",
      "KIR", "Kiribati",
      "KOR", "Korea, Republic of",
      "KOS", "Kosovo",
      "KSA", "Saudi Arabia",
      "KUW", "Kuwait",
      "LAO", "Lao People's Democratic Republic",
      "LAT", "Latvia",
      "LBA", "Libya",
      "LBR", "Liberia",
      "LCA", "Saint Lucia",
      "LES", "Lesotho",
      "LIB", "Lebanon",
      "LIE", "Liechtenstein",
      "LTU", "Lithuania",
      "LUX", "Luxembourg",
      "MAC", "Macao",
      "MAD", "Madagascar",
      "MAR", "Morocco",
      "MAS", "Malaysia",
      "MAW", "Malawi",
      "MDV", "Maldives",
      "MEX", "Mexico",
      "MGL", "Mongolia",
      "MKD", "Macedonia, the Former Yugoslav Republic of",
      "MLD", "Moldova",
      "MLI", "Mali",
      "MLT", "Malta",
      "MNE", "Montenegro",
      "MON", "Monaco",
      "MOZ", "Mozambique",
      "MQE", "Martinique",
      "MRI", "Mauritius",
      "MSH", "Marshall Islands",
      "MTN", "Mauritania",
      "MTS", "Montserrat",
      "MYA", "Myanmar",
      "NAM", "Namibia",
      "NCA", "Nicaragua",
      "NED", "Netherlands",
      "NEP", "Nepal",
      "NGR", "Nigeria",
      "NIG", "Niger",
      "NIR", "Northern Ireland",
      "NIU", "Niue",
      "NOR", "Norway",
      "NRU", "Nauru",
      "NZL", "New Zealand",
      "OMA", "Oman",
      "PAK", "Pakistan",
      "PAN", "Panama",
      "PAR", "Paraguay",
      "PAU", "Palau",
      "PER", "Peru",
      "PHI", "Philippines",
      "PLE", "Palestinian Territory, Occupied",
      "PLY", "French Polynesia",
      "PNG", "Papua New Guinea",
      "POL", "Poland",
      "POR", "Portugal",
      "PRK", "Korea, Democratic People's Republic of",
      "PUR", "Puerto Rico",
      "QAT", "Qatar",
      "ROU", "Romania",
      "RSA", "South Africa",
      "RUS", "Russia",
      "RWA", "Rwanda",
      "SAB", "Saba",
      "SAI", "Northern Mariana Islands",
      "SAM", "Samoa",
      "SCO", "Scotland",
      "SEN", "Senegal",
      "SEY", "Seychelles",
      "SKN", "Saint Kitts and Nevis",
      "SIN", "Singapore",
      "SLE", "Sierra Leone",
      "SLO", "Slovenia",
      "SMA", "Saint Martin (French part)",
      "SMR", "San Marino",
      "SOL", "Solomon Islands",
      "SOM", "Somalia",
      "SRB", "Serbia",
      "SRI", "Sri Lanka",
      "STP", "Sao Tome and Principe",
      "SUD", "Sudan",
      "SUI", "Switzerland",
      "SUR", "Suriname",
      "SVK", "Slovakia",
      "SWE", "Sweden",
      "SWZ", "Swaziland",
      "SXM", "Sint Maarten (Dutch part)",
      "SYR", "Syrian Arab Republic",
      "TAN", "Tanzania",
      "TCI", "Turks & Caicos Islands",
      "TGA", "Tonga",
      "THA", "Thailand",
      "TJK", "Tajikistan",
      "TKM", "Turkmenistan",
      "TLS", "Timor-Leste",
      "TOG", "Togo",
      "TPE", "Taiwan, Province of China",
      "TTO", "Trinidad and Tobago",
      "TUN", "Tunisia",
      "TUR", "Turkey",
      "TUV", "Tuvalu",
      "UAE", "United Arab Emirates",
      "UGA", "Uganda",
      "UKR", "Ukraine",
      "URU", "Uruguay",
      "USA", "United States",
      "UZB", "Uzbekistan",
      "VAN", "Vanuatu",
      "VEN", "Venezuela",
      "VIE", "Viet Nam",
      "VIN", "Saint Vincent and the Grenadines",
      "WAL", "Wales",
      "YEM", "Yemen",
      "ZAM", "Zambia",
      "ZIM", "Zimbabwe"
    ),
    stop("unexpected schema type: ", type)
  )
}

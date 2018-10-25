
kino
====

{kino} was born out of my experience checking out English OmU movie options in Münster. Understandably, the trailers and descriptions are in German, but searching for their English counterparts feels unnecessarily tedious - this should be automatable! The idea is to scrape screening and German movie information from cineplex.de and rating and English movie information from imdb.com and omdb's API. Eventually, I'll build a shiny app on top of this, so anyone can use it! :)

At the moment, the package is still under construction and only works with OmU movies in Münster.

Installation
------------

You can install {kino} from github with:

``` r
# install.packages("devtools")
devtools::install_github("sowla/kino")
```

Here's how you might use {kino}
-------------------------------

First, select a city and checkout the available screening details:

``` r
library(kino)

my_city <- get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")

my_screenings_details <- get_screenings(city_html = my_city)

my_screenings_details
```

    ## # A tibble: 22 x 5
    ##    german_title                      dates    times release_types sites   
    ##    <chr>                             <chr>    <chr> <chr>         <chr>   
    ##  1 Münster Above - Der Film          2018-10… 19:30 2D OmU        Cineplex
    ##  2 Down by Law                       2018-10… 22:45 2D OmU        Schloßt…
    ##  3 Down by Law                       2018-10… 22:45 2D OmU        Schloßt…
    ##  4 Kindeswohl                        2018-10… 17:00 2D OmU        Schloßt…
    ##  5 Champagner & Macarons - Ein unve… 2018-10… 18:40 2D OmU        Schloßt…
    ##  6 Intrigo - Tod eines Autors        2018-10… 20:30 2D OV         Schloßt…
    ##  7 Venom                             2018-10… 21:30 2D OV         Cineplex
    ##  8 A Star is Born                    2018-10… 21:50 2D OmU        Cineplex
    ##  9 Johnny English - Man lebt nur dr… 2018-10… 22:10 2D OmU        Cineplex
    ## 10 Bohemian Rhapsody                 2018-10… 21:00 2D OmU        Cineplex
    ## # ... with 12 more rows

Filter the results based on eg. site or release types:

``` r
filter_screenings(my_screenings_details, sel_sites = "Cineplex", sel_release_types = "2D OmU")
```

    ## # A tibble: 7 x 5
    ##   german_title                       dates     times release_types sites  
    ##   <chr>                              <chr>     <chr> <chr>         <chr>  
    ## 1 Münster Above - Der Film           2018-10-… 19:30 2D OmU        Cinepl…
    ## 2 A Star is Born                     2018-10-… 21:50 2D OmU        Cinepl…
    ## 3 Johnny English - Man lebt nur dre… 2018-10-… 22:10 2D OmU        Cinepl…
    ## 4 Bohemian Rhapsody                  2018-10-… 21:00 2D OmU        Cinepl…
    ## 5 BTS - Burn The Stage: The Movie    2018-11-… 19:00 2D OmU        Cinepl…
    ## 6 BTS - Burn The Stage: The Movie    2018-11-… 17:30 2D OmU        Cinepl…
    ## 7 BTS - Burn The Stage: The Movie    2018-11-… 17:30 2D OmU        Cinepl…

Decide which movies you're interested in and retreive some/all IMDB details:

``` r
imdb_details <- convert_movies("Johnny English - Man lebt nur dreimal")

imdb_details
```

    ## # A tibble: 1 x 4
    ##   check_german_title      english_title         imdb_id  imdb_url         
    ##   <chr>                   <chr>                 <chr>    <chr>            
    ## 1 Johnny English - Man l… Johnny English - Man… tt69219… https://www.imdb…

``` r
imdb_details$imdb_id
```

    ## [1] "tt6921996"

``` r
my_movie_info <- get_mov_info_en(sel_imdb_ids = "tt6921996")

filter_movies(mov_info = my_movie_info, details = c("title", "runtime", "plot"))
```

    ## # A tibble: 1 x 3
    ##   title               runtime plot                                        
    ##   <chr>                 <dbl> <chr>                                       
    ## 1 Johnny English Str…      88 After a cyber-attack reveals the identity o…

``` r
my_movie_info$plot
```

    ## [1] "After a cyber-attack reveals the identity of all of the active undercover agents in Britain, Johnny English is forced to come out of retirement to find the mastermind hacker."

Note: at the moment, when you test this, you'll probably get results that look different from this particular example, which is rendered on 2018-10-25.. I plan to add sample data that you use to test the package, then I'll update the documentation so they fit.. thank you for your patience!

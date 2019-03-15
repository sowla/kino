
# kino

{kino} was born out of my experience checking out English original
soundtrack movie options in Münster. Understandably, the trailers and
descriptions are in German, but searching for their English counterparts
feels unnecessarily tedious - this should be automatable\! The idea is
to scrape screening and German movie information from cineplex.de and
rating and English movie information from imdb.com and omdb’s API.
Eventually, I’ll build a shiny app on top of this, so anyone can use
it\! :)

At the moment, the package is still under construction and only works
with [“originals” movies in
Münster](https://www.cineplex.de/filmreihe/originals/614/muenster/).

## Installation

You can install {kino} from github with:

``` r
# install the remotes package first if you don't have it already:
# install.packages("remotes")

remotes::install_github("sowla/kino")
```

## Here’s how you might use {kino}

First, select a city and checkout the available screening details:

``` r
library(kino)

my_city <- get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")

my_screenings_details <- get_screenings(my_city)

my_screenings_details
```

    #> # A tibble: 40 x 5
    #>    german_title                 dates    times release_types sites         
    #>    <chr>                        <chr>    <chr> <chr>         <chr>         
    #>  1 Der verlorene Sohn           2019-03… 17:00 2D OmU        Cinema        
    #>  2 A Star is Born               2019-03… 22:30 2D OmU        Schloßtheater…
    #>  3 Studio 54 - The Documentary  2019-03… 23:00 2D OmU        Schloßtheater…
    #>  4 Studio 54 - The Documentary  2019-03… 23:00 2D OmU        Schloßtheater…
    #>  5 The Sisters Brothers         2019-03… 22:10 2D OmU        Cinema        
    #>  6 The Sisters Brothers         2019-03… 20:30 2D OmU        Cinema        
    #>  7 Green Book - Eine besondere… 2019-03… 17:15 2D OmU        Cineplex Müns…
    #>  8 Bohemian Rhapsody            2019-03… 17:40 2D OmU        Cineplex Müns…
    #>  9 We want Sex                  2019-03… 18:00 2D OmU        Cinema        
    #> 10 Captain Marvel               2019-03… 18:00 3D OV         Cineplex Müns…
    #> # … with 30 more rows

You can also use the `example_screenings_details` data I’ve included,
which is the result of running the same code on 14th March 2019.

``` r
example_screenings_details
```

    #> # A tibble: 42 x 5
    #>    german_title                 dates    times release_types sites         
    #>    <chr>                        <chr>    <chr> <chr>         <chr>         
    #>  1 Der verlorene Sohn           2019-03… 17:00 2D OmU        Cinema        
    #>  2 A Star is Born               2019-03… 22:30 2D OmU        Schloßtheater…
    #>  3 Studio 54 - The Documentary  2019-03… 23:00 2D OmU        Schloßtheater…
    #>  4 Studio 54 - The Documentary  2019-03… 23:00 2D OmU        Schloßtheater…
    #>  5 The Sisters Brothers         2019-03… 22:10 2D OmU        Cinema        
    #>  6 The Sisters Brothers         2019-03… 20:30 2D OmU        Cinema        
    #>  7 Green Book - Eine besondere… 2019-03… 17:15 2D OmU        Cineplex Müns…
    #>  8 Bohemian Rhapsody            2019-03… 17:40 2D OmU        Cineplex Müns…
    #>  9 We want Sex                  2019-03… 18:00 2D OmU        Cinema        
    #> 10 Captain Marvel               2019-03… 21:00 2D OmU        Cineplex Müns…
    #> # … with 32 more rows

Filter the results based on eg. site or release types:

``` r
filter_screenings(
  example_screenings_details, 
  sel_sites = "Cinema",  # Cinema & Kurbelkiste branch
  sel_release_types = c("2D OmU", "2D OV")
)
```

    #> # A tibble: 21 x 5
    #>    german_title                    dates      times release_types sites 
    #>    <chr>                           <chr>      <chr> <chr>         <chr> 
    #>  1 Der verlorene Sohn              2019-03-15 17:00 2D OmU        Cinema
    #>  2 The Sisters Brothers            2019-03-15 22:10 2D OmU        Cinema
    #>  3 The Sisters Brothers            2019-03-17 20:30 2D OmU        Cinema
    #>  4 We want Sex                     2019-03-18 18:00 2D OmU        Cinema
    #>  5 Beale Street                    2019-03-18 21:15 2D OmU        Cinema
    #>  6 Beale Street                    2019-03-19 16:10 2D OmU        Cinema
    #>  7 Oscar® Shorts 2019: Animation   2019-03-19 18:30 2D OmU        Cinema
    #>  8 Oscar® Shorts 2019: Live Action 2019-03-19 20:30 2D OmU        Cinema
    #>  9 Der Fall Sarah & Saleem         2019-03-14 16:35 2D OmU        Cinema
    #> 10 Der Fall Sarah & Saleem         2019-03-15 21:15 2D OmU        Cinema
    #> # … with 11 more rows

Decide which movies you’re interested in and retreive some/all IMDB
details:

``` r
imdb_details <- convert_movies("Der verlorene Sohn")

imdb_details
```

    #> # A tibble: 1 x 4
    #>   check_german_title english_title     imdb_id  imdb_url                   
    #>   <chr>              <chr>             <chr>    <chr>                      
    #> 1 Der verlorene Sohn Der verlorene So… tt70088… https://www.imdb.com/title…

``` r
imdb_details$imdb_id
```

    #> [1] "tt7008872"

``` r
my_movie_info <- get_mov_info_en(imdb_details$imdb_id)

cat(strwrap(my_movie_info$plot), sep = "\n")  # strwrap() and cat() to format output
```

    #> The son of a Baptist preacher is forced to participate in a
    #> church-supported gay conversion program after being forcibly outed
    #> to his parents.

Note: if you use `filter_movies()` function, it’ll give a warning
message for any unavailable details.

``` r
# this will give a fatal error:
dplyr::select(my_movie_info, title, hey, runtime, plot)
```

    #> Error in .f(.x[[i]], ...) : object 'hey' not found

``` r
# this returns a data frame for just the available details
filter_movies(my_movie_info, c("title", "hey", "runtime", "plot"))
```

    #> Warning in filter_movies(my_movie_info, c("title", "hey", "runtime", "plot")): Information on "hey" is not available.

    #> # A tibble: 1 x 3
    #>   title     runtime plot                                                   
    #>   <chr>       <dbl> <chr>                                                  
    #> 1 Boy Eras…     115 The son of a Baptist preacher is forced to participate…

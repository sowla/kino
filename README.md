
kino
====

{kino} was born out of my experience checking out English original soundtrack movie options in Münster. Understandably, the trailers and descriptions are in German, but searching for their English counterparts feels unnecessarily tedious - this should be automatable! The idea is to scrape screening and German movie information from cineplex.de and rating and English movie information from imdb.com and omdb's API. Eventually, I'll build a shiny app on top of this, so anyone can use it! :)

At the moment, the package is still under construction and only works with ["originals" movies in Münster](https://www.cineplex.de/filmreihe/originals/614/muenster/).

Installation
------------

You can install {kino} from github with:

``` r
# install.packages("remotes")
remotes::install_github("sowla/kino")
```

Here's how you might use {kino}
-------------------------------

First, select a city and checkout the available screening details:

``` r
library(kino)

my_city <- get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")

my_screenings_details <- get_screenings(my_city)

my_screenings_details
```

    #> # A tibble: 13 x 5
    #>    german_title                      dates    times release_types sites    
    #>    <chr>                             <chr>    <chr> <chr>         <chr>    
    #>  1 Westwood                          2018-12… 18:30 2D OmU        Schloßth…
    #>  2 Westwood                          2018-12… 13:10 2D OmU        Schloßth…
    #>  3 Aquaman                           2018-12… 22:15 3D OV         Cineplex 
    #>  4 Aquaman                           2018-12… 22:30 2D OV         Cineplex 
    #>  5 Phantastische Tierwesen: Grindel… 2018-12… 22:25 2D OV         Cineplex 
    #>  6 Mortal Engines: Krieg der Städte  2018-12… 22:45 2D OmU        Cineplex 
    #>  7 Bumblebee                         2018-12… 22:25 2D OV         Cineplex 
    #>  8 Bumblebee                         2018-12… 22:45 3D OV         Cineplex 
    #>  9 Widows - Tödliche Witwen          2018-12… 22:50 2D OmU        Cineplex 
    #> 10 Das krumme Haus                   2018-12… 22:15 2D OmU        Schloßth…
    #> 11 Aufbruch zum Mond                 2018-12… 22:30 2D OmU        Schloßth…
    #> 12 Frankenstein                      2018-12… 22:50 2D OV         Schloßth…
    #> 13 BTS World Tour Love Yourself in … 2019-01… 14:30 2D OV         Cineplex

Filter the results based on eg. site or release types:

``` r
filter_screenings(
  my_screenings_details, 
  sel_sites = "Cineplex", 
  sel_release_types = c("2D OmU", "2D OV")
)
```

    #> # A tibble: 6 x 5
    #>   german_title                         dates     times release_types sites 
    #>   <chr>                                <chr>     <chr> <chr>         <chr> 
    #> 1 Aquaman                              2018-12-… 22:30 2D OV         Cinep…
    #> 2 Phantastische Tierwesen: Grindelwal… 2018-12-… 22:25 2D OV         Cinep…
    #> 3 Mortal Engines: Krieg der Städte     2018-12-… 22:45 2D OmU        Cinep…
    #> 4 Bumblebee                            2018-12-… 22:25 2D OV         Cinep…
    #> 5 Widows - Tödliche Witwen             2018-12-… 22:50 2D OmU        Cinep…
    #> 6 BTS World Tour Love Yourself in Seo… 2019-01-… 14:30 2D OV         Cinep…

Decide which movies you're interested in and retreive some/all IMDB details:

``` r
imdb_details <- convert_movies("Widows - Tödliche Witwen")

imdb_details
```

    #> # A tibble: 1 x 4
    #>   check_german_title     english_title imdb_id  imdb_url                   
    #>   <chr>                  <chr>         <chr>    <chr>                      
    #> 1 Widows - Tödliche Wit… Widows        tt42185… https://www.imdb.com/title…

``` r
imdb_details$imdb_id
```

    #> [1] "tt4218572"

``` r
my_movie_info <- get_mov_info_en(imdb_details$imdb_id)

cat(strwrap(my_movie_info$plot), sep = "\n")  # strwrap() and cat() to format output
```

    #> Set in contemporary Chicago, amid a time of turmoil, four women
    #> with nothing in common except a debt left behind by their dead
    #> husbands' criminal activities, take fate into their own hands, and
    #> conspire to forge a future on their own terms.

Note: if you use `filter_movies()` function, it'll give a warning message for any unavailable details.

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
    #>   title  runtime plot                                                      
    #>   <chr>    <dbl> <chr>                                                     
    #> 1 Widows     129 Set in contemporary Chicago, amid a time of turmoil, four…

Note: at the moment, when you test this, you'll probably get results that look different from this particular example, which is rendered on 2018-12-19.. I plan to add sample data that you use to test the package, then I'll update the documentation so they fit.. thank you for your patience!

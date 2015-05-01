Kevin Dittmar and Anthony Ratliff
6 May 2014
README Documentation for the Game Recommendation Interface.

The files that make up this project include the following:
dark_background.png
footer.php
game_lengths_scraper.pl
game_lengths_search_parser.pl
index.css
index.php
Makefile
metacritic_scraper.pl
metacritic_search_parser.pl
RCS
README.txt 
reviews.css
reviews.js
webline.css

dark_background.png    
    This is the background image for the website.

footer.php
    Contains the browser compatibility webline and the line acknowledging the
sites from which we collected data.

game_lengths_scraper.pl
    This is the Perl script that scrapes information from GameLengths.com.
The data that it scrapes includes game genres and completion time data.  This
information is used by reviews.js to generate a recommendation for the user
based on his or her preferences.

game_lengths_search_parser.pl
    This is the Perl script that uses the title of the game selected by the
user in GameLengths.com's search engine to generate a list of potentially
matching links.  It selects the correct link if it fits into one of these
criteria (game title is the title retrieved from Metacritic):
1) The main link text matches the game title when spaces, punctuation, and
annotations (text in parentheses after the title) are removed.  Also, for
the sake of consistency across Metacritic and GameLengths, the Roman numerals
II, III, and IV are turned into their Arabic equivalents for link matching.
2) The text in parentheses matches the annotation, which occurs when a game
has multiple titles depending on region.

index.css
    Styles the majority of the page, including the generated links,
the search area, the buttons, and the recent searches list.

index.php
    This is the primary HTML file as well as the file that handles the
session data required to keep track of a list of recent searches.  This
PHP file is also the root page for the website and the master file that
runs all of the Perl scripts to generate website data.  This file contains
the group of checkboxes for user preferences, the search field, the recent
search links,  and the recommendations.

Makefile
    Makes it easy to install all of the necessary files from the source
directory to the public directory.

metacritic_scraper.pl
    This Perl script scrapes all of the data from Metacritic.com for a given
game.  This data includes the number of critic reviews, the number of user
reviews, the average critic score, the average user score, a summary for the
game, developer information, ESRB rating information the number of players 
possible, and a sample of reviews from Metacritic users and critics.  It is
possible that some of this data may not be present on the Metacritic page, so
it can't be scraped.  The reviews and ratings scraped form a basis for the
base game recommendation.

metacritic_search_parser.pl
    This Perl script takes a URL to a search results page for Metacritic.com
and generates a list of links of potentially matching games.  It is up to the
user of this site to select the link corresponding to the game that they want,
just like in a normal search engine.  If a user submits an empty search, the
list of links will be composed of the most recent and most popular games on
Metacritic.  If the search term does not match any of the games in Metacritic's
database, then no links are generated and an error message is printed.  This
error message asks the user to try again.

RCS
    The directory where all revisions of all files for this project are stored.

README.txt
    This file.

reviews.css
    This CSS file is responsible for color coding the user and critic reviews,
giving the div fields for reviews borders, and placing the buttons that
correspond with the review pagination.

reviews.js
    This JavaScript file allows the user to iterate through critic and user
reviews one at a time forward or backward.  It also generates the message
that recommends the game to the user.  If the game is bad, it is recommended
that the user not buy the game according to a message near the bottom of the
web page.  Similarly appropriate results are produced for games with higher
scores.  In other words, a really good game will get a "Buy it now!"
recommendation.  reviews.js also weights the game's score based on the user's
selected preferences, and it updates the weighted recommendation score
whenever the user changes his or her preferences.

webline.css
    This CSS file puts the compatibility and validation webline into a nicely
styled table.

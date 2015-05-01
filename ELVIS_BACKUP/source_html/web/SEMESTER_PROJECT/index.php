<!--Kevin Dittmar and Anthony Ratliff
    6 May 2014
    The main page of the website.  Accepts all user input and
    displays reviews, recommendations, and other information.
    This PHP file gets all of that data from the Perl scripts,
    which are called by this file. 
-->

<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">

<head>
    <script type="text/javascript"
          src="http://code.jquery.com/jquery-1.9.0.min.js"> </script>
    <script type="text/javascript" src="reviews.js"> </script>
    <link rel="stylesheet" href="reviews.css" />
    <link rel="stylesheet" href="webline.css" />
    <link rel="stylesheet" href="index.css" />
    <title>Game Recommendation Interface</title>
    <meta name="Author" content="Kevin Dittmar" />
    <meta name="Author" content="Anthony Ratliff" />
    <meta name="generator" content="vi" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body onload="initialize();">
    <?php
        //Make sure we are not resetting the session.
        if (session_id() == '') {
            session_start();
        }
        //This first block is for storing the searched games during a session
        if(isset($_GET['URL']))//Make sure there is a GET parameter
        {
            //A search has already been done.
            if(isset($_SESSION['searchHistory'])) {
                $newSearchArray =  $_SESSION['searchHistory'];
                $newgameArray = $_SESSION['gamenameHistory'];
            }
            $newSearch = $_GET['URL'];
            $newgame = $_GET['gamename'];
            //If no search has been done, create a new array and store it.
            if(empty($newSearchArray)) {
                $newSearchArray = array($newSearch);
                $_SESSION['searchHistory'] = $newSearchArray;
                $newgameArray = array($newgame);
                $_SESSION['gamenameHistory'] = $newgameArray;
            }
            //Check to see that less than 5 searches have been done.
            elseif(!array_key_exists(4,$newSearchArray)) {
                for($i = 0; $i<=4; $i++) {
                    //If we find an empty place, push the value onto the array.
                    if(!array_key_exists($i,$newSearchArray)) {
                        array_push($newSearchArray,$newSearch);
                        $_SESSION['searchHistory'] = $newSearchArray;
                        array_push($newgameArray,$newgame);
                        $_SESSION['gamenameHistory'] = $newgameArray;
                        break;
                    }
                    //If we find a duplicate, break.
                    if($newSearchArray[$i] == $newSearch) {
                        break;
                    }
                }
            }
            //We know that 5 searches have been done.
            else { 
                $alreadyExists = False;
                //Check to see if the game is already in the array.
                for($i = 0; $i<=4; $i++) {
                    if($newSearchArray[$i] == $newSearch) {
                        $alreadyExists = True;
                        break;
                    }
                }
                //If the game is not already saved...
                if(!$alreadyExists) {
                    for($i = 0; $i<4; $i++) {
                        $j = $i+1;
                        //Shift the array contents back one.
                        $newSearchArray[$i] = $newSearchArray[$j];
                        $newgameArray[$i] = $newgameArray[$j];
                    }
                    //and set the last index to the new value.
                    $newSearchArray[4] = $newSearch;
                    $_SESSION['searchHistory'] =  $newSearchArray;
                    $newgameArray[4] = $newgame;
                    $_SESSION['gamenameHistory'] = $newgameArray;
                }
            }
        }

        //Print the recent searches in a table
        if(isset($_SESSION['searchHistory'])) {
            echo '<div id="recentsearches">';
            echo '<table>
                  <tr><th>Recent Searches</th></tr>';
            for($i = 0; $i<5; $i++) {
                if(isset($_SESSION['searchHistory'][$i])) {
                    echo '<tr>';
                    echo '<td><a href="./index.php?URL=' . 
                        $_SESSION['searchHistory'][$i] . '&amp;gamename=' . 
                        $_SESSION['gamenameHistory'][$i] . '">' . 
                        $_SESSION['gamenameHistory'][$i] .  '</a> </td>';
                    echo '</tr>';
                }
            }
            echo '</table>';
            echo '</div>';
        }
    ?> 

    <div id="search">
        <a href = "./">Home</a>
        <form action="index.php" method="get">
            Game Name:
            <input type="text" name="search"/>
            <input type="submit" class="button" value="Search for Game"/>
            <br />
            Preferences:
            <br />
            <div id="preferences">
                <input type="checkbox" name="length[]" value="longgame" class="preference"/>
                <label>Long Games:</label>
                <input type="checkbox" name="length[]" value="shortgame" class="preference"/>
                <label>Short Games:</label>
                <br /> 
                Genre: 
                <br />
                <input type="checkbox" name="genre[]" value="Action" class="preference"/>
                <label>Action</label>

                <input type="checkbox" name="genre[]" value="RPG" class="preference"/>
                <label>RPG</label>

                <input type="checkbox" name="genre[]" value="FPS" class="preference"/>
                <label>First Person Shooter</label>
                <br/>

                <input type="checkbox" name="genre[]" value="3rd-Person-Shooter" class="preference"/>
                <label>Third Person Shooter</label>
     
                <input type="checkbox" name="genre[]" value="Simulation" class="preference"/>
                <label>Simulation</label>
                <br/>
        
                <input type="checkbox" name="genre[]" value="Strategy" class="preference"/>
                <label>Strategy</label>
        
                <input type="checkbox" name="genre[]" value="Adventure" class="preference"/>
                <label>Adventure</label>

                <input type="checkbox" name="genre[]" value="Sports" class="preference"/>
                <label>Sports</label>
                <br/>

                <input type="checkbox" name="genre[]" value="Platformer" class="preference"/>
                <label>Platformer</label>
            </div>
        </form>
    </div>
    <div id="content">
        <?php
            //If search is set, that means that we are trying to search for a game.
            //Bring up a list of search results from metacritic.
            if(isset($_GET['search']))
            {
                echo '<h2>Please choose which game you want to see:</h2>';
                //Make the url in form 
                //http://www.metacritic.com/search/game/search+terms/results
                $searchURL = str_replace(" ", "+",trim($_GET['search']));
                $searchURL = "http://www.metacritic.com/search/game/$searchURL/results";
                $matching_links = shell_exec("perl ./metacritic_search_parser.pl $searchURL");
                echo $matching_links;
            }
        ?>

        <?php
            //If URL is set, we know what page the user wants to look at
            if (isset($_GET['URL']) && isset($_GET['gamename'])) {
                echo '<h1>' . $_GET['gamename'] . '</h1>';
                //Grab the page date from Metacritic
                //Make the url in the form 
                //http://www.metacritic.com/game/platform/game-title
                $metacriticURL = $_GET["URL"];
                $metacriticURL = "http://www.metacritic.com/game/$metacriticURL";
                $metacritic = shell_exec("perl ./metacritic_scraper.pl $metacriticURL");

                //Grab the length data from gamelengths.com
                $gamename = str_replace("%20", "+",trim($_GET['gamename']));
                $gamename = str_replace(" ", "+",trim($_GET['gamename']));
                $gameLengthsURL = 'http://www.gamelengths.com/sitesearch/newSearch/?gameName='. $gamename;
                $game_lengths = shell_exec("perl ./game_lengths_search_parser.pl $gameLengthsURL $gamename");
                echo $game_lengths;
                echo $metacritic;
                echo '<div id="highlyRecommended" class="recommendation">
                        Everyone loves this game.  Go get it.  Now.
                      </div>

                      <div id="recommended" class="recommendation">
                        This one is a solid B.
                      </div>

                      <div id="mildlyRecommended" class="recommendation">
                        Meh.  You might like it.  Go watch a few YouTube videos
                        and come back.
                      </div>

                      <div id="notReallyRecommended" class="recommendation">
                        I dunno about this one.  Well, maybe if you think it
                        looks cool...
                      </div>

                      <div id="notRecommended" class="recommendation">
                        THIS GAME IS THE SPAWN OF SATAN!  STAY AWAY!
                      </div>
                      <div id ="noRecommendation" class = "recommendation">
                        There is not enough information to make a recommendation.
                      </div>';
            }
            echo '</div>';
            require 'footer.php';
        ?>
    </body>
</html>

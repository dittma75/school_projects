#! /usr/bin/perl -w
#
# Kevin Dittmar and Anthony Ratliff
# 6 May 2014
# Scrape the Metacritic data for the given game
# and generate HTML to be used by the PHP file
# index.php to display the game's data.

use strict;
use warnings;
use CGI;
use WWW::Mechanize;     # This is the object that gets stuff
use HTML::TokeParser;   # This is the object that parses HTML

#HTML::Entities information from:
#http://search.cpan.org/dist/HTML-Parser/lib/HTML/Entities.pm
#Used to correctly parse special HTML characters in summaries
#and reviews.
use HTML::Entities;

# create new web agent and get a page
my $agent = WWW::Mechanize->new();

if (defined($ARGV[0]))
{
    $agent->get($ARGV[0]);
}
else
{
    die "Requires a valid Metacritic page URL.";
}

my $cgi = CGI->new;
my $stream = HTML::TokeParser->new(\$agent->{content});
my $tag = $stream->get_tag();

#Make sure that we don't get stuck in an infinite loop.
my $timeout_counter = 1000;
&scrapeMetacritic();

#Scrape the Metacritic site for useful game data.
sub scrapeMetacritic()
{
    my @critic_data = &parseCriticData();
    my $critic_score = $critic_data[0];
    my $critic_ratings = $critic_data[1];

    my @user_data = &parseUserData();
    my $user_score = $user_data[0];
    my $user_ratings = $user_data[1];
    
    my $summary = &getSummary();
    
    my $game_info = &getGameInfo();
    
    #We should differentiate between a score of 0
    #and no critic scores at all.
    my $c_score_text;
    if ($critic_ratings == 0)
    {
        $c_score_text = "TBD";
    }
    else
    {
        $c_score_text = $critic_score."/100";
    }

    #We should differentiate between a score of 0
    #and no user scores at all.
    my $u_score_text;
    if ($user_ratings == 0)
    {
        $u_score_text = "TBD";
    }
    else
    {
        $u_score_text = $user_score."/10";
    }

    print '<table id="score">', "\n",
          "<caption>Scoring Information</caption>\n",
          "<tr><td>Critic Ratings:</td><td>".$critic_ratings."</td></tr>\n",
          "<tr><td>Average Critic Score:</td><td>".$c_score_text."</td></tr>\n",
          "<tr><td>User Ratings:</td><td>".$user_ratings."</td></tr>\n",
          "<tr><td>Average User Score:</td><td>".$u_score_text."</td></tr>\n",
          "</table>\n<br/>\n";

    print $game_info;

    print $summary;

    print &getCriticReviews();
    print &getUserReviews();
    
    &determineScore($critic_score, $user_score);
}

#Scrape the critic rating data, including the number of ratings
#and the average rating score, and return them.
#
#Returns an array containing ($critic_score, $critic_ratings).
sub parseCriticData()
{
    my $critic_score = 0;
    my $critic_ratings = 0;
    #The average critic rating is in a div with the "label" class.
    $tag = $stream->get_tag("div");
    while(!$tag->[1]{class} or
          ($tag->[1]{class} and $tag->[1]{class} ne "label"))
    {
        $tag = $stream->get_tag("div");
        &timeout();
    }
    #If the span tag exists, it has an itemprop of "ratingValue" and holds
    #the average critic rating for the game.
    $tag = $stream->get_tag("span");
    if ($tag->[1]{itemprop} and ($tag->[1]{itemprop} eq "ratingValue"))
    {
        $critic_score = $stream->get_trimmed_text;
    }   
    #There aren't enough critic ratings yet.             
    else
    {
        $critic_score = 0;
    }
    #The count of critic reviews is in the span tag after the next a tag.
    $tag = $stream->get_tag("a");
    $tag = $stream->get_tag("span");
    $critic_ratings = $stream->get_trimmed_text;
    
    return ($critic_score, $critic_ratings);
}

#Scrape the user rating data, including the number of ratings
#and the average rating score, and return them.
#
#Returns the an array containing ($user_score, $user_ratings).
sub parseUserData()
{
    my $user_score = 0;
    my $user_ratings = 0;
    while (!$tag->[1]{class} or
           ($tag->[1]{class} and $tag->[1]{class} ne "details side_details"))
    {
        $tag = $stream->get_tag("div");
        &timeout();
    }
    #The next tag after the div with class "details side_details" will have
    #a class "score_summary" if the user score is defined.
    $tag = $stream->get_tag();
    if ($tag->[1]{class} and $tag->[1]{class} eq "score_summary")
    {
        #The average user review for the game is in the div tag after an a tag
        #with a class named metascore_anchor.
        while (!$tag->[1]{class} or
               ($tag->[1]{class} and $tag->[1]{class} ne "metascore_anchor"))
        {
            $tag = $stream->get_tag("a");
            &timeout();
        }
        $tag = $stream->get_tag("div");
        
        $user_score = $stream->get_trimmed_text;

        #The number of user reviews are in a span tag whose class is "desc".
        while (!$tag->[1]{class} or
               ($tag->[1]{class} and $tag->[1]{class} ne "desc"))
        {
            $tag = $stream->get_tag("span");
            &timeout();
        }
        #If there isn't a placeholder of "No user score yet", get the
        #number of user ratings.
        if ($stream->get_trimmed_text ne "No user score yet")
        {
            $tag = $stream->get_tag("a");
            $user_ratings = $stream->get_trimmed_text;
            #Remove the word "Ratings" from the end of the number.
            $user_ratings =~ s/ Ratings//g;
        }
        #There are no ratings.
        else
        {
            $user_ratings = 0;
        }
    }
    #The game doesn't even have a User Ratings section on its page.
    else
    {
        $user_score = 0;
        $user_ratings = 0;
    }
    return ($user_score, $user_ratings);
}

#Scrape and return the summary for the game in a p tag if it exists.
sub getSummary()
{
    my $summary = "";
    while (!$tag->[1]{class} or
           ($tag->[1]{class} and $tag->[1]{class} ne "summary_details"))
    {
        $tag = $stream->get_tag("ul");
        &timeout();
    }
    #If the summary section exists, it is in the next list item tag,
    #which has the class "summary_detail product_summary".
    $tag = $stream->get_tag("li");
    if ($tag->[1]{class} and 
        $tag->[1]{class} eq "summary_detail product_summary")
    {
        #Two span tags after the ul tag with the class "summary_details" will
        #have the itemprop "description" if a summary for the game exists on the
        #page.
        $tag = $stream->get_tag("span");
        $tag = $stream->get_tag("span");

        if ($tag->[1]{itemprop} and $tag->[1]{itemprop} eq "description")
        {
            #The description for the game is in a span tag within the description
            #span tag if it is short enough that it doesn't need an "Expand" link
            #on Metacritic.
            $tag = $stream->get_tag("span");
            $summary = $stream->get_trimmed_text;
            #If the summary is too long, it is split into two span tags after the
            #description span tag.  Therefore, summary is empty right now and
            #needs to be filled from the text in the next two span tags.
            if ($summary eq "")
            {
                $tag = $stream->get_tag("span");
                $summary = $stream->get_trimmed_text;
                $tag = $stream->get_tag("span");
                $summary .= " ".$stream->get_trimmed_text;
            }
            return $cgi->p("Summary:  ".encode_entities($summary))."\n";
        }
        #The game doesn't have a summary on its Metacritic page.
        else
        {
            return $cgi->p("No summary available.")."\n";
        }
    }
    #The game doesn't even have a summary section on its Metacritic page.
    else
    {
        return $cgi->p("No summary available.")."\n";
    }
}

#Scrape and return the game info, including developer, genre, and ESRB
#rating in a table where applicable.  These fields are list items in 
#an unordered list.
sub getGameInfo()
{
    my $game_info = "";
    #The list of game information starts in the list item whose class list
    #contains the class named "summary_detail developer".
    #Perl index function from:
    #http://stackoverflow.com/questions/7011524/perl-if-string-contains-text
    while (!$tag->[1]{class} or
           ($tag->[1]{class} and 
           (index($tag->[1]{class}, "summary_detail") == -1)))
    {
        $tag = $stream->get_tag("li");
        &timeout();
    }
    
    #The information list ends when the next li tag is a score counter
    #for the game reviews.
    while (!$tag->[1]{class} or
           ($tag->[1]{class} and 
           ($tag->[1]{class} ne "summary_detail more")))
    {
        #It isn't necessary to print the link to GameFAQs or the genres
        #from Metacritic, since the genres are usually "Sci-fi" or "Modern"
        #for no good reason.
        if ($tag->[1]{class} and 
            $tag->[1]{class} ne "summary_detail product_cheats" and
            $tag->[1]{class} ne "summary_detail product_genre")
        {
            #The information in the game information list is in two parts.
            #There is a span tag for the descriptor and a span tag for the
            #information.

            #First comes the information descriptor.
            $tag = $stream->get_tag("span");
            my $descriptor = $stream->get_trimmed_text;
        
            #Then comes the data that matches the descriptor.
            $tag = $stream->get_tag("span");
            my $data = $stream->get_trimmed_text;

            #Add the descriptor and information to the table.
            $game_info .= "<tr><td>".$descriptor."</td><td>".$data."</td></tr>\n";
        }
        $tag = $stream->get_tag("li");
        &timeout();
    }
    if ($game_info ne "")
    {
        return '<table id="game_data">'.
               "\n<caption>Game Information</caption>\n".
                $game_info."</table>\n";
    }
    else
    {
        return $cgi->p("No game information available.");
    }
}

#Returns the critic review data, including the reviewer, the score,
#the date reviewed, and the summary all wrapped in their own divs.
#Each div has an id and a class to make it easier to page through them
#with JavaScript.
sub getCriticReviews()
{
    my $result = "";
    my $counter = 0;
    my $id = "";
    #Infinite loop until return.
    while (0 == 0)
    {
        #Find the next critic review div.
        while (!$tag->[1]{class} or
               ($tag->[1]{class} and $tag->[1]{class} ne "review_critic"))
        {
            #If we didn't find a critic review div, but we found the div
            #for the next review section, break out of function - finished
            #critic reviews.
            if ($tag->[1]{class} and
                $tag->[1]{class} eq "module reviews_module user_reviews_module")
            {
                return $result;
            }
            #We didn't find a critic review or the end of the reviews, so
            #keep going.
            $tag = $stream->get_tag("div");
            &timeout();
        }
        if ($counter == 0)
        {
            &generateButtons("critic");
        }
        
        #Add the next critic review to the list.
        $result .= &parseReview("critic", $counter);
        
        #Increment counter.
        $counter++;
    }
}

#Returns the user review data, including the reviewer, the score,
#the date reviewed, and the summary all wrapped in their own divs.
#Each div has an id and a class to make it easier to page through them
#with JavaScript.
sub getUserReviews()
{
    my $result = "";
    my $counter = 0;
    my $id = "";
    my $review = "";
    #Infinite loop until return.
    while (0 == 0)
    {
        #Find the next critic review div.
        while (!$tag->[1]{class} or
               ($tag->[1]{class} and $tag->[1]{class} ne "review_critic"))
        {
            #If we didn't find a user review div, but we found the div
            #for the providers box at the bottom, then we should return
            #the reviews.  This is okay since user reviews are the last
            #thing that we need to get.
            if ($tag->[1]{id} and $tag->[1]{id} eq "providers")
            {
                return $result;
            }
            #We didn't find a critic review or the end of the reviews, so
            #keep going.
            $tag = $stream->get_tag("div");
            &timeout();
        }
        if ($counter == 0)
        {
           &generateButtons("user");
        }

        #Parse the next user review and add it to the list.
        $result .= &parseReview("user", $counter); 

        #Increment counter.
        $counter++;
        &timeout();
    }
}

#Return the data for the next critic review or user review on the page.
sub parseReview()
{
    #Critic reviews are out of 100; user reviews are out of 10.
    my ($type, $counter) = @_;
    my $max_score;
    my $css_data;
    if ($type eq "critic")
    {
        $max_score = 100;
        $css_data = 'id="critic'.$counter.'" class="critic_review ';
    }
    else
    {
        $max_score = 10;
        $css_data = 'id="user'.$counter.'" class="user_review ';
    }
    my $review = "";
    #Reviewer name is text for the next a tag.
    $tag = $stream->get_tag("a");
    $review .= "Reviewer:  ".$stream->get_trimmed_text."<br/>\n";
    #Review score and/or Date Reviewed may not be present for old entries.
    while (!$tag->[1]{class} or
           ($tag->[1]{class} and $tag->[1]{class} ne "review_body"))
    {
        if ($tag->[1]{class} and $tag->[1]{class} eq "date")
        {
            #Review date is text in the div tag with class "date".
            $review .= "Date Reviewed:  ".$stream->get_trimmed_text."<br/>\n";
        }
        if ($tag->[1]{class} and $tag->[1]{class} eq "review_grade")
        {
            #Review score out of 10 is text in the div after
            #the div with class "review_grade".
            $tag = $stream->get_tag("div");
            my $score = $stream->get_trimmed_text;
            $review .= "Rating:  ".$score."/".$max_score."<br/>\n";
            $css_data .= &interpretScore($score/$max_score);
        }
        $tag = $stream->get_tag("div");
        &timeout();
    }
    #Review summary might be in the div with class "review_body".
    my $summary = $stream->get_trimmed_text;
    if ($summary eq "")
    {
        #It's not in the div, maybe it's in the next span.
        $tag = $stream->get_tag("span");
        $summary = $stream->get_trimmed_text;
        
        #If the review is a two-part review collapsed, it is
        #separated across the next two span tags.
        if ($summary eq "")
        {
            $tag = $stream->get_tag("span");
            $summary = $stream->get_trimmed_text;
            $tag = $stream->get_tag("span");
            $summary .= " ".$stream->get_trimmed_text;
        }
    }
    $review .= $cgi->p("Review:  ".encode_entities($summary));
    return "<div ".$css_data.">\n".$review."\n</div>\n";
}

#Generates the buttons for paging through reviews.
sub generateButtons()
{
    #The buttons can be for paging through user reviews or critic reviews.
    my ($review_type) = @_;
    #CGI button information from:
    #http://perldoc.perl.org/CGI.html
    print "<br/>\n";
    print $cgi->button(-name=>'last_'.lc($review_type).'_review',
                       -class=>'previous button',
                       -value=>'Previous '.ucfirst($review_type).' Review',
                       -onClick=>"last".ucfirst($review_type)."Review();");
    print "\n";
    print $cgi->button(-name=>'next_'.lc($review_type).'_review',
                       -class=>'next button',
                       -value=>'Next '.ucfirst($review_type).' Review',
                       -onClick=>"next".ucfirst($review_type)."Review();");
    print "\n<br/>\n";
}

#Interprets the score based on the ratio.
#Less than half of the available points is bad,
#between 50% and 75% of the available points is average,
#and more than 75% of the available points is good.
#
#Note:  Each case needs to end the double-quote for the
#HTML class string.
sub interpretScore()
{
    my ($ratio) = @_;
    if ($ratio > .75)
    {
        return 'good_score"';
    }
    elsif ($ratio > .5)
    {
        return 'average_score"';
    }
    else
    {
        return 'bad_score"';
    }
}

#Determines an aggregate score between 0 and 100 for use in
#generating a recommendation with JavaScript.
sub determineScore()
{
    my ($critic_score, $user_score) = @_;
    #Since critic scores are out of 100 points and user scores
    #are out of 10 points, make the user score match the critic
    #score by multipllying by 10.
    $user_score *= 10;
    
    my $judgment_score;

    #Don't use the user score if it's 0.
    if ($critic_score != 0 && $user_score == 0)
    {
        $judgment_score = $critic_score;
    }
    #Don't use the critic score if it's 0.
    elsif ($user_score != 0 && $critic_score == 0)
    {
        $judgment_score = $user_score
    }
    #Either both scores are defined, or neither is defined.  Either
    #way, this formula will produce the right result.
    else
    {    
        $judgment_score = ($critic_score + $user_score) / 2;
    }
    print "<br/>\n", $cgi->div({-id=>'aggregate_score'},$judgment_score), "\n";
}

#Monitors the timeout counter to see if a loop is taking
#too long.
sub timeout()
{
    $timeout_counter--;
    if ($timeout_counter <= 0)
    {
        #$timeout_counter = 1000;
        #last;
        die("Problem with Metacritic webpage; stopped.");
    }
}

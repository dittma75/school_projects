#! /usr/bin/perl -w
#Kevin Dittmar and Anthony Ratliff
#6 May 2014
#Matches the given game name to a link on the given search
#page.  The link that matches is then sent to the game_lengths_scraper.pl
#to be scraped for data.

use strict;
use warnings;
use CGI;
use WWW::Mechanize;     # This is the object that gets stuff
use HTML::TokeParser;   # This is the object that parses HTML

# create new web agent and get a page
my $agent = WWW::Mechanize->new();

#Perl command line argument reading information from:
#http://stackoverflow.com/questions/361752/how-can-i-pass-command-line-arguments-to-a-perl-program

if (!defined($ARGV[0]) || !defined($ARGV[1]))
{
    die "Requires a valid GameLengths search URL and a game name.";
}

$agent->get($ARGV[0]);

my $game_title = $ARGV[1];

my $comparison_title = &format_title($game_title);

my $cgi = CGI->new;
my $stream = HTML::TokeParser->new(\$agent->{content});

#This is the base URL for the GameLengths website.
my $root_url = "http://www.gamelengths.com/";

#All of the links are in the only table on the page.
my $tag = $stream->get_tag("table");
#Stores the title of the game from the current link.
my $link_title = "";
my $alt_link_title = "";

#Make sure that we don't get stuck in an infinite loop.
my $timeout_counter = 1000;
#There is a link at the bottom of the page that goes to the "about"
#section.  If we haven't found our game by the time we reach the link with the
#text "about", then we are not going to find it, so we should stop searching.
while (($link_title ne $comparison_title) and
       ($alt_link_title ne $comparison_title ) and
       ($link_title ne "about"))
{
    $tag = $stream->get_tag("a");
    my $text = $stream->get_trimmed_text;
    my $alt_text = $text;
    $link_title = &format_title($text);
    
    #Take everything up to the left parenthesis out and test the contents
    #of the parentheses as an alternative title match.
    $alt_text =~ s/.*\(//g;
    $alt_link_title = &format_title($alt_text);
    &timeout;
}

#If we stopped on the "about" link, then we don't want to try to parse times.
if ($link_title ne "about")
{
    #We have the link we want in the current tag, regardless of whether 
    #it was the main title or the alternative title that matched.
    system("perl ./game_lengths_scraper.pl ".$root_url.$tag->[1]{'href'});
}
else
{
    print $cgi->p("No playtime information or genre information available.");
}

#Remove all characters that would impede link matching from the
#given title and return the title without any special punctuation.
sub format_title()
{
    my ($title) = @_; 
    my $number = $title;
    #GameLengths sometimes adds extra information in ()s.
    #It should be removed.
    $title =~ s/\(.*\)//g;
    #Remove punctuation regexp from:
    #http://stackoverflow.com/questions/3614686/removing-punctuation-from-string-in-perl
    $title =~ s/[[:punct:]]//g;
    $title =~ s/ //g;   #Remove spaces.
    return lc(roman_to_arabic($title));
}

#Some GameLengths games use Arabic numerals whereas
#the counterpart entry in Metacritic uses Roman numerals.
#Since everyone seems to agree for everything except
#two, three, and four, we only need to handle turning
#II to 2, III to 3, and IV to 4.
sub roman_to_arabic()
{
    my ($title) = @_;
    $title =~ s/IV/4/g;
    $title =~ s/III/3/g;
    $title =~ s/II/2/g;
    return $title;
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
        die("No info on GameLengths; stopped.");
    }
}

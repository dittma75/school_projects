#! /usr/bin/perl -w
#Kevin Dittmar and Anthony Ratliff
#6 May 2014
#Reads a search results page from Metacritic and
#prints a list of URLs to games that match the search.
#This URL is then passed to the metacritic_scraper.pl by
#index.php.
use strict;
use warnings;
use CGI;
use WWW::Mechanize;     # This is the object that gets stuff
use HTML::TokeParser;   # This is the object that parses HTML
use Data::Dumper;

# create new web agent and get a page
my $agent = WWW::Mechanize->new();

#Perl command line argument reading information from:
#http://stackoverflow.com/questions/361752/how-can-i-pass-command-line-arguments-to-a-perl-program
if (!defined($ARGV[0]))
{
    die "Requires a valid Metacritic search URL.";
}

my ($url) = $ARGV[0];
$agent->get($url);

my $cgi = CGI->new;
my $stream = HTML::TokeParser->new(\$agent->{content});
my $link_list = "";

#Counter to make sure that we don't enter an infinite loop.
my $timeout_counter = 1000;

#This is the search url base for metacritic.com
my $root_url = "./index.php";
my $tag = $stream->get_tag("h3");
while (defined($tag))
{
    $tag = $stream->get_tag("a");
    my $game_title = $stream->get_trimmed_text;
    #url is path to the PHP script that processes the game
    #along with the necessary params.
    #It looks like:
    #"./index.php?URL=platform/metacritic_page_title&gamename=game_title"
    my $url = "?URL=".$tag->[1]{'href'}."&gamename=".$game_title;
    #Perl split information:
    #http://perldoc.perl.org/functions/split.html
    #The URL format is /game/platform/rest_of_string, so the
    #0th element will be the empty string, the
    #1st element will be the string "game", and the
    #2nd element will be the platform for the game.
    my @split_url = split(/\//, $url);

    #The platform for the game will always be the 2nd element.
    my $platform = $split_url[2];

    #Perl uc (uppercase) information:
    #http://perl.about.com/od/programmingperl/qt/perluc.htm
    my $link_text = $game_title."[".uc($platform)."]";
    $link_list .= $cgi->a({href => $root_url.$url}, $link_text)."<br/>\n";
    $tag = $stream->get_tag("h3");
    #&timeout();
}
#Information on Perl Regular Expressions:
#http://www.regular-expressions.info/perl.html
#Remove all occurences of /game/ from the list of links.
$link_list =~ s!/game/!!g;
if ($link_list eq "")
{
    print "No search results - please try another term.";
}
print $link_list;

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

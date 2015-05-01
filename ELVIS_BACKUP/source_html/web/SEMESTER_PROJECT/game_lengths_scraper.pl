#! /usr/bin/perl -w
#
# By Kevin Dittmar and Anthony Ratliff
# 6 May 2014
# Scrapes the playtime information and genre information
# off of the GameLengths.com website.

use strict;
use warnings;
use CGI;
use WWW::Mechanize;     # This is the object that gets stuff
use HTML::TokeParser;   # This is the object that parses HTML

# create new web agent and get a page
my $agent = WWW::Mechanize->new();
if (defined($ARGV[0]))
{
    $agent->get($ARGV[0]);
}
else
{
    die "Requires a valid GameLengths URL.";
}

my $cgi = CGI->new;
my $stream = HTML::TokeParser->new(\$agent->{content});

#Make sure we don't get stuck in an infinite loop.
my $timeout_counter = 1000;

#The genre information is in a table after the h3 tag with "Game Info".
my $tag = $stream->get_tag("h3");
$tag = $stream->get_tag("table");

#The genre information is in a table header with the text "Genre".
while ($stream->get_trimmed_text ne "Genre")
{
    $tag = $stream->get_tag("th");
    &timeout();
}

#The genre information is in the next table data element.
$tag = $stream->get_tag("td");
my $genres = $stream->get_trimmed_text;
while (!$tag->[1]{class} or
       ($tag->[1]{class} and $tag->[1]{class} ne "span3 time-box"))
{
    $tag = $stream->get_tag("div");
    &timeout();
}
my @headers = ("Average Time", "Minimum Time", "Maximum Time");
print '<table id="playtime">'."\n<caption>Playtime Information</caption>\n";

for (my $i = 0; $i < 3; $i++)
{
    $tag = $stream->get_tag("span");
    print "<tr><td>".$headers[$i].'</td><td class="time">',
          $stream->get_trimmed_text." Hours</td></tr>\n";
}
print "</table>\n<br/>\n";

#Print the genres in their own div.
print "<div>Genre(s):  ".$cgi->span({-id=>"genres"}, $genres)."</div>\n<br/>\n";

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

#! /usr/bin/perl -w

# SMBC Comic Scraper
# CGI Basis by D Provine
# Modified by Kevin Dittmar 3 March 2014

use strict;
use CGI;

use WWW::Mechanize;     # This is the object that gets stuff
use HTML::TokeParser;   # This is the object that parses HTML
use DateTime;			# Date package

# create new web agent and get a page
my $agent = WWW::Mechanize->new();
my $address = "http://www.smbc-comics.com/";
$agent->get($address);

# create new HTML parser and get the content from the web agent
my $stream = HTML::TokeParser->new(\$agent->{content});

# Stores the current date to be used for finding yesterday's
# comic until there is a week's worth of comics.
my $date = DateTime->now;

#################### Start of Comic HTML to Scrape #######################

#Main comic looks like this:
#<!-- Begin COMIC image -->
#
#<div id="comicimage">
#	<img src='http://www.smbc-comics.com/comics/20140301.png'>	   
#</div>
#<!-- End COMIC image -->

#Bonus panel looks like this:
#<div id="aftercomic" 
#	style="position:absolute;
#	z-index:10; display:none" 
#	onMouseDown='hideBlock("aftercomic")'
#>
#	<img src='http://www.smbc-comics.com/comics/20140301after.gif'>
#</div>


#Hidden comic looks like this:
#<div id="konamicomic"
#   style="position:absolute;
#   left:95px;
#   top:400px;
#   z-index:15;
#   display:none"
#   onMouseDown='hideBlock("konamicomic")'
#>
#   <img src='/images/videogamezach.gif'
#       style='border:3px solid black'
#       onMouseDown='hideBlock("konamicomic")'
#   >
#</div>

###################### End of Comic HTML to Scrape #######################

#Initializes the CGI.
my $cgi = new CGI;
#Stores the src for the site's hidden comic.
my $hidden_source;

#Information for including multiple stylesheets came from:
#http://stackoverflow.com/questions/7070873/can-cgis-start-html-method-have-multiple-script-attributes
print $cgi->header(-type=>'text/html', -author =>'Kevin Dittmar');

print $cgi->start_html(-title =>'A Week of SMBC Comics',
		 -author => 'dittma75@students.rowan.edu',
		 -style => [{src => 'webline.css'},{src => 'layout699-.css'},
			{src=>'layout700+.css'}]);

#################### Start of Helper Functions ###############################
#Get the main cartoon from the SMBC website.
sub add_main_cartoon()
{
	#Create new HTML parser and get the content from the web agent
    my $stream = HTML::TokeParser->new(\$agent->{content});

    #Get the first "div" tag to setup the loop.
    my $tag = $stream->get_tag("div");
	
	#Advance to the div with the main cartoon:
    while ($tag->[1]{id} and $tag->[1]{id} ne 'comicbody') {
    	$tag = $stream->get_tag("div");
    }

	#Get the main cartoon:
    my $toon = $stream->get_tag("img");

	#Get the source from the "img" tag:
    my $src = $address.$toon->[1]{'src'};
	my $alt = $toon->[1]{'title'};
	
	print $cgi->h2("Main Comic from ".sprintf("%d-%02d-%02d",
		$date->year(), $date->month(), $date->day() )), "\n";

    print $cgi->img({src => $src, alt => $alt,
		class=> 'comic'}), "\n\n";
	return;
}

#Get the bonus cartoon from the SMBC website.
sub add_bonus_cartoon()
{
	#Create new HTML parser and get the content from the web agent
    my $stream = HTML::TokeParser->new(\$agent->{content});

	#Get the first "div tag to setup the loop.
	my $tag = $stream->get_tag("div");

	#Advance to the div with the bonus panel:
    while (!$tag->[1]{id} or $tag->[1]{id} ne 'aftercomic'){
    	$tag = $stream->get_tag("div");
    }

    #Get the bonus panel:
    my $toon = $stream->get_tag("img");
#    $toon = $stream->get_tag("img");

	#Get the source from the "img" tag:
    my $src = $toon->[1]{'src'};
	my $alt = 'SMBC Bonus Panel';
    if ($src ne "")
	{
		print $cgi->h2("Bonus Comic from ".sprintf("%d-%02d-%02d",
			$date->year(), $date->month(), $date->day() )), "\n";

    	print $cgi->img({src => $src, alt => $alt, 
			class => 'comic'}), "\n\n";
	}
	return;
}
#################### End of Helper Functions ###############################

#Start the loop at the first div:
my $tag = $stream->get_tag("div");

###### This code worked... then they removed the Konami comic...############
#Only get hidden cartoon the first time (same for each page).
#while ($tag->[1]{id} and $tag->[1]{id} ne 'konamicomic') {
#	$tag = $stream->get_tag("div");
#}

#Get the img tag that contains the hidden cartoon:
#my $toon = $stream->get_tag("img");
                
#Get the source from the "img" tag:
#$hidden_source = $toon->[1]{'src'};
############################################################################


#Print a header for the page.
print $cgi->h1("This Week's Saturday Morning Breakfast Cereal Comics");

#Get seven days worth of comics by following the backward link
#and scraping the main and bonus comics on each page.
for (my $comic_counter = 0; $comic_counter < 7; $comic_counter++)
{
    add_main_cartoon();
	add_bonus_cartoon();
	$date->subtract(days=>1);
	#The previous comic button has a class of backRollover
	$agent->follow_link(class=>'prev');
}

########## More Konami Comic stuff that was removed ########################
#print $cgi->h2("Hidden Comic"), "\n";

#Hidden Comic is a relative URL, so use the address to
#get its complete path on the website.
#print $cgi->img({src=>$address.$hidden_source, alt=>"Hidden Comic",
#	class => 'comic'}), "\n\n";
############################################################################


#Information on reading a file and printing its contents from:
#http://www.cs.mcgill.ca/~abatko/computers/programming/perl/howto/open/#read_from_one_file_and_write_its_contents_into_another_file_
my $webline_path = "../resources/webline.txt";
open( FILE, "< $webline_path") or die "Can't open $webline_path.";
while( <FILE> ) {
	print;
}
close FILE;
print $cgi->end_html, "\n";

#! /usr/bin/perl -w

# three_comic_scraper.cgi - demonstrate screen-scraping in Perl
# CGI Basis by D Provine
# Modified by Kevin Dittmar 2 March 2014

use strict;
use CGI;
use WWW::Mechanize;     # This is the object that gets stuff
use HTML::TokeParser;   # This is the object that parses HTML

# create new web agent and get a page
my $agent = WWW::Mechanize->new();
$agent->get("http://www.uclick.com/client/sea/pe/");

# create new HTML parser and get the content from the web agent
my $stream = HTML::TokeParser->new(\$agent->{content});

# HTML is like this (alt is spelled "atl" in the page's source code):
# <div class="columns1234">
# 	<p class="vspacing"></p><p class="vspacing"></p>
# 	<h1>Peanuts</h1>
# 	<p class="byline">By Charles M. Schultz</p>
# 	<div style="padding: 8px 0 5px 0;">
#		<img border="0" height="415" width="600" 
#			src="http://synd.imgsrv.uclick.com/comics/pe/2014/pe140302.jpg" 
#			atl="pe140302.jpg">
# 	</div>
#...
#</div>

# get the first "div" tag to set up the loop...
my $tag = $stream->get_tag("div");

# Skip divs until we get to one without an id and
# a class of columns1234.
while (!$tag->[1]{class} or 
		($tag->[1]{class} and $tag->[1]{class} ne 'columns1234')){
	$tag = $stream->get_tag("div");
}
# get the h1 tag and, subsequently, the header text:
$tag = $stream->get_tag("h1");
my $comic_title = $stream->get_trimmed_text("/h1");

# get the byline
$tag = $stream->get_tag("p");
while ($tag->[1]{class} and $tag->[1]{class} ne 'byline'){
	$tag = $stream->get_tag("p");
}

my $comic_byline = $stream->get_trimmed_text("/p");

# get the cartoon (img in next div):
$tag = $stream->get_tag("div");
my $toon = $stream->get_tag("img");

# get the comic source and alt text:
my $source = $toon->[1]{'src'};
my $alt = "Peanuts";

# get the caption of the cartoon
$tag = $stream->get_tag("div");
while (!$tag->[1]{class} or
		($tag->[1]{class} and $tag->[1]{class} ne 'caption')){
	$tag = $stream->get_tag("div");
}
my $caption = $stream->get_trimmed_text("/div");


# Generate the HTML for the header and the first comic:
my $cgi = new CGI;

print $cgi->header(-type=>'text/html', -author=>"Kevin Dittmar"),
      $cgi->start_html(-title => 'Three Comic Screen Scraper',
		-style => [{src=>'webline.css'}, {src=>'layout699-.css'},
		{src=>'layout700+.css'}]);

print $cgi->h1("$comic_title"), "\n";

print $cgi->p("$comic_byline"), "\n";

print $cgi->img({src=>$source, alt=>$alt, class=>'comic'}), "\n";

print $cgi->p($caption), "\n\n";

# now do "Doonesbury" (note: same objects re-used, no "new()" )
$agent->get("http://doonesbury.slate.com/");
$stream = HTML::TokeParser->new(\$agent->{content});

#HTML looks like this:
#<div id="mutable" style="display: none;">
#	<img alt="Doonesbury" 
#		src="http://assets.amuniversal.com/2c93f0f06fff0131ed27005056a9545d"
#		style="width: 900px;" />
#</div>

$tag = $stream->get_tag("div");
while ($tag->[1]{id} and $tag->[1]{id} ne "mutable")
{
	$tag = $stream->get_tag("div");
}

#The comic is in this div tag's img tag.
$toon = $stream->get_tag("img");

#The src is the link to the comic.
$source = $toon->[1]{'src'};
#The alt is the title of the comic series.
$alt = $toon->[1]{'alt'};
$comic_title = $alt;

print $cgi->h1("$comic_title"), "\n";

print $cgi->img({src=>$source, alt=>$alt, class=>'comic'}), "\n\n";

#Now do Garfield.

#HTML looks like this:
#<div id="comic_wrap" class="img-polaroid">
#	<a href="http://garfield.com/comic/2014-03-01" class="comic-arrow-left ">
#		<i class="fa fa-arrow-left"></i>
#	</a>
#	<a href="#" class="comic-arrow-right hidden">
#		<i class="fa fa-arrow-right"></i>
#	</a>
#	<img class="img-responsive center-block" 
#		src="http://garfield.com/uploads/strips/2014-03-02.jpg" width="900">
#</div>

$agent->get("http://garfield.com/comic/");
$stream = HTML::TokeParser->new(\$agent->{content});

#Start off div loop.
$tag = $stream->get_tag("div");

#Get the div tag with an id of "comic_wrap" and
#a class of "img-polaroid".
while (!$tag->[1]{id} or 
		($tag->[1]{id} and $tag->[1]{id} ne 'comic_wrap')){
	$tag = $stream->get_tag("div");
}

$toon = $stream->get_tag("img");

# get the source from the tag:
$source = $toon->[1]{'src'};

#Set the alt text and comic title to be the title of the comic series.
$alt = $comic_title = 'Garfield';

# add this to the CGI output
print $cgi->h1($comic_title), "\n";
print $cgi->img({src=>$source, alt=>$alt, class=>'comic'}), "\n\n";

#Information on reading a file and printing its contents from:
#http://www.cs.mcgill.ca/~abatko/computers/programming/perl/howto/open/#read_from_one_file_and_write_its_contents_into_another_file_
my $webline_path = "../resources/webline.txt";
open( FILE, "< $webline_path") or die "Can't open $webline_path.";
while( <FILE> ) {
	print;
}
close FILE;

# ALL DONE!
print $cgi->end_html, "\n";

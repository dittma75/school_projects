#!/usr/bin/perl
use strict;
use warnings;
use CGI;
require '../db_connect.pl';

my $CGI = new CGI;
my $title = $CGI->param('title');
my $ISBN = $CGI->param('ISBN');
my $genrename = $CGI->param('genrename');
my $success = 1;

my $dbh = getDBH();
my $sql = "CALL add_genre(\"$ISBN\", \"$genrename\")";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or $success = 0;
$sth->finish();

print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>"AmazingBooks:  add_genre",
                       -author=>'dittma75@students.rowan.edu');
                       print $CGI->a({-href=>"view.cgi?type=book&ID=$ISBN"}, 'Back'), "<br/>\n";
if ($success)
{
    print "New genre $genrename  added to $title.\n";
}
else
{
    print "No genre \"$genrename\"  exists.  Please try again.<br/>\n";
}
print $CGI->end_html, "\n";
$dbh->disconnect();

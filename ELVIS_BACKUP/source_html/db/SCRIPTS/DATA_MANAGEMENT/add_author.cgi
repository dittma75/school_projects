#!/usr/bin/perl
use strict;
use warnings;
use CGI;
require '../db_connect.pl';

my $CGI = new CGI;
my $title = $CGI->param('title');
my $ISBN = $CGI->param('ISBN');
my $authorID = $CGI->param('authorID');
my $success = 1;

my $dbh = getDBH();
my $sql = "CALL add_author(\"$ISBN\", $authorID)";
my $sth = $dbh->prepare($sql);
#If a query fails, we'll print an error message and fail gracefully.
$sth->execute or $success = 0;
$sth->finish();
if ($success)
{
    $sql = "SELECT author_lname, author_fname
            FROM author
            WHERE authorID = $authorID";

    $sth = $dbh->prepare($sql);
    $sth->execute or $success = 0;
}
my @author;

print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>"AmazingBooks:  add_author",
                       -author=>'dittma75@students.rowan.edu');
                       print $CGI->a({-href=>"view.cgi?type=book&ID=$ISBN"}, 'Back'), "<br/>\n";
if ($success)
{
    @author = $sth->fetchrow_array;
    print "New author $author[0], $author[1]  added to $title.\n";
}
else
{
    print "No author with ID $authorID exists.  Please try again.<br/>\n";
}
print $CGI->end_html, "\n";
$dbh->disconnect();

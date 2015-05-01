#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use CGI::Cookie;
require 'SCRIPTS/db_connect.pl';

my %cookies = CGI::Cookie->fetch;
my $success = 1;
my $customerID;
if (%cookies)
{
    $customerID = $cookies{'ID'}->value;
}
else
{
    $success = 0;
}

my $dbh = getDBH();
my $sql = "CALL customer_suggestions($customerID)";
my $sth = $dbh->prepare($sql);

#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or $success = 0;
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Recommendations',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./index.html'}, 'Back'), "<br/>\n";
if ($success)
{
    print $CGI->h1("Give These Books a Try:"), "\n";
    print "<table>\n";
    print "<tr><th>Suggested Reading</th></tr>\n";
    while (my @book = $sth->fetchrow_array)
    {
        print "<tr><td>$book[0]</td></tr>\n";
    }
    print "</table>\n";
}
else
{
    print "Please log in before trying to use this feature.<br/>\n";
}
$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


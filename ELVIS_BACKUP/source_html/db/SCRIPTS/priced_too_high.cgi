#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $sql = "CALL priced_too_high()";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  The Price is Too High',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "\n";
print $CGI->h1("And You Thought the Price of Gas Was High"), "\n";
print "<table>\n";
print "<tr><th>ISBN</th><th>Title</th><th>Price</th></tr>\n";
while (my @book = $sth->fetchrow_array)
{
    print "<tr><td>$book[0]</td><td>$book[1]</td><td>\$$book[2]</td></tr>\n";
}
print "</table>\n";
$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


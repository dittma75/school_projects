#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $sql = "CALL view_inventory()";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Inventory',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "\n";
print $CGI->h1("Current Inventory"), "\n";
print "<table>\n";
print "<tr><th>ISBN</th><th>Title</th><th>Stock</th></tr>\n";
while (my @book = $sth->fetchrow_array)
{
    print "<tr><td>$book[0]</td><td>$book[1]</td><td>$book[2]</td></tr>\n";
}
print "</table>\n";
$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


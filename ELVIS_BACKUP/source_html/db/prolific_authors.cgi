#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'SCRIPTS/db_connect.pl';

my $dbh = getDBH();
my $sql = "CALL list_prolific_authors()";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Prolific Authors',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./index.html'}, 'Back'), "\n";
print $CGI->h1("Our Most Celebrated Authors"), "\n";
print "<table>\n";
print "<tr><th>Prolific Authors</th></tr>\n";
while (my @author = $sth->fetchrow_array)
{
    print "<tr><td>".join(", ", @author)."</td></tr>\n";
}
print "</table>\n";
$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


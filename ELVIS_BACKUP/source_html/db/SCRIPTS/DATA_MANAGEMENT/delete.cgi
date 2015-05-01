#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require '../db_connect.pl';

my $dbh = getDBH();

my $CGI = new CGI;
my $type = $CGI->param('type');
my $ID = $CGI->param('ID');
my $sql;

if ($type eq 'genre')
{
    $sql = "CALL delete_$type(\"$ID\")";
}
else
{
    $sql = "CALL delete_$type($ID)";
}
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>"AmazingBooks:  delete_$type: $ID",
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>"../$type"."_index.cgi"}, 'Back'), "\n<br/>";
print "Removal of $type with ID $ID successful.";
print $CGI->end_html, "\n";
$sth->finish();
$dbh->disconnect();


#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $publisher_sql = "SELECT publisher_name, phone, publisher_ID
                     FROM publisher
                     ORDER BY publisher_name";
my $publisher_sth = $dbh->prepare($publisher_sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$publisher_sth->execute or die "SQL ERROR: $DBI::errstr\n";
my @publishers;
my @phone_numbers;
my @publisherIDs;
while (my @publisher = $publisher_sth->fetchrow_array)
{
    push(@publishers, $publisher[0]);
    push(@phone_numbers, $publisher[1]);
    push(@publisherIDs, $publisher[2]);
}
$publisher_sth->finish();
$dbh->disconnect();
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Publishers',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "\n";
print "<table>\n";
print "<tr><th>ID</th><th>Publisher</th><th>Phone Number</th><th></th></tr>\n";
for (my $i = 0; $i <= $#publishers; $i++)
{
    #Make publisher links for each publisher.
    print "<tr>\n
           <td>$publisherIDs[$i]</td>\n
           <td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/view.cgi?type=publisher&ID=$publisherIDs[$i]"},
                "$publishers[$i]"
           )."</td>\n
           <td>$phone_numbers[$i]</td>\n
           <td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/delete.cgi?type=publisher&ID=$publisherIDs[$i]"},
                "Remove"
           )."</td>\n
           </tr>\n";
}
print "</table>\n";

print "</table><br/>\n";

print '<form action="./DATA_MANAGEMENT/create_new.cgi">'."\n";
print "<table>\n";
print "<tr><td>name</td><td>".$CGI->textfield('publisher_name','',60,45)."</td></tr>\n";
print "<tr><td>phone</td><td>".$CGI->textfield('price','',20,10)."</td></tr>\n";
print '<tr><td><input type="submit" value="Add"></td></tr>';
print "</table>\n";
print '<input type="hidden" name="type" value="publisher">'."\n";

print $CGI->end_html, "\n";

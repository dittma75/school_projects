#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'SCRIPTS/db_connect.pl';

my $dbh = getDBH();
my $CGI = new CGI;
my $search = $CGI->param('search');
#Empty search returns everything.
if ($search eq '')
{
    $search = "%";
}
my $sql = "CALL search_book(\"$search\")";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Search Results',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./index.html'}, 'Back'), "\n";
if ($search eq '%')
{
    print $CGI->h1("All Available Books"), "\n";
}
else
{
    print $CGI->h1("Search Results Matching $search"), "\n";
}
print '<form action="./place_order.cgi">'."\n";
print "<table>\n";
print "<tr>
        <th>Order?</th>
        <th>ISBN</th>
        <th>Title</th>
        <th>Available?</th>
        <th>Amount</th>
</tr>\n";
my $index = 0;
while (my @book = $sth->fetchrow_array)
{
    print "<tr>
        <td><input type=\"checkbox\" name=\"check_$index\" value=\"$book[0]\"></td>
        <td>$book[0]</td>
        <td>$book[1]</td>
        <td>$book[2]</td>
        <td>".$CGI->textfield("qu_$book[0]",'',20,16)."</td>
    </tr>\n";
    $index++;
}
print '<tr>
        <td colspan="2">Payment Type:  '.$CGI->textfield('payment_type','',30,20).'</td>
        <td colspan="2">Card Number:  '.$CGI->textfield('card_number','',20,16).'</td>
        <td><input type="submit" value="Place Order"></td>
    </tr>';
print "</table>\n";
print "</form>\n";
$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


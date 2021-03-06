#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'SCRIPTS/db_connect.pl';

my $CGI = new CGI;
my $orderID = $CGI->param('ID');
my $dbh = getDBH();
my $sql = "SELECT ISBN, title, quantity
           FROM contains JOIN (SELECT ISBN, title
                               FROM book) AS ordered_books USING (ISBN)
           WHERE orderID = $orderID
           ORDER BY title";
my $sth = $dbh->prepare($sql);

#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>"AmazingBooks:  Orders $orderID\'s contents",
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./order_list.cgi'}, 'Back'), "<br/>\n";
print $CGI->h1("Contents of Order #$orderID"), "\n";
print "<table>\n";
print "<tr><th>ISBN</th><th>Title</th><th>Quantity</th></tr>\n";
while (my @contents = $sth->fetchrow_array)
{
    print "<tr>
           <td>$contents[0]</td>
           <td>$contents[1]</td>
           <td>$contents[2]</td>
           </tr>";
}
print "</table>\n";

$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


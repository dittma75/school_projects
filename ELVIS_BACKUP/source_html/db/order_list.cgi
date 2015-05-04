#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use CGI::Cookie;
require 'SCRIPTS/db_connect.pl';

my %cookies = CGI::Cookie->fetch;
my $customerID;
my $success = 1;
if (%cookies)
{
    $customerID  = $cookies{'ID'}->value;
}
else
{
    $success = 0;
}

my $dbh = getDBH();
my $sql = "CALL track_order_by_customer($customerID)";
my $sth = $dbh->prepare($sql);

#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or $success = 0;
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Orders',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./index.html'}, 'Back'), "<br/>\n";
if ($success)
{
    print $CGI->h1("Order Records"), "\n";
    print "<table>\n";
    print "<tr><th>Order#</th><th>Date</th><th>Status</th></tr>\n";
    while (my @order = $sth->fetchrow_array)
    {
        print "<tr><td>
                   ".$CGI->a({-href=>"./contents.cgi?ID=$order[0]"},"$order[0]")."
               </td>
               <td>$order[1]</td>
               <td>$order[2]</td></tr>\n";
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


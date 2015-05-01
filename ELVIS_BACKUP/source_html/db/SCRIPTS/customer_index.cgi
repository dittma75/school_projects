#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $customer_sql = "SELECT lname, fname, city, state, customerID
                     FROM customer
                     ORDER BY lname, fname";
my $customer_sth = $dbh->prepare($customer_sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$customer_sth->execute or die "SQL ERROR: $DBI::errstr\n";

my @lnames;
my @fnames;
my @customerIDs;
my @cities;
my @states;

while (my @customer = $customer_sth->fetchrow_array)
{
    push(@lnames, $customer[0]);
    push(@fnames, $customer[1]);
    push(@cities, $customer[2]);
    push(@states, $customer[3]);
    push(@customerIDs, $customer[4]);
}
$customer_sth->finish();
$dbh->disconnect();
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Customers',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "\n";
print "<table>\n";
print "<tr>
            <th>Name</th>
            <th>City</th>
            <th>State</th>
            <th></th>
       </tr>\n";
for (my $i = 0; $i <= $#customerIDs; $i++)
{
    #Make publisher links for each publisher.
    print "<tr>\n
           <td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/view.cgi?type=customer&ID=$customerIDs[$i]"},
                "$lnames[$i], $fnames[$i]"
           )."</td>\n
           <td>$cities[$i]</td>\n
           <td>$states[$i]</td>\n
           <td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/delete.cgi?type=customer&ID=$customerIDs[$i]"},
                "Remove"
           )."</td>\n
           </tr>\n";
}
print "</table>\n";

print '<form action="./DATA_MANAGEMENT/create_new.cgi">'."\n";
print "<table>\n";
print "<tr><td>First Name</td><td>".$CGI->textfield('fname','',60,45)."</td></tr>\n";
print "<tr><td>Last Name</td><td>".$CGI->textfield('lname','',60,45)."</td></tr>\n";
print "<tr><td>Street:</td><td>".$CGI->textfield('street','',60,45)."</td></tr>\n";
print "<tr><td>City</td><td>".$CGI->textfield('city','',60,45)."</td></tr>\n";
print "<tr><td>State</td><td>".$CGI->textfield('state','',4,2)."</td></tr>\n";
print "<tr><td>Zip</td><td>".$CGI->textfield('zip','',10,5)."</td></tr>\n";
print "<tr><td>Gender</td><td>".$CGI->textfield('gender','',2,1)."</td></tr>\n";
print '<tr><td><input type="submit" value="Add"></td></tr>';
print "</table>\n";
print '<input type="hidden" name="type" value="customer">'."\n";

print $CGI->end_html, "\n";

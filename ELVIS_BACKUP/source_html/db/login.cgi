#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use CGI::Cookie;
require 'SCRIPTS/db_connect.pl';

my $cookie1;
my $dbh = getDBH();
my $CGI = new CGI;
my $ID = $CGI->param('ID');
my $pass = $CGI->param('pass');
my $sql = "SELECT fname, lname
           FROM customer
           WHERE customerID = $ID AND pass = \"$pass\"";
my $sth = $dbh->prepare($sql);
my $success = 1;
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or $success = 0;

#print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
#print $CGI->start_html(-title=>'AmazingBooks:  Login',
#                       -author=>'dittma75@students.rowan.edu');
#print $CGI->a({-href=>'./index.html'}, 'Back'), "\n";

my $customer_name;
if ($success)
{
    while (my @customer = $sth->fetchrow_array)
    {
        $customer_name = join(" ", @customer);
    }

    if ($customer_name ne '')
    {
        $cookie1 = CGI::Cookie->new(-name=>'ID',-value=>$ID);
    }
}

print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar', -cookie=>[$cookie1]);
print $CGI->start_html(-title=>'AmazingBooks:  Login',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./index.html'}, 'Back'), "\n";


if ($customer_name eq '' or not $success)
{
    print $CGI->h2("Login Failed.  Please try again."), "\n";
}
else
{
    print $CGI->h2("Welcome, $customer_name!"), "\n";
}

$sth->finish();
$dbh->disconnect();
print $CGI->end_html, "\n";


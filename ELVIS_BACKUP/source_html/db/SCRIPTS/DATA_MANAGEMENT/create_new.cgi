#!/usr/bin/perl
use strict;
use warnings;
use CGI;
require '../db_connect.pl';

my $CGI = new CGI;
my @params = $CGI->param();
my @args;
my $type;
foreach (@params)
{
    if ($_ eq 'type')
    {
        $type = $CGI->param($_);
    }
    #Add non-string arg values as they are.
    elsif (index($_, 'ID') != -1 or
           $_ eq 'stock' or
           $_ eq 'quantity' or
           $_ eq 'price')
    {
        push(@args, $CGI->param($_));
    }
    #Put quotes around string arg values.
    else
    {
        push(@args, '"'.$CGI->param($_).'"');
    }
}

my $dbh = getDBH();
my $sql = "CALL create_new_$type(".join(", ", @args).")";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>"AmazingBooks:  create_new_$type",
                       -author=>'dittma75@students.rowan.edu');
                       print $CGI->a({-href=>"../$type"."_index.cgi"}, 'Back'), "<br/>\n";
print "New $type with identifying information:  \n",
      join(", ", @args), "added.<br/>\n";
print $CGI->end_html, "\n";
$sth->finish();
$dbh->disconnect();

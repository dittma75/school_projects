#!/usr/bin/perl
use strict;
use warnings;
#db connect info from
#http://perl.about.com/od/perltutorials/a/perlmysql_3.html
use DBD::mysql;
sub getDBH
{
    my $conf_path = "/home/dittma75/source_html/db/SCRIPTS/.db.conf";
    my $db_name;
    my $user;
    my $pass;
    open (CONF, "<", $conf_path);
    while (<CONF>)
    {
        chomp;
        ($db_name, $user, $pass) = split(/,/,$_);
    }
    my $db_handle = DBI->connect("DBI:mysql:$db_name",$user,$pass)
        or die "Connection Error:  $DBI::errstr\n";
    return $db_handle;
}
#required scripts must return true to make the compiler happy.
1;

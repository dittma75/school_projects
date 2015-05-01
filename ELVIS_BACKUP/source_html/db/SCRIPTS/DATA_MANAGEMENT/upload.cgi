#!/usr/bin/perl
#Based on a file upload tutorial from:
#http://www.sitepoint.com/uploading-files-cgi-perl-2/
use strict;
use warnings;
use CGI;
use CGI::Carp qw ( fatalsToBrowser );
use File::Basename;
require '../db_connect.pl';

my $CGI = new CGI;
#Put a 5MB limit on uploads.
$CGI::POST_MAX = 1024 * 5000;
#Define a list of safe characters.
my $safe_filename_characters = "a-zA-Z0-9_.-";
my $filename = $CGI->param('filename');
my $table = $CGI->param('table');
if ( !$filename )
{
    print $CGI->header();
    print "There was a problem uploading the file.";
    exit;
}

my ( $name, $path, $extension ) = fileparse($filename, '..*');
$filename = $name.$extension;
#Replace all spaces with underscores
$filename =~ tr/ /_/;
#Remove all unsafe characters.
$filename =~ s/[^$safe_filename_characters]//g;

#Be extra sure that the filename is safe.
if ( $filename =~ /^([$safe_filename_characters]+)$/ )
{
    $filename = $1;
}
else
{
    die "Filename contains invalid characters";
}

my $upload_filehandle = $CGI->upload("filename");
open(UPLOADFILE, ">./UPLOADED_FILES/$filename") or die "$!";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
    print UPLOADFILE;
}

close UPLOADFILE;

my $dbh = getDBH();
my $sql = "LOAD DATA LOCAL INFILE \"./UPLOADED_FILES/$filename\"
           INTO TABLE $table
           FIELDS TERMINATED BY ','
           LINES TERMINATED BY '".'\n'."'";
my $sth = $dbh->prepare($sql);
$sth->execute or die $!;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  File Upload',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>"./file_upload.html"}, 'Back'), "<br/>\n";
print $CGI->h1("File successfully uploaded."), "<br/>\n";
print $CGI->end_html, "\n";


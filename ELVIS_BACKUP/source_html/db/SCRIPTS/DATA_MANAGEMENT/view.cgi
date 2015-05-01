#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require '../db_connect.pl';

my $dbh = getDBH();

my $CGI = new CGI;
my $type = $CGI->param('type');
my $ID = $CGI->param('ID');
my $sql = "CALL view_$type($ID)";
my $sth = $dbh->prepare($sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$sth->execute or die "SQL ERROR: $DBI::errstr\n";
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>"AmazingBooks:  view_$type: $ID",
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>"../$type"."_index.cgi"}, 'Back'), "<br/>\n";

my $ISBN;
my $title;
my $size;

while (my @item = $sth->fetchrow_array)
{
    print '<form action="./update.cgi" id="u_form">'."\n";
    print '<input type="hidden"'.
               'name="'.$sth->{NAME}->[0].
               '"value="'.$item[0].'">'."\n";
    print "<table>\n";
    for (my $i = 0; $i <= $#item; $i++)
    {
        #Don't print passwords
        if ($sth->{NAME}->[$i] ne 'pass')
        {
            #Save the ISBN and title for adding authors if needed.
            if ($sth->{NAME}->[$i] eq 'ISBN')
            {
                $ISBN = $item[$i];
                $size = 13;
            }
            if ($sth->{NAME}->[$i] eq 'title')
            {
                $title = $item[$i];
                $size = 45;
            }
            #Print the name of the field.
            print "<tr><td>$sth->{NAME}->[$i]: ";
            #If it's a price, print a dollar sign before the value.
            if ($sth->{NAME}->[$i] eq 'price')
            {
                print '$';
            }
            #If it's a gender, expand the name of the gender.
            if ($sth->{NAME}->[$i] eq 'gender')
            {
                print "<select name=\"gender\" form=\"u_form\">\n";
                #F means female
                if ($item[$i] eq 'F')
                {
                    print '<option value="F" selected="selected">Female</option>\n
                           <option value="M">Male</option>', "\n";
                }
                #The only other option is M for male.
                else
                {
                    print '<option value="F">Female</option>\n
                           <option value="M" selected="selected">Male</option>', "\n";
                }
                print "</select>\n";
            }
            #If it's not a gender, print it normally.
            else
            {
                if ($i == 0)
                {
                    print $item[$i], "\n";
                }
                else
                {
                    print $CGI->textfield($sth->{NAME}->[$i], "$item[$i]", 
                                          '60', "$size"), "\n";
                }
            }
            print "</td></tr>\n";
        }
    }
    print '<tr><td><input type="submit" value="Update"></td></tr>';
    print "</table><br/>\n";
    print '<input type="hidden" name="type" value="'.$type.'">'."\n";
    print "</form>\n";
}

#Forms for updating book's join tables wrote and in.
if ($type eq 'book')
{
    print '<form action="./add_author.cgi">'."\n";
    print "<table>\n";
    print "<tr><td>Author ID<td></tr><td>".$CGI->textfield('authorID','',20,11)."</td></tr>\n";
    print '<tr><td><input type="submit" name="author_submit" value="Add"></td></tr>';
    print "</table>\n";
    print '<input type="hidden" name="ISBN" value="'.$ISBN.'">'."\n";
    print '<input type="hidden" name="title" value="'.$title.'">'."\n";
    print "</form><br/>\n";

    print '<form action="./add_genre.cgi">'."\n";
    print "<table>\n";
    print "<tr><td>Genre<td></tr><td>".$CGI->textfield('genrename','',60,45)."</td></tr>\n";
    print '<tr><td><input type="submit" name="genre_submit" value="Add"></td></tr>';
    print "</table>\n";
    print '<input type="hidden" name="ISBN" value="'.$ISBN.'">'."\n";
    print '<input type="hidden" name="title" value="'.$title.'">'."\n";
    print "</form>\n";
}

print $CGI->end_html, "\n";
$sth->finish();
$dbh->disconnect();


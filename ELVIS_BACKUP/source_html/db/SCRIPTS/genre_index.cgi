#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $genre_sql = "SELECT genrename
                 FROM genre
                 ORDER BY genrename";
my $genre_sth = $dbh->prepare($genre_sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$genre_sth->execute or die "SQL ERROR: $DBI::errstr\n";
my @genres;
my @titles;
my @ISBNs;

while (my @genre = $genre_sth->fetchrow_array)
{
    push(@genres, $genre[0]);
    my $book_sql =
        "SELECT title, ISBN
         FROM book
         WHERE ISBN IN (SELECT ISBN
                        FROM `in`
                        WHERE genrename = \"$genre[0]\")
         ORDER BY title";
    my $book_sth = $dbh->prepare($book_sql);
    $book_sth->execute or die "SQL ERROR: $DBI::errstr\n";
    my @title_list;
    my @ISBN_list;
    #Add all titles and ISBNs associated with this genre to per-genre lists.
    while (my @book = $book_sth->fetchrow_array)
    {
        push(@title_list, "$book[0]");
        push(@ISBN_list, "$book[1]");
    }
    #Add the per-genre lists to a list of lists.
    push(@titles, \@title_list);
    push(@ISBNs, \@ISBN_list);
    $book_sth->finish();
}
$genre_sth->finish();
$dbh->disconnect();
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Genres',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "\n";
print "<table>\n";
print "<tr><th>Genre</th><th>Books</th></tr>\n";
for (my $i = 0; $i <= $#genres; $i++)
{
    print "<tr>\n
           <td>$genres[$i]</td>\n";
    print "<td>\n";
    for (my $j = 0; $j <= $#{$titles[$i]}; $j++)
    {
        print $CGI->a(
            {-href=>"DATA_MANAGEMENT/view.cgi?type=book&ID=$ISBNs[$i][$j]"},
                "$titles[$i][$j]");
        if ($j != $#{$titles[$i]})
        {
            print ";\n";
        }
    }
    print "<td>".$CGI->a(
               {-href=>"DATA_MANAGEMENT/delete.cgi?type=genre&ID=$genres[$i]"},
               "Remove"
          )."</td>\n
          </tr>\n
          </td></tr>\n";
}
print "</table>\n";

print '<form action="./DATA_MANAGEMENT/create_new.cgi">'."\n";
print "<table>\n";
print "<tr><td>genre</td><td>".$CGI->textfield('genrename','',60,45)."</td></tr>\n";
print '<tr><td><input type="submit" value="Add"></td></tr>';
print "</table>\n";
print '<input type="hidden" name="type" value="genre">'."\n";

print $CGI->end_html, "\n";

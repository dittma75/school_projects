#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $book_sql = "SELECT ISBN, title
                FROM book
                ORDER BY title";
my $book_sth = $dbh->prepare($book_sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$book_sth->execute or die "SQL ERROR: $DBI::errstr\n";
my @ISBNs;
my @titles;
my @authors;
my @genres;

while (my @book = $book_sth->fetchrow_array)
{
    push(@ISBNs, $book[0]);
    push(@titles, $book[1]);
    my $author_sql =
        "SELECT author_lname, author_fname
         FROM author
         WHERE authorID IN (SELECT authorID
                            FROM wrote
                            WHERE ISBN = \"$book[0]\")
         ORDER BY author_lname";
    my $author_sth = $dbh->prepare($author_sql);
    $author_sth->execute or die "SQL ERROR: $DBI::errstr\n";
    #Make a list of authors for this book.
    my @author_list;
    while (my @author = $author_sth->fetchrow_array)
    {
        push(@author_list, "$author[0], $author[1]");
    }
    push(@authors, join('; ', @author_list));

    my $genre_sql = "SELECT genrename
                     FROM genre
                     WHERE genrename IN (SELECT genrename
                                         FROM `in`
                                         WHERE ISBN = \"$book[0]\")
                     ORDER BY genrename";
    my $genre_sth = $dbh->prepare($genre_sql);
    $genre_sth->execute or die "SQL ERROR: $DBI::errstr\n";

    #Make a list of genres for this book.
    my @genre_list;
    while (my @genre = $genre_sth->fetchrow_array)
    {
        push(@genre_list, "$genre[0]");
    }
    push(@genres, join(', ', @genre_list));

    $author_sth->finish();
    $genre_sth->finish();
}
$book_sth->finish();
$dbh->disconnect();
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks: Books',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "<br/>\n";
print "<table>\n";
print "<tr>
            <th>ISBN</th>
            <th>Title</th>
            <th>Authors</th>
            <th>Genre</th>
            <th></th>
       </tr>\n";
for (my $i = 0; $i <= $#ISBNs; $i++)
{
    #Make a link for each book that goes to its individual view page.
    print "<tr>\n
           <td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/view.cgi?type=book&ID=$ISBNs[$i]"},
                "$ISBNs[$i]"
           )."</td>\n
           <td>$titles[$i]</td>\n
           <td>$authors[$i]</td>\n
           <td>$genres[$i]</td>\n
           <td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/delete.cgi?type=book&ID=$ISBNs[$i]"},
                "Remove"
           )."</td>\n
           </tr>\n";
}
print "</table><br/>\n";

print '<form action="./DATA_MANAGEMENT/create_new.cgi">'."\n";
print "<table>\n";
print "<tr><td>ISBN</td><td>".$CGI->textfield('ISBN','',20,13)."</td></tr>\n";
print "<tr><td>title</td><td>".$CGI->textfield('title','',60,45)."</td></tr>\n";
print "<tr><td>price</td><td>".$CGI->textfield('price','',20,13)."</td></tr>\n";
print "<tr><td>stock:</td><td>".$CGI->textfield('stock','',20,11)."</td></tr>\n";
print "<tr><td>publisherID</td><td>".$CGI->textfield('publisherID','',20,11)."</td></tr>\n";
print "<tr><td>date published</td><td>".$CGI->textfield('date_published','',20,10)."</td></tr>\n";
print '<tr><td><input type="submit" value="Add"></td></tr>';
print "</table>\n";
print '<input type="hidden" name="type" value="book">'."\n";
print "</form>\n";
print $CGI->end_html, "\n";

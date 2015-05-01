#!/usr/bin/perl
use warnings;
use strict;
use CGI;
require 'db_connect.pl';

my $dbh = getDBH();
my $author_sql = "SELECT author_lname, author_fname, authorID
                  FROM author
                  ORDER BY author_lname";
my $author_sth = $dbh->prepare($author_sql);
#This will throw a warning if warnings are on because it is
#used only once, but that's fine because DBI is included in db_connect
$author_sth->execute or die "SQL ERROR: $DBI::errstr\n";
my @titles;
my @ISBNs;
my @authors;
my @authorIDs;

while (my @author = $author_sth->fetchrow_array)
{
    push(@authors, join(", ", ($author[0], $author[1])));
    push(@authorIDs, $author[2]);
    my $book_sql =
        "SELECT title, ISBN
         FROM book
         WHERE ISBN IN (SELECT ISBN
                        FROM wrote
                        WHERE authorID = $author[2])
         ORDER BY title";
    my $book_sth = $dbh->prepare($book_sql);
    $book_sth->execute or die "SQL ERROR: $DBI::errstr\n";
    my @title_list;
    my @ISBN_list;
    #Add all titles and ISBNs for this author to a per-author list.
    while (my @book = $book_sth->fetchrow_array)
    {
        push(@title_list, "$book[0]");
        push(@ISBN_list, "$book[1]");
    }
    #Add the per-author lists to a list of lists.
    push(@titles, \@title_list);
    push(@ISBNs, \@ISBN_list);
    $book_sth->finish();
}
$author_sth->finish();
$dbh->disconnect();
my $CGI = new CGI;
print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Authors',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'../index.html'}, 'Back'), "\n";
print "<table>\n";
print "<tr><th>ID</th><th>Author</th><th>Books</th></tr>\n";
for (my $i = 0; $i <= $#authors; $i++)
{
    print "<tr>\n
           <td>$authorIDs[$i]</td>\n
           <td>$authors[$i]</td>\n";
    print "<td>";
    for (my $j = 0; $j <= $#{$ISBNs[$i]}; $j++)
    {
        #Make book links for each book that the author wrote.
        print $CGI->a(
            {-href=>"DATA_MANAGEMENT/view.cgi?type=book&ID=$ISBNs[$i][$j]"},
            "$titles[$i][$j]");
        if ($j != $#{$titles[$i]})
        {
            print ";\n";
        }
    }
    print "<td>".$CGI->a(
                {-href=>"DATA_MANAGEMENT/delete.cgi?type=author&ID=$authorIDs[$i]"},
                "Remove"
           )."</td>\n
           </td></tr>\n";
}
print "</table>\n";

print '<form action="./DATA_MANAGEMENT/create_new.cgi">'."\n";
print "<table>\n";
print "<tr><td>authorID</td><td>".$CGI->textfield('authorID','',20,11)."</td></tr>\n";
print "<tr><td>First Name</td><td>".$CGI->textfield('author_fname','',60,45)."</td></tr>\n";
print "<tr><td>Last Name</td><td>".$CGI->textfield('author_lname','',60,45)."</td></tr>\n";
print "<tr><td>E-mail</td><td>".$CGI->textfield('email','',60,45)."</td></tr>\n";
print '<tr><td><input type="submit" value="Add"></td></tr>';
print "</table>\n";
print '<input type="hidden" name="type" value="author">'."\n";
print "</form>\n";

print $CGI->end_html, "\n";

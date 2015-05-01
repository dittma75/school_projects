#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use CGI::Cookie;
require 'SCRIPTS/db_connect.pl';

my %cookies = CGI::Cookie->fetch;
my $success = 1;
my $error_str;
my $customerID;
if (%cookies)
{
    $customerID = $cookies{'ID'}->value;
}
else
{
    $success = 0;
    $error_str = "Please log in before trying to place an order.";
}

my $CGI = new CGI;

my @params = $CGI->param();
my $card_number;
my $payment_type;
my @unmatched_ISBNs;
my @ISBNs;
my @quantities;
my $orderID;

my $dbh = getDBH();
my $sql;
my $sth;
#There is no use trying to place an order if the user isn't logged in.
if ($success)
{
    #Parse the parameters.
    foreach(@params)
    {
        #Payment type
        if ($_ eq 'payment_type')
        {
            $payment_type = '"'.$CGI->param($_).'"';
        }
        #Credit card number
        elsif ($_ eq 'card_number')
        {
            $card_number = '"'.$CGI->param($_).'"';
        }
        #The name of the parameter of filled checkboxes is 'check_ISBN'
        elsif (index($_, 'check') != -1)
        {
            push(@unmatched_ISBNs, $CGI->param($_));
        }
        #A quantity parameter
        elsif (index($_, 'qu') != -1)
        {
            for (my $i = 0; $i <= $#unmatched_ISBNs; $i++)
            {
                if (index($_, "$unmatched_ISBNs[$i]") != -1)
                {
                    #Add the now-matched ISBN to the list.
                    push(@ISBNs, '"'.$unmatched_ISBNs[$i].'"');
                    #Remove the now-matched ISBN.
                    splice(@unmatched_ISBNs, $i);
                    $i--;
                    #Add the corresponding quantity.
                    push(@quantities, $CGI->param($_));
                    #We don't need to do the rest of the loop.
                    last;
                }
            }
        }
    }

    #Can't do an order without payment.
    #Credit card numbers must be 16 digits, and payment type can't
    #be empty.  The strings are quoted, so 2 is added to each parameter.
    if (length($card_number) != 18)
    {
        $success = 0;
        $error_str = "Bad card number $card_number.";
    }

    if (length($payment_type) <= 2)
    {
        $success = 0;
        $error_str = "No payment type specified.";
    }
    #There are still selected books without purchase quantities.
    if ($#unmatched_ISBNs > -1)
    {
        $success = 0;
        $error_str = "You did not specify quantities for some of your orders.";
    }
    
    #We didn't order any books.
    if (not @ISBNs)
    {
        $success = 0;
        $error_str = "No books to order.";
    }    

    $sql = "SELECT MAX(orderID) + 1
               FROM orders";
    $sth = $dbh->prepare($sql);
    $sth->execute or die "SQL ERROR: $DBI::errstr\n";
    while (my @order_number = $sth->fetchrow_array)
    {
        $orderID = $order_number[0];
    }
    $sth->finish();
}

#Order preparation succeeded, so make the order.
if ($success)
{
    $sql = "CALL create_new_order($orderID, $payment_type, $card_number, $customerID)";
    $sth = $dbh->prepare($sql);
    if (not $sth->execute)
    {
        $success = 0;
        $error_str = "Order creation failed.";
    }
    $sth->finish();
}

#We have books to order.  Add them to the order listing.
for (my $i = 0; $i <= $#ISBNs; $i++)
{
    if ($success)
    {
        $sql = "CALL add_ordered_books($orderID, $ISBNs[$i], $quantities[$i])";
        $sth = $dbh->prepare($sql);
        if (not $sth->execute)
        {
            $success = 0;
            $error_str = "Adding book $ISBNs[$i] to order failed";
            #Clean up the old query and delete the failed order.
            $sth->finish();
            $sql = "DELETE FROM orders WHERE orderID = $orderID";
            $sth = $dbh->prepare($sql);
            $sth->execute or die "SQL ERROR: $DBI::errstr\n";
        }
        $sth->finish();
    }
}

#We have the specification of an order.  Try to place it.
if ($success)
{
    $sql = "CALL ship_order($orderID)";
    $sth = $dbh->prepare($sql);
    if (not $sth->execute)
    {
        $success = 0;
        $error_str = "Shipping order failed.";
    }
    $sth->finish();
}

print $CGI->header(-type=>'text/html', -author =>'Kevin Dittmar');
print $CGI->start_html(-title=>'AmazingBooks:  Recommendations',
                       -author=>'dittma75@students.rowan.edu');
print $CGI->a({-href=>'./search.cgi'}, 'Back'), "\n";
if ($success)
{
    print $CGI->h2("Your order has been placed."), "\n";
}
else
{
    print $CGI->h2("Error placing your order:  $error_str"), "\n";
}
$dbh->disconnect();
print $CGI->end_html, "\n";


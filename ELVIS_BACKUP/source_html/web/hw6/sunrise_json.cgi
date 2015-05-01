#! /usr/bin/perl -w
# Created by Darren Provine 11 March 2014
# Modified by Kevin Dittmar 25 March 2014
# Have to load my library since system doesn't have
# Astro package installed.
use lib '/opt/kilroy/lib/perl';
use Astro::Sunrise;
use DateTime;
use CGI qw(:standard);

my $year = param('year');
my $month = param('month');
my $day = param('day');

# find two weeks ago today
my $date = DateTime->new(
    year => $year,
    month => $month,
    day => $day
);

$date = $date->subtract( days => 14 );

print "Content-Type: application/json\n\n";

print '{
"SunInfo" : [
';

# Print 29 days worth of JSON data.
for (my $x = 0; $x < 29; $x++)
{
    # The function sunrise returns the sunrise and sunset for a given date,
    # longitude, latitude, given offset, and presence of DST according to
    # its cpan documentation:
    # http://search.cpan.org/dist/Astro-Sunrise/Sunrise.pm
    $DST = &isDST($date);
    ($sunrise, $sunset) = sunrise($date->year(),  # year
                                 $date->month(),  # month
                              	   $date->day(),  # day
                                      -75.12643,  # glassboro longitude
                                       39.70057,  # glassboro latitude
                                             -5,  # offset from UTC
                                           $DST); # Daylight savings time?


    # convert to minutes from midnight
    ($sunrisehours, $sunrisemins) = split(":",$sunrise);
    ($sunsethours, $sunsetmins) = split(":",$sunset);

    my $formatteddate = sprintf("%d-%02d-%02d",
                        $date->year(), $date->month(), $date->day() );


    # generate JSON output for each of the 29 days.

    print " {\n";
    print '    "date": "' . $formatteddate . '",' . "\n";
    print '    "rise": "' . ($sunrisehours * 60 + $sunrisemins) . '",' . "\n";
    print '    "set":  "' . ($sunsethours * 60 + $sunsetmins) . '"' . "\n";
    print " }";
    # Separate each JSON array element with a comma.
    if ($x < 28)
    {
        print ",";
    }
    print "\n";
    # Increment to the next day.
    $date = $date->add(days => 1);
}
print ']
}
';

# Check if the date for sunrise/sunset info is within Daylight
# Saving Time (DST) according to:
# http://www.nist.gov/pml/div688/dst.cfm
sub isDST()
{
    #Information on DateTime functions from:
    #http://search.cpan.org/~drolsky/DateTime-1.08/lib/DateTime.pm
    my ($date) = @_;
    # The start date for DST is the second Sunday of March
    # at 2am, so we'll start at the beginning of the
    # second week, which is day 8.
    my $start_date = DateTime->new(
        year => $date->year(),
        month => 3,
        day => 8,
        hour => 2,
        minute => 0,
        second => 0
    );
    # While start_date isn't on a Sunday, advance one day
    # until start_date is on a Sunday.
    while ($start_date->day_of_week() != 7)
    {
        $start_date = $start_date->add(days => 1);
    }

    # The end date for DST is the first Sunday of November
    # at 2am, so we'll start at the first of the month.
    my $end_date = DateTime->new(
        year => $date->year(),
        month => 11,
        day => 1,
        hour => 2,
        minute => 0,
        second => 0
    );
    # While end_date isn't on a Sunday, advance one day
    # until end_date is on a Sunday.
    while ($end_date->day_of_week() != 7)
    {
        $end_date = $end_date->add(days => 1);
    }
	
    #Test to see if date is in DST range.
    if (DateTime->compare( $date, $start_date) >= 0 &&
        DateTime->compare( $date, $end_date) < 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

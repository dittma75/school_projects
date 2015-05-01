#! /usr/bin/perl -w

#Browser compatibility and XHTML 1.0/CSS 3 validation webline.
#Kevin Dittmar
#Created 3 March 2014
use CGI;
use strict;
my $dir = 'http://elvis.rowan.edu/~dittma75/web/resources/';
my $table_cgi = new CGI;
print $table_cgi->comment("Compatibilty and testing webline."),"\n";
print $table_cgi->table({-id=>'webline'},
	$table_cgi->Tr(
		$table_cgi->th(['Name']),
		$table_cgi->th({-colspan=>"2"}, ['Valid']),
		$table_cgi->th({-colspan=>"7"}, ['Tested Browsers'])
	),
	$table_cgi->Tr(
		$table_cgi->td([
			$table_cgi->a(
				{
					-href=>"http://elvis.rowan.edu/~dittma75/web/hw1/hw1.html",
					-title=>"Link to Homework Listing",
					-class=>"text_link"
				},
				$table_cgi->img(
					{
						-src=>$dir."black_mage.png",
						-alt=>""
					}
				),
				"Kevin Dittmar"
			),
			$table_cgi->a(
				{-href=>"http://validator.w3.org/check/referer"},
				$table_cgi->img(
					{
						-src=>$dir."valid-xhtml10.png",
						-alt=>"XHTML1.0",
						-class=>'valid_icon'
					}
				)
			),
			$table_cgi->a(
				{-href=>"http://jigsaw.w3.org/css-validator/check/referer?profile=css3"},
				$table_cgi->img(
					{
						-src=>$dir."vcss.gif",
						-alt=>"CSS 3",
						-class=>'valid_icon'
					}
				)
			),
			$table_cgi->img(
				{
					-src=>$dir."logo_IE.png",
					-alt=>"Internet Explorer",
					-title=>"Internet Explorer",
					-class=>'browser_icon'
				}
			),
			$table_cgi->img(
				{
					-src=>$dir."logo_FF.png",
					-alt=>"Firefox",
					-title=>"Mozilla Firefox",
					-class=>'browser_icon'
				}
			),
			$table_cgi->img(
				{
					-src=>$dir."logo_chrome.png",
					-alt=>"Chrome",
					-title=>"Google Chrome",
					-class=>'browser_icon'
				}
			),
			$table_cgi->img(
				{
					-src=>$dir."logo_opera.png",
					-alt=>"Opera",
					-title=>"Opera",
					-class=>'browser_icon'
				}
			),
			$table_cgi->img(
				{
					-src=>$dir."logo_konqueror.png",
					-alt=>"Konqueror",
					-title=>"Konqueror",
					-class=>'browser_icon'
				}
			),
			"W3M",
			"Lynx"
		])
	)
);

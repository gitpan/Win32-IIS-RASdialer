#!/usr/local/bin/perl -w
use strict;
use CGI qw(:standard);
use Net::Ping;
my $ping;
									
$ping = Net::Ping->new("udp", 10);
if ($ping -> ping("perl.com")) {
	print header;
	print "<html><head><title>Connected</title><meta http-equiv=\"refresh\" content=\"15;url=conntest.pl\"></head><body>";
	print "<center><h1>Connected</h1><h2>Disconnect?</h2><form><input type=\"button\" name=\"Disconnect\" value=\"Disconnect\" onclick=\"window.location=\'/disconnecting.html\'\"></form></center>";
	print end_html;
}
else {
	print header;
	print start_html	(-title =>'Connection Lost',
						-script =>{-language=>'JAVASCRIPT',
						-code=>'window.focus()'}
						);
	print "<center><h1>Connection Lost</h1><h2>Reconnect?</h2><form><input type=\"button\" name=\"reconnect\" value=\"Reconnect\" onclick=\"window.location=\'/connecting.html\'\"></form></center>";
	print end_html;
}
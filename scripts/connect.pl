#!/usr/local/bin/perl -w
use strict;
use CGI qw(:standard);
use Win32::Process;
my $cmdName = "C:\\winnt\\system32\\rasdial.exe";
my $args = "rasdial \"connect\"";
my $process;
my $processb;
my $XC;
my $msg;
my @ERRS;
#my $izzi = param('user');

Win32::Process::Create($process,
	$cmdName,
	$args,
	0,
	NORMAL_PRIORITY_CLASS,
	".") || &error();

$process->Wait(INFINITE);
Win32::Process::GetExitCode($process, $XC);

#if ($izzi == "izzi"){
#	print header;
#	print start_html ('HA HA!');
#	print "<center><img src=\"/finger.gif\" width=\"159\" height=\"236\"></center>";
#	print end_html;
#}
if ($XC == "756") {
	my $processb;
	until ($XC != "756") {
		Win32::Process::Create($processb,
			$cmdName,
			$args,
			0,
			NORMAL_PRIORITY_CLASS,
			".") || &error();
		$processb->Wait(INFINITE);
		Win32::Process::GetExitCode($processb, $XC);
	}
}

if ($XC == "0"){
	print header;
	print "<html><head><title>Connected</title><meta http-equiv=\"refresh\" content=\"1;url=conntest.pl\"><script type=\"text/javascript\">window.open(\"http://www.google.com\",\"_new\",\"width=800,height=600,toolbar,menubar,scrollbars,resizable,location,status\")</script></head><body>";
	print "<center><h1>Connected</h1><h2>Disconnect?</h2><form><input type=\"button\" name=\"Disconnect\" value=\"Disconnect\" onclick=\"window.location=\'/disconnecting.html\'\"></form></center>";
	print end_html;
}
else {
	open (ERRS, "dialerrors.txt") or die "can't findfile";
		foreach (<ERRS>){
			if ($_ =~ /$XC/){
				$msg = $_;
			}
		}
	close ERRS;
	print header;
	print start_html ('CRAP!');
	print "<center><h4>There was a problem connecting.</h4>";
	print $msg;
	print "<form><input type=\"button\" name=\"retry\" value=\"retry\" onclick=\"window.location=\'/connecting.html\'\"></form></center>";
	print end_html;
}

sub error {
	my $errmsg = Win32::FormatMessage(Win32::GetLastError());
	print header;
	print start_html ($errmsg);
	print "<center><h2>Your request sent back this error:</h2><h1>";
	print $errmsg;
	print "</h1></center></body></html>";
}

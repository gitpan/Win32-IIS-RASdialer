#!/usr/local/bin/perl -w
use strict;
use CGI qw(:standard);
use Win32::Process;
my $cmdName = "C:\\winnt\\system32\\rasdial.exe";
my $args = "rasdial \"connect\" /d";
my $process;
my $XC;
my $cmdNametst = "C:\\winnt\\system32\\ping.exe";
my $argstst = "ping -n 1 perl.com";
my $processtst;
my $XCtst = 0;

Win32::Process::Create($process,
	$cmdName,
	$args,
	0,
	NORMAL_PRIORITY_CLASS,
	".") || &error();

$process->Wait(INFINITE);
Win32::Process::GetExitCode($process, $XC);

if ($XC == "0") {
	until ($XCtst == "1"){
		Win32::Process::Create($processtst,
			$cmdNametst,
			$argstst,
			0,
			NORMAL_PRIORITY_CLASS,
			".") || &error();
			$processtst->Wait(INFINITE);
			Win32::Process::GetExitCode($processtst, $XCtst);
		if ($XCtst == "0"){
			Win32::Process::Create($process,
				$cmdName,
				$args,
				0,
				NORMAL_PRIORITY_CLASS,
				".") || &error();
		}
	}
	print header;
	print start_html ('Disconnected');
	print "<center><h1>Disconnected</h1><h2>Reconnect?</h2><form><input type=\"button\" name=\"Connect\" value=\"Reconnect\" onclick=\"window.location=\'/connecting.html\'\"></form></center>";
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
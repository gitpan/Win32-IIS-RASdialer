Windows Dial-up internet connection sharing connect/disconnect.
By Mujiburger
mujiburgerproductions@yahoo.com


Included files:

connect.html
connecting.html
disconnecting.html
connect.pl
disconnect.pl
conntest.pl
dialerrors.txt
readme.txt

	This script came about because windows 2000 mishandles shared dialup 
connections on a regular basis and because there are still places in the
world (The mountains of North Carolina) where broadband is not an option
AND because in those places when you are taking a vacation you have time
to sit around and hack something like this out.  Dial-on-Demand only works
when it feels like it and if you have kids in the house you are bound to
have some annoying software running on a computer somewhere that constantly
tries to connect triggering the connection to dial. That being said...

INSTALL:

This script was written very quickly for personal use so it has only been
tested in this environment:

Windows 2000 Server
Active State ActivePERL 5.8
IIS
I’m also on a little ad-hoc wireless network of 5 laptops…. Not that it matters.

The script assumes that you have all of these things running with default settings
and that IIS is properly configured to send .pl files to PERL for processing.  It
also assumes that rasdial.exe and ping.exe are both in their default location: /winnt/system32/
and that the dial up connection is named ‘connect’ and that internet connection sharing
is set up properly… you should probably also make sure that dial on demand is not turned
on.  If that is all done then installation is pretty easy…
	Uncompress the script… all the .html files should be in your root directory (wwwpub)
and everything else should go into ‘scripts’ which is one directory up from wwwpub.
Connect.html can be renamed to whatever you want it to be.  **In the file connect.pl you may have
to change line 6 (my $args = "rasdial \"connect\"";) to 'my $args = "rasdial \"connect\" [$USERNAME] [$PASSWORD]";'.
I've had trouble on some systems with rasdial.exe not pulling that info... yeah you will have the username 
and password for your dialup in plaintext... probably not the best way to do it...
	
	Now you can connect and disconnect the dial up connection from any computer on the network
by using a web browser to pull up connect.html…  it should be noted that any security or other
issues arising from the use of this script are your problem… use it at your own risk.
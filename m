Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3D1EP8d031739
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 18:14:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3D1EPDK031738
	for linux-mips-outgoing; Fri, 12 Apr 2002 18:14:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3D1E78d031730
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 18:14:09 -0700
Received: (qmail 2787 invoked from network); 13 Apr 2002 01:14:44 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 13 Apr 2002 01:14:44 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 407D43000BA; Sat, 13 Apr 2002 11:14:37 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP id B842E94
	for <linux-mips@oss.sgi.com>; Sat, 13 Apr 2002 11:14:37 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped? 
In-reply-to: Your message of "Fri, 12 Apr 2002 12:41:28 EST."
             <3CB71C48.B768A40D@cotw.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Apr 2002 11:14:31 +1000
Message-ID: <22260.1018660471@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Apr 2002 12:41:28 -0500, 
Scott A McConnell <samcconn@cotw.com> wrote:
>For my vr5432 based board (2.4.5) I can strip and run executables.
>
>If I strip a module, insmod dies in obj_load() with Floating point
>exception.

The rules for stripping a module are "unusual".  Some symbols have to
be kept even if they are static, because even static symbols can be
exported.  The combination of strip -g to remove all debugging data
plus the script below is safe.  Run as 'strip_module $(modprobe -l)'.

Also note that insmod supports compressed modules if you configure
modutils with --enable-zlib.  I do not know if busybox supports this
feature of insmod.

strip_module.

#!/bin/sh
#
#	Given a list of objects, strip all static symbols except those
#	required by insmod.
#
#	Copyright Keith Owens <kaos@ocs.com.au>.  GPL.
#	Sat Feb  1 12:52:17 EST 1997
#	
#	Mainly intended for reducing the size of modules to save space
#	on emergency and install disks.  Be aware that removing the
#	static symbols reduces the amount of diagnostic information
#	available for oops.  Not recommended for normal module usage.
#
#	This code requires the modules use MODULE_PARM and EXPORT_.
#	Do not strip modules that have not been converted to use
#	MODULE_PARM or are using the old method of exporting symbols.
#	In particular do not use on modules prior to 2.1.20 (approx).
#
#	The objects are stripped in /tmp, only if the strip works is
#	the original overwritten.  If the command line to strip the
#	symbols becomes too long, the strip is done in multiple passes.
#	Running strip_module twice on the same object is safe (and a
#	waste of time).
#

cat > /tmp/$$.awk <<\EOF
BEGIN	{
	strip = "/usr/bin/objcopy";
	nm = "/usr/bin/nm";
	cp = "/bin/cp";
	mv = "/bin/mv";
	rm = "/bin/rm";
	tmp = "/tmp";
	command_size = 400;	# arbitrary but safe

	getline < "/proc/self/stat";
	pid = $1;
	tmpcopy = tmp "/" pid ".object";
	nmout = tmp "/" pid ".nmout";

	for (i = 1; i < ARGC; ++i)
		strip_module(ARGV[i]);

	do_command(rm " -f " tmpcopy " " nmout);

	exit(0);
}

function strip_module(object,
	keep_symbol, to_strip, symbol, command, changed) {
	do_command(cp " -a " object " " tmpcopy);
	do_command(nm " " tmpcopy " > " nmout);
	# delete array_name sometimes breaks, internal error, play safe
	for (symbol in keep_symbol)
		delete keep_symbol[symbol];
	for (symbol in to_strip)
		delete to_strip[symbol];
	new_module_format = 0;
	while ((getline < nmout) > 0) {
		$0 = substr($0, 10);
		# b static variable, uninitialised
		# d static variable, initialised
		# r static array, initialised
		# t static label/procedures
		if ($1 ~ /[bdrt]/)
			to_strip[$2] = "";
		else if ($1 != "?")
			keep_symbol[$2] = "";
		else if ($0 ~ /\? __ksymtab_/)
			keep_symbol[substr($2, 11)] = "";
		else if ($0 ~ /\? __module_parm_/)
			keep_symbol[substr($2, 15)] = "";
		if ($0 ~ /\? __module/)
			new_module_format = 1;
	}
	close(nmout);
	command = "";
	changed = 0;
	if (new_module_format) {
		for (symbol in to_strip) {
			if (!(symbol in keep_symbol)) {
				changed = 1;
				if (length(command) > command_size) {
					do_command(strip command " " tmpcopy);
					command = "";
				}
				command = command " --strip-symbol=" symbol;
			}
		}
	}
	if (command != "") {
		changed = 1;
		do_command(strip command " " tmpcopy);
	}
	if (changed)
		do_command(mv " " tmpcopy " " object);
}

function do_command(command) {
	if ((ret = system(command)) != 0)
		giveup("command \"" command "\" failed " ret, ret);
}

function giveup(message, ret) {
	print "strip_module: " message > "/dev/stderr";
	exit(ret);
}
EOF

awk -f /tmp/$$.awk "$@"
ret=$?
rm -f /tmp/$$.awk
exit $ret

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA03571; Wed, 5 Jun 1996 13:49:12 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA23460 for linux-list; Wed, 5 Jun 1996 18:42:37 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA23448 for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jun 1996 11:42:35 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id LAA18157; Wed, 5 Jun 1996 11:35:29 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id LAA11745; Wed, 5 Jun 1996 11:35:26 -0700
Date: Wed, 5 Jun 1996 11:35:26 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606051835.LAA11745@fir.esd.sgi.com>
To: "David S. Miller" <dm@neteng.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: netbooting
In-Reply-To: <199606050712.AAA11472@neteng.engr.sgi.com>
References: <199606050712.AAA11472@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 > 
 > How much pain is involved in netbooting a kernel from an INDY?  Can I
 > just setup a /tftpboot area with the appropriate files and setup a
 > place to place the kernels for the bootloader to find and it'll work?
 > If so, can someone tell me what the necessary magic is that needs to
 > be done?

      It is easy.  On your host system, either put the kernel you want
to boot in /usr/local/boot/., or, in /etc/inetd.conf on your host
system, add a "-f" to the end of the line and "killall -HUP inetd" (to get
inetd to re-read /etc/inetd.conf).  Then, on the target system, first
set the "netaddr" PROM environment variable.  It should be set to the 
IP address (dotted notation) of the target system.  Check it with the
"printenv" PROM command.  Set it with

	setenv -p netaddr 1.2.3.4

(replacing "1.2.3.4" with the IP address of the target system).  Then,
do

	boot -f bootp()hostsystem:xyx

where "hostsystem" is the name of the host system and "xyz" is the
name of the kernel you want to boot.  If you add "-f" to the bootp
line, you can use a full path name on the target system in place of
"xyz".  Any additional words on the command line are passed to the booted
program as a UNIX-style argument list, and the environment variable list
is passed as well.  That is, on entry, the program will see argc in $a0,
argv in $a1, and environ in $a2.

     On an Indy, the booted kernel (or other program) must be
in MIPS ECOFF format.  On Moosehead, the kernel must be in ELF format.
The "-coff" option to the IRIX ld will cause it to create an ECOFF binary
instead of an ELF binary in the final link, even if all the input binaries
are in ELF format.  If you want to boot an ELF kernel on Indy, you have
to boot an indirect loader.  You can use the IRIX sash.  Put sash in the
volume header on the Indy, or in a bootp-able place on the host system.
Then do

	boot -f bootp()hostsystem:sash

or

	boot -f sash

and then, in either case

	boot -f bootp()hostsystem:xyx

where the last command is to the sash prompt, not the PROM prompt.  sash
knows how to load both ELF and ECOFF.

     On an Indy, the PROM would like you to link the kernel at or above
0x88002000, with the highest address in the linked binary being below
0x88400000 (4 MB). 

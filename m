Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA05252; Tue, 8 Apr 1997 12:52:25 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA24085 for linux-list; Tue, 8 Apr 1997 12:48:23 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA23997 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Apr 1997 12:48:13 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id MAA00762; Tue, 8 Apr 1997 12:48:12 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id MAA14047; Tue, 8 Apr 1997 12:48:07 -0700
Date: Tue, 8 Apr 1997 12:48:07 -0700
Message-Id: <199704081948.MAA14047@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: Mike Shaver <shaver@neon.ingenia.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: serial consoles, sash and other wonders
In-Reply-To: <199704081903.PAA01566@neon.ingenia.ca>
References: <199704081903.PAA01566@neon.ingenia.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver writes:
...
 >      On an Indy, the booted kernel (or other program) must be in MIPS
 > ECOFF format.  On Moosehead, the kernel must be in ELF format.  The
 > "-coff" option to the IRIX ld will cause it to create an ECOFF binary
 > instead of an ELF binary in the final link, even if all the input
 > binaries are in ELF format.  If you want to boot an ELF kernel on
 > Indy, you have to boot an indirect loader.  You can use the IRIX sash.
 > Put sash in the volume header on the Indy, or in a bootp-able place on
 > the host system.
 > 
 > -----
 > 
 > 1) Where's sash?  A find / on my Indy didn't turn up anything by that
 > name.

     Usually, it is only installed on the volume header, but you can
extract it into a regular file using dvhtool.  Sometimes you can find
it in /stand.  To extract sash:

<tanoak#1> dvhtool /dev/rvh

Command? (read, vd, pt, dp, write, bootfile, or quit): read
Volume? (/dev/rvh) 

Command? (read, vd, pt, dp, write, bootfile, or quit): vd
(d FILE, a UNIX_FILE FILE, c UNIX_FILE FILE, g FILE UNIX_FILE or l)?
	l

Current contents:
	File name        Length     Block #
	sgilabel            512           2
	sash             140800           3
	symmon           245760         278

(d FILE, a UNIX_FILE FILE, c UNIX_FILE FILE, g FILE UNIX_FILE or l)?
	g symmon /stand/symmon

(d FILE, a UNIX_FILE FILE, c UNIX_FILE FILE, g FILE UNIX_FILE or l)?
	q

Command? (read, vd, pt, dp, write, bootfile, or quit): quit
<tanoak#2> ls /stand/symmon
-rw-r--r--    1 root     sys       245760 Apr  8 12:26 /stand/symmon


 > 2) What exactly does `bootp-able' mean?  If I stick it in
 > /tftpboot/205.207.220.72/sash, does that count?  (The Indy is my only
 > IRIX box, and I don't have the installation CDs, so I'm somewhat
 > loathe to go screwing with the disk.)

    See the tftpd man page.  The default directory for IRIX tftpd is
/var/boot/, so /var/boot/sash and /var/boot/vmlinux would do for boot files.

    If you don't have the installation CD's, I recommend that you back
up the disk, perhaps to a second disk (complete with volume header and
root partitions), so you can recover from any potential failure.  The
"cp" command in the prom can be used to copy disk to disk to recover.

 > 3) Once I get it booting (pls, pls) will the Linux kernel know how to
 > talk to the serial console?

      I believe that David Miller had that working.  How do you tell linux
to use a serial port as the console (in single-user mode)?  For IRIX,
one does

	setenv -p console d

(for "debug" console, as opposed to the usual "g" for "graphics" console).

 > 4) I've just got the kernel as /tftpboot/205.207.220.72/vmlinux.  DO I
 > need to add .IP22 or anything?

      If you put sash and vmlinux in /var/boot, then do

	boot -f bootp()bootphost:sash

from the PROM, where bootphost is the hostname of your IRIX system, and then

	boot -f bootp()bootphost:vmlinux

from sash, all should be well.  Note that you can boot an ELF kernel directly
from the PROM on an Indy with a newer PROM image (such as the PROM for an 
Indy R5000 system), so try that first.  If it works, your Indy has the newer
PROM, and you can forget about sash.

     By the way, it is pretty easy to write a little program to convert
a kernel ELF binary to an ECOFF binary, discarding most of the symbols and
other stuff, assuming you have the header files for the file formats.
(The result would not be acceptable to many of the tools, such as dbx,
but it would be bootable.)

     For a production linux for the Indy, the most reasonable approach,
however, would be to make silo or whatever boot program you are using be
ECOFF, so that old PROMs are supported.

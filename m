Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA15788; Thu, 7 Aug 1997 10:32:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA15797 for linux-list; Thu, 7 Aug 1997 10:31:51 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA15782 for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 10:31:48 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA08417
	for <linux@cthulhu.engr.sgi.com>; Thu, 7 Aug 1997 10:31:43 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id MAA21512;
	Thu, 7 Aug 1997 12:30:46 -0500
Date: Thu, 7 Aug 1997 12:30:46 -0500
Message-Id: <199708071730.MAA21512@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Pending fixes
X-Info: When in doubt, blame the network
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

    Here is a smallish list of tasks that should be done, for those
that want to start coding some bits:

	- Find and fix this bug:  

cat > argv-bad.c << EOF
main (int argc, char *argv []){ printf ("%s\n", argv [0]); }
EOF
gcc argv-bad.c -o argv-bad
./argv-bad

	- NFS is crashing after heavy usage.  This is not the same 
	  problem that the 2.1 tree has on the intel.  Every time it
	  crashes on me it fails around the end of do_bottom_half.

	- Fix the ethernet driver, it is timing out too frequently.

	- Look up the semaphore IRIX api from the developers toolbox
	  in www.sgi.com, figure out how these C functions use the
	  /dev/usema and /dev/usemaclone devices.  

	- If you feel like it, implement those devices ;-)

   I personally installed lots of Ralf's RPMS on my Indy and compiled
some more programs to prepare for debugging the Xsgi IRIX server, with
the exception of the semaphore devices, the mouse and the newport
context switch code, everything else is ready now.  I will work on
getting gdb up next, since I refuse to debug this beast with
printf/printk :-).

Miguel.

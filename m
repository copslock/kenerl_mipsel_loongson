Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA393289 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Jan 1998 09:47:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA23195 for linux-list; Mon, 5 Jan 1998 09:46:31 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA23183 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 09:46:29 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA12616
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 09:46:28 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xpGbW-0027ZXC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 5 Jan 1998 18:46:22 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xpGbK-002OhsC; Mon, 5 Jan 98 18:46 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id SAA02852;
	Mon, 5 Jan 1998 18:45:10 +0100
Message-ID: <19980105184510.65220@alpha.franken.de>
Date: Mon, 5 Jan 1998 18:45:10 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: gcc -shared ... -lc ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

while compiling redhat 5.0 rpms, I've found something very strange, when
building shared libraries. Some of the built shared libs are very big and
a nm on them shows, that the whole libc (I guess so) is included.  Binaries
inked against these library just dump core. The built line for these shared 
libs always ends with a -lc. Now I'm wondering wether this is a ld bug or
just a user error. What's really weird is the following patch from one
of the redhat rpms:

--- termcap-2.0.8/Makefile.ewt  Tue Jul  8 11:08:00 1997
+++ termcap-2.0.8/Makefile      Tue Jul  8 11:08:12 1997
@@ -41,7 +41,7 @@
 
 $(SHARED_LIB): $(OBJS)
        cd pic; \
-       $(CC) -shared -o ../$@ -Wl,-soname,$(SONAME_SHARED_LIB) $(OBJS)
+       $(CC) -shared -o ../$@ -Wl,-soname,$(SONAME_SHARED_LIB) $(OBJS) -lc
 
 pic:
        -if [ ! -d pic ]; then mkdir pic; fi

So it looks like the ld for alpha and i386 don't include the whole libc
when linked with the comand line above. Any hints ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA479278; Fri, 22 Aug 1997 18:45:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA27321 for linux-list; Fri, 22 Aug 1997 18:45:12 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA27293 for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 18:45:09 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA11792
	for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 18:45:08 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id VAA26951; Fri, 22 Aug 1997 21:44:23 -0400
Date: Fri, 22 Aug 1997 21:44:23 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: miguel@nuclecu.unam.mx, linux@cthulhu.engr.sgi.com
Subject: Re: Kernel compile errors...
In-Reply-To: <199708230125.DAA27638@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970822212938.26054A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 23 Aug 1997, Ralf Baechle wrote:
> > > Strange, I have been using the gcc and binutils packages put together
> > > by Ralf for a long time, it is not the stock gcc/binutils, probably
> > > this is your problem?
> > I don't think so.  The ones I'm using are those from Ralf as well.  I will
> > double check to make sure.
> This is a bug which I fixed in my version of binutils, so ...

... so I don't have the right version.

I'm using the RPM's I create in:
ftp://ftp.linux.sgi.com/pub/crossdev/i486-linux/mips-linux/

Those are based on the executables found in the .tar.gz in that directory.
I know that because I made the RPM, and because the file sizes match. They
are:

-rwxr-xr-x   1 root     root        27856 Jul 25 20:21 mips-linux-ar*
-rwxr-xr-x   1 root     root       193440 Jul 25 20:21 mips-linux-as*
-rwxr-xr-x   2 root     root         6544 Sep 20  1996 mips-linux-c++*
-rwxr-xr-x   1 root     root        24428 Jul 25 20:21 mips-linux-c++filt*
-rwxr-xr-x   2 root     root         6544 Sep 20  1996 mips-linux-g++*
-rwxr-xr-x   1 root     root        41960 Jul 25 20:21 mips-linux-gasp*
-rwxr-xr-x   1 root     root        50880 Sep 20  1996 mips-linux-gcc*
-rwxr-xr-x   1 root     root       155792 Jul 25 20:21 mips-linux-ld*
-rwxr-xr-x   1 root     root        36924 Jul 25 20:21 mips-linux-nm*
-rwxr-xr-x   1 root     root       152396 Jul 25 20:21 mips-linux-objcopy*
-rwxr-xr-x   1 root     root       151304 Jul 25 20:21 mips-linux-objdump*
-rwxr-xr-x   1 root     root        27856 Jul 25 20:21 mips-linux-ranlib*
-rwxr-xr-x   1 root     root        14220 Jul 25 20:21 mips-linux-size*
-rwxr-xr-x   1 root     root        14172 Jul 25 20:21 mips-linux-strings*
-rwxr-xr-x   1 root     root       152396 Jul 25 20:21 mips-linux-strip*

Is this the correct binutils, and if not, where is it?

- Alex

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA138177; Sat, 9 Aug 1997 11:36:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA29157 for linux-list; Sat, 9 Aug 1997 11:36:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA29140 for <linux@engr.sgi.com>; Sat, 9 Aug 1997 11:36:27 -0700
Received: from odin.waw.com (ns1.waw.com [194.51.88.250]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA00622
	for <linux@engr.sgi.com>; Sat, 9 Aug 1997 11:36:25 -0700
	env-from (vincent@waw.com)
Received: from odin.waw.com (vincent@mail.waw.com [194.51.88.252]) by odin.waw.com (8.7.3/8.7.3/waw) with SMTP id UAA27158; Sat, 9 Aug 1997 20:40:06 +0100
Date: Sat, 9 Aug 1997 20:40:06 +0100 (GMT+0100)
From: Vincent Renardias <vincent@waw.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: your mail
In-Reply-To: <199708091741.TAA09294@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970809195755.24185B-100000@odin.waw.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 9 Aug 1997, Ralf Baechle wrote:

> > 2/ While using the crossdev gcc, several times I got complains about a
> > file 'sgidefs.h' missing (from
> > /usr/local/lib/gcc-lib/mips-linux/2.7.2/include/va-mips.h, line 41). 
> > Commenting the '#include' file made the compile work, but I not sure it's
> > the right fix. 
> 
> Not the right thing, but won't hurt.  I shows that your libc is
> not installed correctly.

I just installed the binutils/gcc crossdev packages from
ftp.linux.sgi.com. Should i also install the glibc-2.0.4-1.tar.gz package
from /pub/mips-linux? In case it matters my native libc is glibc-2.0.4
(i386).

[Thanx for the explanation on endianess ;]

	Cordialement,

--
-     ** Linux **         +-------------------+             ** WAW **     -
-  vincent@debian.org     | RENARDIAS Vincent |          vincent@waw.com  -
-  Debian/GNU Linux       +-------------------+      http://www.waw.com/  -
-  http://www.debian.org/           |            WAW  (33) 4 91 81 21 45  -
---------------------------------------------------------------------------

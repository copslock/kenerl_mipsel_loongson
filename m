Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA13731; Tue, 27 May 1997 13:41:24 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA20943 for linux-list; Tue, 27 May 1997 13:41:10 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA20926 for <linux@relay.engr.SGI.COM>; Tue, 27 May 1997 13:41:08 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA17607
	for <linux@relay.engr.SGI.COM>; Tue, 27 May 1997 13:41:01 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id WAA12797; Tue, 27 May 1997 22:37:12 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705272037.WAA12797@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id WAA07439; Tue, 27 May 1997 22:37:11 +0200
Subject: Re: strace/truss equiv?
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Tue, 27 May 1997 22:37:11 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199705271919.PAA21206@neon.ingenia.ca> from "Mike Shaver" at May 27, 97 03:19:29 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> OK, I'll bite.
> What's the strace/truss equivalent under IRIX?
> 
> I'm trying to figure out why my "dynamically-linked" hello world
> binaries are 115K, and I can't tell where the heck the linker is
> finding the static libs.

The GNU linker has a verbose option which will make it print all the
files as it tries to open them.  Check the docs.  You should have

<prefix>/mips-linux/lib/libc.so             (A linker script)
<prefix>/mips-linux/lib/libc.so.6           (A symlink to the acutal shlib)
<prefix>/mips-linux/lib/libc-<version>.so   (The actual shared library image)
<prefix>/mips-linux/lib/libc.a              (The static libc)

Note that libc.so is an ASCII file containing a short linker script
unlike Linux libc.

Does that help?

  Ralf

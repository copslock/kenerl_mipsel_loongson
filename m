Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA12388; Fri, 20 Jun 1997 11:53:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA00847 for linux-list; Fri, 20 Jun 1997 11:53:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA00808 for <linux@engr.sgi.com>; Fri, 20 Jun 1997 11:53:08 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA26183
	for <linux@engr.sgi.com>; Fri, 20 Jun 1997 11:53:04 -0700
	env-from (ralf@Julia.DE)
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id TAA27076;
	Fri, 20 Jun 1997 19:43:05 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id UAA31057; Fri, 20 Jun 1997 20:42:52 +0200
Message-Id: <199706201842.UAA31057@kernel.panic.julia.de>
Subject: Re: MAP_AUTOGROW
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 20 Jun 1997 20:42:52 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199706201817.OAA30967@neon.ingenia.ca> from "Mike Shaver" at Jun 20, 97 02:17:29 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Thus spake Ralf Baechle:
> > > "Your" mkdep.c uses MAP_AUTOGROW, which doesn't appear in my Intel
> > > kernel sources.
> > > 
> > > This makes it kinda hard to xcompile. =)
> > > 
> > > I'm going to try just removing the reference, and see if it breaks anything.
> > 
> > Uhh...  That's an ugly hack which I added to make the things run on
> > IRIX and Solaris.  I knew that it has some problems ...
> 
> If I add something like:
> #ifndef MAP_AUTOGROW
> #define MAP_AUTOGROW 0
> #endif
> 
> to the file and commit it, will that work OK?

No, that's also an incorrect solution.  Let me explain the bug in mkdep.
When mkdep processes a file it does not read it into memory but it uses
open(2) and mmap(2) and then parses the file using a highly optimized
state machine.  When mkdep reaches the end of the file the state machine
may access some bytes beyond the mapped file.  Under normal circumstances
this makes no problems.  If however the excess bytes are on the next page
the mkdep will be sent a SIGBUS.

This only happens on systems where the mmap does strictly conform to
standards like IRIX or Solaris.  For Linux mkdep uses a little trick,
it tries to make more of the file than the file is long and Linux honors
that trick by not sending the signal for an attempted access to the
trailing bytes.  By my (very strict) interpretation of POSIX / XPG4 Linux
does the wrong thing and mkdep is based on this special Linux behaviour.

The way I glue this by using MAP_AUTOGROW is also broken ...

  Ralf

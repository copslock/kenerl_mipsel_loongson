Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA01862; Tue, 3 Jun 1997 11:29:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA17388 for linux-list; Tue, 3 Jun 1997 11:28:50 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA17355 for <linux@relay.engr.SGI.COM>; Tue, 3 Jun 1997 11:28:47 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA00134
	for <linux@relay.engr.SGI.COM>; Tue, 3 Jun 1997 11:28:33 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from flake (ralf@flake.uni-koblenz.de [141.26.4.37]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id UAA01401; Tue, 3 Jun 1997 20:23:49 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706031823.UAA01401@informatik.uni-koblenz.de>
Received: by flake (SMI-8.6/KO-2.0)
	id UAA04106; Tue, 3 Jun 1997 20:23:43 +0200
Subject: Re: The Plan For Userland(tm)
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Tue, 3 Jun 1997 20:23:42 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199706021821.OAA12315@neon.ingenia.ca> from "Mike Shaver" at Jun 2, 97 02:21:47 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Here's my plan for getting the userland stuff to critical mass:
> - kernel and glibc sync'd.  Shouldn't be too hard, once I get the new
> kernel from Ralf.

Sorry, it's taking a bit longer.  In the meantime I synced with .42;
still need to fix some more bugs.

>                   (At the very least, I need the SOCK_{STREAM,DGRAM}
> stuff sorted out, and I'd like to figure out a good strategy for
> asm/atomic.h.)

Whith what package again did you have the problems with atomic.h?

> - rpm built
> - native gcc built as an rpm
> - start building rpms natively, and installing them on a fresh
> partition
> 
> I think the SCSI driver is dodgy (this may be a known problem), and I
> need to get glibc installed on neon to ease the configuration issue,
> but I think we're well on our way.
> 
> I'm _definitely_ going to need more disk space on neon, but I can
> steal the ext2 one from bogomips in the short-term.

Yeah, and if there won't be xfs for linux I'd really like to see ext2
support for IRIX ...

> Oh, BTW:
> [shaver@neon shaver]$ telnet bogomips

ssh works also pretty good.  The only problem it has is that my X
pseudo port has still a "couple" of bugs.

  Ralf

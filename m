Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA16377; Thu, 14 Aug 1997 16:18:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA11276 for linux-list; Thu, 14 Aug 1997 16:16:54 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA11237 for <linux@cthulhu.engr.sgi.com>; Thu, 14 Aug 1997 16:16:41 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA00021
	for <linux@cthulhu.engr.sgi.com>; Thu, 14 Aug 1997 16:16:17 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id BAA06429; Fri, 15 Aug 1997 01:15:42 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708142315.BAA06429@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id BAA02579; Fri, 15 Aug 1997 01:15:22 +0200
Subject: Re: clock skew and ethernet timeouts
To: marks@sun470.sun470.rd.qms.com (Mark Salter)
Date: Fri, 15 Aug 1997 01:15:22 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199708132209.RAA31518@speedy.rd.qms.com> from "Mark Salter" at Aug 13, 97 05:09:32 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I also noticed that the linux time of day clock falls behind
> real time whenever these timeouts occur. I decided to take a
> look at this side of the problem and discovered that interrupts
> are being turned off for extended periods of time. I modified
> the timer interrupt handler to print a message if it detects
> a missed system tick. Sure enough, every ethernet timeout is
> accompanied by a message coming from the timer interrupt. The
> message indicates that the timer interrupt was held off for
> as much as 45ms!

I've never seen these problems in my configurations.  However I've fixed
a couple of interrupt realted things which I'll commit into the CVS
as soon as I'm in Mountain View.  One of these, a console bug might
actually have been the cause of the extreme long interrupt disable time
you have seen.

There are more thing which need to be reworked with resprect to interrupts.
For example cache flushing turns interrupts off for sometimes several
thousand cycles even though this is only required for certain buggy CPUs
like the R4600 v1.x.  And even there are better workarounds.  General
rule about cli():  Think about it if you really need it.  Then think again
about it.  If you're finished wnd still think cli() might be a good solution,
then think once again about it ...

For me the "most wanted - fix on sight" bug is currently a memory corruption
problem.  Other than that I was able to compile >92mb RPM binaries several
times in a row.  It's just that that memory corruption problem corrupts
disk data structures in memory which might be written back later ...

  Ralf

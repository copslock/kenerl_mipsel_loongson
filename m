Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA512075; Mon, 18 Aug 1997 16:28:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA23279 for linux-list; Mon, 18 Aug 1997 16:27:10 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA23265 for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 16:27:08 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA25228; Mon, 18 Aug 1997 16:34:36 -0700
Date: Mon, 18 Aug 1997 16:34:36 -0700
Message-Id: <199708182334.QAA25228@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: linux@fir.engr.sgi.com
Subject: Re: clock skew and ethernet timeouts
In-Reply-To: <199708142315.BAA06429@informatik.uni-koblenz.de>
References: <199708132209.RAA31518@speedy.rd.qms.com>
	<199708142315.BAA06429@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
...
 > There are more thing which need to be reworked with resprect to interrupts.
 > For example cache flushing turns interrupts off for sometimes several
 > thousand cycles even though this is only required for certain buggy CPUs
 > like the R4600 v1.x.  And even there are better workarounds.  General
 > rule about cli():  Think about it if you really need it.  Then think again
 > about it.  If you're finished wnd still think cli() might be a good solution,
 > then think once again about it ...
...

     In IRIX, I had the cache flushing code, when doing writebacks on
the R4600 and the like, reenable interrupts every page, to limit the
wait time (to about 50 us. on an Indy).  I patched out the extra instructions
to disable and reenable interrupts on processors which did not require them.
Assuming that the code uses index invalidate or index writeback invalidate
when the buffer is larger than the cache, the invalidate-only case (without
writeback) is short enough (5 us. or less) that reenabling interrupts is
not needed.  The writeback case takes much longer, in the worst case,
because each cache line must be written to memory, taking about 400 ns.
each on the Indy.

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA13409; Mon, 12 Aug 1996 14:10:11 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA22942 for linux-list; Mon, 12 Aug 1996 21:10:06 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA22927 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 14:10:04 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA29622 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 14:08:20 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id OAA13322; Mon, 12 Aug 1996 14:09:39 -0700
Message-Id: <199608122109.OAA13322@neteng.engr.sgi.com>
To: Steve Alexander <sca@refugee.engr.sgi.com>
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: lm@neteng.engr.sgi.com, Nigel Gamble <nigel@cthulhu.engr.sgi.com>,
        Alistair Lambie <alambie@wellington.sgi.com>,
        ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: Linux: the next step 
Date: Mon, 12 Aug 1996 14:09:39 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

: However, I agree that more locking is not the answer.  Eliminating as much
: shared, global data as possible is the answer.  Nexus doesn't really do
: anything towards that end that I can see.

Yeah.

: >Linux already has a RT kernel.  I just reviewed a fantastic Usenix paper
: >that added RT to Linux - fully preemptable, hard real time to < 100 usecs,
: >and less than 3K lines of code change.  Their test case was a 100Khz clock
: >pulse on a parallel port; they got it every time, with less than 15usecs
: >skew, while the system was tar-ing one file system to another, running 
: >netscape, and generally doing same old Unix stuff just like normal.  It's
: >really impressive and very uninvasive.
: 
: I'd like to see that when it comes out.

You'll have to borrow my copy, Usenix rejected it.  Fuckheads.

: >Finally, think about this:  how many times have you had a "great idea"
: >for better IRIX performance, gone off an prototyped it, only to find
: >that it makes no difference?  Linux lets you test out those ideas and
: >see the real performance difference, unadulterated by any surrounding
: >bloat.  That's cool.  We want that.
: 
: If it makes no difference, what difference does it make what platform you try
: it on?  If it does make a difference, you would be able to measure it despite
: the underlying bloat, and again the underlying platform makes no difference.

Suppose you are trying to reach some performance point, X.  Whatever that
is.  You do some work that would, in theory, get you closer to point X.
It doesn't, you can't see the difference.  Just for the sake of argument,
suppose that that work was indeed correctly focussed on something that
needed to get fixed in order to get to point X.  But the effects of that
work were overshadowed by all of the surrounding bloat.  That doesn't mean
that the work was useless or wrong, it means that the bloat dominates.  If
the bloat wasn't there, you would need to do the work to get to X.

A more concrete example: IRIX syscall entry is something like 15-30 usecs,
if I remember correctly.  On Linux, it's about .5 - 5 usecs.  In the
Linux world, optimizations that made a 100% difference would be lost in
the bloat in IRIX.  Does that mean that those optimizations are pointless?

Not to me, it doesn't.  I want a kernel that is fast enough that dropping
into to diddle something and then popping back out is about a procedure
call, no more.  IRIX is miles from that, Linux is approaching it.

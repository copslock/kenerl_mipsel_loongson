Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA20537; Fri, 2 Aug 1996 18:13:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA29306 for linux-list; Sat, 3 Aug 1996 01:11:45 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA29301 for <linux@cthulhu.engr.sgi.com>; Fri, 2 Aug 1996 18:11:44 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA13659 for <linux@yon.engr.sgi.com>; Fri, 2 Aug 1996 18:10:07 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id SAA20491; Fri, 2 Aug 1996 18:11:31 -0700
Message-Id: <199608030111.SAA20491@neteng.engr.sgi.com>
To: Nigel Gamble <nigel@cthulhu.engr.sgi.com>
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: Alistair Lambie <alambie@wellington.sgi.com>, ariel@cthulhu.engr.sgi.com,
        linux@yon.engr.sgi.com
Subject: Re: Linux: the next step 
Date: Fri, 02 Aug 1996 18:11:31 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

: Dream on!  Here in ISD (Indigo2 land), we're working flat out just to
: get IRIX to run on any new platforms at first shipment, with all
: the neat features supported.  I think you'll find the same
: is true of all the other product divisions.

It's hard work.  I know people are working hard to keep IRIX going.  And 
there is a lot in IRIX that isn't in Linux.

However, there's a lot in IRIX that shouldn't be in IRIX, let alone Linux.
One of the cool things that David has done this summer was to keep the
generic code free of #ifdef *_WAR stuff that is littered throughout the
IRIX kernel.

: We are neither a hardware company nor a software company.
: We are a *systems* company.  

I agree.  But answer these questions:

	. would anyone buy our hardware if we didn't put the software on it?

	. would anyone buy our software on some other hardware?

I think that gives you an answer to what kind of comapny we really are.

: As for Linux,
: when will it support true symmetric multiprocessing with fine-grained
: semaphore and mutex locking, and a fully preemptible kernel?

The fine grained locking is a lose.  It costs us way too much and what I
am seeing is a trend backwards towards coarser grained locking.  If this
wasn't true, why did we build lego?  Why are we building Nexus?

Linux already has a RT kernel.  I just reviewed a fantastic Usenix paper
that added RT to Linux - fully preemptable, hard real time to < 100 usecs,
and less than 3K lines of code change.  Their test case was a 100Khz clock
pulse on a parallel port; they got it every time, with less than 15usecs
skew, while the system was tar-ing one file system to another, running 
netscape, and generally doing same old Unix stuff just like normal.  It's
really impressive and very uninvasive.

: At the San Diego Usenix earlier this year, Linus Torvalds
: thought that the probable answer was "not anytime soon".
: (By the way, in order to do this correctly, every device driver would
: have to be rewritten.)  

Almost none of the drivers need a rewrite for the RT stuff.  That work was
a good example of what I call "orthogonal thinking" or using a completely
different approach to solve the problem.

: Linux would need this *at a minimum* before
: there is any hope that it would supplant IRIX on the current
: generation of hardware, let alone any future new platforms.

Linux isn't going to replace IRIX any time soon.  However, Linux is
going to show off MTI's chips and SGI's hardware in a somewhat more
positive light.  If all that happens is that people get psyched about
the "hidden" performance in SGI hardware and get IRIX to show off that
performance, then the paltry amount we've spent on Linux will be worth it.

Finally, think about this:  how many times have you had a "great idea"
for better IRIX performance, gone off an prototyped it, only to find
that it makes no difference?  Linux lets you test out those ideas and
see the real performance difference, unadulterated by any surrounding
bloat.  That's cool.  We want that.

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA15492; Mon, 12 Aug 1996 14:50:22 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA02665 for linux-list; Mon, 12 Aug 1996 21:50:07 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA02659 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 14:50:05 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA29836 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 14:48:17 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id OAA15461; Mon, 12 Aug 1996 14:49:45 -0700
Message-Id: <199608122149.OAA15461@neteng.engr.sgi.com>
To: jes@machine.engr.sgi.com (John E. Schimmel)
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: sca@refugee.engr.sgi.com (Steve Alexander), lm@neteng.engr.sgi.com,
        nigel@cthulhu.engr.sgi.com, alambie@wellington.sgi.com,
        ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: Linux: the next step 
Date: Mon, 12 Aug 1996 14:49:45 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

: > No doubt to make room for some paper on TCL scripts or something.  Feh.
: > Yeah, if you can make me a copy or convince the authors to send me one I'd
: > appreciate it.
: 
: Now wait a minute here.  Read the paper before commenting.
: They create a "real-time" thread under Linux.  That does not
: mean that it does anything, that the OS has real time support,
: etc.  There was nothing particularly new about what it did.

Here's what they did:  they took over control of interrupt disable/enable
and dispatch.  They run Linux as a thread and allow you to have 0 or more
real time threads.   If all you are doing is running Linux, it looked
to me like there was minimal impact to the performance of the system.

Real time threads run on the bare hardware, they have little
integration with the OS, other than a pipe like communications device.
The programming paradigm is you run two processes, one real time that
gathers events and stuffs them in the "pipe", and one normal that reads
events out of the pipe and does time _un_critical processing.

They can guarentee real time response of 10Khz, with less than 15 usec
variation.  That was with Linux running a 

	tar f - /usr | (cd /newusr; tar xf -)

a web browser, X, etc, etc.  Good luck doing that on IRIX up.  Maybe MP.

I thought the new work was the idea of *not* buggering up your entire OS
to support real time.  They give the real time guys ownership of the CPU
with minimal impact on the rest of the system.  And they had to do next
to nothing to make this work, they just use Unix for everything except
the lowest level of RT work.  I dunno, maybe I'm projecting some pipe
dream, but I think this is really cool work.   Points for orthogonal
thinking on their part.

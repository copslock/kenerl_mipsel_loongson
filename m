Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA13760; Mon, 12 Aug 1996 14:22:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA25633 for linux-list; Mon, 12 Aug 1996 21:22:20 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA25618 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 14:22:18 -0700
Received: from refugee.engr.sgi.com (refugee.engr.sgi.com [150.166.61.22]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA29714 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 14:20:33 -0700
Received: from refugee.engr.sgi.com by refugee.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id OAA18080; Mon, 12 Aug 1996 14:20:39 -0700
Message-Id: <199608122120.OAA18080@refugee.engr.sgi.com>
X-Mailer: exmh version 1.6.7 5/3/96
To: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
Cc: lm@neteng.engr.sgi.com, Nigel Gamble <nigel@cthulhu.engr.sgi.com>,
        Alistair Lambie <alambie@wellington.sgi.com>,
        ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: Linux: the next step 
In-reply-to: Message from lm@gate1-neteng of 12 Aug 1996 14:09:39 PDT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 1996 14:20:39 -0700
From: Steve Alexander <sca@refugee.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

lm@gate1-neteng (Larry McVoy) writes:
>You'll have to borrow my copy, Usenix rejected it.  Fuckheads.

No doubt to make room for some paper on TCL scripts or something.  Feh.
Yeah, if you can make me a copy or convince the authors to send me one I'd
appreciate it.

>A more concrete example: IRIX syscall entry is something like 15-30 usecs,
>if I remember correctly.  On Linux, it's about .5 - 5 usecs.  In the
>Linux world, optimizations that made a 100% difference would be lost in
>the bloat in IRIX.  Does that mean that those optimizations are pointless?

To some degree, yes.  This is why application developers often have a lot of
platform-specific code; optimizations that work on one system won't necessarily
work on all systems.  I'm not saying this is good, mind you.

-- Steve

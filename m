Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA13577; Mon, 12 Aug 1996 14:20:22 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA24984 for linux-list; Mon, 12 Aug 1996 21:20:08 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA24960 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 14:20:06 -0700
Received: from refugee.engr.sgi.com (refugee.engr.sgi.com [150.166.61.22]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA29660 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 14:18:21 -0700
Received: from refugee.engr.sgi.com by refugee.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id OAA18053; Mon, 12 Aug 1996 14:18:18 -0700
Message-Id: <199608122118.OAA18053@refugee.engr.sgi.com>
X-Mailer: exmh version 1.6.7 5/3/96
To: Bob English <renglish@ratliff.engr.sgi.com>
Cc: lm@gate1-neteng.engr.sgi.com (Larry McVoy),
        Nigel Gamble <nigel@cthulhu.engr.sgi.com>,
        Alistair Lambie <alambie@wellington.sgi.com>,
        ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com
Subject: Re: Linux: the next step 
In-reply-to: Message from renglish@ratliff of 12 Aug 1996 13:52:47 PDT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 1996 14:18:18 -0700
From: Steve Alexander <sca@refugee.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Bob English <renglish@ratliff> writes:
>If you look at larry's context switch and pipe benchmarks, you'll see
>that they run much faster on a single CPU than on two or more.  A lot of
>the difference is due to fine-grained locking, which causes more dirty
>cache lines to thrash than is actually necessary for the operations
>involved.  Pipe communication takes locks at the vnode and inode
>level.  Context switches take locks on threads, accounting structures,
>and queues.

If I look at those benchmarks, they'll probably run faster on Linux on an Indy
than they do on IRIX on an Indy, so I doubt the locking is the big problem we
need to be looking at.  I don't have numbers from David to quote, so maybe I'm
wrong.  I'd like to be wrong.

-- Steve

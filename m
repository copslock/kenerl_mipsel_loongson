Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA13804; Mon, 12 Aug 1996 14:25:26 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA26341 for linux-list; Mon, 12 Aug 1996 21:25:22 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA26334 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Aug 1996 14:25:20 -0700
Received: from ratliff.engr.sgi.com (ratliff.engr.sgi.com [150.166.42.14]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA29751 for <linux@yon.engr.sgi.com>; Mon, 12 Aug 1996 14:23:35 -0700
Received: from localhost by ratliff.engr.sgi.com via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id OAA08877; Mon, 12 Aug 1996 14:24:15 -0700
Message-Id: <199608122124.OAA08877@ratliff.engr.sgi.com>
To: Steve Alexander <sca@refugee.engr.sgi.com>
cc: Bob English <renglish@ratliff.engr.sgi.com>,
        lm@gate1-neteng.engr.sgi.com (Larry McVoy),
        Nigel Gamble <nigel@cthulhu.engr.sgi.com>,
        Alistair Lambie <alambie@wellington.sgi.com>,
        ariel@cthulhu.engr.sgi.com, linux@yon.engr.sgi.com,
        renglish@ratliff.engr.sgi.com
Subject: Re: Linux: the next step 
In-reply-to: Your message of "Mon, 12 Aug 96 14:18:18 PDT."
             <199608122118.OAA18053@refugee.engr.sgi.com> 
Date: Mon, 12 Aug 96 14:24:15 -0700
From: Bob English <renglish@ratliff.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <199608122118.OAA18053@refugee.engr.sgi.com> you write:
>If I look at those benchmarks, they'll probably run faster on Linux on an Indy
>than they do on IRIX on an Indy, so I doubt the locking is the big problem we
>need to be looking at.  I don't have numbers from David to quote, so maybe I'm
>wrong.  I'd like to be wrong.

I was comparing Irix MP times vs. Irix UP times, and the difference is
both substantial and locking related.  Of course, if Irix were as
efficient on a UP as Linux, the difference might be a factor of 10
rather than a factor of 2 :-).

--bob--

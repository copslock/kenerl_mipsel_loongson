Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA513236 for <linux-archive@neteng.engr.sgi.com>; Mon, 19 Jan 1998 13:01:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA12343 for linux-list; Mon, 19 Jan 1998 12:57:33 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA12318; Mon, 19 Jan 1998 12:57:24 -0800
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA01688; Mon, 19 Jan 1998 12:57:23 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id MAA21373;
	Mon, 19 Jan 1998 12:57:22 -0800 (PST)
Received: from netscape.com ([205.217.243.3]) by dredd.mcom.com
          (Netscape Messaging Server 3.0)  with ESMTP id AAA8869;
          Mon, 19 Jan 1998 12:57:19 -0800
Message-ID: <34C3B980.74B882C6@netscape.com>
Date: Mon, 19 Jan 1998 12:37:20 -0800
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.02 [en] (X11; U; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
CC: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: help new people get on board
References: <199801192028.MAA26854@oz.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon wrote:
> 
> To whom it may concern...
> 
> It seems that tere have been a recent surge in people who
> want to try SGI/Linux on their Indy's.  Unfortunately, despite
> having about 10 people already running Linux on their SGIs
> we still don't have a really easy, complete, up-to-date,
> and straightforward doc on how to get there...
> 
> For example:
> 
>         ftp://ftp.linux.sgi.com/pub/mips-linux/GettingStarted/README
> 
> says that Linux-installer-0.1.tar.gz is broken.

Linux-installer-0.1b.tar.gz is being uploaded as I type this.
It's the old installer package with the actual installer.

0.2 will have the new libc and RPM stuff, along with whatever else
appears in the RPMs or kernel tree by then.

My Indy at home doesn't work because of the cache bug, and the one at
work may be reallocated as fallout from the layoffs, so I'm having a bit
of trouble progressing with the installer.
Once we get the cache bug committed, I'll build a new kernel for the
installer package and try to push it out quickly.

Mike

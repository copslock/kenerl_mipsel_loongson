Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA17803 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 00:57:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA74399
	for linux-list;
	Fri, 17 Jul 1998 00:57:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA37039;
	Fri, 17 Jul 1998 00:57:22 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA06665; Fri, 17 Jul 1998 00:57:17 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id JAA00673;
	Fri, 17 Jul 1998 09:57:16 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id JAA05127;
	Fri, 17 Jul 1998 09:57:14 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id JAA25693;
	Fri, 17 Jul 1998 09:57:15 +0200 (MET DST)
Message-Id: <199807170757.JAA25693@aisa.fi.muni.cz>
Subject: Re: SGI/Linux mirror in taiwan
In-Reply-To: <199807161852.LAA98466@oz.engr.sgi.com> from Ariel Faigon at "Jul 16, 98 11:52:11 am"
To: ariel@cthulhu.engr.sgi.com
Date: Fri, 17 Jul 1998 09:57:14 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> - ftp/ftpd has slowdown problem receiving big file (270M)
>   reget was normal at first, slowed quickly.
> 
>   (probably the shortage problem of usable memory, may/may
>    not be cured until the swapon works.)

Can't this be the general problem of 2.1.99 slowing down? I've
experianced the same, IMO caused by the value of buffers very high,
not being freed, or so. The swap did not really matter because the
kernel did not touch the swap at all. It just did not have any
free memory.

You might benefit from downloading new kernel from the test directory
and run with it. It doesn't slow down anymore.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------

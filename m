Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA07020; Mon, 14 Apr 1997 11:40:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA27555 for linux-list; Mon, 14 Apr 1997 11:39:47 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA27539 for <linux@cthulhu.engr.sgi.com>; Mon, 14 Apr 1997 11:39:45 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13936; Mon, 14 Apr 1997 11:35:57 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199704141835.LAA13936@yon.engr.sgi.com>
Subject: Re: How big is the Linux/MIPS kernel?
To: ariel@sgi.com
Date: Mon, 14 Apr 1997 11:35:56 -0700 (PDT)
Cc: mikemac@titian.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199704141824.LAA13874@yon.engr.sgi.com> from "Ariel Faigon" at Apr 14, 97 11:24:49 am
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:11:26 ariel@info /hosts/neteng.engr/home/dm/alambie> size vmlinux 
:
:
:           Section           Size        Physical        Virtual
:                                         Address         Address
:
:               .text      809344        2282131456      2282131456      
:             .rodata       71264        2282940800      2282940800      
:            .reginfo          24        2283012064      2283012064      
:               .data       90848        2283012096      2283012096      
:               .sbss         349        2283102944      2283102944      
:                .bss      131324        2283103296      2283103296      
:880632 + 90848 + 131673 = 1103153
:
Maybe I should have added:

That's less than half the size of IRIX (6.3 on my Indy)
and about a quarter of the size of IRIX64 (6.4 on info.engr)

Of course, IRIX has much more in it, like XFS, Trusted IRIX,
Real Time and priority-classes scheduling, MPP (in 6.4), digital
media device drivers ..., but I thought you may want to know the numbers.

IRIX64:	2992844 (text) + 967960 (data) + 405460 (bss) = 4366264  (6.4)
IRIX:   2224072 (text) + 202752 (data) + 196560 (bss) = 2623384  (6.3)

-- 
Peace, Ariel

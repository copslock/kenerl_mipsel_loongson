Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id AAA605469 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 00:59:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA09463 for linux-list; Thu, 26 Feb 1998 00:59:19 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA09452 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 00:59:18 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA23069
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 00:59:17 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup148-2-21.swipnet.se [130.244.148.85]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id JAA16575; Thu, 26 Feb 1998 09:04:59 GMT
Date: Thu, 26 Feb 1998 10:00:54 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: Mike Shaver <shaver@netscape.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <34F50934.7C766D2C@netscape.com>
Message-ID: <Pine.LNX.3.96.980226095100.2735A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 25 Feb 1998, Mike Shaver wrote:

> Ulf Carlsson wrote:
> > It's also very strange that the kernel doesn't detect my scsi harddrives
> > correctly (I have reported these error messages earlier). I tested fx, and
> > fx detected them correctly. I get the same error with my orginal sgi
> > harddrive which obviously works, since irix doesn't have any problems with
> > it.
> 
> Oh...is that drive SCSI id 7?  I had problems with one of my drives
> (which was happy under IRIX) until I changed the id to something other
> than 7.

No, one drive is at id 4 and one at id 6.

Have I forgot to do something? I used the Disk Manager from the menu to
partition my scsi drive. Then I used mke2fs /dev/dsk/dks0d6s7. Is that the
corrected procedure?

> > I'll take a look in the kernel source and try to figure out what's causing
> > that kernel paging error.
> 
> You want to run mips-linux-objdump to get a function+offset (or, if that
> kernel was compiled -g, line number info) for the fault, and then we can
> try to debug it.

Is mips-linux-objdump in the binutils package?

/Ulf Carlsson

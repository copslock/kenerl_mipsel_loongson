Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA365097 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Sep 1997 08:10:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA00293 for linux-list; Fri, 26 Sep 1997 08:10:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA00289 for <linux@cthulhu.engr.sgi.com>; Fri, 26 Sep 1997 08:10:35 -0700
Received: from rover.village.org (rover.village.org [204.144.255.49]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id IAA16902
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Sep 1997 08:10:21 -0700
	env-from (imp@village.org)
Received: from harmony [10.0.0.6] 
	by rover.village.org with esmtp (Exim 1.71 #1)
	id 0xEc27-0003iK-00; Fri, 26 Sep 1997 09:10:19 -0600
Received: from harmony.village.org (localhost [127.0.0.1]) by harmony.village.org (8.8.7/8.8.3) with ESMTP id JAA22806; Fri, 26 Sep 1997 09:10:24 -0600 (MDT)
Message-Id: <199709261510.JAA22806@harmony.village.org>
To: Ralf Baechle <ralf@cobaltmicro.com>
Subject: Re: R3000 SGI machines 
Cc: linux@cthulhu.engr.sgi.com
In-reply-to: Your message of "Thu, 25 Sep 1997 23:39:27 PDT."
		<199709260639.XAA09959@dull.cobaltmicro.com> 
References: <199709260639.XAA09959@dull.cobaltmicro.com>  
Date: Fri, 26 Sep 1997 09:10:24 -0600
From: Warner Losh <imp@village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <199709260639.XAA09959@dull.cobaltmicro.com> Ralf Baechle writes:
: I receive an increasing number of emails asking for Linux as replacement
: operating system for older R3000 SGI machines as well as Mips Inc.
: machines.  Is there still documentation available for these systems
: that would make a port possible?

I'll have to search my email archive (which would take some doing),
but someone at SGI offered to get me the sources to RISCos, or at
least the device drivers.  They were donated to berkeley, who didn't
integrate them into their 4.4 or 4.4lite release, was the story I was
told.  Might be worth looking into.  Wouldn't help with some of the
older SGI machines, but would help with the MIPS co boxes.

Warner

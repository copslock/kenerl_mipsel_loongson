Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id XAA80343 for <linux-archive@neteng.engr.sgi.com>; Fri, 10 Oct 1997 23:12:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA09540 for linux-list; Fri, 10 Oct 1997 23:11:43 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA09535 for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 23:11:41 -0700
Received: from rover.village.org (rover.village.org [204.144.255.49]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id XAA22607
	for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 23:11:39 -0700
	env-from (imp@village.org)
Received: from harmony [10.0.0.6] 
	by rover.village.org with esmtp (Exim 1.71 #1)
	id 0xJum1-0005ew-00; Sat, 11 Oct 1997 00:11:37 -0600
Received: from harmony.village.org (localhost [127.0.0.1]) by harmony.village.org (8.8.7/8.8.3) with ESMTP id AAA24902; Sat, 11 Oct 1997 00:11:56 -0600 (MDT)
Message-Id: <199710110611.AAA24902@harmony.village.org>
To: Ralf Baechle <ralf@cobaltmicro.com>
Subject: Re: make zImage, and initrd... 
Cc: adevries@engsoc.carleton.ca (Alex deVries), linux@cthulhu.engr.sgi.com
In-reply-to: Your message of "Fri, 10 Oct 1997 17:58:48 PDT."
		<199710110058.RAA14665@dull.cobaltmicro.com> 
References: <199710110058.RAA14665@dull.cobaltmicro.com>  
Date: Sat, 11 Oct 1997 00:11:55 -0600
From: Warner Losh <imp@village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <199710110058.RAA14665@dull.cobaltmicro.com> Ralf Baechle writes:
: What I suggest instead is to load the ramdisk file using the ARCS
: Open, Read, Write, Close and Seek functions from any ARC supported media.
: That includes tapes, CDROM, EFS, XFS and even tftp.  Take the information
: what file to read from the ARC command line.

These can include ...  Not all ARC machines support all these types of
file systems...

Warner

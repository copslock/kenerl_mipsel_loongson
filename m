Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id FAA634971 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 05:55:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA03189 for linux-list; Thu, 26 Feb 1998 05:55:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA03178 for <linux@engr.sgi.com>; Thu, 26 Feb 1998 05:55:03 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA04688
	for <linux@engr.sgi.com>; Thu, 26 Feb 1998 05:55:01 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup147-1-1.swipnet.se [130.244.147.1]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id LAA18879 for <linux@engr.sgi.com>; Thu, 26 Feb 1998 11:11:24 GMT
Date: Thu, 26 Feb 1998 12:07:20 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
Message-ID: <Pine.LNX.3.96.980226120308.3903B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello again.

I'm getting pretty tired. No progress at all. Is my configuration special
in any way?

System: IP22
Processor: 100 Mhz R4000, with FPU
Primary I-cache size: 8 kbytes
Primary d-cache size: 8 kbytes
Secondary cache size: 1024 Kbytes
Memory size: 32 Mbytes
Graphics: Indy 8-bit
SCSI Disk: scsi(0)disk(4)
SCSI Disk: scsi(0)disk(6)

Are not all indys almost identical? It's very strange IMO that .72 hangs
before it prints anything on the screen. I think I've tested almost
everything by now.

Those harddrive problems don't matter right now. It's possible to run over
nfs so.. it's the kernel paging error which is the problem. I think this
error might be caused by my pc, because I don't get that error when the
network is down or the pc is shut down, but I can't boot when the pc is
down because I'm using nfs root system. Maybe the pc sends out signals on
the network which sgi linux can't handle (just a thought).

I am not blaming you SGI/Linux developers for creating a bad system in any
way. It would have been really nice if it worked :)

What will I do?

/Ulf Carlsson

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA346577 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 06:10:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA06636 for linux-list; Thu, 26 Feb 1998 06:10:04 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA06631 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 06:10:02 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA10213
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 06:10:01 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup179-2-3.swipnet.se [130.244.179.67]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id KAA18370 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 10:45:29 GMT
Date: Thu, 26 Feb 1998 11:41:26 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <Pine.LNX.3.96.980226095100.2735A-100000@calypso.saturn>
Message-ID: <Pine.LNX.3.96.980226112524.2914B-100000@calypso.saturn>
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
nfs so.. it's the kernel paging error which is the problem.

I am not blaming you SGI/Linux developers for creating a bad system in any
way. It would have been really nice if it worked :)

What will I do?

/Ulf Carlsson

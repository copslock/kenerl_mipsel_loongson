Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA561607 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 09:35:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA24418 for linux-list; Thu, 26 Feb 1998 09:34:10 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA24371; Thu, 26 Feb 1998 09:34:05 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA25332; Thu, 26 Feb 1998 09:34:05 -0800
Date: Thu, 26 Feb 1998 09:34:05 -0800
Message-Id: <199802261734.JAA25332@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ulf Carlsson <grimsy@varberg.se>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <Pine.LNX.3.96.980226120308.3903B-100000@calypso.saturn>
References: <Pine.LNX.3.96.980226120308.3903B-100000@calypso.saturn>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson writes:
 > Hello again.
 > 
 > I'm getting pretty tired. No progress at all. Is my configuration special
 > in any way?
 > 
 > System: IP22
 > Processor: 100 Mhz R4000, with FPU
 > Primary I-cache size: 8 kbytes
 > Primary d-cache size: 8 kbytes
 > Secondary cache size: 1024 Kbytes
 > Memory size: 32 Mbytes
 > Graphics: Indy 8-bit
 > SCSI Disk: scsi(0)disk(4)
 > SCSI Disk: scsi(0)disk(6)
 > 
 > Are not all indys almost identical? It's very strange IMO that .72 hangs
 > before it prints anything on the screen. I think I've tested almost
 > everything by now.
...

     No, there are many different CPU types for the Indy, in order
of appearance:

	R4000PC, 100 MHZ
	R4000SC, 100 MHZ
	R4600PC, 100 and 133 MHZ
	R4400SC, 150 and 200 MHZ
	R4600SC, 133 MHZ
	R5000PC, 150 and 180 MHZ
	R5000SC, 180 MHZ

In the above, "PC" means that there is no secondary cache and "SC"
means that there is.  The R4000 and R4400 are functionally very similar, except
for cache size.  The R4600 and R5000 are also similar, but with
a very different cache organization from the R4000 and R4400.  Various
revision of the processors (and more than one revision was shipped
for each processor) have different errata, so the kernel must work around
various processor errata according to the processor type and revision.
As I understand it, the currently checked-in source must be recompiled
to provide R4600/R5000 PC and SC versions for Indy, and those versions
may not be fully tested on all R4000 and R4400 revisions.  In the not
distant future, a single kernel will likely support all the processors,
as does the IRIX kernel, but that is more work than just selecting
the processor type at compile time.

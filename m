Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA1169414 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 19:10:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA11076 for linux-list; Thu, 11 Dec 1997 19:09:12 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA11050 for <linux@engr.sgi.com>; Thu, 11 Dec 1997 19:09:10 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA21964
	for <linux@engr.sgi.com>; Thu, 11 Dec 1997 19:09:08 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-09.uni-koblenz.de [141.26.249.9])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA24064
	for <linux@engr.sgi.com>; Fri, 12 Dec 1997 04:08:30 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA03374;
	Fri, 12 Dec 1997 03:34:48 +0100
Message-ID: <19971212033448.01867@uni-koblenz.de>
Date: Fri, 12 Dec 1997 03:34:48 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Indy crash during bootup
References: <19971208150602.52582@brian.uni-koblenz.de> <ralf@uni-koblenz.de> <9712091934.ZM3116@mdhill.interlog.com> <19971210040210.27443@uni-koblenz.de> <9712110612.ZM1219@mdhill.interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <9712110612.ZM1219@mdhill.interlog.com>; from Michael Hill on Thu, Dec 11, 1997 at 06:12:24AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 11, 1997 at 06:12:24AM -0500, Michael Hill wrote:

> Got a bus error IRQ, shouldn't happen yet
> $0 : 00000000 00000000 0007c000 8007d000
> $4 : 00000080 89f7d000 1000fc01 8007cfe0
> $8 : 80000000 00000000 00009f7c 8813de68
> $12: 00000001 00000001 00000001 fffffffc
> $16: 09f7c000 89f7c000 00000000 00000000
> $20: a87ffc20 a8746d60 9fc556d4 00000000
> $24: 1000fc01 0000000f
> $28: eb3b6f7f 89f81d90 00000001 880f2890
> epc   : 88026918
> Status: 1000fc03
> Cause : 00004000
> Spinning...

Ok, I did some further analysis.  Dissassembling shows that Benjamin's
report doesn't really contain useful data.  His machine took the
bus error interrupt while processing some other exception.  Michael's
machine took the bus error at the end of r4k_flush_page_to_ram_d32i32_r4600()
which is being called during sgiwd33.c:sgiwd93_detect().c.

Since the R4600 v2.0 is running rocksolid - my RM200 is up for over two
weeks - the problem seems to be in the SGI specific code in the function
that handles the Indy style l2 caches.

Hmm...  I just noticed in Benjamin's startup messages that his machine
doesn't print a message (``Enabling R4600 SCACHE'') about activating the
second level cache.  I bet both your and Benjamin's machines don't have
second level caches.  Could you check the hinv output, please?

William: would an attempt to manipulate the R4600 second level cache on
a Indy without such a cache result in a bus error interrupt?

  Ralf

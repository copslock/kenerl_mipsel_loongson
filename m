Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id EAA164440 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Dec 1997 04:26:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA24284 for linux-list; Tue, 16 Dec 1997 04:24:49 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA24263 for <linux@cthulhu.engr.sgi.com>; Tue, 16 Dec 1997 04:24:40 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA04581
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Dec 1997 04:24:38 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id NAA28691;
	Tue, 16 Dec 1997 13:24:09 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id NAA07121; Tue, 16 Dec 1997 13:24:08 +0100
Message-ID: <19971216132407.31525@zaphod.uni-koblenz.de>
Date: Tue, 16 Dec 1997 13:24:07 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Joachim Schmitz <jojo@unixpc.dus.Tandem.COM>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: bus error IRQ
References: <199712161036.LAA07650@unixpc.germany.tandem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199712161036.LAA07650@unixpc.germany.tandem.com>; from Joachim Schmitz on Tue, Dec 16, 1997 at 11:36:08AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Dec 16, 1997 at 11:36:08AM +0100, Joachim Schmitz wrote:

> I'm new to this list and currently trying to setup my Indy for Linux.
> For a start I tried just to boot vmlinux-970916-efs and vmlinux-2.1.67
> ... without success. Both boots ends up with:
> 
> boot vmlinux-2.1.67
> PROMLIB: SGI ARCS firmware Version 1 Revision 10
> PROMLIB: Total free ram 64376832 bytes (62868k,61MB)
> ARCH: SGI-IP22
> CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
> Loading R4000 MMU routines.
> CPU revision is: 00002020
> Primary ICACHE 16k (linesize 32 bytes)
> Primary DCACHE 16k (linesize 32 bytes)
> R4600/R5000 SCACHE size 0K linesize 32 bytes
                          ^^
That's the problem, there is a kernel bug which prevents Linux from
working on R4600/R5000 Indys without second level cache.  My next
kernel release will fix that.

  Ralf

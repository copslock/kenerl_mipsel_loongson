Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11762; Mon, 9 Jun 1997 11:36:36 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA03132 for linux-list; Mon, 9 Jun 1997 11:36:21 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA03113 for <linux@cthulhu.engr.sgi.com>; Mon, 9 Jun 1997 11:36:18 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA25776 for <linux@yon.engr.sgi.com>; Mon, 9 Jun 1997 11:36:17 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA02114; Mon, 9 Jun 1997 11:36:10 -0700
Date: Mon, 9 Jun 1997 11:36:10 -0700
Message-Id: <199706091836.LAA02114@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
Cc: ralf@Julia.DE, ariel@sgi.com, linux@yon.engr.sgi.com
Subject: Re: Merge back of the MIPS sources
In-Reply-To: <199706061807.LAA01554@piecomputer.engr.sgi.com>
References: <199706061732.TAA18428@kernel.panic.julia.de>
	<199706061807.LAA01554@piecomputer.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Bob Mende Pie writes:
 > Ralf,
 > 
 >    Have you verified that the newest code still works on the other MIPS
 > based systems?   Also, is it possible to have (linux) binary compatability
 > between a mips Magnum or Millennium and an Indy?
 >    There is a 50Mhz Millennium over here that we might be able to use as a
 > test system.

      If the MIPS system is running big-endian (as under RISCos), it can
be binary-compatible with Indy linux, just as RISCos 5.01 -systype svr4
binaries are binary-compatible with Indy IRIX 5.1 and later systems.
If the MIPS system is running little-endian (as under NT), it cannot
be binary-compatible with Indy linux, without adding bi-endian support
(for running opposite-endian binaries, which is feasible, but messy).
We prototyped bi-endian support in RISCos when before the Magnum
was built, and it worked, but the code was very ugly in the streams
area.  linux would likely be easier, but still a hassle.

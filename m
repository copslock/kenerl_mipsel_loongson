Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA12919; Tue, 10 Jun 1997 04:16:25 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA23990 for linux-list; Tue, 10 Jun 1997 04:16:00 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA23984 for <linux@cthulhu.engr.sgi.com>; Tue, 10 Jun 1997 04:15:56 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA28220 for <linux@yon.engr.sgi.com>; Tue, 10 Jun 1997 04:15:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA23927; Tue, 10 Jun 1997 04:15:33 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA25907; Tue, 10 Jun 1997 04:06:46 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id MAA18571; Tue, 10 Jun 1997 12:59:21 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706101059.MAA18571@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id MAA21876; Tue, 10 Jun 1997 12:59:19 +0200
Subject: Re: Merge back of the MIPS sources
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Tue, 10 Jun 1997 12:59:18 +0200 (MET DST)
Cc: mende@piecomputer.engr.sgi.com, ralf@Julia.DE, ariel@sgi.com,
        linux@yon.engr.sgi.com
In-Reply-To: <199706091836.LAA02114@fir.engr.sgi.com> from "William J. Earl" at Jun 9, 97 11:36:10 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>       If the MIPS system is running big-endian (as under RISCos), it can
> be binary-compatible with Indy linux, just as RISCos 5.01 -systype svr4
> binaries are binary-compatible with Indy IRIX 5.1 and later systems.
> If the MIPS system is running little-endian (as under NT), it cannot
> be binary-compatible with Indy linux, without adding bi-endian support
> (for running opposite-endian binaries, which is feasible, but messy).
> We prototyped bi-endian support in RISCos when before the Magnum
> was built, and it worked, but the code was very ugly in the streams
> area.  linux would likely be easier, but still a hassle.

Now that the overhead of accessing the userspace from the kernel under
Linux is very close to zero I fear that the additional overhead of the
byteorder conversion will show up very clearly in benchmarks unless
someone comes up with very clever ideas how do this.  Do you have
numbers how much the impact on RISC/os performance was?

  Ralf

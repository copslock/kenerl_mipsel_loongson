Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA3273394 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 May 1998 05:34:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA19617730
	for linux-list;
	Sun, 3 May 1998 05:33:19 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA19542135
	for <linux@engr.sgi.com>;
	Sun, 3 May 1998 05:33:18 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id FAA11282
	for <linux@engr.sgi.com>; Sun, 3 May 1998 05:33:16 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-29.uni-koblenz.de [141.26.249.29])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA08109
	for <linux@engr.sgi.com>; Sun, 3 May 1998 14:33:14 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA05341;
	Sun, 3 May 1998 14:33:00 +0200
Message-ID: <19980503143300.07739@uni-koblenz.de>
Date: Sun, 3 May 1998 14:33:00 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: IDE device in defconfig...
References: <Pine.LNX.3.95.980502210755.4130F-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980502210755.4130F-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, May 02, 1998 at 09:14:11PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, May 02, 1998 at 09:14:11PM -0400, Alex deVries wrote:

> The default config in the kernel is to enable IDE devices, which as I
> found out the hard way breaks the bootup on my SGI.  Is this the default
> for a reason? Do other non-SGI MIPS machines have IDE controllers?  If
> not, I'd like to change this.

The default configuration happens to be what I use to compile a kernel
for my RM200 and Acer machine and yes, one can plug IDE hostadapters
into them.  Whatever, IDE configured shouldn't crash the kernel, that's
the bug, not that IDE is configured in and it's easy to fix, see
linux/include/asm-mips/ide.h.

  Ralf

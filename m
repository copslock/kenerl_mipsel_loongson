Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA1136687 for <linux-archive@neteng.engr.sgi.com>; Fri, 10 Apr 1998 17:47:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA10375044
	for linux-list;
	Fri, 10 Apr 1998 17:46:32 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA10399872
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 10 Apr 1998 17:46:25 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA14958
	for <linux@cthulhu.engr.sgi.com>; Fri, 10 Apr 1998 17:46:24 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA22593
	for <linux@cthulhu.engr.sgi.com>; Sat, 11 Apr 1998 02:46:21 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA26093;
	Fri, 10 Apr 1998 23:26:22 +0200
Message-ID: <19980410232621.28017@uni-koblenz.de>
Date: Fri, 10 Apr 1998 23:26:21 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Ooops!
References: <Pine.LNX.3.95.980409160950.11499F-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980409160950.11499F-100000@lager.engsoc.carleton.ca>; from Alex deVries on Thu, Apr 09, 1998 at 04:11:06PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 09, 1998 at 04:11:06PM -0400, Alex deVries wrote:

> I've recompiled 2.1.91 without the -N flag, and the image boots.  

We should document that problem somewhere.  It's a bug in the binutils and
I don't want to put workarounds for it into the kernel.  Could you do me
a favor and add a note to the webpages?

> Now, I get an oops on bootup, here's my handdrawn facsimile of the bootup:
> 
> ...
> Starting kswapd v 1.5
> SGI Zilog8530 serial driver version 1.00
> tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
> tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
> Uniform CD-ROM driver Revision: 2.12
> Unable to handle kernel paging request at virtual address 0000001f6, epc
> == 080d6f44, ra == 880d6f4c

I could bet you have support for IDE peripherals, probably CDROMs, in
your kernel.  0x1f6 is the address of an IDE port of the first IDE
hostadaptor.  IDE support plus Indy -> no good.

  Ralf

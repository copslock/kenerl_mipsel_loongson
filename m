Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.3/8.9.3) with ESMTP id CAA02136
	for <pstadt@stud.fh-heilbronn.de>; Wed, 6 Oct 1999 02:05:37 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA03684; Tue, 5 Oct 1999 17:04:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA44059
	for linux-list;
	Tue, 5 Oct 1999 16:56:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA51494
	for <linux@engr.sgi.com>;
	Tue, 5 Oct 1999 16:56:11 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA854227
	for <linux@engr.sgi.com>; Tue, 5 Oct 1999 16:56:08 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-25.uni-koblenz.de [141.26.131.25])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA18621
	for <linux@engr.sgi.com>; Wed, 6 Oct 1999 01:56:05 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA19936;
	Wed, 6 Oct 1999 01:54:11 +0200
Date: Wed, 6 Oct 1999 01:54:11 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Dave Airlie <airlied@csn.ul.ie>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS 2.3.10 + framebuffer + keyboard, DS5000/200
Message-ID: <19991006015410.A19750@uni-koblenz.de>
References: <Pine.LNX.4.10.9910052006530.26951-100000@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.10.9910052006530.26951-100000@skynet.csn.ul.ie>; from Dave Airlie on Tue, Oct 05, 1999 at 08:09:02PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Oct 05, 1999 at 08:09:02PM +0100, Dave Airlie wrote:

> hi,
> 	I've just gotten CVS 2.3.10 and started applying the patches for
> fb support and keyboard and it compiles fine, but it hangs at some stage
> during the bootup sequence... it gets as far as Initializing random number
> generator usually, when booting with init=/bin/bash it hung after I did a
> few cd's around, no response no oops... a reset shows the PC in a function
> but this is different after each crash ...
> 
> So what changes did 2.3.10 make to break stuff ??
> 
> back to 2.3.9 I think for development work ..

2.3.10 is working on the Indy.  I suppose the problem you're observing has
hit me on the Indy when I upgraded it to 2.3.11.  I've traced it to some
inconsistence between the page tables in memory and the TLB which
results in recursive page faults which lockup the process in do_pagefault()
in fault.c.  Really hard to trace and hits both MIPS32 and MIPS64 ...

  Ralf

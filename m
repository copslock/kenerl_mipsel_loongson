Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA67425 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 04:38:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA20395197
	for linux-list;
	Fri, 8 May 1998 04:37:49 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA21451720
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 04:37:43 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA08071
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 04:37:39 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id NAA21762
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 13:37:31 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id NAA11954;
	Fri, 8 May 1998 13:37:13 +0200
Message-ID: <19980508133713.20895@uni-koblenz.de>
Date: Fri, 8 May 1998 13:37:13 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: My .99 oops...
References: <Pine.LNX.3.95.980508065104.20848B-100000@lager.engsoc.carleton.ca> <Pine.LNX.3.95.980508071419.20848D-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980508071419.20848D-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, May 08, 1998 at 07:15:36AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, May 08, 1998 at 07:15:36AM -0400, Alex deVries wrote:

> On Fri, 8 May 1998, Alex deVries wrote:
> > Checking for 'wait' instruction...  available
> > POSIX conformance testing by UNIFIX
> > Starting kswapd v 1.5
> > Floppy drive(s): fd0 is 1.44M
> > Unable to handle kernel paging request at virtual address 00000000, epc ==
> > My guess is it's that I enabled the floppy drive (as it came as the
> > default).  I'll remove that, recompile and reboot.
> 
> Alright, I removed floppy support and recompiled, and everything is okay
> now.

Ok, I'll make the floppy driver bulletproof also...

  Ralf

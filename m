Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA2532803 for <linux-archive@neteng.engr.sgi.com>; Sun, 26 Apr 1998 08:20:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA8845937
	for linux-list;
	Sun, 26 Apr 1998 08:18:22 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA16773722
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 26 Apr 1998 08:18:15 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA11974
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 08:18:10 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id RAA22090
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 17:18:08 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA11716;
	Sun, 26 Apr 1998 14:09:28 +0200
Message-ID: <19980426140928.63303@uni-koblenz.de>
Date: Sun, 26 Apr 1998 14:09:28 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: gcc RPM missing crtbegin.o
References: <19980426053938.20282@uni-koblenz.de> <Pine.LNX.3.95.980426002620.16850A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980426002620.16850A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Apr 26, 1998 at 12:34:54AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Apr 26, 1998 at 12:34:54AM -0400, Alex deVries wrote:

> > tell me where these two addresses are pointing to?  Just send me twenty
> > lines or so around the addresses.  (In general that's the right thing to
> > do when the machine bombs with a register dump.)
> > (Also I'm pretty shure that you misstyped $28 and $29 or something really
> > bad happend.)
> 
> Uh, there was nothing at 080f3b5c or nearby, so I'm pretty sure that that
> was misttyped as 880f3b5c.  Here are both:

880f3b5c makes sense.  The bad news is that none of the two routines
r4k_dma_cache_wback_inv_pc or dma_setup is the culprit.  Something else
must either have assembled bad SCSI scatter gather lists or corrupted
them such that a NULL pointer got passed down to dma_cache_wback_inv.
So no fix obvious.

Grrrr,

  Ralf

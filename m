Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3704702 for <linux-archive@neteng.engr.sgi.com>; Mon, 4 May 1998 12:46:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA19757765
	for linux-list;
	Mon, 4 May 1998 12:44:04 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA19550266
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 4 May 1998 12:44:01 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA15066
	for <linux@cthulhu.engr.sgi.com>; Mon, 4 May 1998 12:43:15 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-13.uni-koblenz.de [141.26.249.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA11605
	for <linux@cthulhu.engr.sgi.com>; Mon, 4 May 1998 21:43:08 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA08286;
	Mon, 4 May 1998 21:42:52 +0200
Message-ID: <19980504214252.14493@uni-koblenz.de>
Date: Mon, 4 May 1998 21:42:52 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: rpm-list@redhat.com, SGI Linux <linux@cthulhu.engr.sgi.com>,
        support@cobaltmicro.com, tim@cobaltmicro.com
Subject: Re: CobaltMicro's Qube.
References: <Pine.LNX.3.96.980217120532.1214P-100000@mercury.redhat.com> <Pine.LNX.3.95.980504141032.11760K-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980504141032.11760K-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, May 04, 1998 at 02:48:01PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, May 04, 1998 at 02:48:01PM -0400, Alex deVries wrote:

> A while back we produced the big endian mips (mipseb) architecture for
> machines such as SGIs.  This was especially important because of the SGI
> port actively releasing binaries only in RPM format.  
> 
> Because (we thought) there were more packages that were in fact more big
> endian labelled as 'mips', we kept 4 as mipseb, and made a new mipsel
> (#11). I suggested that because I thought the only mipseb/mipsel packages
> were produced by specific people: Ralf, Alan and myself.  I just hadn't
> thought about Cobalt, and nobody at Cobalt piped up to complain when we
> were throwing the idea around.

The same applies also in the opposite direction.  Again, in order to be
on the safe side we _had_ to change the extension used in package names
and the architecture id.  In short again, the situation isn't really
nice but not too bad either.

  Ralf

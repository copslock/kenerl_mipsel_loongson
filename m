Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA76462 for <linux-archive@neteng.engr.sgi.com>; Wed, 28 Apr 1999 10:56:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA95708
	for linux-list;
	Wed, 28 Apr 1999 10:53:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA19021;
	Wed, 28 Apr 1999 10:53:47 -0700 (PDT)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id KAA79893; Wed, 28 Apr 1999 10:53:47 -0700 (PDT)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199904281753.KAA79893@anchor.engr.sgi.com>
Subject: Re: using ec3 on a Challenge S
In-Reply-To: <Pine.LNX.3.96.990428133838.9204B-100000@lager.engsoc.carleton.ca> from Alex deVries at "Apr 28, 99 01:42:22 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Wed, 28 Apr 1999 10:53:47 -0700 (PDT)
Cc: cpezzee@microsoft.com, linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote: 
|  You should probably try to figure out where on the GIO64 that is located,
|  it shouldn't be too difficult with some guidance from folks at SGI.  What
|  ethernet controller is on there exactly?

It's basicly the same ethernet setup as the IP20 (r4k Indigo).
The driver is quite similar, but there are a few differences in
features.  The DMA is the IP20 dma (hpc1, not hpc3), but the 
ethernet chip is identical to the one on the indy/challenge S,
just some features enabled by hpc3 aren't present.

If you have an irix system, the HPC31 defines in hpc3.h provide
most of the necessary info.  On irix, it's actually shipped as
a seperate binary driver from the onboard ethernet, because of
the dma/control register differences.  It would be possible to
do it all in one driver, but we didn't bother.  The source code
for irix is the same for both, with a few ifdefs.


Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com

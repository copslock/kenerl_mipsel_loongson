Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA10516 for <linux-archive@neteng.engr.sgi.com>; Tue, 4 May 1999 16:02:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA91282
	for linux-list;
	Tue, 4 May 1999 16:00:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id QAA52266;
	Tue, 4 May 1999 16:00:51 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA17970; Tue, 4 May 1999 16:00:00 -0700
Date: Tue, 4 May 1999 16:00:00 -0700
Message-Id: <199905042300.QAA17970@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Dave Olson <olson@anchor.engr.sgi.com>,
        Charles Lepple <clepple@foo.tho.org>, linux@cthulhu.engr.sgi.com
Subject: Re: building an elf64 R10k kernel
In-Reply-To: <19990505001606.E1063@uni-koblenz.de>
References: <372E6AA0.505A6071@foo.tho.org>
	<199905040354.UAA16791@anchor.engr.sgi.com>
	<19990505001606.E1063@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > On Mon, May 03, 1999 at 08:54:28PM -0700, Dave Olson wrote:
 > 
 > > Charles Lepple wrote: 
 > > |  Hey all,
 > > |  Does anyone out there know any details on building elf64 objects? I was
 > > |  all happy about seeing Andrew's Indigo2 patches, and decided that I
 > > |  _had_ to try and make it work on an Indigo2 Impact 10000... Suffice it
 > > |  to say that it isn't straightforward.
 > > 
 > > For r10k Indigo2 to work, you will need to hack the compiler,
 > > for various reasons (the way the r10k works, plus the fact that
 > > indigo2 doesn't have i/o cache coherency, interact in some "interesting"
 > > ways.  I would suggest not attempting this port, unless you have a *lot*
 > > of spare time.
 > 
 > Let me point out that SGI has invented an almost genious workaround for a
 > R10000 bug that only hits systems without I/O cache coherency, that is the
 > Indigo2 and O2.
...

     The R10000 "bug" is, in a sense, a feature, in that it improves
performance, and is harmless on machines with cache-coherent I/O.
Specifically, on a speculative store miss (a cache miss due to a
speculatively executed store instruction), the R10000 fetches the line
dirty-exclusive and marks it modified, in anticipation of the store.
If, however, the speculatively executed store never graduates (is
never committed), the line is left dirty, even though it has not been
modified.  If the line happens to be part of a buffer into which data
is being DMAed, a subsequent victim writeback of the dirty cache line
might overwrite good data from the DMA with the obsolete data in the
cache line.  This means that, one way or the other, a system with
non-cache-coherent I/O and an R10000 must avoid allowing the
processor to perform a speculative store miss with respect to memory
into which a DMA is taking place.

     Note that the Indigo2 and O2 have somewhat different workarounds.
The Indigo2 deals with the kernel side using a special compilation mode,
and the O2 deals with the kernel side using a special hardware feature
plus a generalization of the solution for the user mode part of the problem.
Both deal with the user mode by invalidating TLB entries for pages into
which data is being transferred via DMA, so that the processor cannot
resolve the virtual address, and hence cannot speculatively fetch
a cache line at that address, while the DMA is in progress.  The kernel
side is harder, since the TLB is not used for K0SEG and XKPHYS address
spaces, which is where things get complicated.

     I can provide the details to someone who is really interested
in working on this, but, as Dave Olson indicated, you don't want to
start on this unless you have a LOT of spare time. 

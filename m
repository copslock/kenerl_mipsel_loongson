Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA20238 for <linux-archive@neteng.engr.sgi.com>; Tue, 29 Sep 1998 18:22:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA68200
	for linux-list;
	Tue, 29 Sep 1998 18:21:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA80360;
	Tue, 29 Sep 1998 18:21:34 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA21169; Tue, 29 Sep 1998 18:21:03 -0700
Date: Tue, 29 Sep 1998 18:21:03 -0700
Message-Id: <199809300121.SAA21169@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: VCEI/VCED handling
In-Reply-To: <19980930015819.D3920@uni-koblenz.de>
References: <19980929011414.43485@alpha.franken.de>
	<19980929015003.E2215@uni-koblenz.de>
	<19980929232455.30571@alpha.franken.de>
	<19980930015819.D3920@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > It's a known problem - and a nasty one.  Basically a good solution requires
 > a way to map a page's physical address to virtual addresses.  And Linux 2.2's
 > mm will not provide this feature.  Reverse mappings are under planning for
 > 2.3 for other improvments.  It was my plan to ignore this bug for now and
 > deal with virtual coherency when reverse mappings are implemented in 2.3.
 >
 > Oh, I've already implemented the solution for the special case of ZERO_PAGE.
 > On CPUs which know about the virtual coherency exception have eight colours
 > for zero page.  The change is basically to pass in the virtual address to
 > ZERO_PAGE such that we always do ``colourly correct'' allocation.  That was
 > the simple case.

       On the machines without VCE detection (R4000PC, R4600, R5000),
the zero page is safe, because it is read-only.  Anonymous pages
are not an issue, since they are not double-mapped.

       What is wrong with going from the mem_map_t.inode to the
inode.i_mmap list of mappings, and thence to the PTEs?  IRIX, at least
before IRIX 6.5, does the equivalent to solve this problem.

 > > How does IRIX solve this problem ? Does it disable caching for shared 
 > > writeable pages ?
 > 
 > Mapping shared writeable pages uncached is not the solution.  The virtual
 > coherency problem in Linux/MIPS may happen between multiple userspace
 > mappings or userspace and kernelspace, that is KSEG0, mappings.  While
 > we could disable caching for certain pages in the hope that we'll only
 > end up with a few uncached pages making KSEG0 uncached is completly
 > unacceptable performancewise.  However, if we don't, then we might end up
 > with aliases between userspace pages and KSEG0 pages.

      You can use KSEG2 instead of KSEG0 for all pages which might be
mapped into user space.  IRIX mostly does that, and keeps the KSEG2 mapping
around only as long as necessary, and then only with the current virtual
color (the color which currently has write ownership of the page) locked
(which means that references via other colors block until the kernel
gives up its mapping).  

Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA16884
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 02:28:43 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA4040200; Wed, 30 Jun 1999 17:26:54 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA89060
	for linux-list;
	Wed, 30 Jun 1999 17:24:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA96879;
	Wed, 30 Jun 1999 17:24:15 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08080; Wed, 30 Jun 1999 17:24:13 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-20.uni-koblenz.de [141.26.131.20])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA00628;
	Thu, 1 Jul 1999 02:24:08 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id CAA31519;
	Thu, 1 Jul 1999 02:23:58 +0200
Date: Thu, 1 Jul 1999 02:23:57 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Ulf Carlsson <ulfc@thepuffingroup.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Memory corruption
Message-ID: <19990701022357.D30652@uni-koblenz.de>
References: <19990622033931.A7201@thepuffingroup.com> <199906300101.SAA09334@fir.engr.sgi.com> <19990630044702.A6969@thepuffingroup.com> <199906302201.PAA29334@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199906302201.PAA29334@fir.engr.sgi.com>; from William J. Earl on Wed, Jun 30, 1999 at 03:01:27PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 30, 1999 at 03:01:27PM -0700, William J. Earl wrote:

>      I have been looking at the fault handling and the cache flushing routines
> for the R4600.  In do_no_page() in mm/memory.c, we have:
> 
> 	flush_page_to_ram(page);
> 
> I don't see where any code invalidates the icache, which might have
> cached lines from a previous incarnation of the page.
> flush_page_to_ram(), for the R4600, essentially does a writeback of
> the dcache, if I understand the code correctly.  I believe that an
> icache invalidate is also needed, at least for executable pages
> (including any page for which mprotect() with PROT_EXEC has been
> called, not just for text pages from an executable file).  Also,
> unless something has changed, my understanding is that conflicting
> virtual aliases (in the dcache) are still possible, which will also
> lead to data corruption when it happens.

The particular flush_page_to_ram() call is only necessary because the
call to vma->vm_ops->nopage() may have brought the page into the
primary cache under it's KSEG0 address.

>      In particular, if process A mmaps a file page at virtual index
> 0 and process B happens to mmap the same file page at virtual index
> 1, they will in general corrupt each other's view of the data.

Oh, the common case is either shared r/o mappings or SysV SHM which per
ABI is 64kb aligned, so the hairy case doesn't hit us.  Usually ...

Especially I don't see why anything should corrupt executable pages
which are r/o mapped.

>      There is a comment in memory.c that a non-present page shouldn't
> be cached, but it is not yet clear to me that this is guaranteed for
> the icache.

Flushing the caches for pages which are being unmapped is done by
flush_cach_page and takes care of the VM_EXEC flag.

On exec, fork or exit we flush the entire cache so that problems shouldn't
hit us either.

Actually we're pretty generous with our cacheflushed, we flush more than we
should.

> Also, the flush_page_to_ram() slows down processing on
> machines which physical cache tags, for cases where the virtual
> index used by the kernel and the virtual index used by the application
> are the same.  It should have an extra argument of the intended user virtual
> address, so that it can decide whether to flush or not on architectures
> such as MIPS.

For R3000 and R6000 flush_page_to_ram() is a no-op, see arch/mips/mm/r2300.c
and arch/mips/mm/r6000.c.

For virtual indexed CPUs something like change_page_colour(oldvaddr, newvaddr)
would usually do a more efficient job than always flushing the page to
memory especially when combined with an allocator which takes the vaddr where
the page will be mapped as a hint.

  Ralf

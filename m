Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA00071 for <linux-archive@neteng.engr.sgi.com>; Sat, 3 Oct 1998 09:14:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA06300
	for linux-list;
	Sat, 3 Oct 1998 09:13:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA11524;
	Sat, 3 Oct 1998 09:13:11 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08198; Sat, 3 Oct 1998 09:12:54 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-17.uni-koblenz.de [141.26.249.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id SAA09818;
	Sat, 3 Oct 1998 18:12:50 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA01857;
	Sat, 3 Oct 1998 18:00:10 +0200
Message-ID: <19981003180009.B1675@uni-koblenz.de>
Date: Sat, 3 Oct 1998 18:00:09 +0200
From: ralf@uni-koblenz.de
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: VCEI/VCED handling
References: <19980929011414.43485@alpha.franken.de> <19980929015003.E2215@uni-koblenz.de> <19980929232455.30571@alpha.franken.de> <19980930015819.D3920@uni-koblenz.de> <199809300121.SAA21169@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199809300121.SAA21169@fir.engr.sgi.com>; from William J. Earl on Tue, Sep 29, 1998 at 06:21:03PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 29, 1998 at 06:21:03PM -0700, William J. Earl wrote:

>        On the machines without VCE detection (R4000PC, R4600, R5000),
> the zero page is safe, because it is read-only.  Anonymous pages
> are not an issue, since they are not double-mapped.
> 
>        What is wrong with going from the mem_map_t.inode to the
> inode.i_mmap list of mappings, and thence to the PTEs?  IRIX, at least
> before IRIX 6.5, does the equivalent to solve this problem.

Nothing - anymore.  On older kernels your suggestion wouldn't have worked
for SYSV IPC, so I forgot about that possibility ...

>  > Mapping shared writeable pages uncached is not the solution.  The virtual
>  > coherency problem in Linux/MIPS may happen between multiple userspace
>  > mappings or userspace and kernelspace, that is KSEG0, mappings.  While
>  > we could disable caching for certain pages in the hope that we'll only
>  > end up with a few uncached pages making KSEG0 uncached is completly
>  > unacceptable performancewise.  However, if we don't, then we might end up
>  > with aliases between userspace pages and KSEG0 pages.
> 
>       You can use KSEG2 instead of KSEG0 for all pages which might be
> mapped into user space.  IRIX mostly does that, and keeps the KSEG2 mapping
> around only as long as necessary, and then only with the current virtual
> color (the color which currently has write ownership of the page) locked
> (which means that references via other colors block until the kernel
> gives up its mapping).  

It is my understanding that read/write syscalls used on mmaped file is the
only instance of that problem we need to deal with.  I think we can do so by
modifying update_vm_cache to fit the special needs of certain cache
architectures and introducing something similar to be used when reading.

The KSEG2 approach is definately much nicer for that than what we're using
right now for ptrace reading / writing to other processes' address space.

Btw, it looks like the MIPS NT HAL do the same thing.  At least the interfaces
provides by HAL.DLL strongly suggest so.

Oh, and somebody just promised to snail me a R4000SC module so I hope I can
tackle the SC problems rsn and make some more people lucky.

  Ralf

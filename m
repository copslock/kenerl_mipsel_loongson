Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA332382 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 18:12:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA12680 for linux-list; Thu, 4 Dec 1997 18:07:48 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA12675; Thu, 4 Dec 1997 18:07:46 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA17787; Thu, 4 Dec 1997 18:07:43 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-20.uni-koblenz.de [141.26.249.20])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA14550;
	Fri, 5 Dec 1997 03:07:39 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA31621;
	Fri, 5 Dec 1997 02:33:17 +0100
Message-ID: <19971205023316.12386@uni-koblenz.de>
Date: Fri, 5 Dec 1997 02:33:16 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Greg Chesson <greg@xtp.engr.sgi.com>,
        David Chatterton <chatz@omen.melbourne.sgi.com>,
        Lige Hensley <ligeh@carpediem.com>, Chris Carlson <cwcarlson@home.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Linux on the O2
References: <Pine.SGI.3.96.971204001929.20475A-100000@barramunda> <9712041708.ZM8190@omen.melbourne.sgi.com> <chatz@omen.melbourne.sgi.com> <9712040903.ZM8161@xtp.engr.sgi.com> <199712041722.JAA26372@fir.engr.sgi.com> <19971204230122.18229@uni-koblenz.de> <199712042333.PAA27062@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <199712042333.PAA27062@fir.engr.sgi.com>; from William J. Earl on Thu, Dec 04, 1997 at 03:33:01PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 04, 1997 at 03:33:01PM -0800, William J. Earl wrote:

>  > Indeed - and you're pointing to what I consider _the_ problem with
>  > current Linux kernels.  Linux uses the ``buddy system'' described by
>  > Donald Knuth's ``Algorithems And Data Structures'' to maintain it's
>  > free pages.  This algorithem results in massive fragmentation even
>  > after a short uptime.
> 
>      Are you saying that linux uses the buddy system for all of memory,
> or just for the kernel heap?  (I would be surprised if it were used
> for other than the kernel heap, although that is bad enough.)  

The buddy system is only used to maintain the pool of free pages.  The
buddy system has the advantage that it is very fast.  On top of this
lowest level we've got additional layers:

 - The ``slab allocator''.  It's basically what Jeff Bonwick from Sun
   describes in his USENIX paper from '94.  Miguel has the paper on his
   homepage.  The slab allocator has been added during the Linux 2.1.x
   series.
 - The ``simp allocator''.  Yet another memory allocator for cached objects
   that has been added during 2.1.x.  Pretty fast and still under
   development.
 - kmalloc() is the kernel equivallent to malloc(3).  It's mostly used
   for allocations smaller than a single page but can be used to allocate
   upto 128kb.  For Linux 2.0 kmalloc() is getting it's pages directly from
   the free page pool.  For Linux 2.1.x kmalloc is implemented on top of
   the slab allocator.
   Both implementations are directly or indirectly getting the memory from
   the pool of free pages (that's KSEG0 on MIPS), therefore have to
   live with the advantages and disadvantages of the buddy system.

>       One thing we do in IRIX is to always allocate kernel heap buffers
> of 1 page or larger as an integral set of pages, mapped into kernel
> virtual space, but not part of the main kernel heap (which is used only
> for smaller buffers).  Except for fragmentation of the kernel mapped
> space pool (a pool of address space, not real memory), this guarantees
> you can always get large buffers if pages are available.  Fragmentation
> of smaller buffers of course requires a better heap manager, although
> using zone allocation (where a zone has blocks all of the same size,
> and there are zones for most popular sizes) helps a lot and is also
> faster than using the regular heap manager.

Actually we also have this type of kernel virtual memory in Linux.  On
MIPS the address space >=KSEG2 is being used for that purpose.  The
functions vmalloc(9) and vfree(9) are used for that purpose.  However
vmalloc is rarely being used in the kernel.  Among the reasons is that
vmalloc() is slower than other types of memory allocation.  Furthermore
the primitive PC-style DMA hardware often does not have the required
support to use vmalloc'ed memory as scatter/gather buffer.  Finally
accessing vmalloced memory may result in TLB reloads on some architectures
while pages allocated from the pool of free pages don't.  So accessing
vmalloced memory may imply a performance penalty.

>       We (the SGI people on the list) will have to talk with the
> general manager for the O2 platform.  I personally think that would be
> ok.  As I mentioned in my earlier message, a lot of the IRIX value
> added for O2 is in essentially generic facilities, not in the
> device-dependent drivers, and we already tell customers in high level
> terms about the overall architecture (such as the unified memory for
> graphics and I/O), so there is not much in the hardware documentation
> which needs to be treated as a trade secret.  Conceptually, the O2 graphics
> pipeline is fully described by the OpenGL reference (software) implementation
> and specification, so the hardware value added is in the internals
> of the implementation, not in the interface (which is essentially
> a large part of the OpenGL pipeline).

Well, sounds good.  You're making the differenciation between the interface
and the implementation of the O2, something that so far people I've been
discussing with haven't done.  As a software guy all need is the
interface and maybe a peek into internals for a better understanding of
the interface.

  Ralf

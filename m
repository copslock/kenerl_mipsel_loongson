Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2831754 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 15:48:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA7259692
	for linux-list;
	Fri, 3 Apr 1998 15:47:23 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA7457128;
	Fri, 3 Apr 1998 15:47:20 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA21860; Fri, 3 Apr 1998 15:47:19 -0800
Date: Fri, 3 Apr 1998 15:47:19 -0800
Message-Id: <199804032347.PAA21860@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
In-Reply-To: <19980404011332.15427@loria.fr>
References: <199804031911.LAA21028@fir.engr.sgi.com>
	<m0yLByA-000aNnC@the-village.bc.nu>
	<19980404011332.15427@loria.fr>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Olivier Galibert writes:
 > On Fri, Apr 03, 1998 at 08:17:41PM +0100, Alan Cox wrote:
 > > Colouring in Linux isnt going to work without ripping the godawful buddy
 > > allocator out of it.[...]
 > 
 > Can someone point me  to a good documentation/book/whatever explaining
 > what cache colouring is ?

     As far as I know, there is none.

     I can give a basic tutorial.  A cache color for memory management
purposes is the set of bits from the page number portion of page
address used as part of the cache index (the value which selects a
line in the cache).  For caches indexed by the physical address (such
as secondary caches on most MIPS processors), the cache color is
determined from the physical address bits.  For caches indexed by the
virtual address (such as primary caches on most MIPS processors),
the cache color is determined from the virtual address bits.  
For caches with more than one set (such the primary caches on the R5000
and R10000), the cache color is determined with respect to a single set.

     For example, if the page size is 4KB, and the cache size is 32 KB,
and there are two sets, each set is 16 KB, so two bits of the address
form the cache color.  That is, there are four pages in each set,
so the low-order two bits of the virtual page number are the cache color.
Thus a cache line at virtual address 0x401320 has cache color 1 and,
if the cache line size is 32 bytes, as on the R5000 and R10000, the
cache index is 0x99.  If I map the same physical address to virtual 
0x1002320 (same page offset, but a different virtual page number), the
cache color is 2.  If the hardware does not detect the confict, as on
the R5000, and I try updating a variable via both addresses, I will
in general get wrong answers, since I could have two dirty copies of
the cache line in the cache at the same time (one at cache offset 0x1320
and the other at cache offset 0x2320).  Note that this is not a problem
for read-only data, such as instructions, since they are all the same,
but it is fatal for read-write data, unless software (on the R5000)
or hardware (on the R10000) or a combination (on the R4000SC) arranges
that at most one virtual color can be present in the cache for a given
line at any one time.  If only software is used, typically a whole page
must be managed.  When hardware is used, a secondary cache line is typically
the unit of management (since the "current" virtual index is stored
in the secondary cache tag).  

     Note that there cannot be a virtual-index cache coloring problem if the 
the cache set size is at least the page size.  For example, on the
QED RM7000, the primary cache is 16 KB and four-way set associative,
so each set is 4 KB and hence there are no virtual color index bits.
Similarly, for physically indexed caches, there is no index
coherency problem, since a given page has only one physical address.
(Actually, there are cases where this is not true, as in the case
of the first 512 KB of memory on Indy, which is mapped at both physical
address 0 and physical address 0x8000000, but software can easily deal
with that problem by only using one of the possible physical addresses.)

     The physical cache color, for physically indexed caches, is important
not for correctness but for performance.  Suppose, for example, that
I have a direct-mapped secondary cache, as on the R4000SC, and that
I happen to allocate several of the popular physical pages of a program
to the pages with the same physical cache color.  Then further suppose
that the most popular (frequently referenced) offset of each of these pages happens
to be 0.  Then the processor will try to put the data for the first
cache line of each page into the same slot in the secondary cache, so
that each time the program references a different one of the pages,
it will take a cache miss.  If, on the other hand, the system allocated
physical pages with different cache colors to the various virtual pages,
there would be not collisions and hence far fewer caches misses.  While
a two-set secondary cache, as on the R10000, helps a bit, it is still
important distribute physical addresses as uniformly as possible to minimize
cache misses.

     There has been some research on techniques to detect excessive
cache misses due to color conflicts, so that software can move one
of the offending virtual pages to a physical page with a different
cache color.  (One paper advocated a hardware monitor called a "camel buffer"
to detect such "hot" pages; the buffer was basically looking for 
cache indexes which were replaced more often than other indexes.)
A crude approximation might be derived from the page stealer's 
reference counting.

    The simplest way to reduce color conflicts, given existing
hardware, is to allocate pages with well-distributed colors.  One way
to do this is to divide the free page list into buckets, one per
color, and have a rotor which selects a different bucket for each
allocation.  Moreover, if you also would prefer to match virtual color
to physical color, so that the kernel can use a K0SEG address for a
page without incurring a virtual index conflict with respect to a
KUSEG user mapping of the same pages, you then easily look at just the
appropriate subset of the buckets (those for which the physical color
mod the number of virtual colors is equal to the desired virtual
color).  The use of the array of buckets has been shown to
substantially increase performance on RISC/os and IRIX, especially
on the R4000SC and R4400SC.  It should apply to any processor with
a physically indexed cache.

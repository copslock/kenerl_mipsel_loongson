Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA35095 for <linux-archive@neteng.engr.sgi.com>; Tue, 29 Sep 1998 15:35:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA39717
	for linux-list;
	Tue, 29 Sep 1998 15:35:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA27422;
	Tue, 29 Sep 1998 15:35:01 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA20790; Tue, 29 Sep 1998 15:34:30 -0700
Date: Tue, 29 Sep 1998 15:34:30 -0700
Message-Id: <199809292234.PAA20790@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: VCEI/VCED handling
In-Reply-To: <19980929232455.30571@alpha.franken.de>
References: <19980929011414.43485@alpha.franken.de>
	<19980929015003.E2215@uni-koblenz.de>
	<19980929232455.30571@alpha.franken.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > On Tue, Sep 29, 1998 at 01:50:03AM +0200, ralf@uni-koblenz.de wrote:
 > > We've got code of which we're shure that it is correct.  Nevertheless
 > > Linux ist still fragile on SC machines.  I've been tracking this in
 > > private emails with Ulf but so far only with limited success.  Aside of
 > > the missing VCED / VCEI handlers there must be something else that is
 > > broken.
 > 
 > As I understand the problem now, I wrote the little test program below.
 > If I'll try it on a R4600PC Indy or a R4000PC Olivetti with Linux, I don't
 > get what I would expect. On IRIX, Linux/Alpha (I have to change the offset
 > between the two mapping to 0x2000, because of the bigger page size on Alphas)
 > and Linux/x86 the program works. IMHO this is a showstopper as we don't handle 
 > cache aliases right.  
 > 
 > How does IRIX solve this problem ? Does it disable caching for shared 
 > writeable pages ?

      No, IRIX does write ownership switching, using the TLB.  That
is, only one virtual cache color (virtual cache page index)
equivalence class of mappings can have the hardware PTE valid bit set
at any one time, if any class has the hardware PTE modify bit set in
any of its PTEs.  If no class has the modify bit set in any PTE, then
all classes may have the PTE valid bit set.  If you want to read
via class (color) 0, and the class 1 is currently writing, all PTEs of
class 1 have the modify bit turned off, and the primary data cache
for class 1 is written back to memory (and is hence marked "clean"
instead of "dirty" in the cache).  Class 0 is then allowed to read
(the hardware valid bit is set in the faulting PTE).  If class 0 wants
to write (gets a modify fault), the valid bit is turned off for all
PTEs of other classes, and the data cache for those classes is invalidated
with respect to the page in question, and then the modify bit is turned
on for the faulting PTE.  

     Note that this problem applies to the R4000PC and to all R4600
and R5000 processors (PC and SC), because there is no hardware VCE
support in those processors.  Software must avoid allowing virtual
aliases of different colors to write concurrently, and must
writeback-invalidate the cache for the old color and invalidate the
PTEs for the old color, when allowing some other color to write.
Doing this efficienly requires some form of back pointer from the page
frame table entry for the page to all of the virtual references for
the page (the PTEs).  IRIX does not need to do this for anonymous
pages, since they cannot be double-mapped with different virtual
colors.  It uses the vnode pointer in the page frame table to the list
of mappings for the page; the analog in linux is inode field in
mem_map_t, which points to the mapped file, which in turn points to
the mappings via i_mmap and the vm_next_share/vm_pprev_share pointers.

    Note further that this problem is complicated by the MIPS K0SEG
addressing mode.  Since there are no PTEs for K0SEG, the kernel should
not use K0SEG addresses for pages which may be mapped into user space
with multiple colors.

    IRIX makes an effort to minimize conflicting mappings, by arranging
that the default address selected for mmap() is color-congruent to the
offset in the file being mapped.  This of course does not work for
MAP_FIXED, so MAP_FIXED requires the above write ownership switching.

    The ownership can be provided by a field in mem_map_t of 5 bits:

	int	vcolor : 5;

Where we define:

#define	PAGE_VCOLOR_MIN 0
#define	PAGE_VCOLOR_MAX 7
#define PAGE_VCOLOR_NONE (-2)
#define PAGE_VCOLOR_SHARED (-1)

and

#define PAGE_IS_VCOLOR_EXCLUSIVE(mm) ((mm)->vcolor >= 0)
#define PAGE_IS_VCOLOR_SHARED(mm) ((mm)->vcolor == PAGE_VCOLOR_SHARED)

We also have

extern	int	pagevcolorsize;
extern	int	pagevcolormask;

#define vaddr_to_vcolor(va) ((((__psunsigned_t) (va)) / NBPP) & pagevcolormask)

We set pagecolorsize to the size of one set of the cache divided by the
size of a page, and we set pagecolormask to (pagecolorsize - 1).
For the R4000PC and R4600, pagecolorsize is 2; for the R5000, pagecolorsize
is 4.  Note that the virtual color on the R4000SC and R4400SC has 8 values,
regardless of the primary cache size, for a page size of 4 KB, because
the secondary cache treats the 8 possible values of the PIdx field of the
secondary cache tag as distinct.

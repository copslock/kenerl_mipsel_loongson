Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 12:21:46 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:45516 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8224847AbSLDLVo>;
	Wed, 4 Dec 2002 12:21:44 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB4BLRNf022519;
	Wed, 4 Dec 2002 03:21:27 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA11247;
	Wed, 4 Dec 2002 03:21:26 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB4BLRb00952;
	Wed, 4 Dec 2002 12:21:27 +0100 (MET)
Message-ID: <3DEDE537.CD58AD8F@mips.com>
Date: Wed, 04 Dec 2002 12:21:27 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org,
	Jun Sun <jsun@mvista.com>
Subject: Re: possible Malta 4Kc cache problem ...
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com>
Content-Type: multipart/mixed;
 boundary="------------63CEFDDE1EAEF4F9A52D6AA8"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------63CEFDDE1EAEF4F9A52D6AA8
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I just noticed that the patch I send (I don't know how long ago), hasn't made it
into the CVS tree.
So there is a potentially hole in the indexed flushes, which might only flush one
of the cache ways.

Please try the mips32_cache.h, I have attached.

/Carsten



Carsten Langgaard wrote:

> I have just tried your test on a 4Kc and I see no problems.
> However I'm running on our internal kernel sources, and as Kevin mention we have
> changed a fixed a few things in this area.
> As Kevin also mention it sure look more like a I-cache invalidation problem,
> rather than a D-cache flush problem, as the 4Kc has a write-through cache.
> One think you could try, is our latest kernel release. You can find it here:
> ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/
>
> /Carsten
>
> "Kevin D. Kissell" wrote:
>
> > > I attached the test case.  Untar it.  Type 'make' and run 'a.out'.
> > >
> > > If the test fails you will see a print-out.  Otherwise you see nothing.
> > >
> > > It does not always fail.  But if it fails, it is usually pretty consistent.
> > > Try a few times.  Moving source tree to a different directory may cause
> > > the symptom appear or disappear.
> > >
> > > I spent quite some time to trace this problem, and came to suspect
> > > there might be a hardware problem.
> > >
> > > The problem involves emulating a "lw" instruction in cp1 branch delay
> > > slot, which needs to  set up trampoline in user stack.  The net effect
> > > looks as if the icache line or dcache line is not flushed properly.
> > >
> > > Using gdb/kgdb, printf or printk in any useful places would hide the bug.
> > >
> > > I did find a smaller part of the problem.  flush_cache_sigtramp for
> > > MIPS32 (4Kc) calls protected_writeback_dcache_line in mips32_cache.h.
> > > It uses Hit_Writeback_D, and the 4Kc mannual says it is not implemented
> > > and executed as no-op (*ick*).
> >
> > Which version of the 4Kc manual are you looking at?  I'm looking
> > at a very recent version of the 4Kc Software User's Manual
> > (version 1.17, dated September 25, 2002), and it only shows
> > Hit_Writeback_D to be invalid for *secondary and teritary*
> > caches, which makes sense, since the 4KSc doesn't have any.
> >
> > > Even after fixing this, I still see the problem happening.
> >
> > That's not too surprising.  The 4Kc D-cache is write-through,
> > so if you're really seeing a problem with trampolimes, it is almost
> > certain to be a problem with the Icache invalidation, not the
> > Dcache flush.
> >
> > > If you replace flush_cache_sigtramp() with flush_cache_all(), symptom
> > > would disppear.
> >
> > Which again would make sense if there's a problem on
> > the icache side of the flush.  Oddly enough, we've seen
> > some glitches on other CPUs with other kernels that
> > might have been explicable by failures of protected_flush_icache_line(),
> > but we never found a problem with it, and a higher-level
> > memory management patch made the problem go away.
> > Makes me wonder if we shouldn't look at it again, more
> > closely.  Is there any possibility that the logic for restarting
> > a protected kernel access following a page fault will somehow
> > screw up on CACHE instructions, as opposed to the loads
> > and stores for which the code was originally written?
> >
> > > Several of my tests seem to suggest it is the icache that did not
> > > get flushed (or updated) properly.
> > >
> > > Not re-producible on other MIPS boards.  At least so far.
> > >
> > > Does anybody with more knowledge about 4Kc have any clues here?
> > >
> > > Thanks.
> > >
> > > Jun
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------63CEFDDE1EAEF4F9A52D6AA8
Content-Type: text/plain; charset=iso-8859-15;
 name="mips32_cache.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips32_cache.h"

/*
 * mips32_cache.h
 *
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
 *
 * ########################################################################
 *
 *  This program is free software; you can distribute it and/or modify it
 *  under the terms of the GNU General Public License (Version 2) as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * ########################################################################
 *
 * Inline assembly cache operations.
 * 
 * This file is the original r4cache.c file with modification that makes the
 * cache handling more generic.
 *
 * FIXME: Handle split L2 caches.
 *
 */
#ifndef _MIPS_R4KCACHE_H
#define _MIPS_R4KCACHE_H

#include <asm/asm.h>
#include <asm/cacheops.h>

static inline void flush_icache_line_indexed(unsigned long addr)
{
	unsigned long waystep = icache_size/mips_cpu.icache.ways;
	unsigned int way;

	for (way = 0; way < mips_cpu.icache.ways; way++)
	{
		__asm__ __volatile__(
			".set noreorder\n\t"
			".set mips3\n\t"
			"cache %1, (%0)\n\t"
			".set mips0\n\t"
			".set reorder"
			:
			: "r" (addr),
			"i" (Index_Invalidate_I));
		
		addr += waystep;
	}
}

static inline void flush_dcache_line_indexed(unsigned long addr)
{
	unsigned long waystep = dcache_size/mips_cpu.dcache.ways;
	unsigned int way;

	for (way = 0; way < mips_cpu.dcache.ways; way++)
	{
		__asm__ __volatile__(
			".set noreorder\n\t"
			".set mips3\n\t"
			"cache %1, (%0)\n\t"
			".set mips0\n\t"
			".set reorder"
			:
			: "r" (addr),
			"i" (Index_Writeback_Inv_D));

		addr += waystep;
	}
}

static inline void flush_scache_line_indexed(unsigned long addr)
{
	unsigned long waystep = scache_size/mips_cpu.scache.ways;
	unsigned int way;

	for (way = 0; way < mips_cpu.scache.ways; way++)
	{
		__asm__ __volatile__(
			".set noreorder\n\t"
			".set mips3\n\t"
			"cache %1, (%0)\n\t"
			".set mips0\n\t"
			".set reorder"
			:
			: "r" (addr),
			"i" (Index_Writeback_Inv_SD));

		addr += waystep;
	}
}

static inline void flush_icache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n\t"
		"cache %1, (%0)\n\t"
		".set mips0\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_I));
}

static inline void flush_dcache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n\t"
		"cache %1, (%0)\n\t"
		".set mips0\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Writeback_Inv_D));
}

static inline void invalidate_dcache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n\t"
		"cache %1, (%0)\n\t"
		".set mips0\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_D));
}

static inline void invalidate_scache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n\t"
		"cache %1, (%0)\n\t"
		".set mips0\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_SD));
}

static inline void flush_scache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n\t"
		"cache %1, (%0)\n\t"
		".set mips0\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Writeback_Inv_SD));
}

/*
 * The next two are for badland addresses like signal trampolines.
 */
static inline void protected_flush_icache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n"
		"1:\tcache %1,(%0)\n"
		"2:\t.set mips0\n\t"
		".set reorder\n\t"
		".section\t__ex_table,\"a\"\n\t"
		STR(PTR)"\t1b,2b\n\t"
		".previous"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_I));
}

static inline void protected_writeback_dcache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		".set mips3\n"
		"1:\tcache %1,(%0)\n"
		"2:\t.set mips0\n\t"
		".set reorder\n\t"
		".section\t__ex_table,\"a\"\n\t"
		STR(PTR)"\t1b,2b\n\t"
		".previous"
		:
		: "r" (addr),
		  "i" (Hit_Writeback_D));
}

#define cache_unroll(base,op)	        	\
	__asm__ __volatile__("	         	\
		.set noreorder;		        \
		.set mips3;		        \
                cache %1, (%0);	                \
		.set mips0;			\
		.set reorder"			\
		:				\
		: "r" (base),			\
		  "i" (op));


static inline void blast_dcache(void)
{
	unsigned long start = KSEG0;
	unsigned long end = (start + dcache_size);

	while(start < end) {
		cache_unroll(start,Index_Writeback_Inv_D);
		start += dc_lsize;
	}
}

static inline void blast_dcache_page(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = (start + PAGE_SIZE);

	while(start < end) {
		cache_unroll(start,Hit_Writeback_Inv_D);
		start += dc_lsize;
	}
}

static inline void blast_dcache_page_indexed(unsigned long page)
{
	unsigned long start;
	unsigned long end = (page + PAGE_SIZE);
	unsigned long waystep = dcache_size/mips_cpu.dcache.ways;
	unsigned int way;

	for (way = 0; way < mips_cpu.dcache.ways; way++) {
		start = page + way*waystep;
		while(start < end) {
			cache_unroll(start,Index_Writeback_Inv_D);
			start += dc_lsize;
		}
	}
}

static inline void blast_icache(void)
{
	unsigned long start = KSEG0;
	unsigned long end = (start + icache_size);

	while(start < end) {
		cache_unroll(start,Index_Invalidate_I);
		start += ic_lsize;
	}
}

static inline void blast_icache_page(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = (start + PAGE_SIZE);

	while(start < end) {
		cache_unroll(start,Hit_Invalidate_I);
		start += ic_lsize;
	}
}

static inline void blast_icache_page_indexed(unsigned long page)
{
	unsigned long start;
	unsigned long end = (page + PAGE_SIZE);
	unsigned long waystep = icache_size/mips_cpu.icache.ways;
	unsigned int way;

	for (way = 0; way < mips_cpu.icache.ways; way++) {
		start = page + way*waystep;
		while(start < end) {
			cache_unroll(start,Index_Invalidate_I);
			start += ic_lsize;
		}
	}
}

static inline void blast_scache(void)
{
	unsigned long start = KSEG0;
	unsigned long end = KSEG0 + scache_size;

	while(start < end) {
		cache_unroll(start,Index_Writeback_Inv_SD);
		start += sc_lsize;
	}
}

static inline void blast_scache_page(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = page + PAGE_SIZE;

	while(start < end) {
		cache_unroll(start,Hit_Writeback_Inv_SD);
		start += sc_lsize;
	}
}

static inline void blast_scache_page_indexed(unsigned long page)
{
	unsigned long start;
	unsigned long end = (page + PAGE_SIZE);
	unsigned long waystep = scache_size/mips_cpu.scache.ways;
	unsigned int way;

	for (way = 0; way < mips_cpu.scache.ways; way++) {
		start = page + way*waystep;
		while(start < end) {
			cache_unroll(start,Index_Writeback_Inv_SD);
			start += sc_lsize;
		}
	}
}

#endif /* !(_MIPS_R4KCACHE_H) */

--------------63CEFDDE1EAEF4F9A52D6AA8--

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C9FdRw017070
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 02:15:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C9Fd0H017069
	for linux-mips-outgoing; Fri, 12 Jul 2002 02:15:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C9EgRw017051;
	Fri, 12 Jul 2002 02:14:42 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6C9IRXb015663;
	Fri, 12 Jul 2002 02:18:27 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA28385;
	Fri, 12 Jul 2002 02:18:24 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6C9IOb12196;
	Fri, 12 Jul 2002 11:18:24 +0200 (MEST)
Message-ID: <3D2E9EDF.C8DA9FF5@mips.com>
Date: Fri, 12 Jul 2002 11:18:23 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Burgess <Jon_Burgess@eur.3com.com>
CC: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF3.00366849.00@notesmta.eur.3com.com>
Content-Type: multipart/mixed;
 boundary="------------21F4CFB1A6461EDD2D3FD0B4"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------21F4CFB1A6461EDD2D3FD0B4
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

One thing that just stroke me, I've made some changes to the MIPS32 cache routine
last month.
I just realized it hadn't made it into the CVS tree. It doesn't explain what you
are seeing, but it fixes some problem that you might get.

One of the things it fix, is a typo, which will hit you because you have different
size of the I- and D-caches.
But it also fix, that in a lot of the cache routine, we only flush one of the ways.

Please see the attached patch, I think Ralf didn't liked it, because it wasn't
optimized for speed, but at least it's better than what we got.

/Carsten


Jon Burgess wrote:

> >This sound more like a hardware bug to me.
> >What CPU are you running on ?
> >
> >/Carsten
>
> The CPU is a Broadcom BCM6352 which contains a 225Mhz Mips32 core with cache as
> follows:
>      16Kb Instruction cache, linesize 16 bytes (2 ways)
>      4Kb Data cache, linesize 16 byes (2 ways)
> I don't know the exact variant of the core but the chip has only been recently
> released. I will try asking my Broadcom contacts to see if they can shed any
> further light on this.
>
> >Ralf Baechle wrote:
> >>
> >> While that could be done it's not a good idea; running code in KSEG1 is
> >> very slow.
> >>
> >
> >Unfortunately, it's required by manuals for some processors. As I know,
> >IDT HW manuals clearly state cache flush routines must operate from
> >uncached code and must access uncached data only. Examples are R30x1 CPU
> >series.
> >
> >Regards,
> >Gleb.
>
> I'm fairly sure i've seen comments that say that cache manipulation code should
> be run uncached. My current thought is that it is probably safe to manipulate
> the d-cache with cached code, but I-cache manipulation which could invalidate
> the cacheline containing the currently executing code really should be run
> uncached. I think the CPU probably then skips instructions until it gets to the
> next cacheline, what effect this has depends on how the instructions are aligned
> relative to the cacheline. Given how hit-and-miss this is I am suspicous that
> this problem could simply be lurking undiscovered.
>
> The patch below makes the I-Cache routines run via kseg1, it is a bit ugly but
> seems to work. I have not measured the performance impact of this patch.
>
> diff -Nruw --exclude=CVS include/asm-mips-old/mips32_cache.h
> include/asm-mips/mips32_cache.h
> --- include/asm-mips-old/mips32_cache.h  Wed Apr 10 22:53:12 2002
> +++ include/asm-mips/mips32_cache.h      Thu Jul 11 10:25:06 2002
> @@ -219,37 +219,24 @@
>      }
>  }
>
> +/* Call I-cache manipulation routines via uncached kseg1 */
> +extern void mips32_blast_icache(void);
> +extern void mips32_blast_icache_page(unsigned long page);
> +extern void mips32_blast_icache_page_indexed(unsigned long page);
> +
>  static inline void blast_icache(void)
>  {
> -    unsigned long start = KSEG0;
> -    unsigned long end = (start + icache_size);
> -
> -    while(start < end) {
> -         cache_unroll(start,Index_Invalidate_I);
> -         start += ic_lsize;
> -    }
> +    ((void (*)(void))KSEG1ADDR((unsigned long)mips32_blast_icache))();
>  }
>
>  static inline void blast_icache_page(unsigned long page)
>  {
> -    unsigned long start = page;
> -    unsigned long end = (start + PAGE_SIZE);
> -
> -    while(start < end) {
> -         cache_unroll(start,Hit_Invalidate_I);
> -         start += ic_lsize;
> -    }
> +    ((void (*)(unsigned long))KSEG1ADDR((unsigned
> long)mips32_blast_icache_page))(page);
>  }
>
>  static inline void blast_icache_page_indexed(unsigned long page)
>  {
> -    unsigned long start = page;
> -    unsigned long end = (start + PAGE_SIZE);
> -
> -    while(start < end) {
> -         cache_unroll(start,Index_Invalidate_I);
> -         start += ic_lsize;
> -    }
> +    ((void (*)(unsigned long))KSEG1ADDR((unsigned
> long)mips32_blast_icache_page_indexed))(page);
>  }
>
>  static inline void blast_scache(void)
> diff -Nurw arch/mips/mm-old/c-mips32.c arch/mips/mm/c-mips32.c
> --- arch/mips/mm-old/c-mips32.c    Thu May 23 15:19:36 2002
> +++ arch/mips/mm/c-mips32.c   Thu Jul 11 10:21:02 2002
> @@ -708,3 +708,36 @@
>
>      __flush_cache_all();
>  }
> +
> +void mips32_blast_icache(void)
> +{
> +    unsigned long start = KSEG0;
> +    unsigned long end = (start + icache_size);
> +
> +    while(start < end) {
> +         cache_unroll(start,Index_Invalidate_I);
> +         start += ic_lsize;
> +    }
> +}
> +
> +void mips32_blast_icache_page(unsigned long page)
> +{
> +    unsigned long start = page;
> +    unsigned long end = (start + PAGE_SIZE);
> +
> +    while(start < end) {
> +         cache_unroll(start,Hit_Invalidate_I);
> +         start += ic_lsize;
> +    }
> +}
> +
> +void mips32_blast_icache_page_indexed(unsigned long page)
> +{
> +    unsigned long start = page;
> +    unsigned long end = (start + PAGE_SIZE);
> +
> +    while(start < end) {
> +         cache_unroll(start,Index_Invalidate_I);
> +         start += ic_lsize;
> +    }
> +}
>
>      Jon Burgess

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------21F4CFB1A6461EDD2D3FD0B4
Content-Type: text/plain; charset=iso-8859-15;
 name="cache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache.patch"

--- arch/mips/mm/c-mips32.c	Wed May 29 05:03:17 2002
+++ ../../linux-2.4.18/sw/linux-2.4.18/arch/mips/mm/c-mips32.c	Thu Jul 11 09:55:08 2002
@@ -17,7 +17,6 @@
  *
  * MIPS32 CPU variant specific MMU/Cache routines.
  */
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -75,7 +74,8 @@
 	unsigned long flags;
 
 	__save_and_cli(flags);
-	blast_dcache(); blast_icache();
+	blast_dcache(); 
+	blast_icache();
 	__restore_flags(flags);
 }
 
@@ -303,7 +303,7 @@
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
 
-	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & (dcache_size - 1));
+	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & (icache_size - 1));
 	blast_icache_page_indexed(address);
 }
 
@@ -317,7 +317,7 @@
 	unsigned int flags;
 
 	if (size >= dcache_size) {
-		flush_cache_all();
+		blast_dcache();
 	} else {
 	        __save_and_cli(flags);
 		a = addr & ~(dc_lsize - 1);
@@ -338,7 +338,7 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_all();
+		blast_scache();
 		return;
 	}
 
@@ -358,13 +358,13 @@
 	unsigned int flags;
 
 	if (size >= dcache_size) {
-		flush_cache_all();
+		blast_dcache();
 	} else {
 	        __save_and_cli(flags);
 		a = addr & ~(dc_lsize - 1);
 		end = (addr + size) & ~(dc_lsize - 1);
 		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			invalidate_dcache_line(a); /* Hit_Inv_D */
 			if (a == end) break;
 			a += dc_lsize;
 		}
@@ -380,14 +380,14 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		flush_cache_all();
+		blast_scache();
 		return;
 	}
 
 	a = addr & ~(sc_lsize - 1);
 	end = (addr + size) & ~(sc_lsize - 1);
 	while (1) {
-		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
+		invalidate_scache_line(a); /* Hit_Writeback_Inv_SD */
 		if (a == end) break;
 		a += sc_lsize;
 	}
--- include/asm-mips/mips32_cache.h	Wed Jul  3 08:30:08 2002
+++ ../../linux-2.4.18/sw/linux-2.4.18/include/asm-mips/mips32_cache.h	Mon Jun 24 13:17:36 2002
@@ -37,41 +37,65 @@
 
 static inline void flush_icache_line_indexed(unsigned long addr)
 {
-	__asm__ __volatile__(
-		".set noreorder\n\t"
-		".set mips3\n\t"
-		"cache %1, (%0)\n\t"
-		".set mips0\n\t"
-		".set reorder"
-		:
-		: "r" (addr),
-		  "i" (Index_Invalidate_I));
+	unsigned long waystep = icache_size/mips_cpu.icache.ways;
+	unsigned int way;
+
+	for (way = 0; way < mips_cpu.icache.ways; way++)
+	{
+		__asm__ __volatile__(
+			".set noreorder\n\t"
+			".set mips3\n\t"
+			"cache %1, (%0)\n\t"
+			".set mips0\n\t"
+			".set reorder"
+			:
+			: "r" (addr),
+			"i" (Index_Invalidate_I));
+		
+		addr += waystep;
+	}
 }
 
 static inline void flush_dcache_line_indexed(unsigned long addr)
 {
-	__asm__ __volatile__(
-		".set noreorder\n\t"
-		".set mips3\n\t"
-		"cache %1, (%0)\n\t"
-		".set mips0\n\t"
-		".set reorder"
-		:
-		: "r" (addr),
-		  "i" (Index_Writeback_Inv_D));
+	unsigned long waystep = dcache_size/mips_cpu.dcache.ways;
+	unsigned int way;
+
+	for (way = 0; way < mips_cpu.dcache.ways; way++)
+	{
+		__asm__ __volatile__(
+			".set noreorder\n\t"
+			".set mips3\n\t"
+			"cache %1, (%0)\n\t"
+			".set mips0\n\t"
+			".set reorder"
+			:
+			: "r" (addr),
+			"i" (Index_Writeback_Inv_D));
+
+		addr += waystep;
+	}
 }
 
 static inline void flush_scache_line_indexed(unsigned long addr)
 {
-	__asm__ __volatile__(
-		".set noreorder\n\t"
-		".set mips3\n\t"
-		"cache %1, (%0)\n\t"
-		".set mips0\n\t"
-		".set reorder"
-		:
-		: "r" (addr),
-		  "i" (Index_Writeback_Inv_SD));
+	unsigned long waystep = scache_size/mips_cpu.scache.ways;
+	unsigned int way;
+
+	for (way = 0; way < mips_cpu.scache.ways; way++)
+	{
+		__asm__ __volatile__(
+			".set noreorder\n\t"
+			".set mips3\n\t"
+			"cache %1, (%0)\n\t"
+			".set mips0\n\t"
+			".set reorder"
+			:
+			: "r" (addr),
+			"i" (Index_Writeback_Inv_SD));
+
+		addr += waystep;
+	}
 }
 
 static inline void flush_icache_line(unsigned long addr)
@@ -210,12 +234,17 @@
 
 static inline void blast_dcache_page_indexed(unsigned long page)
 {
-	unsigned long start = page;
-	unsigned long end = (start + PAGE_SIZE);
-
-	while(start < end) {
-		cache_unroll(start,Index_Writeback_Inv_D);
-		start += dc_lsize;
+	unsigned long start;
+	unsigned long end = (page + PAGE_SIZE);
+	unsigned long waystep = dcache_size/mips_cpu.dcache.ways;
+	unsigned int way;
+
+	for (way = 0; way < mips_cpu.dcache.ways; way++) {
+		start = page + way*waystep;
+		while(start < end) {
+			cache_unroll(start,Index_Writeback_Inv_D);
+			start += dc_lsize;
+		}
 	}
 }
 
@@ -243,12 +272,17 @@
 
 static inline void blast_icache_page_indexed(unsigned long page)
 {
-	unsigned long start = page;
-	unsigned long end = (start + PAGE_SIZE);
-
-	while(start < end) {
-		cache_unroll(start,Index_Invalidate_I);
-		start += ic_lsize;
+	unsigned long start;
+	unsigned long end = (page + PAGE_SIZE);
+	unsigned long waystep = icache_size/mips_cpu.icache.ways;
+	unsigned int way;
+
+	for (way = 0; way < mips_cpu.icache.ways; way++) {
+		start = page + way*waystep;
+		while(start < end) {
+			cache_unroll(start,Index_Invalidate_I);
+			start += ic_lsize;
+		}
 	}
 }
 
@@ -276,12 +310,17 @@
 
 static inline void blast_scache_page_indexed(unsigned long page)
 {
-	unsigned long start = page;
-	unsigned long end = page + PAGE_SIZE;
-
-	while(start < end) {
-		cache_unroll(start,Index_Writeback_Inv_SD);
-		start += sc_lsize;
+	unsigned long start;
+	unsigned long end = (page + PAGE_SIZE);
+	unsigned long waystep = scache_size/mips_cpu.scache.ways;
+	unsigned int way;
+
+	for (way = 0; way < mips_cpu.scache.ways; way++) {
+		start = page + way*waystep;
+		while(start < end) {
+			cache_unroll(start,Index_Writeback_Inv_SD);
+			start += sc_lsize;
+		}
 	}
 }
 

--------------21F4CFB1A6461EDD2D3FD0B4--

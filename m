Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:06:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([12.44.186.158]:64755 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225241AbSLKRGi>;
	Wed, 11 Dec 2002 17:06:38 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBBH6Z606891;
	Wed, 11 Dec 2002 09:06:35 -0800
Date: Wed, 11 Dec 2002 09:06:35 -0800
From: Jun Sun <jsun@mvista.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: Cache routine patch
Message-ID: <20021211090635.C6755@mvista.com>
References: <3DF719D0.658530E2@mips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DF719D0.658530E2@mips.com>; from carstenl@mips.com on Wed, Dec 11, 2002 at 11:56:17AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Part of you patches fixes an off-by-one problem in flushing
cache for a range of addresses.  I have a different version
for that part which is a little more visually pleasing.

See attachment.

Jun

On Wed, Dec 11, 2002 at 11:56:17AM +0100, Carsten Langgaard wrote:
> I have attached a patch, containing some fixes for some of the cache
> routines.
> Most of it is related to the MIPS32/MIPS64 specific routines, but it
> also contain a fix, which appear to be needed in all of the dma flushing
> routines. The problem is that we sometimes flush a cache line too much.
> Ralf, could you please take a look at it ?
> 
> /Carsten
> 
> 
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
> 
> 

> Index: arch/mips/mm/c-mips32.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-mips32.c,v
> retrieving revision 1.3.2.7
> diff -u -r1.3.2.7 c-mips32.c
> --- arch/mips/mm/c-mips32.c	2 Dec 2002 00:24:49 -0000	1.3.2.7
> +++ arch/mips/mm/c-mips32.c	11 Dec 2002 10:00:18 -0000
> @@ -298,13 +298,18 @@
>  static void
>  mips32_flush_icache_page(struct vm_area_struct *vma, struct page *page)
>  {
> -	int address;
> -
> +	/*
> +	 * If there's no context yet, or the page isn't executable, no icache 
> +	 * flush is needed.
> +	 */
>  	if (!(vma->vm_flags & VM_EXEC))
>  		return;
>  
> -	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & (dcache_size - 1));
> -	blast_icache_page_indexed(address);
> +	/*
> +	 * We're not sure of the virtual address(es) involved here, so
> +	 * conservatively flush the entire caches.
> +	 */
> +	flush_cache_all();
>  }
>  
>  /*
> @@ -317,11 +322,11 @@
>  	unsigned int flags;
>  
>  	if (size >= dcache_size) {
> -		flush_cache_all();
> +		blast_dcache();
>  	} else {
>  	        __save_and_cli(flags);
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -338,12 +343,12 @@
>  	unsigned long end, a;
>  
>  	if (size >= scache_size) {
> -		flush_cache_all();
> +		blast_scache();
>  		return;
>  	}
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
>  		if (a == end) break;
> @@ -358,13 +363,13 @@
>  	unsigned int flags;
>  
>  	if (size >= dcache_size) {
> -		flush_cache_all();
> +		blast_dcache();
>  	} else {
>  	        __save_and_cli(flags);
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
> -			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
> +			invalidate_dcache_line(a); /* Hit_Inv_D */
>  			if (a == end) break;
>  			a += dc_lsize;
>  		}
> @@ -380,14 +385,14 @@
>  	unsigned long end, a;
>  
>  	if (size >= scache_size) {
> -		flush_cache_all();
> +		blast_scache();
>  		return;
>  	}
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
> -		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
> +		invalidate_scache_line(a); /* Hit_Inv_SD */
>  		if (a == end) break;
>  		a += sc_lsize;
>  	}
> @@ -412,7 +417,7 @@
>  
>  static void mips32_flush_icache_all(void)
>  {
> -	if (mips_cpu.cputype == CPU_20KC) {
> +	if (mips_cpu.icache.flags | MIPS_CACHE_VTAG_CACHE) {
>  		blast_icache();
>  	}
>  }
> @@ -423,6 +428,7 @@
>          unsigned long config1;
>  	unsigned int lsize;
>  
> +	mips_cpu.icache.flags = 0;
>          if (!(config & (1 << 31))) {
>  	        /*
>  		 * Not a MIPS32 complainant CPU.
> @@ -452,6 +458,16 @@
>  	       ic_lsize = mips_cpu.icache.linesz;
>  	       icache_size = mips_cpu.icache.sets * mips_cpu.icache.ways *
>  		             ic_lsize;
> +
> +	       if ((config & 0x8) || (mips_cpu.cputype == CPU_20KC)) {
> +		       /* 
> +			* The CPU has a virtually tagged I-cache.
> +			* Some older 20Kc chips doesn't have the 'VI' bit in
> +			* the config register, so we also check for 20Kc.
> +			*/
> +		       mips_cpu.icache.flags = MIPS_CACHE_VTAG_CACHE;
> +		       printk("Virtually tagged I-cache detected\n");
> +	       }
>  	}
>  	printk("Primary instruction cache %dkb, linesize %d bytes (%d ways)\n",
>  	       icache_size >> 10, ic_lsize, mips_cpu.icache.ways);
> @@ -462,6 +478,7 @@
>          unsigned long config1;
>  	unsigned int lsize;
>  
> +	mips_cpu.dcache.flags = 0;
>          if (!(config & (1 << 31))) {
>  	        /*
>  		 * Not a MIPS32 complainant CPU.
> Index: arch/mips/mm/c-r4k.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
> retrieving revision 1.3.2.12
> diff -u -r1.3.2.12 c-r4k.c
> --- arch/mips/mm/c-r4k.c	6 Dec 2002 18:46:47 -0000	1.3.2.12
> +++ arch/mips/mm/c-r4k.c	11 Dec 2002 10:00:18 -0000
> @@ -970,7 +970,7 @@
>  #endif
>  
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -993,7 +993,7 @@
>  	}
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
>  		if (a == end) break;
> @@ -1016,7 +1016,7 @@
>  #endif
>  
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -1040,7 +1040,7 @@
>  	}
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
>  		if (a == end) break;
> Index: arch/mips/mm/c-r5432.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-r5432.c,v
> retrieving revision 1.4.2.3
> diff -u -r1.4.2.3 c-r5432.c
> --- arch/mips/mm/c-r5432.c	2 Dec 2002 00:24:49 -0000	1.4.2.3
> +++ arch/mips/mm/c-r5432.c	11 Dec 2002 10:00:18 -0000
> @@ -384,7 +384,7 @@
>  		flush_cache_all();
>  	} else {
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -403,7 +403,7 @@
>  		flush_cache_all();
>  	} else {
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> Index: arch/mips/mm/c-rm7k.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-rm7k.c,v
> retrieving revision 1.4.2.5
> diff -u -r1.4.2.5 c-rm7k.c
> --- arch/mips/mm/c-rm7k.c	2 Dec 2002 00:24:49 -0000	1.4.2.5
> +++ arch/mips/mm/c-rm7k.c	11 Dec 2002 10:00:18 -0000
> @@ -131,7 +131,7 @@
>  	unsigned long end, a;
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
>  		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
> @@ -143,7 +143,7 @@
>  		return;
>  
>  	a = addr & ~(tc_pagesize - 1);
> -	end = (addr + size) & ~(tc_pagesize - 1);
> +	end = (addr + size - 1) & ~(tc_pagesize - 1);
>  	while(1) {
>  		invalidate_tcache_page(a);	/* Page_Invalidate_T */
>  		if (a == end) break;
> @@ -157,7 +157,7 @@
>  	unsigned long end, a;
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		invalidate_dcache_line(a);	/* Hit_Invalidate_D */
>  		invalidate_scache_line(a);	/* Hit_Invalidate_SD */
> @@ -169,7 +169,7 @@
>  		return;
>  
>  	a = addr & ~(tc_pagesize - 1);
> -	end = (addr + size) & ~(tc_pagesize - 1);
> +	end = (addr + size - 1) & ~(tc_pagesize - 1);
>  	while(1) {
>  		invalidate_tcache_page(a);	/* Page_Invalidate_T */
>  		if (a == end) break;
> Index: arch/mips/mm/c-tx39.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-tx39.c,v
> retrieving revision 1.4.2.3
> diff -u -r1.4.2.3 c-tx39.c
> --- arch/mips/mm/c-tx39.c	2 Dec 2002 00:24:50 -0000	1.4.2.3
> +++ arch/mips/mm/c-tx39.c	11 Dec 2002 10:00:18 -0000
> @@ -65,7 +65,7 @@
>  
>  	iob();
>  	a = addr & ~(dcache_lsize - 1);
> -	end = (addr + size) & ~(dcache_lsize - 1);
> +	end = (addr + size - 1) & ~(dcache_lsize - 1);
>  	while (1) {
>  		invalidate_dcache_line(a); /* Hit_Invalidate_D */
>  		if (a == end) break;
> @@ -198,7 +198,7 @@
>  		flush_cache_all();
>  	} else {
>  		a = addr & ~(dcache_lsize - 1);
> -		end = (addr + size) & ~(dcache_lsize - 1);
> +		end = (addr + size - 1) & ~(dcache_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -215,7 +215,7 @@
>  		flush_cache_all();
>  	} else {
>  		a = addr & ~(dcache_lsize - 1);
> -		end = (addr + size) & ~(dcache_lsize - 1);
> +		end = (addr + size - 1) & ~(dcache_lsize - 1);
>  		while (1) {
>  			invalidate_dcache_line(a); /* Hit_Invalidate_D */
>  			if (a == end) break;
> Index: arch/mips/mm/c-tx49.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-tx49.c,v
> retrieving revision 1.3.2.3
> diff -u -r1.3.2.3 c-tx49.c
> --- arch/mips/mm/c-tx49.c	2 Dec 2002 00:24:50 -0000	1.3.2.3
> +++ arch/mips/mm/c-tx49.c	11 Dec 2002 10:00:18 -0000
> @@ -311,7 +311,7 @@
>  		__save_and_cli(flags);
>  
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -333,7 +333,7 @@
>  		__save_and_cli(flags);
>  
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~(dc_lsize - 1);
> +		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> Index: arch/mips64/mm/c-mips64.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/mm/c-mips64.c,v
> retrieving revision 1.1.2.4
> diff -u -r1.1.2.4 c-mips64.c
> --- arch/mips64/mm/c-mips64.c	2 Dec 2002 00:24:52 -0000	1.1.2.4
> +++ arch/mips64/mm/c-mips64.c	11 Dec 2002 10:00:18 -0000
> @@ -301,13 +301,18 @@
>  static void
>  mips64_flush_icache_page(struct vm_area_struct *vma, struct page *page)
>  {
> -	unsigned long address;
> -
> +	/*
> +	 * If there's no context yet, or the page isn't executable, no icache 
> +	 * flush is needed.
> +	 */
>  	if (!(vma->vm_flags & VM_EXEC))
>  		return;
>  
> -	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & ((unsigned long)icache_size - 1));
> -	blast_icache_page_indexed(address);
> +	/*
> +	 * We're not sure of the virtual address(es) involved here, so
> +	 * conservatively flush the entire caches.
> +	 */
> +	flush_cache_all();
>  }
>  
>  /*
> @@ -324,7 +329,7 @@
>  	} else {
>  	        __save_and_cli(flags);
>  		a = addr & ~(dc_lsize - 1);
> -		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
> +		end = (addr + size - 1) & ~((unsigned long)dc_lsize - 1);
>  		while (1) {
>  			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
>  			if (a == end) break;
> @@ -346,7 +351,7 @@
>  	}
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
>  		if (a == end) break;
> @@ -365,7 +370,7 @@
>  	} else {
>  	        __save_and_cli(flags);
>  		a = addr & ~((unsigned long)dc_lsize - 1);
> -		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
> +		end = (addr + size - 1) & ~((unsigned long)dc_lsize - 1);
>  		while (1) {
>  			invalidate_dcache_line(a); /* Hit_Inv_D */
>  			if (a == end) break;
> @@ -388,7 +393,7 @@
>  	}
>  
>  	a = addr & ~(sc_lsize - 1);
> -	end = (addr + size) & ~(sc_lsize - 1);
> +	end = (addr + size - 1) & ~(sc_lsize - 1);
>  	while (1) {
>  		invalidate_scache_line(a); /* Hit_Writeback_Inv_SD */
>  		if (a == end) break;
> @@ -416,7 +421,7 @@
>  static void
>  mips64_flush_icache_all(void)
>  {
> -	if (mips_cpu.cputype == CPU_20KC) {
> +	if (mips_cpu.icache.flags | MIPS_CACHE_VTAG_CACHE) {
>  		blast_icache();
>  	}
>  }
> @@ -428,6 +433,7 @@
>          unsigned long config1;
>  	unsigned int lsize;
>  
> +	mips_cpu.icache.flags = 0;
>          if (!(config & (1 << 31))) {
>  	        /*
>  		 * Not a MIPS64 complainant CPU.
> @@ -457,6 +463,16 @@
>  	       ic_lsize = mips_cpu.icache.linesz;
>  	       icache_size = mips_cpu.icache.sets * mips_cpu.icache.ways *
>  		             ic_lsize;
> +
> +	       if ((config & 0x8) || (mips_cpu.cputype == CPU_20KC)) {
> +		       /* 
> +			* The CPU has a virtually tagged I-cache.
> +			* Some older 20Kc chips doesn't have the 'VI' bit in
> +			* the config register, so we also check for 20Kc.
> +			*/
> +		       mips_cpu.icache.flags = MIPS_CACHE_VTAG_CACHE;
> +		       printk("Virtually tagged I-cache detected\n");
> +	       }
>  	}
>  	printk("Primary instruction cache %dkb, linesize %d bytes (%d ways)\n",
>  	       icache_size >> 10, ic_lsize, mips_cpu.icache.ways);
> @@ -467,6 +483,7 @@
>          unsigned long config1;
>  	unsigned int lsize;
>  
> +	mips_cpu.dcache.flags = 0;
>          if (!(config & (1 << 31))) {
>  	        /*
>  		 * Not a MIPS64 complainant CPU.
> Index: include/asm-mips/cache.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips/cache.h,v
> retrieving revision 1.10.2.1
> diff -u -r1.10.2.1 cache.h
> --- include/asm-mips/cache.h	27 Jun 2002 14:21:23 -0000	1.10.2.1
> +++ include/asm-mips/cache.h	11 Dec 2002 10:00:22 -0000
> @@ -27,6 +27,7 @@
>   * Flag definitions
>   */
>  #define MIPS_CACHE_NOT_PRESENT 0x00000001
> +#define MIPS_CACHE_VTAG_CACHE  0x00000002 /* Virtually tagged cache. */
>  
>  #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_R6000) || defined(CONFIG_CPU_TX39XX)
>  #define L1_CACHE_BYTES		16
> Index: include/asm-mips/mips32_cache.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips/mips32_cache.h,v
> retrieving revision 1.2.2.1
> diff -u -r1.2.2.1 mips32_cache.h
> --- include/asm-mips/mips32_cache.h	5 Aug 2002 23:53:37 -0000	1.2.2.1
> +++ include/asm-mips/mips32_cache.h	11 Dec 2002 10:00:22 -0000
> @@ -37,45 +37,70 @@
>  
>  static inline void flush_icache_line_indexed(unsigned long addr)
>  {
> -	__asm__ __volatile__(
> -		".set noreorder\n\t"
> -		".set mips3\n\t"
> -		"cache %1, (%0)\n\t"
> -		".set mips0\n\t"
> -		".set reorder"
> -		:
> -		: "r" (addr),
> -		  "i" (Index_Invalidate_I));
> +	unsigned long waystep = icache_size/mips_cpu.icache.ways;
> +	unsigned int way;
> +
> +	for (way = 0; way < mips_cpu.icache.ways; way++)
> +	{
> +		__asm__ __volatile__(
> +			".set noreorder\n\t"
> +			".set mips3\n\t"
> +			"cache %1, (%0)\n\t"
> +			".set mips0\n\t"
> +			".set reorder"
> +			:
> +			: "r" (addr),
> +			"i" (Index_Invalidate_I));
> +		
> +		addr += waystep;
> +	}
>  }
>  
>  static inline void flush_dcache_line_indexed(unsigned long addr)
>  {
> -	__asm__ __volatile__(
> -		".set noreorder\n\t"
> -		".set mips3\n\t"
> -		"cache %1, (%0)\n\t"
> -		".set mips0\n\t"
> -		".set reorder"
> -		:
> -		: "r" (addr),
> -		  "i" (Index_Writeback_Inv_D));
> +	unsigned long waystep = dcache_size/mips_cpu.dcache.ways;
> +	unsigned int way;
> +
> +	for (way = 0; way < mips_cpu.dcache.ways; way++)
> +	{
> +		__asm__ __volatile__(
> +			".set noreorder\n\t"
> +			".set mips3\n\t"
> +			"cache %1, (%0)\n\t"
> +			".set mips0\n\t"
> +			".set reorder"
> +			:
> +			: "r" (addr),
> +			"i" (Index_Writeback_Inv_D));
> +
> +		addr += waystep;
> +	}
>  }
>  
>  static inline void flush_scache_line_indexed(unsigned long addr)
>  {
> -	__asm__ __volatile__(
> -		".set noreorder\n\t"
> -		".set mips3\n\t"
> -		"cache %1, (%0)\n\t"
> -		".set mips0\n\t"
> -		".set reorder"
> -		:
> -		: "r" (addr),
> -		  "i" (Index_Writeback_Inv_SD));
> +	unsigned long waystep = scache_size/mips_cpu.scache.ways;
> +	unsigned int way;
> +
> +	for (way = 0; way < mips_cpu.scache.ways; way++)
> +	{
> +		__asm__ __volatile__(
> +			".set noreorder\n\t"
> +			".set mips3\n\t"
> +			"cache %1, (%0)\n\t"
> +			".set mips0\n\t"
> +			".set reorder"
> +			:
> +			: "r" (addr),
> +			"i" (Index_Writeback_Inv_SD));
> +
> +		addr += waystep;
> +	}
>  }
>  
>  static inline void flush_icache_line(unsigned long addr)
>  {
> +
>  	__asm__ __volatile__(
>  		".set noreorder\n\t"
>  		".set mips3\n\t"
> @@ -210,12 +235,17 @@
>  
>  static inline void blast_dcache_page_indexed(unsigned long page)
>  {
> -	unsigned long start = page;
> -	unsigned long end = (start + PAGE_SIZE);
> -
> -	while(start < end) {
> -		cache_unroll(start,Index_Writeback_Inv_D);
> -		start += dc_lsize;
> +	unsigned long start;
> +	unsigned long end = (page + PAGE_SIZE);
> +	unsigned long waystep = dcache_size/mips_cpu.dcache.ways;
> +	unsigned int way;
> +
> +	for (way = 0; way < mips_cpu.dcache.ways; way++) {
> +		start = page + way*waystep;
> +		while(start < end) {
> +			cache_unroll(start,Index_Writeback_Inv_D);
> +			start += dc_lsize;
> +		}
>  	}
>  }
>  
> @@ -243,12 +273,17 @@
>  
>  static inline void blast_icache_page_indexed(unsigned long page)
>  {
> -	unsigned long start = page;
> -	unsigned long end = (start + PAGE_SIZE);
> -
> -	while(start < end) {
> -		cache_unroll(start,Index_Invalidate_I);
> -		start += ic_lsize;
> +	unsigned long start;
> +	unsigned long end = (page + PAGE_SIZE);
> +	unsigned long waystep = icache_size/mips_cpu.icache.ways;
> +	unsigned int way;
> +
> +	for (way = 0; way < mips_cpu.icache.ways; way++) {
> +		start = page + way*waystep;
> +		while(start < end) {
> +			cache_unroll(start,Index_Invalidate_I);
> +			start += ic_lsize;
> +		}
>  	}
>  }
>  
> @@ -276,12 +311,17 @@
>  
>  static inline void blast_scache_page_indexed(unsigned long page)
>  {
> -	unsigned long start = page;
> -	unsigned long end = page + PAGE_SIZE;
> -
> -	while(start < end) {
> -		cache_unroll(start,Index_Writeback_Inv_SD);
> -		start += sc_lsize;
> +	unsigned long start;
> +	unsigned long end = (page + PAGE_SIZE);
> +	unsigned long waystep = scache_size/mips_cpu.scache.ways;
> +	unsigned int way;
> +
> +	for (way = 0; way < mips_cpu.scache.ways; way++) {
> +		start = page + way*waystep;
> +		while(start < end) {
> +			cache_unroll(start,Index_Writeback_Inv_SD);
> +			start += sc_lsize;
> +		}
>  	}
>  }
>  
> Index: include/asm-mips64/cache.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips64/cache.h,v
> retrieving revision 1.7.2.3
> diff -u -r1.7.2.3 cache.h
> --- include/asm-mips64/cache.h	24 Jul 2002 16:12:11 -0000	1.7.2.3
> +++ include/asm-mips64/cache.h	11 Dec 2002 10:00:22 -0000
> @@ -27,6 +27,7 @@
>   * Flag definitions
>   */
>  #define MIPS_CACHE_NOT_PRESENT 0x00000001
> +#define MIPS_CACHE_VTAG_CACHE  0x00000002 /* Virtually tagged cache. */
>  
>  #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_R6000) || defined(CONFIG_CPU_TX39XX)
>  #define L1_CACHE_BYTES		16


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="off-by-one-flush-cache.patch"

diff -Nru linux/arch/mips/mm/c-mips32.c.orig linux/arch/mips/mm/c-mips32.c
--- linux/arch/mips/mm/c-mips32.c.orig	Fri May 10 09:12:29 2002
+++ linux/arch/mips/mm/c-mips32.c	Wed Nov 13 11:11:49 2002
@@ -324,12 +324,9 @@
 	} else {
 	        __save_and_cli(flags);
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 		__restore_flags(flags);
 	}
 	bc_wback_inv(addr, size);
@@ -346,12 +343,9 @@
 	}
 
 	a = addr & ~(sc_lsize - 1);
-	end = (addr + size) & ~(sc_lsize - 1);
-	while (1) {
+	end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
+	for (; a != end; a += sc_lsize)
 		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
-		if (a == end) break;
-		a += sc_lsize;
-	}
 }
 
 static void
@@ -365,12 +359,9 @@
 	} else {
 	        __save_and_cli(flags);
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 		__restore_flags(flags);
 	}
 
@@ -388,12 +379,9 @@
 	}
 
 	a = addr & ~(sc_lsize - 1);
-	end = (addr + size) & ~(sc_lsize - 1);
-	while (1) {
+	end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
+	for (; a != end; a += sc_lsize)
 		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
-		if (a == end) break;
-		a += sc_lsize;
-	}
 }
 
 static void
diff -Nru linux/arch/mips/mm/c-r4k.c.orig linux/arch/mips/mm/c-r4k.c
--- linux/arch/mips/mm/c-r4k.c.orig	Fri May 10 09:12:29 2002
+++ linux/arch/mips/mm/c-r4k.c	Wed Nov 13 11:15:47 2002
@@ -1167,12 +1167,9 @@
 		*(volatile unsigned long *)KSEG1;
 
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 		__restore_flags(flags);
 	}
 	bc_wback_inv(addr, size);
@@ -1189,12 +1186,9 @@
 	}
 
 	a = addr & ~(sc_lsize - 1);
-	end = (addr + size) & ~(sc_lsize - 1);
-	while (1) {
+	end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
+	for (; a != end; a += sc_lsize)
 		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
-		if (a == end) break;
-		a += sc_lsize;
-	}
 }
 
 static void
@@ -1211,12 +1205,9 @@
 		*(volatile unsigned long *)KSEG1;
 
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 		__restore_flags(flags);
 	}
 
@@ -1234,12 +1225,9 @@
 	}
 
 	a = addr & ~(sc_lsize - 1);
-	end = (addr + size) & ~(sc_lsize - 1);
-	while (1) {
+	end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
+	for (; a != end; a += sc_lsize)
 		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
-		if (a == end) break;
-		a += sc_lsize;
-	}
 }
 
 static void
diff -Nru linux/arch/mips/mm/c-r5432.c.orig linux/arch/mips/mm/c-r5432.c
--- linux/arch/mips/mm/c-r5432.c.orig	Fri May 10 09:12:29 2002
+++ linux/arch/mips/mm/c-r5432.c	Wed Nov 13 11:13:41 2002
@@ -384,12 +384,9 @@
 		flush_cache_all();
 	} else {
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 	}
 	bc_wback_inv(addr, size);
 }
@@ -403,12 +400,9 @@
 		flush_cache_all();
 	} else {
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 	}
 
 	bc_inv(addr, size);
diff -Nru linux/arch/mips/mm/c-rm7k.c.orig linux/arch/mips/mm/c-rm7k.c
--- linux/arch/mips/mm/c-rm7k.c.orig	Fri May 10 09:12:29 2002
+++ linux/arch/mips/mm/c-rm7k.c	Wed Nov 13 11:14:14 2002
@@ -130,25 +130,20 @@
 	unsigned long end, a;
 
 	a = addr & ~(sc_lsize - 1);
-	end = (addr + size) & ~(sc_lsize - 1);
-	while (1) {
+	end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
+	for (; a != end; a += sc_lsize) {
 		flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
 		flush_icache_line(a);	/* Hit_Invalidate_I */
 		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
-		if (a == end) break;
-		a += sc_lsize;
 	}
 
 	if (!rm7k_tcache_enabled) 
 		return;
 
 	a = addr & ~(tc_pagesize - 1);
-	end = (addr + size) & ~(tc_pagesize - 1);
-	while(1) {
+	end = (addr + size + tc_pagesize - 1) & ~(tc_pagesize - 1);
+	for (; a != end; a += tc_pagesize) 
 		invalidate_tcache_page(a);	/* Page_Invalidate_T */
-		if (a == end) break;
-		a += tc_pagesize;
-	}
 }
 	       
 static void
@@ -157,13 +152,11 @@
 	unsigned long end, a;
 
 	a = addr & ~(sc_lsize - 1);
-	end = (addr + size) & ~(sc_lsize - 1);
-	while (1) {
+	end = (addr + size + sc_lsize - 1) & ~(sc_lsize - 1);
+	for (; a != end; a += sc_lsize) {
 		invalidate_dcache_line(a);	/* Hit_Invalidate_D */
 		flush_icache_line(a);		/* Hit_Invalidate_I */
 		invalidate_scache_line(a);	/* Hit_Invalidate_SD */
-		if (a == end) break;
-		a += sc_lsize;
 	}
 
 	if (!rm7k_tcache_enabled) 
@@ -171,11 +164,8 @@
 
 	a = addr & ~(tc_pagesize - 1);
 	end = (addr + size) & ~(tc_pagesize - 1);
-	while(1) {
+	for (; a != end; a += tc_pagesize) 
 		invalidate_tcache_page(a);	/* Page_Invalidate_T */
-		if (a == end) break;
-		a += tc_pagesize;
-	}
 }
 
 static void
diff -Nru linux/arch/mips/mm/c-tx39.c.orig linux/arch/mips/mm/c-tx39.c
--- linux/arch/mips/mm/c-tx39.c.orig	Fri May 10 09:12:29 2002
+++ linux/arch/mips/mm/c-tx39.c	Wed Nov 13 11:09:01 2002
@@ -66,12 +66,9 @@
 	wbflush();
 
 	a = addr & ~(dcache_lsize - 1);
-	end = (addr + size) & ~(dcache_lsize - 1);
-	while (1) {
+	end = (addr + size + dcache_lsize - 1) & ~(dcache_lsize - 1);
+	for (; a != end; a += dcache_lsize)
 		invalidate_dcache_line(a); /* Hit_Invalidate_D */
-		if (a == end) break;
-		a += dcache_lsize;
-	}
 }
 
 
@@ -199,12 +196,9 @@
 		flush_cache_all();
 	} else {
 		a = addr & ~(dcache_lsize - 1);
-		end = (addr + size) & ~(dcache_lsize - 1);
-		while (1) {
+		end = (addr + size + dcache_lsize - 1) & ~(dcache_lsize - 1);
+		for (; a != end; a += dcache_lsize)
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dcache_lsize;
-		}
 	}
 }
 
@@ -216,12 +210,9 @@
 		flush_cache_all();
 	} else {
 		a = addr & ~(dcache_lsize - 1);
-		end = (addr + size) & ~(dcache_lsize - 1);
-		while (1) {
+		end = (addr + size + dcache_lsize - 1) & ~(dcache_lsize - 1);
+		for (; a != end; a += dcache_lsize)
 			invalidate_dcache_line(a); /* Hit_Invalidate_D */
-			if (a == end) break;
-			a += dcache_lsize;
-		}
 	}
 }
 
diff -Nru linux/arch/mips/mm/c-tx49.c.orig linux/arch/mips/mm/c-tx49.c
--- linux/arch/mips/mm/c-tx49.c.orig	Mon Oct  7 18:17:40 2002
+++ linux/arch/mips/mm/c-tx49.c	Wed Nov 13 11:10:28 2002
@@ -310,12 +310,9 @@
 		__save_and_cli(flags);
 
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize) 
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 		__restore_flags(flags);
 	}
 }
@@ -332,12 +329,9 @@
 		__save_and_cli(flags);
 
 		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
+		end = (addr + size + dc_lsize - 1) & ~(dc_lsize - 1);
+		for (; a != end; a += dc_lsize) 
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
 		__restore_flags(flags);
 	}
 }

--6c2NcOVqGQ03X4Wi--

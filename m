Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 03:52:09 +0100 (BST)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:10136 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133716AbWDNCv7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 03:51:59 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k3E33u8i001534;
	Fri, 14 Apr 2006 03:03:57 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k3E33unE022597;
	Fri, 14 Apr 2006 03:03:56 GMT
Message-ID: <443F111C.2000302@am.sony.com>
Date:	Thu, 13 Apr 2006 20:03:56 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp> <20060313.182303.115641770.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060313.182303.115641770.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Nemoto-san,

Your changes caused me some problems with linux-2.6.16.1 on tx4937:

/ # ps -A
CPU 0 Unable to handle kernel paging request at virtual address 7fa99400, epc == 80031018, ra == 80030
Oops[#1]:
Cpu 0
$ 0   : 00000000 10008401 7fa99400 7fa99400
$ 4   : 7fa99000 00000004 00000000 7fa9a000
$ 8   : 7fa99400 00000001 00000001 fffffff8
$12   : 00000006 00000000 00000000 2ace3bdc
$16   : 7fa99000 81338de0 00000004 80290000
$20   : 7fa24278 87ea0000 00000000 81338de0
$24   : 00000050 800305ac
$28   : 87e36000 87e37dd8 00000000 800318b0
Hi    : ffffffe0
Lo    : 00000002
epc   : 80031018 tx49_blast_icache32_page_indexed+0x220/0x6c8     Not tainted
ra    : 800318b0 r4k_flush_cache_page+0x22c/0x274
Status: 10008403    KERNEL EXL IE
Cause : 10000008
BadVA : 7fa99400
PrId  : 00002d30
Modules linked in:
Process ps (pid: 23, threadinfo=87e36000, task=8124a468)
Stack : 00000010 87e37e38 87e37e34 87e37ea8 813495f4 7fa99fc4 000013b4 87ea0000
        0000001b 0000001b 7fa99fc4 813b4fc4 800520c4 80051f94 00000000 00000001
        00000001 800a8194 00000000 00000001 87e37e30 87e37e34 81027680 813495f4
        87ea0000 81338e14 0000001b 81338de0 00000000 87ea0000 7fa24278 81157898
        00000000 1010e140 10008bcc 800d1ca0 81157898 8114c2dc 7fa24278 87e37f18
        ...
Call Trace:
 [<800520c4>] access_process_vm+0x1cc/0x200
 [<80051f94>] access_process_vm+0x9c/0x200
 [<800a8194>] __path_lookup_intent_open+0x60/0xc8
 [<800d1ca0>] proc_pid_cmdline+0x6c/0x11c
 [<800d272c>] proc_info_read+0x78/0xd0
 [<8004e4d0>] tasklet_action+0xc8/0x1a4
 [<80090da8>] vfs_read+0xa8/0x1bc
 [<80090d80>] vfs_read+0x80/0x1bc
 [<80091228>] sys_read+0x54/0xa0
 [<8009026c>] do_sys_open+0x11c/0x16c
 [<8002c624>] stack_done+0x20/0x3c


Code: 24880400  0800c427  01001821 <bc400000> bc400020  bc400040  bc400060  bc400080  bc4000a0
Segmentation fault

The revert below seemed to make it work.

-Geoff


Index: 2.6.16.1/arch/mips/mm/c-r4k.c
===================================================================
--- 2.6.16.1.orig/arch/mips/mm/c-r4k.c	2006-03-19 21:53:29.000000000 -0800
+++ 2.6.16.1/arch/mips/mm/c-r4k.c	2006-04-13 19:39:02.000000000 -0700
@@ -383,7 +383,6 @@
 	struct flush_cache_page_args *fcp_args = args;
 	struct vm_area_struct *vma = fcp_args->vma;
 	unsigned long addr = fcp_args->addr;
-	unsigned long paddr = fcp_args->pfn << PAGE_SHIFT;
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
@@ -433,11 +432,11 @@
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
+	addr = INDEX_BASE + (addr & (dcache_size - 1));
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
-		r4k_blast_dcache_page_indexed(cpu_has_pindexed_dcache ?
-					      paddr : addr);
+ 		r4k_blast_dcache_page_indexed(addr);
 		if (exec && !cpu_icache_snoops_remote_store) {
-			r4k_blast_scache_page_indexed(paddr);
+			r4k_blast_scache_page_indexed(addr);
 		}
 	}
 	if (exec) {

Atsushi Nemoto wrote:
>>>>>> On Wed, 01 Feb 2006 00:03:56 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> anemo> If dcache_size != icache_size or dcache_size != scache_size,
> anemo> icache/scache does not flushed properly.  Use correct cache size to
> anemo> calculate index value for scache/icache.
> 
> Ping.  I believe current c-r4k.c still broken for CPUs with large
> set-assotiative cache or physically indexed cache.  Here is a patch
> against current GIT tree.
> 
> 
> If dcache_size != icache_size or dcache_size != scache_size, or
> set-associative cache, icache/scache does not flushed properly.  Make
> blast_?cache_page_indexed() masks its index value correctly.  Also,
> use physical address for physically indexed pcache/scache.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 0668e9b..9572ed4 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -375,6 +375,7 @@ static void r4k_flush_cache_mm(struct mm
>  struct flush_cache_page_args {
>  	struct vm_area_struct *vma;
>  	unsigned long addr;
> +	unsigned long pfn;
>  };
>  
>  static inline void local_r4k_flush_cache_page(void *args)
> @@ -382,6 +383,7 @@ static inline void local_r4k_flush_cache
>  	struct flush_cache_page_args *fcp_args = args;
>  	struct vm_area_struct *vma = fcp_args->vma;
>  	unsigned long addr = fcp_args->addr;
> +	unsigned long paddr = fcp_args->pfn << PAGE_SHIFT;
>  	int exec = vma->vm_flags & VM_EXEC;
>  	struct mm_struct *mm = vma->vm_mm;
>  	pgd_t *pgdp;
> @@ -431,11 +433,12 @@ static inline void local_r4k_flush_cache
>  	 * Do indexed flush, too much work to get the (possible) TLB refills
>  	 * to work correctly.
>  	 */
> -	addr = INDEX_BASE + (addr & (dcache_size - 1));
>  	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
> -		r4k_blast_dcache_page_indexed(addr);
> -		if (exec && !cpu_icache_snoops_remote_store)
> -			r4k_blast_scache_page_indexed(addr);
> +		r4k_blast_dcache_page_indexed(cpu_has_pindexed_dcache ?
> +					      paddr : addr);
> +		if (exec && !cpu_icache_snoops_remote_store) {
> +			r4k_blast_scache_page_indexed(paddr);
> +		}
>  	}
>  	if (exec) {
>  		if (cpu_has_vtag_icache) {
> @@ -455,6 +458,7 @@ static void r4k_flush_cache_page(struct 
>  
>  	args.vma = vma;
>  	args.addr = addr;
> +	args.pfn = pfn;
>  
>  	on_each_cpu(local_r4k_flush_cache_page, &args, 1, 1);
>  }
> @@ -956,6 +960,7 @@ static void __init probe_pcache(void)
>  	switch (c->cputype) {
>  	case CPU_20KC:
>  	case CPU_25KF:
> +		c->dcache.flags |= MIPS_CACHE_PINDEX;
>  	case CPU_R10000:
>  	case CPU_R12000:
>  	case CPU_SB1:
> diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
> index 7c572be..fe232e3 100644
> --- a/arch/mips/mm/c-tx39.c
> +++ b/arch/mips/mm/c-tx39.c
> @@ -210,7 +210,6 @@ static void tx39_flush_cache_page(struct
>  	 * Do indexed flush, too much work to get the (possible) TLB refills
>  	 * to work correctly.
>  	 */
> -	page = (KSEG0 + (page & (dcache_size - 1)));
>  	if (cpu_has_dc_aliases || exec)
>  		tx39_blast_dcache_page_indexed(page);
>  	if (exec)
> diff --git a/include/asm-mips/cpu-features.h b/include/asm-mips/cpu-features.h
> index 78c9cc2..3f2b6d9 100644
> --- a/include/asm-mips/cpu-features.h
> +++ b/include/asm-mips/cpu-features.h
> @@ -96,6 +96,9 @@
>  #ifndef cpu_has_ic_fills_f_dc
>  #define cpu_has_ic_fills_f_dc	(cpu_data[0].icache.flags & MIPS_CACHE_IC_F_DC)
>  #endif
> +#ifndef cpu_has_pindexed_dcache
> +#define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
> +#endif
>  
>  /*
>   * I-Cache snoops remote store.  This only matters on SMP.  Some multiprocessors
> diff --git a/include/asm-mips/cpu-info.h b/include/asm-mips/cpu-info.h
> index d5cf519..140be1c 100644
> --- a/include/asm-mips/cpu-info.h
> +++ b/include/asm-mips/cpu-info.h
> @@ -39,6 +39,7 @@ struct cache_desc {
>  #define MIPS_CACHE_ALIASES	0x00000004	/* Cache could have aliases */
>  #define MIPS_CACHE_IC_F_DC	0x00000008	/* Ic can refill from D-cache */
>  #define MIPS_IC_SNOOPS_REMOTE	0x00000010	/* Ic snoops remote stores */
> +#define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
>  
>  struct cpuinfo_mips {
>  	unsigned long		udelay_val;
> diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
> index 9632c27..0bcb79a 100644
> --- a/include/asm-mips/r4kcache.h
> +++ b/include/asm-mips/r4kcache.h
> @@ -257,7 +257,8 @@ static inline void blast_##pfx##cache##l
>  									\
>  static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
>  {									\
> -	unsigned long start = page;					\
> +	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
> +	unsigned long start = INDEX_BASE + (page & indexmask);		\
>  	unsigned long end = start + PAGE_SIZE;				\
>  	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
>  	unsigned long ws_end = current_cpu_data.desc.ways <<		\
> 
> 

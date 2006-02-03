Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 14:42:35 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:23327 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133401AbWBCOmO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 14:42:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k13EldCg008571;
	Fri, 3 Feb 2006 14:47:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k13Eld2Q008570;
	Fri, 3 Feb 2006 14:47:39 GMT
Date:	Fri, 3 Feb 2006 14:47:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
Message-ID: <20060203144739.GB3375@linux-mips.org>
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp> <20060203.141424.72708300.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203.141424.72708300.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 03, 2006 at 02:14:24PM +0900, Atsushi Nemoto wrote:

> 
> >>>>> On Wed, 01 Feb 2006 00:03:56 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> anemo> If dcache_size != icache_size or dcache_size != scache_size,
> anemo> icache/scache does not flushed properly.  Use correct cache
> anemo> size to calculate index value for scache/icache.
> 
> Sorry, this patch was wrong !
> 
> We should use mask value based on the waysize (not whole cache size).
> 
> And now I think it would be better to do it in __BUILD_BLAST_CACHE().
> 
> I'll post a new patch later.

Maciej ran over what seems to be the same issue; I attach his patch below.
Could you check if it resolves your issues?

  Ralf

Date: Tue, 31 Jan 2006 15:38:37 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Ralf Baechle <ralf@mips.com>

Ralf,

 This patch fixes a problem with set-associative caches, where depending 
on the address passed to flush_cache_page() some ways may not indeed be 
invalidated.  This has been observed with a 24KEc and a 64K D-cache.  The 
S-cache part of the fix wasn't tested. ;-)

 As suggested by Nigel, alternatively blast_?cache_page_indexed() 
functions might be changed to mask out way selection bits, in which case 
the Atsushi's fix is the right one (barring magic number removal).

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@mips.com>

patch-mips-2.6.15-rc7-20060109-dc_aliases-4
diff -up --recursive --new-file linux-mips-2.6.15-rc7-20060109.macro/arch/mips/mm/c-r4k.c linux-mips-2.6.15-rc7-20060109/arch/mips/mm/c-r4k.c
--- linux-mips-2.6.15-rc7-20060109.macro/arch/mips/mm/c-r4k.c	Fri Dec  9 06:11:21 2005
+++ linux-mips-2.6.15-rc7-20060109/arch/mips/mm/c-r4k.c	Tue Jan 31 15:27:11 2006
@@ -375,7 +375,7 @@ static inline void local_r4k_flush_cache
 {
 	struct flush_cache_page_args *fcp_args = args;
 	struct vm_area_struct *vma = fcp_args->vma;
-	unsigned long addr = fcp_args->addr;
+	unsigned long addr = fcp_args->addr, iaddr;
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
@@ -425,11 +425,15 @@ static inline void local_r4k_flush_cache
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
-	addr = INDEX_BASE + (addr & (dcache_size - 1));
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
-		r4k_blast_dcache_page_indexed(addr);
-		if (exec && !cpu_icache_snoops_remote_store)
-			r4k_blast_scache_page_indexed(addr);
+		iaddr = INDEX_BASE +
+			(addr & (current_cpu_data.dcache.waysize - 1));
+		r4k_blast_dcache_page_indexed(iaddr);
+		if (exec && !cpu_icache_snoops_remote_store) {
+			iaddr = INDEX_BASE +
+				(addr & (current_cpu_data.scache.waysize - 1));
+			r4k_blast_scache_page_indexed(iaddr);
+		}
 	}
 	if (exec) {
 		if (cpu_has_vtag_icache) {
@@ -437,8 +441,11 @@ static inline void local_r4k_flush_cache
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
-		} else
-			r4k_blast_icache_page_indexed(addr);
+		} else {
+			iaddr = INDEX_BASE +
+				(addr & (current_cpu_data.icache.waysize - 1));
+			r4k_blast_icache_page_indexed(iaddr);
+		}
 	}
 }
 
@@ -1032,7 +1039,8 @@ static void __init probe_pcache(void)
 	case CPU_SB1:
 		break;
 	case CPU_24K:
-		if (!(read_c0_config7() & (1 << 16)))
+	case CPU_34K:
+		if (!(read_c0_config7() & _24K_CONF7_AR))
 	default:
 			if (c->dcache.waysize > PAGE_SIZE)
 				c->dcache.flags |= MIPS_CACHE_ALIASES;
diff -up --recursive --new-file linux-mips-2.6.15-rc7-20060109.macro/include/asm-mips/mipsregs.h linux-mips-2.6.15-rc7-20060109/include/asm-mips/mipsregs.h
--- linux-mips-2.6.15-rc7-20060109.macro/include/asm-mips/mipsregs.h	Thu Dec  8 05:58:58 2005
+++ linux-mips-2.6.15-rc7-20060109/include/asm-mips/mipsregs.h	Fri Jan 27 14:56:22 2006
@@ -533,6 +533,9 @@
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 
+/* Bits specific to the MIPS 24K, etc. CPUs.  */
+#define _24K_CONF7_AR		(_ULCAST_(1) << 16)
+
 /*
  * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
  */

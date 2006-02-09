Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 15:34:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43004 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133466AbWBIPdk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 15:33:40 +0000
Received: from localhost (p5155-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A41E3800E; Fri, 10 Feb 2006 00:39:28 +0900 (JST)
Date:	Fri, 10 Feb 2006 00:39:06 +0900 (JST)
Message-Id: <20060210.003906.08077001.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] add protected_blast_icache_range, blast_icache_range, etc.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add blast_xxx_range(), protected_blast_xxx_range() etc. for common
use.  They are built by __BUILD_BLAST_CACHE_RANGE().
Use protected_cache_op() macro for various protected_ routines.
Output code should be logically same.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e51c38c..1b71d91 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -471,61 +471,29 @@ struct flush_icache_range_args {
 static inline void local_r4k_flush_icache_range(void *args)
 {
 	struct flush_icache_range_args *fir_args = args;
-	unsigned long dc_lsize = cpu_dcache_line_size();
-	unsigned long ic_lsize = cpu_icache_line_size();
-	unsigned long sc_lsize = cpu_scache_line_size();
 	unsigned long start = fir_args->start;
 	unsigned long end = fir_args->end;
-	unsigned long addr, aend;
 
 	if (!cpu_has_ic_fills_f_dc) {
 		if (end - start > dcache_size) {
 			r4k_blast_dcache();
 		} else {
 			R4600_HIT_CACHEOP_WAR_IMPL;
-			addr = start & ~(dc_lsize - 1);
-			aend = (end - 1) & ~(dc_lsize - 1);
-
-			while (1) {
-				/* Hit_Writeback_Inv_D */
-				protected_writeback_dcache_line(addr);
-				if (addr == aend)
-					break;
-				addr += dc_lsize;
-			}
+			protected_blast_dcache_range(start, end);
 		}
 
 		if (!cpu_icache_snoops_remote_store) {
-			if (end - start > scache_size) {
+			if (end - start > scache_size)
 				r4k_blast_scache();
-			} else {
-				addr = start & ~(sc_lsize - 1);
-				aend = (end - 1) & ~(sc_lsize - 1);
-
-				while (1) {
-					/* Hit_Writeback_Inv_SD */
-					protected_writeback_scache_line(addr);
-					if (addr == aend)
-						break;
-					addr += sc_lsize;
-				}
-			}
+			else
+				protected_blast_scache_range(start, end);
 		}
 	}
 
 	if (end - start > icache_size)
 		r4k_blast_icache();
-	else {
-		addr = start & ~(ic_lsize - 1);
-		aend = (end - 1) & ~(ic_lsize - 1);
-		while (1) {
-			/* Hit_Invalidate_I */
-			protected_flush_icache_line(addr);
-			if (addr == aend)
-				break;
-			addr += ic_lsize;
-		}
-	}
+	else
+		protected_blast_icache_range(start, end);
 }
 
 static void r4k_flush_icache_range(unsigned long start, unsigned long end)
@@ -619,27 +587,14 @@ static void r4k_flush_icache_page(struct
 
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long end, a;
-
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
 	if (cpu_has_subset_pcaches) {
-		unsigned long sc_lsize = cpu_scache_line_size();
-
-		if (size >= scache_size) {
+		if (size >= scache_size)
 			r4k_blast_scache();
-			return;
-		}
-
-		a = addr & ~(sc_lsize - 1);
-		end = (addr + size - 1) & ~(sc_lsize - 1);
-		while (1) {
-			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
-			if (a == end)
-				break;
-			a += sc_lsize;
-		}
+		else
+			blast_scache_range(addr, addr + size);
 		return;
 	}
 
@@ -651,17 +606,8 @@ static void r4k_dma_cache_wback_inv(unsi
 	if (size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
-		unsigned long dc_lsize = cpu_dcache_line_size();
-
 		R4600_HIT_CACHEOP_WAR_IMPL;
-		a = addr & ~(dc_lsize - 1);
-		end = (addr + size - 1) & ~(dc_lsize - 1);
-		while (1) {
-			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
-			if (a == end)
-				break;
-			a += dc_lsize;
-		}
+		blast_dcache_range(addr, addr + size);
 	}
 
 	bc_wback_inv(addr, size);
@@ -669,44 +615,22 @@ static void r4k_dma_cache_wback_inv(unsi
 
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long end, a;
-
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
 	if (cpu_has_subset_pcaches) {
-		unsigned long sc_lsize = cpu_scache_line_size();
-
-		if (size >= scache_size) {
+		if (size >= scache_size)
 			r4k_blast_scache();
-			return;
-		}
-
-		a = addr & ~(sc_lsize - 1);
-		end = (addr + size - 1) & ~(sc_lsize - 1);
-		while (1) {
-			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
-			if (a == end)
-				break;
-			a += sc_lsize;
-		}
+		else
+			blast_scache_range(addr, addr + size);
 		return;
 	}
 
 	if (size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
-		unsigned long dc_lsize = cpu_dcache_line_size();
-
 		R4600_HIT_CACHEOP_WAR_IMPL;
-		a = addr & ~(dc_lsize - 1);
-		end = (addr + size - 1) & ~(dc_lsize - 1);
-		while (1) {
-			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
-			if (a == end)
-				break;
-			a += dc_lsize;
-		}
+		blast_dcache_range(addr, addr + size);
 	}
 
 	bc_inv(addr, size);
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 0a97a94..7c572be 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -44,8 +44,6 @@ __asm__ __volatile__( \
 /* TX39H-style cache flush routines. */
 static void tx39h_flush_icache_all(void)
 {
-	unsigned long start = KSEG0;
-	unsigned long end = (start + icache_size);
 	unsigned long flags, config;
 
 	/* disable icache (set ICE#) */
@@ -53,33 +51,18 @@ static void tx39h_flush_icache_all(void)
 	config = read_c0_conf();
 	write_c0_conf(config & ~TX39_CONF_ICE);
 	TX39_STOP_STREAMING();
-
-	/* invalidate icache */
-	while (start < end) {
-		cache16_unroll32(start, Index_Invalidate_I);
-		start += 0x200;
-	}
-
+	blast_icache16();
 	write_c0_conf(config);
 	local_irq_restore(flags);
 }
 
 static void tx39h_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long end, a;
-	unsigned long dc_lsize = current_cpu_data.dcache.linesz;
-
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
 	iob();
-	a = addr & ~(dc_lsize - 1);
-	end = (addr + size - 1) & ~(dc_lsize - 1);
-	while (1) {
-		invalidate_dcache_line(a); /* Hit_Invalidate_D */
-		if (a == end) break;
-		a += dc_lsize;
-	}
+	blast_inv_dcache_range(addr, addr + size);
 }
 
 
@@ -241,42 +224,21 @@ static void tx39_flush_data_cache_page(u
 
 static void tx39_flush_icache_range(unsigned long start, unsigned long end)
 {
-	unsigned long dc_lsize = current_cpu_data.dcache.linesz;
-	unsigned long addr, aend;
-
 	if (end - start > dcache_size)
 		tx39_blast_dcache();
-	else {
-		addr = start & ~(dc_lsize - 1);
-		aend = (end - 1) & ~(dc_lsize - 1);
-
-		while (1) {
-			/* Hit_Writeback_Inv_D */
-			protected_writeback_dcache_line(addr);
-			if (addr == aend)
-				break;
-			addr += dc_lsize;
-		}
-	}
+	else
+		protected_blast_dcache_range(start, end);
 
 	if (end - start > icache_size)
 		tx39_blast_icache();
 	else {
 		unsigned long flags, config;
-		addr = start & ~(dc_lsize - 1);
-		aend = (end - 1) & ~(dc_lsize - 1);
 		/* disable icache (set ICE#) */
 		local_irq_save(flags);
 		config = read_c0_conf();
 		write_c0_conf(config & ~TX39_CONF_ICE);
 		TX39_STOP_STREAMING();
-		while (1) {
-			/* Hit_Invalidate_I */
-			protected_flush_icache_line(addr);
-			if (addr == aend)
-				break;
-			addr += dc_lsize;
-		}
+		protected_blast_icache_range(start, end);
 		write_c0_conf(config);
 		local_irq_restore(flags);
 	}
@@ -311,7 +273,7 @@ static void tx39_flush_icache_page(struc
 
 static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long end, a;
+	unsigned long end;
 
 	if (((size | addr) & (PAGE_SIZE - 1)) == 0) {
 		end = addr + size;
@@ -322,20 +284,13 @@ static void tx39_dma_cache_wback_inv(uns
 	} else if (size > dcache_size) {
 		tx39_blast_dcache();
 	} else {
-		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
-		a = addr & ~(dc_lsize - 1);
-		end = (addr + size - 1) & ~(dc_lsize - 1);
-		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
+		blast_dcache_range(addr, addr + size);
 	}
 }
 
 static void tx39_dma_cache_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long end, a;
+	unsigned long end;
 
 	if (((size | addr) & (PAGE_SIZE - 1)) == 0) {
 		end = addr + size;
@@ -346,14 +301,7 @@ static void tx39_dma_cache_inv(unsigned 
 	} else if (size > dcache_size) {
 		tx39_blast_dcache();
 	} else {
-		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
-		a = addr & ~(dc_lsize - 1);
-		end = (addr + size - 1) & ~(dc_lsize - 1);
-		while (1) {
-			invalidate_dcache_line(a); /* Hit_Invalidate_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
+		blast_inv_dcache_range(addr, addr + size);
 	}
 }
 
diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
index cc53196..9632c27 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -14,6 +14,7 @@
 
 #include <asm/asm.h>
 #include <asm/cacheops.h>
+#include <asm/cpu-features.h>
 
 /*
  * This macro return a properly sign-extended address suitable as base address
@@ -78,22 +79,25 @@ static inline void flush_scache_line(uns
 	cache_op(Hit_Writeback_Inv_SD, addr);
 }
 
+#define protected_cache_op(op,addr)				\
+	__asm__ __volatile__(					\
+	"	.set	push			\n"		\
+	"	.set	noreorder		\n"		\
+	"	.set	mips3			\n"		\
+	"1:	cache	%0, (%1)		\n"		\
+	"2:	.set	pop			\n"		\
+	"	.section __ex_table,\"a\"	\n"		\
+	"	"STR(PTR)" 1b, 2b		\n"		\
+	"	.previous"					\
+	:							\
+	: "i" (op), "r" (addr))
+
 /*
  * The next two are for badland addresses like signal trampolines.
  */
 static inline void protected_flush_icache_line(unsigned long addr)
 {
-	__asm__ __volatile__(
-		"	.set	push			\n"
-		"	.set	noreorder		\n"
-		"	.set	mips3			\n"
-		"1:	cache	%0, (%1)		\n"
-		"2:	.set	pop			\n"
-		"	.section __ex_table,\"a\"	\n"
-		"	"STR(PTR)" 1b, 2b		\n"
-		"	.previous"
-		:
-		: "i" (Hit_Invalidate_I), "r" (addr));
+	protected_cache_op(Hit_Invalidate_I, addr);
 }
 
 /*
@@ -104,32 +108,12 @@ static inline void protected_flush_icach
  */
 static inline void protected_writeback_dcache_line(unsigned long addr)
 {
-	__asm__ __volatile__(
-		"	.set	push			\n"
-		"	.set	noreorder		\n"
-		"	.set	mips3			\n"
-		"1:	cache	%0, (%1)		\n"
-		"2:	.set	pop			\n"
-		"	.section __ex_table,\"a\"	\n"
-		"	"STR(PTR)" 1b, 2b		\n"
-		"	.previous"
-		:
-		: "i" (Hit_Writeback_Inv_D), "r" (addr));
+	protected_cache_op(Hit_Writeback_Inv_D, addr);
 }
 
 static inline void protected_writeback_scache_line(unsigned long addr)
 {
-	__asm__ __volatile__(
-		"	.set	push			\n"
-		"	.set	noreorder		\n"
-		"	.set	mips3			\n"
-		"1:	cache	%0, (%1)		\n"
-		"2:	.set	pop			\n"
-		"	.section __ex_table,\"a\"	\n"
-		"	"STR(PTR)" 1b, 2b		\n"
-		"	.previous"
-		:
-		: "i" (Hit_Writeback_Inv_SD), "r" (addr));
+	protected_cache_op(Hit_Writeback_Inv_SD, addr);
 }
 
 /*
@@ -295,4 +279,28 @@ __BUILD_BLAST_CACHE(i, icache, Index_Inv
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
 __BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
 
+/* build blast_xxx_range, protected_blast_xxx_range */
+#define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot) \
+static inline void prot##blast_##pfx##cache##_range(unsigned long start, \
+						    unsigned long end)	\
+{									\
+	unsigned long lsize = cpu_##desc##_line_size();			\
+	unsigned long addr = start & ~(lsize - 1);			\
+	unsigned long aend = (end - 1) & ~(lsize - 1);			\
+	while (1) {							\
+		prot##cache_op(hitop, addr);				\
+		if (addr == aend)					\
+			break;						\
+		addr += lsize;						\
+	}								\
+}
+
+__BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, protected_)
+__BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_)
+__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_)
+__BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, )
+__BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, )
+/* blast_inv_dcache_range */
+__BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, )
+
 #endif /* _ASM_R4KCACHE_H */

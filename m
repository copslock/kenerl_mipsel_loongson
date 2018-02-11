Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 08:47:23 +0100 (CET)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:58364 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeBKHrQRaD1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 08:47:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 16FE33F649;
        Sun, 11 Feb 2018 08:47:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2DjC4JEGfiaB; Sun, 11 Feb 2018 08:46:59 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 149F73F5D0;
        Sun, 11 Feb 2018 08:46:52 +0100 (CET)
Date:   Sun, 11 Feb 2018 08:46:51 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Use SYNC.L for data cache and SYNC.P for
 instruction cache
Message-ID: <20180211074651.GB2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Toshiba TX79 manual programming notes:

    For all CACHE sub-operations which operate on the instruction cache
    the following programming restrictions have to be followed:

    1. A sequence of CACHE instructions has to be directly preceded and
       followed by a SYNC.P instruction.
    2. Each individual FILL sub-operation has to be followed by a SYNC.L
       instruction.

    For all CACHE sub-operations which operate on the data cache the
    following programming restrictions have to be followed:

    1. A sequence of CACHE instructions have to be directly preceded and
       followed by a SYNC.L instruction.
    2. Each of the three WRITEBACK sub-operations have to be
       individually followed by a SYNC.L instruction.

    For all CACHE sub-operations which operate on the BTAC the following
    programming restrictions have to be followed:

    1. A sequence of CACHE instructions have to be directly preceded and
       followed by a SYNC.P instruction.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
This change has been ported from v2.6 patches.

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 1b69bb602ffd..c1834e2ed92d 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -46,7 +46,7 @@ extern void (*r4k_blast_icache)(void);
 #define R5900_LOOP_WAR() do { } while(0)
 #endif
 
-#define cache_op(op,addr)						\
+#define cache_op_s(op,addr)						\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noreorder				\n"	\
@@ -55,6 +55,35 @@ extern void (*r4k_blast_icache)(void);
 	"	.set	pop					\n"	\
 	:								\
 	: "i" (op), "R" (*(unsigned char *)(addr)))
+#ifdef CONFIG_CPU_R5900
+#define cache_op_d(op,addr)						\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noreorder				\n"	\
+	"	.set	mips3\n\t				\n"	\
+	"	sync.l						\n"	\
+	"	cache	%0, %1					\n"	\
+	"	sync.l						\n"	\
+	"	.set	pop					\n"	\
+	:								\
+	: "i" (op), "R" (*(unsigned char *)(addr)))
+#define cache_op_i(op,addr)						\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noreorder				\n"	\
+	"	.set	mips3\n\t				\n"	\
+	"	sync.p						\n"	\
+	"	cache	%0, %1					\n"	\
+	"	sync.p						\n"	\
+	"	.set	pop					\n"	\
+	:								\
+	: "i" (op), "R" (*(unsigned char *)(addr)))
+#else
+#define cache_op_d cache_op_s
+#define cache_op_i cache_op_s
+#define cache_op cache_op_s
+#endif
+#define cache_op_t cache_op_s
 
 #ifdef CONFIG_MIPS_MT
 
@@ -99,20 +128,20 @@ extern void (*r4k_blast_icache)(void);
 static inline void flush_icache_line_indexed(unsigned long addr)
 {
 	__iflush_prologue
-	cache_op(Index_Invalidate_I, addr);
+	cache_op_i(Index_Invalidate_I, addr);
 	__iflush_epilogue
 }
 
 static inline void flush_dcache_line_indexed(unsigned long addr)
 {
 	__dflush_prologue
-	cache_op(Index_Writeback_Inv_D, addr);
+	cache_op_d(Index_Writeback_Inv_D, addr);
 	__dflush_epilogue
 }
 
 static inline void flush_scache_line_indexed(unsigned long addr)
 {
-	cache_op(Index_Writeback_Inv_SD, addr);
+	cache_op_s(Index_Writeback_Inv_SD, addr);
 }
 
 static inline void flush_icache_line(unsigned long addr)
@@ -120,11 +149,11 @@ static inline void flush_icache_line(unsigned long addr)
 	__iflush_prologue
 	switch (boot_cpu_type()) {
 	case CPU_LOONGSON2:
-		cache_op(Hit_Invalidate_I_Loongson2, addr);
+		cache_op_i(Hit_Invalidate_I_Loongson2, addr);
 		break;
 
 	default:
-		cache_op(Hit_Invalidate_I, addr);
+		cache_op_i(Hit_Invalidate_I, addr);
 		break;
 	}
 	__iflush_epilogue
@@ -133,28 +162,28 @@ static inline void flush_icache_line(unsigned long addr)
 static inline void flush_dcache_line(unsigned long addr)
 {
 	__dflush_prologue
-	cache_op(Hit_Writeback_Inv_D, addr);
+	cache_op_d(Hit_Writeback_Inv_D, addr);
 	__dflush_epilogue
 }
 
 static inline void invalidate_dcache_line(unsigned long addr)
 {
 	__dflush_prologue
-	cache_op(Hit_Invalidate_D, addr);
+	cache_op_d(Hit_Invalidate_D, addr);
 	__dflush_epilogue
 }
 
 static inline void invalidate_scache_line(unsigned long addr)
 {
-	cache_op(Hit_Invalidate_SD, addr);
+	cache_op_s(Hit_Invalidate_SD, addr);
 }
 
 static inline void flush_scache_line(unsigned long addr)
 {
-	cache_op(Hit_Writeback_Inv_SD, addr);
+	cache_op_s(Hit_Writeback_Inv_SD, addr);
 }
 
-#define protected_cache_op(op,addr)				\
+#define protected_cache_op_s(op,addr)				\
 ({								\
 	int __err = 0;						\
 	__asm__ __volatile__(					\
@@ -176,6 +205,49 @@ static inline void flush_scache_line(unsigned long addr)
 	__err;							\
 })
 
+#ifdef CONFIG_CPU_R5900
+#define protected_cache_op_d(op,addr)				\
+({								\
+	int __err = 0;						\
+	__asm__ __volatile__(					\
+	"	.set	push			\n"		\
+	"	.set	noreorder		\n"		\
+	"	.set	mips3			\n"		\
+	"	sync.l				\n"		\
+	"1:	cache	%0, (%1)		\n"		\
+	"	sync.l				\n"		\
+	"2:	.set	pop			\n"		\
+	"	.section __ex_table,\"a\"	\n"		\
+	"	"STR(PTR)" 1b, 2b		\n"		\
+	"	.previous"					\
+	:							\
+	: "i" (op), "r" (addr));				\
+	__err;							\
+})
+
+#define protected_cache_op_i(op,addr)				\
+({								\
+	int __err = 0;						\
+	__asm__ __volatile__(					\
+	"	.set	push			\n"		\
+	"	.set	noreorder		\n"		\
+	"	.set	mips3			\n"		\
+	"	sync.p				\n"		\
+	"1:	cache	%0, (%1)		\n"		\
+	"	sync.p				\n"		\
+	"2:	.set	pop			\n"		\
+	"	.section __ex_table,\"a\"	\n"		\
+	"	"STR(PTR)" 1b, 2b		\n"		\
+	"	.previous"					\
+	:							\
+	: "i" (op), "r" (addr));				\
+	__err;							\
+})
+#else
+#define protected_cache_op_i protected_cache_op_s
+#define protected_cache_op_d protected_cache_op_s
+#define protected_cache_op protected_cache_op_s
+#endif
 
 #define protected_cachee_op(op,addr)				\
 ({								\
@@ -207,13 +279,13 @@ static inline int protected_flush_icache_line(unsigned long addr)
 {
 	switch (boot_cpu_type()) {
 	case CPU_LOONGSON2:
-		return protected_cache_op(Hit_Invalidate_I_Loongson2, addr);
+		return protected_cache_op_i(Hit_Invalidate_I_Loongson2, addr);
 
 	default:
 #ifdef CONFIG_EVA
-		return protected_cachee_op(Hit_Invalidate_I, addr);
+		return protected_cachee_op_i(Hit_Invalidate_I, addr);
 #else
-		return protected_cache_op(Hit_Invalidate_I, addr);
+		return protected_cache_op_i(Hit_Invalidate_I, addr);
 #endif
 	}
 }
@@ -227,18 +299,18 @@ static inline int protected_flush_icache_line(unsigned long addr)
 static inline int protected_writeback_dcache_line(unsigned long addr)
 {
 #ifdef CONFIG_EVA
-	return protected_cachee_op(Hit_Writeback_Inv_D, addr);
+	return protected_cachee_op_d(Hit_Writeback_Inv_D, addr);
 #else
-	return protected_cache_op(Hit_Writeback_Inv_D, addr);
+	return protected_cache_op_d(Hit_Writeback_Inv_D, addr);
 #endif
 }
 
 static inline int protected_writeback_scache_line(unsigned long addr)
 {
 #ifdef CONFIG_EVA
-	return protected_cachee_op(Hit_Writeback_Inv_SD, addr);
+	return protected_cachee_op_s(Hit_Writeback_Inv_SD, addr);
 #else
-	return protected_cache_op(Hit_Writeback_Inv_SD, addr);
+	return protected_cache_op_s(Hit_Writeback_Inv_SD, addr);
 #endif
 }
 
@@ -247,7 +319,7 @@ static inline int protected_writeback_scache_line(unsigned long addr)
  */
 static inline void invalidate_tcache_page(unsigned long addr)
 {
-	cache_op(Page_Invalidate_T, addr);
+	cache_op_t(Page_Invalidate_T, addr);
 }
 
 #ifndef CONFIG_CPU_MIPSR6
@@ -328,6 +400,65 @@ static inline void invalidate_tcache_page(unsigned long addr)
 		:							\
 		: "r" (base),						\
 		  "i" (op));
+#ifdef CONFIG_CPU_R5900
+#define cache64_unroll32_d(base,op)					\
+	__asm__ __volatile__(						\
+	"	.set push					\n"	\
+	"	.set noreorder					\n"	\
+	"	.set mips3					\n"	\
+	"	sync.l						\n"	\
+	"	cache %1, 0x000(%0); sync.l; cache %1, 0x040(%0); sync.l	\n"	\
+	"	cache %1, 0x080(%0); sync.l; cache %1, 0x0c0(%0); sync.l	\n"	\
+	"	cache %1, 0x100(%0); sync.l; cache %1, 0x140(%0); sync.l	\n"	\
+	"	cache %1, 0x180(%0); sync.l; cache %1, 0x1c0(%0); sync.l	\n"	\
+	"	cache %1, 0x200(%0); sync.l; cache %1, 0x240(%0); sync.l	\n"	\
+	"	cache %1, 0x280(%0); sync.l; cache %1, 0x2c0(%0); sync.l	\n"	\
+	"	cache %1, 0x300(%0); sync.l; cache %1, 0x340(%0); sync.l	\n"	\
+	"	cache %1, 0x380(%0); sync.l; cache %1, 0x3c0(%0); sync.l	\n"	\
+	"	cache %1, 0x400(%0); sync.l; cache %1, 0x440(%0); sync.l	\n"	\
+	"	cache %1, 0x480(%0); sync.l; cache %1, 0x4c0(%0); sync.l	\n"	\
+	"	cache %1, 0x500(%0); sync.l; cache %1, 0x540(%0); sync.l	\n"	\
+	"	cache %1, 0x580(%0); sync.l; cache %1, 0x5c0(%0); sync.l	\n"	\
+	"	cache %1, 0x600(%0); sync.l; cache %1, 0x640(%0); sync.l	\n"	\
+	"	cache %1, 0x680(%0); sync.l; cache %1, 0x6c0(%0); sync.l	\n"	\
+	"	cache %1, 0x700(%0); sync.l; cache %1, 0x740(%0); sync.l	\n"	\
+	"	cache %1, 0x780(%0); sync.l; cache %1, 0x7c0(%0); sync.l	\n"	\
+	"	.set pop					\n"	\
+		:							\
+		: "r" (base),						\
+		  "i" (op));
+
+#define cache64_unroll32_i(base,op)					\
+	__asm__ __volatile__(						\
+	"	.set push					\n"	\
+	"	.set noreorder					\n"	\
+	"	.set mips3					\n"	\
+	"	sync.p						\n"	\
+	"	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n"	\
+	"	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n"	\
+	"	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n"	\
+	"	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n"	\
+	"	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n"	\
+	"	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n"	\
+	"	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n"	\
+	"	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n"	\
+	"	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n"	\
+	"	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n"	\
+	"	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n"	\
+	"	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n"	\
+	"	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n"	\
+	"	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n"	\
+	"	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n"	\
+	"	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n"	\
+	"	sync.p						\n"	\
+	"	.set pop					\n"	\
+		:							\
+		: "r" (base),						\
+		  "i" (op));
+#else
+#define cache64_unroll32_i cache64_unroll32
+#define cache64_unroll32_d cache64_unroll32
+#endif
 
 #define cache128_unroll32(base,op)					\
 	__asm__ __volatile__(						\
@@ -584,7 +715,7 @@ static inline void invalidate_tcache_page(unsigned long addr)
 		  "i" (op));
 
 /* build blast_xxx, blast_xxx_page, blast_xxx_page_indexed */
-#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize, extra)	\
+#define __BUILD_BLAST_CACHE(fn_pfx, pfx, desc, indexop, hitop, lsize, extra)	\
 static inline void extra##blast_##pfx##cache##lsize(void)		\
 {									\
 	unsigned long start = INDEX_BASE;				\
@@ -598,7 +729,7 @@ static inline void extra##blast_##pfx##cache##lsize(void)		\
 									\
 	for (ws = 0; ws < ws_end; ws += ws_inc)				\
 		for (addr = start; addr < end; addr += lsize * 32)	\
-			cache##lsize##_unroll32(addr|ws, indexop);	\
+			cache##lsize##_unroll32##fn_pfx(addr|ws, indexop);	\
 									\
 	__##pfx##flush_epilogue						\
 }									\
@@ -611,7 +742,7 @@ static inline void extra##blast_##pfx##cache##lsize##_page(unsigned long page) \
 	__##pfx##flush_prologue						\
 									\
 	do {								\
-		cache##lsize##_unroll32(start, hitop);			\
+		cache##lsize##_unroll32##fn_pfx(start, hitop);			\
 		start += lsize * 32;					\
 	} while (start < end);						\
 									\
@@ -632,31 +763,31 @@ static inline void extra##blast_##pfx##cache##lsize##_page_indexed(unsigned long
 									\
 	for (ws = 0; ws < ws_end; ws += ws_inc)				\
 		for (addr = start; addr < end; addr += lsize * 32)	\
-			cache##lsize##_unroll32(addr|ws, indexop);	\
+			cache##lsize##_unroll32##fn_pfx(addr|ws, indexop);	\
 									\
 	__##pfx##flush_epilogue						\
 }
 
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 16, )
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16, )
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16, )
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 32, )
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32, )
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I_Loongson2, 32, loongson2_)
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32, )
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64, )
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64, )
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 128, )
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 128, )
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128, )
+__BUILD_BLAST_CACHE(, d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 16, )
+__BUILD_BLAST_CACHE(, i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16, )
+__BUILD_BLAST_CACHE(, s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16, )
+__BUILD_BLAST_CACHE(, d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 32, )
+__BUILD_BLAST_CACHE(, i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32, )
+__BUILD_BLAST_CACHE(, i, icache, Index_Invalidate_I, Hit_Invalidate_I_Loongson2, 32, loongson2_)
+__BUILD_BLAST_CACHE(, s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32, )
+__BUILD_BLAST_CACHE(_d, d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 64, )
+__BUILD_BLAST_CACHE(_i, i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )
+__BUILD_BLAST_CACHE(, s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64, )
+__BUILD_BLAST_CACHE(, d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 128, )
+__BUILD_BLAST_CACHE(, i, icache, Index_Invalidate_I, Hit_Invalidate_I, 128, )
+__BUILD_BLAST_CACHE(, s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128, )
 
-__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16, )
-__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 32, )
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 16, )
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32, )
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64, )
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128, )
+__BUILD_BLAST_CACHE(, inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 16, )
+__BUILD_BLAST_CACHE(, inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D, 32, )
+__BUILD_BLAST_CACHE(, inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 16, )
+__BUILD_BLAST_CACHE(, inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32, )
+__BUILD_BLAST_CACHE(, inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64, )
+__BUILD_BLAST_CACHE(, inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128, )
 
 #define __BUILD_BLAST_USER_CACHE(pfx, desc, indexop, hitop, lsize) \
 static inline void blast_##pfx##cache##lsize##_user_page(unsigned long page) \
@@ -685,7 +816,7 @@ __BUILD_BLAST_USER_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,
 __BUILD_BLAST_USER_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
 
 /* build blast_xxx_range, protected_blast_xxx_range */
-#define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot, extra)	\
+#define __BUILD_BLAST_CACHE_RANGE(fn_pfx, pfx, desc, hitop, prot, extra)	\
 static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start, \
 						    unsigned long end)	\
 {									\
@@ -696,7 +827,7 @@ static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,
 	__##pfx##flush_prologue						\
 									\
 	while (1) {							\
-		prot##cache_op(hitop, addr);				\
+		prot##cache_op##fn_pfx(hitop, addr);			\
 		R5900_LOOP_WAR();  /* FIXME: Is this needed in C? */	\
 		if (addr == aend)					\
 			break;						\
@@ -708,8 +839,8 @@ static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,
 
 #ifndef CONFIG_EVA
 
-__BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, protected_, )
-__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_, )
+__BUILD_BLAST_CACHE_RANGE(_d, d, dcache, Hit_Writeback_Inv_D, protected_, )
+__BUILD_BLAST_CACHE_RANGE(_i, i, icache, Hit_Invalidate_I, protected_, )
 
 #else
 
@@ -746,14 +877,14 @@ __BUILD_PROT_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D)
 __BUILD_PROT_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I)
 
 #endif
-__BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_, )
-__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson2, \
+__BUILD_BLAST_CACHE_RANGE(_s, s, scache, Hit_Writeback_Inv_SD, protected_, )
+__BUILD_BLAST_CACHE_RANGE(_i, i, icache, Hit_Invalidate_I_Loongson2, \
 	protected_, loongson2_)
-__BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, , )
-__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, , )
-__BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
+__BUILD_BLAST_CACHE_RANGE(_d, d, dcache, Hit_Writeback_Inv_D, , )
+__BUILD_BLAST_CACHE_RANGE(_i, i, icache, Hit_Invalidate_I, , )
+__BUILD_BLAST_CACHE_RANGE(_s, s, scache, Hit_Writeback_Inv_SD, , )
 /* blast_inv_dcache_range */
-__BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
-__BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
+__BUILD_BLAST_CACHE_RANGE(_d, inv_d, dcache, Hit_Invalidate_D, , )
+__BUILD_BLAST_CACHE_RANGE(_d, inv_s, scache, Hit_Invalidate_SD, , )
 
 #endif /* _ASM_R4KCACHE_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3cd5bb465354..432ebd18cb7c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1626,14 +1626,14 @@ static int probe_scache(void)
 	write_c0_taglo(0);
 	write_c0_taghi(0);
 	__asm__ __volatile__("nop; nop; nop; nop;"); /* avoid the hazard */
-	cache_op(Index_Store_Tag_I, begin);
-	cache_op(Index_Store_Tag_D, begin);
-	cache_op(Index_Store_Tag_SD, begin);
+	cache_op_i(Index_Store_Tag_I, begin);
+	cache_op_d(Index_Store_Tag_D, begin);
+	cache_op_s(Index_Store_Tag_SD, begin);
 
 	/* Now search for the wrap around point. */
 	pow2 = (128 * 1024);
 	for (addr = begin + (128 * 1024); addr < end; addr = begin + pow2) {
-		cache_op(Index_Load_Tag_SD, addr);
+		cache_op_s(Index_Load_Tag_SD, addr);
 		__asm__ __volatile__("nop; nop; nop; nop;"); /* hazard... */
 		if (!read_c0_taglo())
 			break;

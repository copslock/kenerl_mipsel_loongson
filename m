Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2006 17:26:58 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23241 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3458491AbWA1R0i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Jan 2006 17:26:38 +0000
Received: from localhost (p1217-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D16489C93; Sun, 29 Jan 2006 02:31:17 +0900 (JST)
Date:	Sun, 29 Jan 2006 02:30:55 +0900 (JST)
Message-Id: <20060129.023055.29575878.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] build blast_cache routines from template
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
X-archive-position: 10219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Build blast_xxx, blast_xxx_page, blast_xxx_page_indexed from template.
Easy to maintainance and saves 300 lines.
Output code should not be changed.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
index a5ea9d8..cc53196 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -166,123 +166,6 @@ static inline void invalidate_tcache_pag
 		: "r" (base),						\
 		  "i" (op));
 
-static inline void blast_dcache16(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.dcache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
-	unsigned long ws_end = current_cpu_data.dcache.ways <<
-	                       current_cpu_data.dcache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x200)
-			cache16_unroll32(addr|ws,Index_Writeback_Inv_D);
-}
-
-static inline void blast_dcache16_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-
-	do {
-		cache16_unroll32(start,Hit_Writeback_Inv_D);
-		start += 0x200;
-	} while (start < end);
-}
-
-static inline void blast_dcache16_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
-	unsigned long ws_end = current_cpu_data.dcache.ways <<
-	                       current_cpu_data.dcache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x200)
-			cache16_unroll32(addr|ws,Index_Writeback_Inv_D);
-}
-
-static inline void blast_icache16(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.icache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x200)
-			cache16_unroll32(addr|ws,Index_Invalidate_I);
-}
-
-static inline void blast_icache16_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-
-	do {
-		cache16_unroll32(start,Hit_Invalidate_I);
-		start += 0x200;
-	} while (start < end);
-}
-
-static inline void blast_icache16_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x200)
-			cache16_unroll32(addr|ws,Index_Invalidate_I);
-}
-
-static inline void blast_scache16(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.scache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x200)
-			cache16_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
-static inline void blast_scache16_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = page + PAGE_SIZE;
-
-	do {
-		cache16_unroll32(start,Hit_Writeback_Inv_SD);
-		start += 0x200;
-	} while (start < end);
-}
-
-static inline void blast_scache16_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x200)
-			cache16_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
 #define cache32_unroll32(base,op)					\
 	__asm__ __volatile__(						\
 	"	.set push					\n"	\
@@ -309,123 +192,6 @@ static inline void blast_scache16_page_i
 		: "r" (base),						\
 		  "i" (op));
 
-static inline void blast_dcache32(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.dcache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
-	unsigned long ws_end = current_cpu_data.dcache.ways <<
-	                       current_cpu_data.dcache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400)
-			cache32_unroll32(addr|ws,Index_Writeback_Inv_D);
-}
-
-static inline void blast_dcache32_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-
-	do {
-		cache32_unroll32(start,Hit_Writeback_Inv_D);
-		start += 0x400;
-	} while (start < end);
-}
-
-static inline void blast_dcache32_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
-	unsigned long ws_end = current_cpu_data.dcache.ways <<
-	                       current_cpu_data.dcache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400)
-			cache32_unroll32(addr|ws,Index_Writeback_Inv_D);
-}
-
-static inline void blast_icache32(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.icache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400)
-			cache32_unroll32(addr|ws,Index_Invalidate_I);
-}
-
-static inline void blast_icache32_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-
-	do {
-		cache32_unroll32(start,Hit_Invalidate_I);
-		start += 0x400;
-	} while (start < end);
-}
-
-static inline void blast_icache32_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400)
-			cache32_unroll32(addr|ws,Index_Invalidate_I);
-}
-
-static inline void blast_scache32(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.scache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400)
-			cache32_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
-static inline void blast_scache32_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = page + PAGE_SIZE;
-
-	do {
-		cache32_unroll32(start,Hit_Writeback_Inv_SD);
-		start += 0x400;
-	} while (start < end);
-}
-
-static inline void blast_scache32_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400)
-			cache32_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
 #define cache64_unroll32(base,op)					\
 	__asm__ __volatile__(						\
 	"	.set push					\n"	\
@@ -452,84 +218,6 @@ static inline void blast_scache32_page_i
 		: "r" (base),						\
 		  "i" (op));
 
-static inline void blast_icache64(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.icache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x800)
-			cache64_unroll32(addr|ws,Index_Invalidate_I);
-}
-
-static inline void blast_icache64_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-
-	do {
-		cache64_unroll32(start,Hit_Invalidate_I);
-		start += 0x800;
-	} while (start < end);
-}
-
-static inline void blast_icache64_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-	                       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x800)
-			cache64_unroll32(addr|ws,Index_Invalidate_I);
-}
-
-static inline void blast_scache64(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.scache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x800)
-			cache64_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
-static inline void blast_scache64_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = page + PAGE_SIZE;
-
-	do {
-		cache64_unroll32(start,Hit_Writeback_Inv_SD);
-		start += 0x800;
-	} while (start < end);
-}
-
-static inline void blast_scache64_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x800)
-			cache64_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
 #define cache128_unroll32(base,op)					\
 	__asm__ __volatile__(						\
 	"	.set push					\n"	\
@@ -556,43 +244,55 @@ static inline void blast_scache64_page_i
 		: "r" (base),						\
 		  "i" (op));
 
-static inline void blast_scache128(void)
-{
-	unsigned long start = INDEX_BASE;
-	unsigned long end = start + current_cpu_data.scache.waysize;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x1000)
-			cache128_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
-
-static inline void blast_scache128_page(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = page + PAGE_SIZE;
-
-	do {
-		cache128_unroll32(start,Hit_Writeback_Inv_SD);
-		start += 0x1000;
-	} while (start < end);
-}
-
-static inline void blast_scache128_page_indexed(unsigned long page)
-{
-	unsigned long start = page;
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
-	unsigned long ws_end = current_cpu_data.scache.ways <<
-	                       current_cpu_data.scache.waybit;
-	unsigned long ws, addr;
-
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x1000)
-			cache128_unroll32(addr|ws,Index_Writeback_Inv_SD);
-}
+/* build blast_xxx, blast_xxx_page, blast_xxx_page_indexed */
+#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize) \
+static inline void blast_##pfx##cache##lsize(void)			\
+{									\
+	unsigned long start = INDEX_BASE;				\
+	unsigned long end = start + current_cpu_data.desc.waysize;	\
+	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
+	unsigned long ws_end = current_cpu_data.desc.ways <<		\
+	                       current_cpu_data.desc.waybit;		\
+	unsigned long ws, addr;						\
+									\
+	for (ws = 0; ws < ws_end; ws += ws_inc)				\
+		for (addr = start; addr < end; addr += lsize * 32)	\
+			cache##lsize##_unroll32(addr|ws,indexop);	\
+}									\
+									\
+static inline void blast_##pfx##cache##lsize##_page(unsigned long page)	\
+{									\
+	unsigned long start = page;					\
+	unsigned long end = page + PAGE_SIZE;				\
+									\
+	do {								\
+		cache##lsize##_unroll32(start,hitop);			\
+		start += lsize * 32;					\
+	} while (start < end);						\
+}									\
+									\
+static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
+{									\
+	unsigned long start = page;					\
+	unsigned long end = start + PAGE_SIZE;				\
+	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
+	unsigned long ws_end = current_cpu_data.desc.ways <<		\
+	                       current_cpu_data.desc.waybit;		\
+	unsigned long ws, addr;						\
+									\
+	for (ws = 0; ws < ws_end; ws += ws_inc)				\
+		for (addr = start; addr < end; addr += lsize * 32)	\
+			cache##lsize##_unroll32(addr|ws,indexop);	\
+}
+
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 16)
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16)
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D, 32)
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32)
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
 
 #endif /* _ASM_R4KCACHE_H */

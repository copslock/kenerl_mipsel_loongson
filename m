Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:34:13 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44752 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825759AbaA0UZ1gW0A7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:25:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 41/58] MIPS: asm: r4kcache: Add EVA cache flushing functions
Date:   Mon, 27 Jan 2014 20:19:28 +0000
Message-ID: <1390853985-14246-42-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_25_24
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Add EVA cache flushing functions similar to non-EVA configurations.
Because the cache may or may not contain user virtual addresses, we
need to use the 'cache' or 'cachee' instruction based on whether we
flush the cache on behalf of kernel or user respectively.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/r4kcache.h | 154 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index ae026bf..b973e02 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -17,6 +17,7 @@
 #include <asm/cpu-features.h>
 #include <asm/cpu-type.h>
 #include <asm/mipsmtregs.h>
+#include <asm/uaccess.h> /* for segment_eq() */
 
 /*
  * This macro return a properly sign-extended address suitable as base address
@@ -374,6 +375,91 @@ static inline void invalidate_tcache_page(unsigned long addr)
 		: "r" (base),						\
 		  "i" (op));
 
+/*
+ * Perform the cache operation specified by op using a user mode virtual
+ * address while in kernel mode.
+ */
+#define cache16_unroll32_user(base,op)					\
+	__asm__ __volatile__(						\
+	"	.set push					\n"	\
+	"	.set noreorder					\n"	\
+	"	.set mips0					\n"	\
+	"	.set eva					\n"	\
+	"	cachee %1, 0x000(%0); cachee %1, 0x010(%0)	\n"	\
+	"	cachee %1, 0x020(%0); cachee %1, 0x030(%0)	\n"	\
+	"	cachee %1, 0x040(%0); cachee %1, 0x050(%0)	\n"	\
+	"	cachee %1, 0x060(%0); cachee %1, 0x070(%0)	\n"	\
+	"	cachee %1, 0x080(%0); cachee %1, 0x090(%0)	\n"	\
+	"	cachee %1, 0x0a0(%0); cachee %1, 0x0b0(%0)	\n"	\
+	"	cachee %1, 0x0c0(%0); cachee %1, 0x0d0(%0)	\n"	\
+	"	cachee %1, 0x0e0(%0); cachee %1, 0x0f0(%0)	\n"	\
+	"	cachee %1, 0x100(%0); cachee %1, 0x110(%0)	\n"	\
+	"	cachee %1, 0x120(%0); cachee %1, 0x130(%0)	\n"	\
+	"	cachee %1, 0x140(%0); cachee %1, 0x150(%0)	\n"	\
+	"	cachee %1, 0x160(%0); cachee %1, 0x170(%0)	\n"	\
+	"	cachee %1, 0x180(%0); cachee %1, 0x190(%0)	\n"	\
+	"	cachee %1, 0x1a0(%0); cachee %1, 0x1b0(%0)	\n"	\
+	"	cachee %1, 0x1c0(%0); cachee %1, 0x1d0(%0)	\n"	\
+	"	cachee %1, 0x1e0(%0); cachee %1, 0x1f0(%0)	\n"	\
+	"	.set pop					\n"	\
+		:							\
+		: "r" (base),						\
+		  "i" (op));
+
+#define cache32_unroll32_user(base, op)					\
+	__asm__ __volatile__(						\
+	"	.set push					\n"	\
+	"	.set noreorder					\n"	\
+	"	.set mips0					\n"	\
+	"	.set eva					\n"	\
+	"	cachee %1, 0x000(%0); cachee %1, 0x020(%0)	\n"	\
+	"	cachee %1, 0x040(%0); cachee %1, 0x060(%0)	\n"	\
+	"	cachee %1, 0x080(%0); cachee %1, 0x0a0(%0)	\n"	\
+	"	cachee %1, 0x0c0(%0); cachee %1, 0x0e0(%0)	\n"	\
+	"	cachee %1, 0x100(%0); cachee %1, 0x120(%0)	\n"	\
+	"	cachee %1, 0x140(%0); cachee %1, 0x160(%0)	\n"	\
+	"	cachee %1, 0x180(%0); cachee %1, 0x1a0(%0)	\n"	\
+	"	cachee %1, 0x1c0(%0); cachee %1, 0x1e0(%0)	\n"	\
+	"	cachee %1, 0x200(%0); cachee %1, 0x220(%0)	\n"	\
+	"	cachee %1, 0x240(%0); cachee %1, 0x260(%0)	\n"	\
+	"	cachee %1, 0x280(%0); cachee %1, 0x2a0(%0)	\n"	\
+	"	cachee %1, 0x2c0(%0); cachee %1, 0x2e0(%0)	\n"	\
+	"	cachee %1, 0x300(%0); cachee %1, 0x320(%0)	\n"	\
+	"	cachee %1, 0x340(%0); cachee %1, 0x360(%0)	\n"	\
+	"	cachee %1, 0x380(%0); cachee %1, 0x3a0(%0)	\n"	\
+	"	cachee %1, 0x3c0(%0); cachee %1, 0x3e0(%0)	\n"	\
+	"	.set pop					\n"	\
+		:							\
+		: "r" (base),						\
+		  "i" (op));
+
+#define cache64_unroll32_user(base, op)					\
+	__asm__ __volatile__(						\
+	"	.set push					\n"	\
+	"	.set noreorder					\n"	\
+	"	.set mips0					\n"	\
+	"	.set eva					\n"	\
+	"	cachee %1, 0x000(%0); cachee %1, 0x040(%0)	\n"	\
+	"	cachee %1, 0x080(%0); cachee %1, 0x0c0(%0)	\n"	\
+	"	cachee %1, 0x100(%0); cachee %1, 0x140(%0)	\n"	\
+	"	cachee %1, 0x180(%0); cachee %1, 0x1c0(%0)	\n"	\
+	"	cachee %1, 0x200(%0); cachee %1, 0x240(%0)	\n"	\
+	"	cachee %1, 0x280(%0); cachee %1, 0x2c0(%0)	\n"	\
+	"	cachee %1, 0x300(%0); cachee %1, 0x340(%0)	\n"	\
+	"	cachee %1, 0x380(%0); cachee %1, 0x3c0(%0)	\n"	\
+	"	cachee %1, 0x400(%0); cachee %1, 0x440(%0)	\n"	\
+	"	cachee %1, 0x480(%0); cachee %1, 0x4c0(%0)	\n"	\
+	"	cachee %1, 0x500(%0); cachee %1, 0x540(%0)	\n"	\
+	"	cachee %1, 0x580(%0); cachee %1, 0x5c0(%0)	\n"	\
+	"	cachee %1, 0x600(%0); cachee %1, 0x640(%0)	\n"	\
+	"	cachee %1, 0x680(%0); cachee %1, 0x6c0(%0)	\n"	\
+	"	cachee %1, 0x700(%0); cachee %1, 0x740(%0)	\n"	\
+	"	cachee %1, 0x780(%0); cachee %1, 0x7c0(%0)	\n"	\
+	"	.set pop					\n"	\
+		:							\
+		: "r" (base),						\
+		  "i" (op));
+
 /* build blast_xxx, blast_xxx_page, blast_xxx_page_indexed */
 #define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize) \
 static inline void blast_##pfx##cache##lsize(void)			\
@@ -446,9 +532,35 @@ __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 32
 __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 64)
 __BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_SD, 128)
 
+#define __BUILD_BLAST_USER_CACHE(pfx, desc, indexop, hitop, lsize) \
+static inline void blast_##pfx##cache##lsize##_user_page(unsigned long page) \
+{									\
+	unsigned long start = page;					\
+	unsigned long end = page + PAGE_SIZE;				\
+									\
+	__##pfx##flush_prologue						\
+									\
+	do {								\
+		cache##lsize##_unroll32_user(start, hitop);             \
+		start += lsize * 32;					\
+	} while (start < end);						\
+									\
+	__##pfx##flush_epilogue						\
+}
+
+__BUILD_BLAST_USER_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,
+			 16)
+__BUILD_BLAST_USER_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16)
+__BUILD_BLAST_USER_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,
+			 32)
+__BUILD_BLAST_USER_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32)
+__BUILD_BLAST_USER_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,
+			 64)
+__BUILD_BLAST_USER_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
+
 /* build blast_xxx_range, protected_blast_xxx_range */
 #define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot, extra)	\
-static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start, \
+static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,\
 						    unsigned long end)	\
 {									\
 	unsigned long lsize = cpu_##desc##_line_size();			\
@@ -467,9 +579,47 @@ static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,
 	__##pfx##flush_epilogue						\
 }
 
+#ifndef CONFIG_EVA
+
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, protected_, )
-__BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_, )
 __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_, )
+
+#else
+
+#define __BUILD_PROT_BLAST_CACHE_RANGE(pfx, desc, hitop)		\
+static inline void protected_blast_##pfx##cache##_range(unsigned long start,\
+							unsigned long end) \
+{									\
+	unsigned long lsize = cpu_##desc##_line_size();			\
+	unsigned long addr = start & ~(lsize - 1);			\
+	unsigned long aend = (end - 1) & ~(lsize - 1);			\
+									\
+	__##pfx##flush_prologue						\
+									\
+	if (segment_eq(get_fs(), USER_DS)) {				\
+		while (1) {						\
+			protected_cachee_op(hitop, addr);		\
+			if (addr == aend)				\
+				break;					\
+			addr += lsize;					\
+		}							\
+	} else {							\
+		while (1) {						\
+			protected_cache_op(hitop, addr);		\
+			if (addr == aend)				\
+				break;					\
+			addr += lsize;					\
+		}                                                       \
+									\
+	}								\
+	__##pfx##flush_epilogue						\
+}
+
+__BUILD_PROT_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D)
+__BUILD_PROT_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I)
+
+#endif
+__BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_, )
 __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson23, \
 	protected_, loongson23_)
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, , )
-- 
1.8.5.3

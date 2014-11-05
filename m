From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 5 Nov 2014 08:25:37 +0000
Subject: MIPS: r4kcache: Add EVA case for protected_writeback_dcache_line
Message-ID: <20141105082537.1vnG4QbR-N1SnwDchemSZvr6vgVHAG2vB8BVV5J5wlA@z>

commit 83fd43449baaf88fe5c03dd0081a062041837c51 upstream.

Commit de8974e3f76c0 ("MIPS: asm: r4kcache: Add EVA cache flushing
functions") added cache function for EVA using the cachee instruction.
However, it didn't add a case for the protected_writeback_dcache_line.
mips_dsemul() calls r4k_flush_cache_sigtramp() which in turn uses
the protected_writeback_dcache_line() to flush the trampoline code
back to memory. This used the wrong "cache" instruction leading to
random userland crashes on non-FPU cores.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8331/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/r4kcache.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 0b8bd28a0df1..ed038d7c3410 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -254,7 +254,11 @@ static inline void protected_flush_icache_line(unsigned long addr)
  */
 static inline void protected_writeback_dcache_line(unsigned long addr)
 {
+#ifdef CONFIG_EVA
+	protected_cachee_op(Hit_Writeback_Inv_D, addr);
+#else
 	protected_cache_op(Hit_Writeback_Inv_D, addr);
+#endif
 }

 static inline void protected_writeback_scache_line(unsigned long addr)

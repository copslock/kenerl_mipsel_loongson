From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 17 Nov 2014 09:30:23 +0000
Subject: MIPS: asm: uaccess: Add v1 register to clobber list on EVA
Message-ID: <20141117093023.LDiCI9fhQBz-TIw88zdvS3u4bMrxbOJ4h_ic_GFOFNY@z>

commit 58563817cfed0432e9a54476d5fc6c3aeba475e4 upstream.

When EVA is turned on and prefetching is being used in memcpy.S,
the v1 register is being used as a helper register to the PREFE
instruction. However, v1 ($3) was not in the clobber list, which
means that the compiler did not preserve it across function calls,
and that could corrupt the value of the register leading to all
sorts of userland crashes. We fix this problem by using the
DADDI_SCRATCH macro to define the clobbered register when
CONFIG_EVA && CONFIG_CPU_HAS_PREFETCH are enabled.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8510/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index a10951090234..b9ab717e3619 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -773,10 +773,11 @@ extern void __put_user_unaligned_unknown(void);
 	"jal\t" #destination "\n\t"
 #endif

-#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
-#define DADDI_SCRATCH "$0"
-#else
+#if defined(CONFIG_CPU_DADDI_WORKAROUNDS) || (defined(CONFIG_EVA) &&	\
+					      defined(CONFIG_CPU_HAS_PREFETCH))
 #define DADDI_SCRATCH "$3"
+#else
+#define DADDI_SCRATCH "$0"
 #endif

 extern size_t __copy_user(void *__to, const void *__from, size_t __n);
--
2.1.0

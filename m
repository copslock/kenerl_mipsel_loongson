From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 4 Jan 2016 20:29:04 +0000
Subject: MIPS: uaccess: Take EVA into account in [__]clear_user
Message-ID: <20160104202904.lCLNWp3qsNyi_xzuurYHUa2dgI7fGmoYqBXD7hqPr90@z>

commit d6a428fb583738ad685c91a684748cdee7b2a05f upstream.

__clear_user() (and clear_user() which uses it), always access the user
mode address space, which results in EVA store instructions when EVA is
enabled even if the current user address limit is KERNEL_DS.

Fix this by adding a new symbol __bzero_kernel for the normal kernel
address space bzero in EVA mode, and call that from __clear_user() if
eva_kernel_access().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10844/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[james.hogan@imgtec.com: backport]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 32 ++++++++++++++++++++++----------
 arch/mips/kernel/mips_ksyms.c   |  2 ++
 arch/mips/lib/memset.S          |  2 ++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 81d4d7e012ca..681331257bac 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1204,16 +1204,28 @@ __clear_user(void __user *addr, __kernel_size_t size)
 {
 	__kernel_size_t res;

-	might_fault();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, $0\n\t"
-		"move\t$6, %2\n\t"
-		__MODULE_JAL(__bzero)
-		"move\t%0, $6"
-		: "=r" (res)
-		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+	if (config_enabled(CONFIG_EVA) && segment_eq(get_fs(), get_ds())) {
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, $0\n\t"
+			"move\t$6, %2\n\t"
+			__MODULE_JAL(__bzero_kernel)
+			"move\t%0, $6"
+			: "=r" (res)
+			: "r" (addr), "r" (size)
+			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+	} else {
+		might_fault();
+		__asm__ __volatile__(
+			"move\t$4, %1\n\t"
+			"move\t$5, $0\n\t"
+			"move\t$6, %2\n\t"
+			__MODULE_JAL(__bzero)
+			"move\t%0, $6"
+			: "=r" (res)
+			: "r" (addr), "r" (size)
+			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+	}

 	return res;
 }
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 1b2452e2be67..c1e152a27b17 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -17,6 +17,7 @@
 #include <asm/fpu.h>
 #include <asm/msa.h>

+extern void *__bzero_kernel(void *__s, size_t __count);
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_kernel_nocheck_asm(char *__to,
 					      const char *__from, long __len);
@@ -66,6 +67,7 @@ EXPORT_SYMBOL(__copy_from_user_eva);
 EXPORT_SYMBOL(__copy_in_user_eva);
 EXPORT_SYMBOL(__copy_to_user_eva);
 EXPORT_SYMBOL(__copy_user_inatomic_eva);
+EXPORT_SYMBOL(__bzero_kernel);
 #endif
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm);
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 7b0e5462ca51..fd83406ceccc 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -238,6 +238,8 @@ LEAF(memset)
 1:
 #ifndef CONFIG_EVA
 FEXPORT(__bzero)
+#else
+FEXPORT(__bzero_kernel)
 #endif
 	__BUILD_BZERO LEGACY_MODE

From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 10 Feb 2015 10:03:00 +0000
Subject: MIPS: Export MSA functions used by lose_fpu(1) for KVM
Message-ID: <20150210100300.LcO0_OnNxZLStjMsmthPvpH5lFcTtpJzGMXJIWeYfHU@z>

commit ca5d25642e212f73492d332d95dc90ef46a0e8dc upstream.

Export the _save_msa asm function used by the lose_fpu(1) macro to GPL
modules so that KVM can make use of it when it is built as a module.

This fixes the following build error when CONFIG_KVM=m and
CONFIG_CPU_HAS_MSA=y due to commit f798217dfd03 ("KVM: MIPS: Don't leak
FPU/DSP to guest"):

ERROR: "_save_msa" [arch/mips/kvm/kvm.ko] undefined!

Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9261/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/mips_ksyms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index e69bdd3b4b74..1b2452e2be67 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -15,6 +15,7 @@
 #include <asm/uaccess.h>
 #include <asm/ftrace.h>
 #include <asm/fpu.h>
+#include <asm/msa.h>

 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_kernel_nocheck_asm(char *__to,
@@ -38,6 +39,9 @@ extern long __strnlen_user_asm(const char *s);
  * Core architecture code
  */
 EXPORT_SYMBOL_GPL(_save_fp);
+#ifdef CONFIG_CPU_HAS_MSA
+EXPORT_SYMBOL_GPL(_save_msa);
+#endif

 /*
  * String functions

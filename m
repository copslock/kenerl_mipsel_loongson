From: "Maciej W. Rozycki" <macro@imgtec.com>
Date: Tue, 17 May 2016 06:12:27 +0100
Subject: MIPS: MSA: Fix a link error on `_init_msa_upper' with older GCC
Message-ID: <20160517051227.7UEGqkGjCmvWhsEZsyXDxPNz95ZXuPjmNfvu93nqNug@z>

commit e49d38488515057dba8f0c2ba4cfde5be4a7281f upstream.

Fix a build regression from commit c9017757c532 ("MIPS: init upper 64b
of vector registers when MSA is first used"):

arch/mips/built-in.o: In function `enable_restore_fp_context':
traps.c:(.text+0xbb90): undefined reference to `_init_msa_upper'
traps.c:(.text+0xbb90): relocation truncated to fit: R_MIPS_26 against `_init_msa_upper'
traps.c:(.text+0xbef0): undefined reference to `_init_msa_upper'
traps.c:(.text+0xbef0): relocation truncated to fit: R_MIPS_26 against `_init_msa_upper'

to !CONFIG_CPU_HAS_MSA configurations with older GCC versions, which are
unable to figure out that calls to `_init_msa_upper' are indeed dead.
Of the many ways to tackle this failure choose the approach we have
already taken in `thread_msa_context_live'.

[ralf@linux-mips.org: Drop patch segment to junk file.]

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13271/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/msa.h | 13 +++++++++++++
 arch/mips/kernel/traps.c    |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index af5638b..38bbeda 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -67,6 +67,19 @@ static inline void restore_msa(struct task_struct *t)
 		_restore_msa(t);
 }

+static inline void init_msa_upper(void)
+{
+	/*
+	 * Check cpu_has_msa only if it's a constant. This will allow the
+	 * compiler to optimise out code for CPUs without MSA without adding
+	 * an extra redundant check for CPUs with MSA.
+	 */
+	if (__builtin_constant_p(cpu_has_msa) && !cpu_has_msa)
+		return;
+
+	_init_msa_upper();
+}
+
 #ifdef TOOLCHAIN_SUPPORTS_MSA

 #define __BUILD_MSA_CTL_REG(name, cs)				\
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 86454f5..4f1d297 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1229,7 +1229,7 @@ static int enable_restore_fp_context(int msa)
 		err = init_fpu();
 		if (msa && !err) {
 			enable_msa();
-			_init_msa_upper();
+			init_msa_upper();
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
@@ -1292,7 +1292,7 @@ static int enable_restore_fp_context(int msa)
 	 */
 	prior_msa = test_and_set_thread_flag(TIF_MSA_CTX_LIVE);
 	if (!prior_msa && was_fpu_owner) {
-		_init_msa_upper();
+		init_msa_upper();

 		goto out;
 	}
@@ -1309,7 +1309,7 @@ static int enable_restore_fp_context(int msa)
 		 * of each vector register such that it cannot see data left
 		 * behind by another task.
 		 */
-		_init_msa_upper();
+		init_msa_upper();
 	} else {
 		/* We need to restore the vector context. */
 		restore_msa(current);
--
2.7.4

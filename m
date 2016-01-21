From: Huacai Chen <chenhc@lemote.com>
Date: Thu, 21 Jan 2016 21:09:52 +0800
Subject: MIPS: Fix some missing CONFIG_CPU_MIPSR6 #ifdefs
Message-ID: <20160121130952.q2DwodbBYvvp6Teo9zVTLT5ELCBFgBw4dOGg16qXMQ8@z>

commit 4f33f6c522948fffc345261896042b58dea23754 upstream.

Commit be0c37c985eddc4 (MIPS: Rearrange PTE bits into fixed positions.)
defines fixed PTE bits for MIPS R2. Then, commit d7b631419b3d230a4d383
(MIPS: pgtable-bits: Fix XPA damage to R6 definitions.) adds the MIPS
R6 definitions in the same way as MIPS R2. But some R6 #ifdefs in the
later commit are missing, so in this patch I fix that.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12164/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/pgtable.h | 4 ++--
 arch/mips/mm/tlbex.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index ae85694..6bc427f 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -353,7 +353,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pte_val(pte) & _PAGE_NO_READ))
 		pte_val(pte) |= _PAGE_SILENT_READ;
 	else
@@ -558,7 +558,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_ACCESSED;

-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pmd_val(pmd) & _PAGE_NO_READ))
 		pmd_val(pmd) |= _PAGE_SILENT_READ;
 	else
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 323d1d3..99e3bd3 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -242,7 +242,7 @@ static void output_pgtable_bits_defines(void)
 	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
 	pr_define("_PAGE_SPLITTING_SHIFT %d\n", _PAGE_SPLITTING_SHIFT);
 #endif
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_rixi) {
 #ifdef _PAGE_NO_EXEC_SHIFT
 		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
--
1.9.1

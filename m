From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date: Fri, 12 Oct 2018 17:24:10 +0100
Subject: [PATCH] Incremental fixes to the mmremap patch
Message-ID: <20181012162410.Ry4iRgwkf4jvRPZs-V05ws70sswqvDzk_C0f4bDC-q4@z>

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/pgalloc.h | 4 ++--
 arch/um/include/asm/pgtable.h | 3 +++
 arch/um/kernel/tlb.c          | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index bf90b2aa2002..99eb5682792a 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,8 +25,8 @@
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
-extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
+extern pgtable_t pte_alloc_one(struct mm_struct *);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 7485398d0737..1692da55e63a 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -359,4 +359,7 @@ do {						\
 	__flush_tlb_one((vaddr));		\
 } while (0)
 
+extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd);
+
 #endif
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 763d35bdda01..d17b74184ba0 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -647,3 +647,9 @@ void force_flush_all(void)
 		vma = vma->vm_next;
 	}
 }
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd)
+{
+	*pmdp = pmd;
+}
+
-- 
2.11.0


--------------A6D223F721C42CB9BAB1286E--

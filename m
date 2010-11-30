From: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Date: Tue, 30 Nov 2010 11:34:31 -0800
Subject: [PATCH] MIPS: Add local_flush_tlb_all_mm to clear all mm
contexts on calling cpu
Message-ID: <20101130193431.ZXdG6_Vel3NmfhC3Oy7pUiASZDhiqt8TGGxN5z4lw_4@z>

When hotplug removing a cpu, all mm context TLB entries must be cleared
to avoid ASID conflict when cpu is restarted.
New functions local_flush_tlb_all_mm() and all-cpu version
flush_tlb_all_mm() are added.
To function properly, local_flush_tlb_all_mm() must be called when
mm_cpumask for all
mm context on given cpu is cleared.

Signed-off-by: Maksim Rayskiy <maksim.rayskiy@gmail.com>
---
 arch/mips/include/asm/tlbflush.h |    4 ++++
 arch/mips/kernel/smp.c           |   10 ++++++++++
 arch/mips/mm/tlb-r4k.c           |   12 ++++++++++++
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/tlbflush.h b/arch/mips/include/asm/tlbflush.h
index 86b21de..d7b75e6 100644
--- a/arch/mips/include/asm/tlbflush.h
+++ b/arch/mips/include/asm/tlbflush.h
@@ -8,12 +8,14 @@
  *
  *  - flush_tlb_all() flushes all processes TLB entries
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
+ *  - flush_tlb_all_mm() flushes all mm context TLB entries
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
+extern void local_flush_tlb_all_mm(void);
 extern void local_flush_tlb_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void local_flush_tlb_kernel_range(unsigned long start,
@@ -26,6 +28,7 @@ extern void local_flush_tlb_one(unsigned long vaddr);

 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *);
+extern void flush_tlb_all_mm(void);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long,
 	unsigned long);
 extern void flush_tlb_kernel_range(unsigned long, unsigned long);
@@ -36,6 +39,7 @@ extern void flush_tlb_one(unsigned long vaddr);

 #define flush_tlb_all()			local_flush_tlb_all()
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
+#define flush_tlb_all_mm()		local_flush_tlb_all_mm()
 #define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma,
vmaddr, end)
 #define flush_tlb_kernel_range(vmaddr,end) \
 	local_flush_tlb_kernel_range(vmaddr, end)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 383aeb9..535231f 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -242,6 +242,16 @@ void flush_tlb_all(void)
 	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
 }

+static void flush_tlb_all_mm_ipi(void *info)
+{
+	local_flush_tlb_all_mm();
+}
+
+void flush_tlb_all_mm(void)
+{
+	on_each_cpu(flush_tlb_all_mm_ipi, NULL, 1);
+}
+
 static void flush_tlb_mm_ipi(void *mm)
 {
 	local_flush_tlb_mm((struct mm_struct *)mm);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c618eed..5c03218 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -66,6 +66,18 @@ extern void build_tlb_refill_handler(void);

 #endif

+/* This function will clear all mm contexts on calling cpu
+ * To produce desired effect it must be called
+ * when mm_cpumask for all mm contexts is cleared
+ */
+void local_flush_tlb_all_mm(void)
+{
+	struct task_struct *p;
+	for_each_process(p)
+		if (p->mm)
+			local_flush_tlb_mm(p->mm);
+}
+
 void local_flush_tlb_all(void)
 {
 	unsigned long flags;
-- 
1.7.0.4

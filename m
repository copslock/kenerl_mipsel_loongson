Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:33:36 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41207 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904165Ab1KEVd1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:27 +0100
Received: (qmail 28051 invoked from network); 5 Nov 2011 17:28:27 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:27 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:27 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maksim Rayskiy <maksim.rayskiy@gmail.com>,
 Kevin D. Kissell <kevink@paralogos.com>, Sergey Shtylyov
 <sshtylyov@mvista.com>
Subject: [PATCH RESEND 1/9] MIPS: Add local_flush_tlb_all_mm to clear all mm
 contexts on calling cpu
Date:   Sat, 05 Nov 2011 14:21:10 -0700
Message-Id: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4398

From: Maksim Rayskiy <maksim.rayskiy@gmail.com>

When hotplug removing a cpu, all mm context TLB entries must be cleared
to avoid ASID conflict when cpu is restarted.  New functions
local_flush_tlb_all_mm() and all-cpu version flush_tlb_all_mm() are
added.  To function properly, local_flush_tlb_all_mm() must be called
when mm_cpumask for all mm context on given cpu is cleared.

Signed-off-by: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Tested-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/tlbflush.h |    4 ++++
 arch/mips/kernel/smp.c           |   10 ++++++++++
 arch/mips/mm/tlb-r4k.c           |   13 +++++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

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
 #define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma, vmaddr, end)
 #define flush_tlb_kernel_range(vmaddr,end) \
 	local_flush_tlb_kernel_range(vmaddr, end)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 32c1e95..78ca04c 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -269,6 +269,16 @@ void flush_tlb_all(void)
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
index 0d394e0..908fbe9 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -66,6 +66,19 @@ extern void build_tlb_refill_handler(void);
 
 #endif
 
+/* This function will clear all mm contexts on calling cpu
+ * To produce desired effect it must be called
+ * when mm_cpumask for all mm contexts is cleared
+ */
+void local_flush_tlb_all_mm(void)
+{
+	struct task_struct *p;
+
+	for_each_process(p)
+		if (p->mm)
+			local_flush_tlb_mm(p->mm);
+}
+
 void local_flush_tlb_all(void)
 {
 	unsigned long flags;
-- 
1.7.6.3

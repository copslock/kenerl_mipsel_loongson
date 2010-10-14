Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 20:32:51 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11393 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0JNScr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 20:32:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb74cef0000>; Thu, 14 Oct 2010 11:33:19 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 11:32:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 11:32:58 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9EIWdLR010443;
        Thu, 14 Oct 2010 11:32:39 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9EIWadq010441;
        Thu, 14 Oct 2010 11:32:36 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v3] MIPS: Make TASK_SIZE reflect proper size for both 32 and 64 bit processes.
Date:   Thu, 14 Oct 2010 11:32:33 -0700
Message-Id: <1287081153-10409-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 14 Oct 2010 18:32:59.0004 (UTC) FILETIME=[39F5DBC0:01CB6BCE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The TASK_SIZE macro should reflect the size of a user process virtual
address space.  Previously for 64-bit kernels, this was not the case.
The immediate cause of pain was in
hugetlbfs/inode.c:hugetlb_get_unmapped_area() where 32-bit processes
trying to mmap a huge page would be served a page with an address
outside of the 32-bit address range.  But there are other uses of
TASK_SIZE in the kernel as well that would like an accurate value.

The new definition is nice because it now makes TASK_SIZE and
TASK_SIZE_OF() yield the same value for any given process.

For 32-bit kernels there should be no change, although I did factor
out some code in asm/processor.h that became identical for the 32-bit and
64-bit cases.

__UA_LIMIT is now set to ~((1 << SEGBITS) - 1) for 64-bit kernels.
This should eliminate the possibility of getting a
AddressErrorException in the kernel for addresses that pass the
access_ok() test.

With the patch applied, I can still run o32, n32 and n64 processes,
and have an o32 shell fork/exec both n32 and n64 processes.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
The third time should be the charm here.  Only change from the first
two is __UA_LIMIT.

 arch/mips/include/asm/pgtable-64.h |    4 +-
 arch/mips/include/asm/processor.h  |   40 +++++++++++++++++------------------
 arch/mips/include/asm/uaccess.h    |    4 ++-
 arch/mips/kernel/cpu-probe.c       |   13 +++++++++++
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 1be4b0f..82d881a 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -113,10 +113,10 @@
 #endif
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
-#if PGDIR_SIZE >= TASK_SIZE
+#if PGDIR_SIZE >= TASK_SIZE64
 #define USER_PTRS_PER_PGD       (1)
 #else
-#define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define USER_PTRS_PER_PGD	(TASK_SIZE64 / PGDIR_SIZE)
 #endif
 #define FIRST_USER_ADDRESS	0UL
 
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 0d629bb..ead6928 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -50,13 +50,10 @@ extern unsigned int vced_count, vcei_count;
  * so don't change it unless you know what you are doing.
  */
 #define TASK_SIZE	0x7fff8000UL
-#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - SPECIAL_PAGES_SIZE)
 
-/*
- * This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	((TASK_SIZE / 3) & ~(PAGE_SIZE))
+#ifdef __KERNEL__
+#define STACK_TOP_MAX	TASK_SIZE
+#endif
 
 #define TASK_IS_32BIT_ADDR 1
 
@@ -71,28 +68,29 @@ extern unsigned int vced_count, vcei_count;
  * 8192EB ...
  */
 #define TASK_SIZE32	0x7fff8000UL
-#define TASK_SIZE	0x10000000000UL
-#define STACK_TOP	\
-	(((test_thread_flag(TIF_32BIT_ADDR) ?				\
-	   TASK_SIZE32 : TASK_SIZE) & PAGE_MASK) - SPECIAL_PAGES_SIZE)
+#define TASK_SIZE64	0x10000000000UL
+#define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
+
+#ifdef __KERNEL__
+#define STACK_TOP_MAX	TASK_SIZE64
+#endif
+
 
-/*
- * This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE						\
-	(test_thread_flag(TIF_32BIT_ADDR) ?				\
-		PAGE_ALIGN(TASK_SIZE32 / 3) : PAGE_ALIGN(TASK_SIZE / 3))
 #define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE)
+	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 
 #define TASK_IS_32BIT_ADDR test_thread_flag(TIF_32BIT_ADDR)
 
 #endif
 
-#ifdef __KERNEL__
-#define STACK_TOP_MAX	TASK_SIZE
-#endif
+#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - SPECIAL_PAGES_SIZE)
+
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE PAGE_ALIGN(TASK_SIZE / 3)
+
 
 #define NUM_FPU_REGS	32
 
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index c2d53c1..653a412 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -35,7 +35,9 @@
 
 #ifdef CONFIG_64BIT
 
-#define __UA_LIMIT	(- TASK_SIZE)
+extern u64 __ua_limit;
+
+#define __UA_LIMIT	__ua_limit
 
 #define __UA_ADDR	".dword"
 #define __UA_LA		"dla"
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b9378cd..70f0aa2 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -25,6 +25,8 @@
 #include <asm/system.h>
 #include <asm/watch.h>
 #include <asm/spram.h>
+#include <asm/uaccess.h>
+
 /*
  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
  * the implementation of the "wait" feature differs between CPU families. This
@@ -983,6 +985,12 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+#ifdef CONFIG_64BIT
+/* For use by uaccess.h */
+u64 __ua_limit;
+EXPORT_SYMBOL(__ua_limit);
+#endif
+
 const char *__cpu_name[NR_CPUS];
 const char *__elf_platform;
 
@@ -1060,6 +1068,11 @@ __cpuinit void cpu_probe(void)
 		c->srsets = 1;
 
 	cpu_probe_vmbits(c);
+
+#ifdef CONFIG_64BIT
+	if (cpu == 0)
+		__ua_limit = ~((1ull << cpu_vmbits) - 1);
+#endif
 }
 
 __cpuinit void cpu_report(void)
-- 
1.7.2.3

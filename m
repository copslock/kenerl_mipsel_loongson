Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2010 23:02:16 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10085 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab0JLVCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Oct 2010 23:02:12 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb4ccf30001>; Tue, 12 Oct 2010 14:02:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 12 Oct 2010 14:02:21 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 12 Oct 2010 14:02:21 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9CL21Om015882;
        Tue, 12 Oct 2010 14:02:01 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9CL1vmm015881;
        Tue, 12 Oct 2010 14:01:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Make TASK_SIZE reflect proper size for both 32 and 64 bit processes.
Date:   Tue, 12 Oct 2010 14:01:56 -0700
Message-Id: <1286917316-15849-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 12 Oct 2010 21:02:21.0948 (UTC) FILETIME=[C37713C0:01CB6A50]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28050
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

Another, perhaps non-obvious, change is that in 64-bit kernels, the
get_fs() value (A.K.A current_thread_info()->addr_limit) will now vary
depending on the address space size of the process.  This is a change,
as previously even 32-bit processes would have an addr_limit
appropriate for a 64-bit process.  This will change the behavior of
access_ok(), but I think the new behavior is desirable.

Before the patch it may have been possible for a user space process to
pass a pointer to the kernel that would pass the access_ok() check,
but be outside of the 32-bit address space.

With the patch applied, I can still run o32, n32 and n64 processes,
and have an o32 shell fork/exec both n32 and n64 processes.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/elf.h        |    1 +
 arch/mips/include/asm/pgtable-64.h |    4 +-
 arch/mips/include/asm/processor.h  |   40 +++++++++++++++++------------------
 arch/mips/include/asm/uaccess.h    |    3 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index fd1d39e..ca8cb9f 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -306,6 +306,7 @@ do {									\
 									\
 	if (current->personality != PER_LINUX32)			\
 		set_personality(PER_LINUX);				\
+	set_fs(USER_DS); /* Update addr_limit for TIF_32BIT_ADDR. */	\
 } while (0)
 
 #endif /* CONFIG_64BIT */
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
index c2d53c1..8f7b5fd 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -35,7 +35,8 @@
 
 #ifdef CONFIG_64BIT
 
-#define __UA_LIMIT	(- TASK_SIZE)
+#define __UA_LIMIT	\
+	(test_thread_flag(TIF_32BIT_ADDR) ? 0xffffffff80000000ul : -TASK_SIZE64)
 
 #define __UA_ADDR	".dword"
 #define __UA_LA		"dla"
-- 
1.7.2.3

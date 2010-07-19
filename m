Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 22:16:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7337 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492302Ab0GSUPW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jul 2010 22:15:22 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c44b2730000>; Mon, 19 Jul 2010 13:15:47 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 19 Jul 2010 13:15:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 19 Jul 2010 13:15:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6JKFBkN011099;
        Mon, 19 Jul 2010 13:15:11 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6JKFAo0011098;
        Mon, 19 Jul 2010 13:15:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Randomize mmap if randomize_va_space is set
Date:   Mon, 19 Jul 2010 13:14:56 -0700
Message-Id: <1279570497-11060-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279570497-11060-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279570497-11060-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 Jul 2010 20:15:20.0059 (UTC) FILETIME=[1C603CB0:01CB277F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Fairly straight forward: For 32-bit address spaces randomize within a
16MB space, for 64-bit within a 256MB space.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/processor.h |   11 +++++++++++
 arch/mips/kernel/syscall.c        |   21 ++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 5d33b72..24d91f8 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -34,6 +34,11 @@ extern void (*cpu_wait)(void);
 extern unsigned int vced_count, vcei_count;
 
 /*
+ * MIPS does have an arch_pick_mmap_layout()
+ */
+#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
+
+/*
  * A special page (the vdso) is mapped into all processes at the very
  * top of the virtual memory space.
  */
@@ -52,6 +57,9 @@ extern unsigned int vced_count, vcei_count;
  * space during mmap's.
  */
 #define TASK_UNMAPPED_BASE	((TASK_SIZE / 3) & ~(PAGE_SIZE))
+
+#define TASK_IS_32BIT_ADDR 1
+
 #endif
 
 #ifdef CONFIG_64BIT
@@ -77,6 +85,9 @@ extern unsigned int vced_count, vcei_count;
 		PAGE_ALIGN(TASK_SIZE32 / 3) : PAGE_ALIGN(TASK_SIZE / 3))
 #define TASK_SIZE_OF(tsk)						\
 	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE)
+
+#define TASK_IS_32BIT_ADDR test_thread_flag(TIF_32BIT_ADDR)
+
 #endif
 
 #ifdef __KERNEL__
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index dd81b0f..9824a82 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -29,6 +29,7 @@
 #include <linux/ipc.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/random.h>
 
 #include <asm/asm.h>
 #include <asm/branch.h>
@@ -116,7 +117,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
 	}
-	addr = TASK_UNMAPPED_BASE;
+	addr = current->mm->mmap_base;
 	if (do_color_align)
 		addr = COLOUR_ALIGN(addr, pgoff);
 	else
@@ -134,6 +135,24 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	}
 }
 
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	unsigned long random_factor = 0UL;
+
+	if (current->flags & PF_RANDOMIZE) {
+		random_factor = get_random_int();
+		random_factor = random_factor << PAGE_SHIFT;
+		if (TASK_IS_32BIT_ADDR)
+			random_factor &= 0xfffffful;
+		else
+			random_factor &= 0xffffffful;
+	}
+
+	mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
+	mm->get_unmapped_area = arch_get_unmapped_area;
+	mm->unmap_area = arch_unmap_area;
+}
+
 SYSCALL_DEFINE6(mips_mmap, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags, unsigned long,
 	fd, off_t, offset)
-- 
1.7.1.1

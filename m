Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 22:15:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7336 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492279Ab0GSUPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jul 2010 22:15:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c44b2720000>; Mon, 19 Jul 2010 13:15:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 19 Jul 2010 13:15:19 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 19 Jul 2010 13:15:19 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6JKFDaj011103;
        Mon, 19 Jul 2010 13:15:13 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6JKFCvW011102;
        Mon, 19 Jul 2010 13:15:12 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Enable heap randomization.
Date:   Mon, 19 Jul 2010 13:14:57 -0700
Message-Id: <1279570497-11060-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279570497-11060-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279570497-11060-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 Jul 2010 20:15:19.0387 (UTC) FILETIME=[1BF9B2B0:01CB277F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Based somewhat on the PPC implementation.

32-bit processes have the heap randomized in an 8MB space, 256MB for
64-bit processes.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/elf.h |    5 +++++
 arch/mips/kernel/syscall.c  |   28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index ea77a42..fd1d39e 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -372,4 +372,9 @@ extern const char *__elf_platform;
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
+
+struct mm_struct;
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+#define arch_randomize_brk arch_randomize_brk
+
 #endif /* _ASM_ELF_H */
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 9824a82..58bab2e 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/elf.h>
 
 #include <asm/asm.h>
 #include <asm/branch.h>
@@ -153,6 +154,33 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	mm->unmap_area = arch_unmap_area;
 }
 
+static inline unsigned long brk_rnd(void)
+{
+	unsigned long rnd = get_random_int();
+
+	rnd = rnd << PAGE_SHIFT;
+	/* 8MB for 32bit, 256MB for 64bit */
+	if (TASK_IS_32BIT_ADDR)
+		rnd = rnd & 0x7ffffful;
+	else
+		rnd = rnd & 0xffffffful;
+
+	return rnd;
+}
+
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+	unsigned long base = mm->brk;
+	unsigned long ret;
+
+	ret = PAGE_ALIGN(base + brk_rnd());
+
+	if (ret < mm->brk)
+		return mm->brk;
+
+	return ret;
+}
+
 SYSCALL_DEFINE6(mips_mmap, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags, unsigned long,
 	fd, off_t, offset)
-- 
1.7.1.1

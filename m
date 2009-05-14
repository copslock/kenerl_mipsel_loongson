Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 04:14:46 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:53389 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021368AbZENDOk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 May 2009 04:14:40 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n4E3EUsx018316;
	Wed, 13 May 2009 20:14:32 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 May 2009 20:14:30 -0700
Received: from localhost.localdomain ([128.224.158.160]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 May 2009 20:14:30 -0700
From:	Yong Zhang <yong.zhang@windriver.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] MIPS: o32 application running on 64bit kernel core dump
Date:	Thu, 14 May 2009 11:15:19 +0800
Message-Id: <16bd35f2910f585740f4764fa1e80bf31c80d576.1242178813.git.yong.zhang@windriver.com>
X-Mailer: git-send-email 1.5.6.5
X-OriginalArrivalTime: 14 May 2009 03:14:30.0577 (UTC) FILETIME=[18CCBA10:01C9D442]
Return-Path: <yong.zhang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
Precedence: bulk
X-list: linux-mips

If an o32 application crashes and generates a core dump on
a 64 bit kernel, the core file will not be correctly
recognized. This is because ELF_CORE_COPY_REGS and
ELF_CORE_COPY_TASK_REGS are not correctly defined for o32
and will use the default register set which would
be CONFIG_64BIT in asm/elf.h.

So we'll switch to use the right register defines in
this situation by checking for WANT_COMPAT_REG_H and
use the right defines of ELF_CORE_COPY_REGS and
ELF_CORE_COPY_TASK_REGS.

Signed-off-by: Yong Zhang <yong.zhang@windriver.com>
---
 arch/mips/include/asm/elf.h      |    4 ++++
 arch/mips/include/asm/reg.h      |    2 +-
 arch/mips/kernel/binfmt_elfo32.c |   20 +++++++++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index d58f128..7990694 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -316,9 +316,13 @@ extern void elf_dump_regs(elf_greg_t *, struct pt_regs *regs);
 extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
 
+#ifndef ELF_CORE_COPY_REGS
 #define ELF_CORE_COPY_REGS(elf_regs, regs)			\
 	elf_dump_regs((elf_greg_t *)&(elf_regs), regs);
+#endif
+#ifndef ELF_CORE_COPY_TASK_REGS
 #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
+#endif
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs)			\
 	dump_task_fpu(tsk, elf_fpregs)
 
diff --git a/arch/mips/include/asm/reg.h b/arch/mips/include/asm/reg.h
index 634b55d..910e71a 100644
--- a/arch/mips/include/asm/reg.h
+++ b/arch/mips/include/asm/reg.h
@@ -69,7 +69,7 @@
 
 #endif
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && !defined(WANT_COMPAT_REG_H)
 
 #define EF_R0			 0
 #define EF_R1			 1
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index e1333d7..53bc6b4 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -53,6 +53,23 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 #define ELF_ET_DYN_BASE         (TASK32_SIZE / 3 * 2)
 
 #include <asm/processor.h>
+
+/*
+ * When this file is selected, we are definitely running a 64bit kernel.
+ * So using the right regs define in asm/reg.h
+ */
+#define WANT_COMPAT_REG_H
+
+/* These MUST be defined before elf.h gets included */
+extern void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs);
+#define ELF_CORE_COPY_REGS(_dest, _regs) elf32_core_copy_regs(_dest, _regs);
+#define ELF_CORE_COPY_TASK_REGS(_tsk, _dest)				\
+({									\
+	int __res = 1;							\
+	elf32_core_copy_regs((*_dest), (task_pt_regs(_tsk)));		\
+	__res;								\
+})
+
 #include <linux/module.h>
 #include <linux/elfcore.h>
 #include <linux/compat.h>
@@ -110,9 +127,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 	value->tv_usec = rem / NSEC_PER_USEC;
 }
 
-#undef ELF_CORE_COPY_REGS
-#define ELF_CORE_COPY_REGS(_dest, _regs) elf32_core_copy_regs(_dest, _regs);
-
 void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
 {
 	int i;
-- 
1.5.6.5

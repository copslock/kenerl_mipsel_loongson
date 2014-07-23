Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:46:36 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:59780 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842530AbaGWNnk6NtIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:40 +0200
Received: by mail-wg0-f46.google.com with SMTP id m15so1197676wgh.17
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j/C4o6IMJSG8MsIFLCcLBl13bZWorv711cglvcFHfeY=;
        b=mPXEkw/koinmtwyzVEYeE2GgQVbnZxliacdSb3e+Knsn77N2D1whNIDzQh+Lsota/b
         ylh8rSKv5mlfa3s7tdaVmS568AoIFa2nUruBHJ3mX3EhhP1X8T4MoSKP6WEUlt+KONU4
         mxg3fxq3hxK1nMVfZDTlN0cm94o0lO1srzEjOcAY/grNQdHdCDzRDidouKqlAFze3T1I
         +EgnE8/W87BdFhZOJMCxU3NBDVhNDkjTwWNhe7JaikCEKehXbpXAG7rfQr3Qc6S2IToY
         ZKg3kH/PSo40MFMl30Gz4jaMhpsuejCxzC19CAF9WsWvPlG1aHhQUwhqz6D4pyBBQ3U+
         9dFg==
X-Gm-Message-State: ALoCoQkvbOnnYt+RMC+K2IhFlp/HsMUUazTS3EymaEVCM3zYZWtu0l6W1EQTLvrJ2JcS0HW/dtX2
X-Received: by 10.180.98.130 with SMTP id ei2mr24879453wib.24.1406123013595;
        Wed, 23 Jul 2014 06:43:33 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:33 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>
Subject: [PATCH 09/11] MIPS: Remove old core dump functions
Date:   Wed, 23 Jul 2014 14:40:14 +0100
Message-Id: <1406122816-2424-10-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Since the core dumper now uses regsets, the old core dump functions are
now unused. Remove them.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
---
 arch/mips/include/asm/elf.h      | 17 -------------
 arch/mips/kernel/binfmt_elfo32.c | 32 -----------------------
 arch/mips/kernel/process.c       | 55 ----------------------------------------
 3 files changed, 104 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index d414405..1d38fe0 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -339,23 +339,6 @@ do {									\
 
 #endif /* CONFIG_64BIT */
 
-struct pt_regs;
-struct task_struct;
-
-extern void elf_dump_regs(elf_greg_t *, struct pt_regs *regs);
-extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
-extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
-
-#ifndef ELF_CORE_COPY_REGS
-#define ELF_CORE_COPY_REGS(elf_regs, regs)			\
-	elf_dump_regs((elf_greg_t *)&(elf_regs), regs);
-#endif
-#ifndef ELF_CORE_COPY_TASK_REGS
-#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
-#endif
-#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs)			\
-	dump_task_fpu(tsk, elf_fpregs)
-
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index 71df942..9287678 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -72,16 +72,6 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
 #include <asm/processor.h>
 
-/* These MUST be defined before elf.h gets included */
-extern void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs);
-#define ELF_CORE_COPY_REGS(_dest, _regs) elf32_core_copy_regs(_dest, _regs);
-#define ELF_CORE_COPY_TASK_REGS(_tsk, _dest)				\
-({									\
-	int __res = 1;							\
-	elf32_core_copy_regs(*(_dest), task_pt_regs(_tsk));		\
-	__res;								\
-})
-
 #include <linux/module.h>
 #include <linux/elfcore.h>
 #include <linux/compat.h>
@@ -139,28 +129,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 	value->tv_usec = rem / NSEC_PER_USEC;
 }
 
-void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
-{
-	int i;
-
-	for (i = 0; i < MIPS32_EF_R0; i++)
-		grp[i] = 0;
-	grp[MIPS32_EF_R0] = 0;
-	for (i = 1; i <= 31; i++)
-		grp[MIPS32_EF_R0 + i] = (elf_greg_t) regs->regs[i];
-	grp[MIPS32_EF_R26] = 0;
-	grp[MIPS32_EF_R27] = 0;
-	grp[MIPS32_EF_LO] = (elf_greg_t) regs->lo;
-	grp[MIPS32_EF_HI] = (elf_greg_t) regs->hi;
-	grp[MIPS32_EF_CP0_EPC] = (elf_greg_t) regs->cp0_epc;
-	grp[MIPS32_EF_CP0_BADVADDR] = (elf_greg_t) regs->cp0_badvaddr;
-	grp[MIPS32_EF_CP0_STATUS] = (elf_greg_t) regs->cp0_status;
-	grp[MIPS32_EF_CP0_CAUSE] = (elf_greg_t) regs->cp0_cause;
-#ifdef MIPS32_EF_UNUSED0
-	grp[MIPS32_EF_UNUSED0] = 0;
-#endif
-}
-
 MODULE_DESCRIPTION("Binary format loader for compatibility with o32 Linux/MIPS binaries");
 MODULE_AUTHOR("Ralf Baechle (ralf@linux-mips.org)");
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 0a1ec0f..7564c37 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -152,61 +152,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
-/* Fill in the fpu structure for a core dump.. */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *r)
-{
-	int i;
-
-	for (i = 0; i < NUM_FPU_REGS; i++)
-		memcpy(&r[i], &current->thread.fpu.fpr[i], sizeof(*r));
-
-	memcpy(&r[NUM_FPU_REGS], &current->thread.fpu.fcr31,
-	       sizeof(current->thread.fpu.fcr31));
-
-	return 1;
-}
-
-void elf_dump_regs(elf_greg_t *gp, struct pt_regs *regs)
-{
-	int i;
-
-	for (i = 0; i < EF_R0; i++)
-		gp[i] = 0;
-	gp[EF_R0] = 0;
-	for (i = 1; i <= 31; i++)
-		gp[EF_R0 + i] = regs->regs[i];
-	gp[EF_R26] = 0;
-	gp[EF_R27] = 0;
-	gp[EF_LO] = regs->lo;
-	gp[EF_HI] = regs->hi;
-	gp[EF_CP0_EPC] = regs->cp0_epc;
-	gp[EF_CP0_BADVADDR] = regs->cp0_badvaddr;
-	gp[EF_CP0_STATUS] = regs->cp0_status;
-	gp[EF_CP0_CAUSE] = regs->cp0_cause;
-#ifdef EF_UNUSED0
-	gp[EF_UNUSED0] = 0;
-#endif
-}
-
-int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
-{
-	elf_dump_regs(*regs, task_pt_regs(tsk));
-	return 1;
-}
-
-int dump_task_fpu(struct task_struct *t, elf_fpregset_t *fpr)
-{
-	int i;
-
-	for (i = 0; i < NUM_FPU_REGS; i++)
-		memcpy(&fpr[i], &t->thread.fpu.fpr[i], sizeof(*fpr));
-
-	memcpy(&fpr[NUM_FPU_REGS], &t->thread.fpu.fcr31,
-	       sizeof(t->thread.fpu.fcr31));
-
-	return 1;
-}
-
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
-- 
1.9.1

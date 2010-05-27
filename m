Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:05:44 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:39721 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492352Ab0E0NEq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:04:46 +0200
Received: by pxi1 with SMTP id 1so3253104pxi.36
        for <multiple recipients>; Thu, 27 May 2010 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QRohS2uw3CKVRx/QBgM8phxjs+oiwY6lgO5Wrg+OO3I=;
        b=V3tcnvg5Ws/5c7CQFp/pjIwhQ3NoHdOx8vToNawJ7Dju4sATQUlgcrwpNyoo87M8XX
         4Otsxvo85kTVHg8a/qJR2ifwMmWsGjjH4kPZp05qoDDUegwXnGdkCd1PF5bDbIYJhPCi
         6onyelW+2mDh4L4E6OMDhFVJbPERcwc79EplU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jkSS1oQbcngBpIf1YrbsPX/ot7MaZ6mOnqH74bBKqYcNJCIVALKq+LChWrn0jbLyIH
         2LXjGOkRnKcq9NgLcGI7oDNM30ee0MnEG4Jg/Va8w+FXNyZEP/f6UsX5imYjRN2AxNSd
         Pibqrj9rlDB9RbiNaMmihwIZ5cmw2CLd4R2lE=
Received: by 10.142.195.20 with SMTP id s20mr6592534wff.248.1274965478738;
        Thu, 27 May 2010 06:04:38 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.04.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:04:37 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 03/12] MIPS: add support for software performance events
Date:   Thu, 27 May 2010 21:03:31 +0800
Message-Id: <1274965420-5091-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Software events are required as part of the measurable stuff by the
Linux performance counter subsystem. Here is the list of events added by
this patch:
PERF_COUNT_SW_PAGE_FAULTS
PERF_COUNT_SW_PAGE_FAULTS_MIN
PERF_COUNT_SW_PAGE_FAULTS_MAJ
PERF_COUNT_SW_ALIGNMENT_FAULTS
PERF_COUNT_SW_EMULATION_FAULTS

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig            |    2 ++
 arch/mips/kernel/traps.c     |   18 +++++++++++++++---
 arch/mips/kernel/unaligned.c |    5 +++++
 arch/mips/math-emu/cp1emu.c  |    3 +++
 arch/mips/mm/fault.c         |   11 +++++++++--
 5 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ef3d8ca..1bccfe5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,8 @@ config MIPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_PERF_EVENTS
+	select PERF_USE_VMALLOC
 	select GENERIC_ATOMIC64 if !64BIT
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8bdd6a6..d16b3fc 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -27,6 +27,7 @@
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
 #include <linux/kdb.h>
+#include <linux/perf_event.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -570,10 +571,16 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
  */
 static int simulate_llsc(struct pt_regs *regs, unsigned int opcode)
 {
-	if ((opcode & OPCODE) == LL)
+	if ((opcode & OPCODE) == LL) {
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		return simulate_ll(regs, opcode);
-	if ((opcode & OPCODE) == SC)
+	}
+	if ((opcode & OPCODE) == SC) {
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		return simulate_sc(regs, opcode);
+	}
 
 	return -1;			/* Must be something else ... */
 }
@@ -589,6 +596,8 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
 		int rd = (opcode & RD) >> 11;
 		int rt = (opcode & RT) >> 16;
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		switch (rd) {
 		case 0:		/* CPU number */
 			regs->regs[rt] = smp_processor_id();
@@ -624,8 +633,11 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 
 static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 {
-	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC)
+	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC) {
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		return 0;
+	}
 
 	return -1;			/* Must be something else ... */
 }
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 69b039c..a319c7a 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -78,6 +78,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
+#include <linux/perf_event.h>
 #include <asm/asm.h>
 #include <asm/branch.h>
 #include <asm/byteorder.h>
@@ -109,6 +110,8 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	unsigned long value;
 	unsigned int res;
 
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+			1, 0, regs, 0);
 	regs->regs[0] = 0;
 
 	/*
@@ -513,6 +516,8 @@ asmlinkage void do_ade(struct pt_regs *regs)
 	unsigned int __user *pc;
 	mm_segment_t seg;
 
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
+			1, 0, regs, regs->cp0_badvaddr);
 	/*
 	 * Did we catch a fault trying to load an instruction?
 	 * Or are we running in MIPS16 mode?
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 47842b7..fd180ea 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -37,6 +37,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
+#include <linux/perf_event.h>
 
 #include <asm/inst.h>
 #include <asm/bootinfo.h>
@@ -259,6 +260,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 	}
 
       emul:
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+			1, 0, xcp, 0);
 	MIPS_FPU_EMU_INC_STATS(emulated);
 	switch (MIPSInst_OPCODE(ir)) {
 	case ldc1_op:{
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index b78f7d9..5987d2b 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>
+#include <linux/perf_event.h>
 
 #include <asm/branch.h>
 #include <asm/mmu_context.h>
@@ -132,6 +133,7 @@ good_area:
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -139,10 +141,15 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR)
+	if (fault & VM_FAULT_MAJOR) {
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
+				1, 0, regs, address);
 		tsk->maj_flt++;
-	else
+	} else {
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
+				1, 0, regs, address);
 		tsk->min_flt++;
+	}
 
 	up_read(&mm->mmap_sem);
 	return;
-- 
1.6.3.3

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:37:09 +0200 (CEST)
Received: from mail-pz0-f172.google.com ([209.85.222.172]:57451 "EHLO
        mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491059Ab0FIEf3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:29 +0200
Received: by pzk2 with SMTP id 2so977282pzk.25
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wfBFaEQzFsiYvQYI+4OGtivPSeDH+iW2fmxk3V6Dufo=;
        b=HLfeYolMmqCdfxT/aYV4mFNodyeWRD/LwoVYJE3+vIu5AW20PlbS71a7CufLc5omsJ
         aYmJ1l/wIaGTdr5AGNRn+WtAyJiJMrZsUC96eNyQaP57G1mjQQAQhiiv2+OqFG2MNufb
         eo8FlIhknqV4a4YpX7TCERRjZjkjRQ9hYeo2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XuK2uypVjoy7O4VKndzOzHx0ZyymHg0VCPtRot8CdySUKeHYlni5fWZejN71MI4nhO
         g0kD7y2/OCyKytg9OPN0NsEMhc0ZTuHjuUIlIaMG9J5ZPE3eHqVw5JdaqOglYxFAMfII
         36nSiq5GuhhmnQSiKTW9ySO5U/bWOyB6QCuOY=
Received: by 10.142.119.33 with SMTP id r33mr2042159wfc.213.1276058120348;
        Tue, 08 Jun 2010 21:35:20 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:20 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 3/7] MIPS: add support for software performance events
Date:   Wed,  9 Jun 2010 12:35:26 +0800
Message-Id: <1276058130-25851-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6108

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
index 564e30b..378c25d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,8 @@ config MIPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_PERF_EVENTS
+	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
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
index b4aac42..1887ff6 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/perf_event.h>
 
 #include <asm/branch.h>
 #include <asm/mmu_context.h>
@@ -131,6 +132,7 @@ good_area:
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -138,10 +140,15 @@ good_area:
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

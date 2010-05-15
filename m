Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:38:57 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:35812 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab0EOPiG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:38:06 +0200
Received: by pzk32 with SMTP id 32so668030pzk.21
        for <multiple recipients>; Sat, 15 May 2010 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G+kWz7JyAVWMWpsISnaAAtkMZkkgYCKPUmgSXfaCiyA=;
        b=fO9XRFvVu0NO5Z5abxnuHB31vXXUpAAoeZ+7DPMBAyzI7Ar5cqrUaiLkqneW1sU75T
         vb4C9nrzQZB+QrYoym8ZYrPySvo0UvRvu/WkzmiJdSjpUB1djlUQRoW1+fvAT5WeTvzg
         ESnQHGX0oiv/AUCUbnvzsUkqbRT9rr4EFHmS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F48g1NiyaoQKJ1eNV0WZLrmA43iPtAQtZNSwsu9xfpQp6sOWK9FtZwtr2eEnAD8KAy
         a2eaobF8umYV6D47EOuvL0isDTnLbE/FMApBAkSbNPCR6Ps/R1o5gCMFOSgLeF/gIWUk
         Ls4WdBzs1zecRxXjp6MsPdVLapbApfTBPB6pM=
Received: by 10.115.133.39 with SMTP id k39mr2327902wan.198.1273937879589;
        Sat, 15 May 2010 08:37:59 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.37.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:37:58 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 3/9] MIPS: add support for software performance events
Date:   Sat, 15 May 2010 23:36:49 +0800
Message-Id: <1273937815-4781-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26730
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
index 7e5e38c..20e1942 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
+#include <linux/perf_event.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -562,10 +563,16 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
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
@@ -581,6 +588,8 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
 		int rd = (opcode & RD) >> 11;
 		int rt = (opcode & RT) >> 16;
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		switch (rd) {
 		case 0:		/* CPU number */
 			regs->regs[rt] = smp_processor_id();
@@ -616,8 +625,11 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 
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

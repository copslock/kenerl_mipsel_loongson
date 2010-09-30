Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 11:10:14 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:42074 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491163Ab0I3JJd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 11:09:33 +0200
Received: by pvg12 with SMTP id 12so583088pvg.36
        for <multiple recipients>; Thu, 30 Sep 2010 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RaebCCJ275EllAP165XfdeqAaWhSmeE3PoE+HrJmRVg=;
        b=fqPucuk+2JsBCtzHTkLIGZwsTTZKlWapwH3D/9mq3N8cI9G+IdIWw+Mj4nH/IVNYbm
         LnJMiLjqSFF1lUhh+uWCPdaYxYA2ijlVW3kix1x+XYCn5WQGGWkZZPZbfYhr3r+CNrk7
         UzHj/wxo80k4XrjsmF1RJhcD7RFepCwEba2ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TPcmZfbiXUEsooF6jE9YwzLvGd/5spg9rxb+5w21vZ5W85648NU1OT2UU5FIjTdSrM
         CaaEVhcV9anV1aG2a2dKffZvWb3OVxmHZypT1c+RwSbL0DZcBpOhiazStusbbA8mXRwT
         XoPOUdd4QoNuXDIVD+el++FBwYT+pcxvSIrJI=
Received: by 10.114.127.17 with SMTP id z17mr3738505wac.35.1285837763595;
        Thu, 30 Sep 2010 02:09:23 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id c10sm16210348wam.1.2010.09.30.02.09.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 02:09:14 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, dengcheng.zhu@gmail.com
Subject: [PATCH v7 3/6] MIPS: add support for software performance events
Date:   Thu, 30 Sep 2010 17:09:17 +0800
Message-Id: <1285837760-10362-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24022

Software events are required as part of the measurable stuff by the
Linux performance counter subsystem. Here is the list of events added by
this patch:
PERF_COUNT_SW_PAGE_FAULTS
PERF_COUNT_SW_PAGE_FAULTS_MIN
PERF_COUNT_SW_PAGE_FAULTS_MAJ
PERF_COUNT_SW_ALIGNMENT_FAULTS
PERF_COUNT_SW_EMULATION_FAULTS

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
---
 arch/mips/Kconfig            |    2 ++
 arch/mips/kernel/traps.c     |   18 +++++++++++++++---
 arch/mips/kernel/unaligned.c |    6 ++++++
 arch/mips/math-emu/cp1emu.c  |    3 +++
 arch/mips/mm/fault.c         |   11 +++++++++--
 5 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5526faa..ce54490 100644
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
index 03ec001..45def62 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -28,6 +28,7 @@
 #include <linux/kprobes.h>
 #include <linux/notifier.h>
 #include <linux/kdb.h>
+#include <linux/perf_event.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -576,10 +577,16 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
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
@@ -595,6 +602,8 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
 		int rd = (opcode & RD) >> 11;
 		int rt = (opcode & RT) >> 16;
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		switch (rd) {
 		case 0:		/* CPU number */
 			regs->regs[rt] = smp_processor_id();
@@ -630,8 +639,11 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 
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
index 69b039c..f28a087 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -78,6 +78,8 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
+#include <linux/perf_event.h>
+
 #include <asm/asm.h>
 #include <asm/branch.h>
 #include <asm/byteorder.h>
@@ -109,6 +111,8 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	unsigned long value;
 	unsigned int res;
 
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+			1, 0, regs, 0);
 	regs->regs[0] = 0;
 
 	/*
@@ -513,6 +517,8 @@ asmlinkage void do_ade(struct pt_regs *regs)
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
index 783ad00..137ee76 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/perf_event.h>
 
 #include <asm/branch.h>
 #include <asm/mmu_context.h>
@@ -144,6 +145,7 @@ good_area:
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -151,10 +153,15 @@ good_area:
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
1.7.0.4

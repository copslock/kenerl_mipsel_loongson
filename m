Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 12:37:34 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:39598 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492381Ab0DWKg7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Apr 2010 12:36:59 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so1853372pwj.36
        for <multiple recipients>; Fri, 23 Apr 2010 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=BjTnXpdhf3gq4SVNF0VHKwAAKSE0hSUd7Z7hxsRGNQE=;
        b=qcHrgWic0xSv6ADQy2IojhiZGYPNPsi7pfrXh2kdlYOE11qbLq4S/lOp7TnLELHjfZ
         Z5FsJc2pjvkHvq1y/1wXVol18FxNmSGnRVwiH1iU0Nx1nP/1cNfRmtD4ga9fRi3bZj9P
         dVVN8ACS3n8BStpnycxLlPZNjvrU3Uf3fMvbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=KvwBpqwOTFQf7gCoyrPZhz3Hog+8ZAqgQWNqrVdkU9Y3P4jqb3LLWryFa4IAQJalo1
         /z1B0JFjXu5VDSZHvGGHTlkVKLw0QwmrM1CCqjHxVzi+nvxkN0LwXSZzegXXaDc24IEm
         MGAZGS5UaeV4+KTrJfWAVr/yr5GHTpnr0wi04=
Received: by 10.115.114.37 with SMTP id r37mr3241934wam.97.1272019018494;
        Fri, 23 Apr 2010 03:36:58 -0700 (PDT)
Received: from [192.168.1.100] ([114.84.71.49])
        by mx.google.com with ESMTPS id 20sm945604pzk.15.2010.04.23.03.36.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 03:36:57 -0700 (PDT)
Subject: [PATCH v2 3/4] MIPS: adding support for software performance events
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 23 Apr 2010 18:36:46 +0800
Message-ID: <1272019006.4662.95.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Software events are required as a part of the measurable stuff by the
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
index 469176c..ebf2c79 100644
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
index 1a4dd65..851705b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
+#include <linux/perf_event.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -557,10 +558,16 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
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
@@ -576,6 +583,8 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
 		int rd = (opcode & RD) >> 11;
 		int rt = (opcode & RT) >> 16;
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+				1, 0, regs, 0);
 		switch (rd) {
 		case 0:		/* CPU number */
 			regs->regs[rt] = smp_processor_id();
@@ -611,8 +620,11 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 
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
index 8f2f8e9..b3fa153 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -37,6 +37,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
+#include <linux/perf_event.h>
 
 #include <asm/inst.h>
 #include <asm/bootinfo.h>
@@ -256,6 +257,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
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
1.7.0.4

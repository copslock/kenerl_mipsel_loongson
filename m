Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2011 11:08:11 +0200 (CEST)
Received: from ams-iport-4.cisco.com ([144.254.224.147]:51584 "EHLO
        ams-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab1JMJIA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2011 11:08:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=13306; q=dns/txt;
  s=iport; t=1318496880; x=1319706480;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=xsQfrO4hGVA9U0oKvysvyso8gxAe8bcO5sORXbnh7tk=;
  b=SfXFZpg4yyR2DW19GTUq5bPXnaGQyZx473AyC33h344Db9aNBbYdBz8N
   FK0JsM4zqNLoBKT233Q9vgF+3+vOEKoPXNsrdU0Lx18gz+3vISbQlLyc3
   pS9jhwSw+5mvp0RTBhGUwZMx3tqoDOBP+qaSSdg1IyZEXq93azOWpP0nN
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAA6qlk6Q/khR/2dsb2JhbABDqFCBBYFTAQIWAQIBERM/MB8mGDwIIqEsAYMpDwGacIcMYQSHf4t5kV0
X-IronPort-AV: E=Sophos;i="4.69,339,1315180800"; 
   d="scan'208";a="931013"
Received: from ams-core-1.cisco.com ([144.254.72.81])
  by ams-iport-4.cisco.com with ESMTP; 13 Oct 2011 09:07:54 +0000
Received: from cisco.com (dhcp-72-163-207-192.cisco.com [72.163.207.192])
        by ams-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id p9D97r9M025692;
        Thu, 13 Oct 2011 09:07:53 GMT
Received: by cisco.com (Postfix, from userid 1001)
        id EC6FB81CA3; Thu, 13 Oct 2011 14:37:49 +0530 (IST)
Date:   Thu, 13 Oct 2011 14:37:49 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ananth@in.ibm.com, david.daney@cavium.com, kamensky@cisco.com
Subject: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111013090749.GB16761@cisco.com>
Reply-To: manesoni@cisco.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8896


From: Maneesh Soni <manesoni@cisco.com>

This patch provides support for kprobes on branch instructions. The branch
instruction at the probed address is actually emulated and not executed
out-of-line like other normal instructions. Instead the delay-slot instruction
is copied and single stepped out of line.

At the time of probe hit, the original branch instruction is evaluated
and the target cp0_epc is computed similar to compute_retrun_epc(). It
is also checked if the delay slot instruction can be skipped, which is
true if there is a NOP in delay slot or branch is taken in case of
branch likely instructions. Once the delay slot instruction is single
stepped the normal execution resume with the cp0_epc updated the earlier
computed cp0_epc as per the branch instructions.

Signed-off-by: Maneesh Soni <manesoni@cisco.com>
---
 arch/mips/include/asm/kprobes.h |    7 +
 arch/mips/kernel/kprobes.c      |  341 +++++++++++++++++++++++++++++++++++----
 2 files changed, 320 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index e6ea4d4..c0a3e6f 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -74,6 +74,8 @@ struct prev_kprobe {
 		: MAX_JPROBES_STACK_SIZE)
 
 
+#define SKIP_DELAYSLOT	1
+
 /* per-cpu kprobe control block */
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
@@ -81,6 +83,11 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_saved_SR;
 	unsigned long kprobe_saved_epc;
 	unsigned long jprobe_saved_sp;
+
+	/* Per-thread fields, used while emulating branches */
+	unsigned long flags;
+	unsigned long target_epc;
+
 	struct pt_regs jprobe_saved_regs;
 	u8 jprobes_stack[MAX_JPROBES_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index ee28683..0a4a61c 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -121,8 +121,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	prev_insn = p->addr[-1];
 	insn = p->addr[0];
 
-	if (insn_has_delayslot(insn) || insn_has_delayslot(prev_insn)) {
-		pr_notice("Kprobes for branch and jump instructions are not supported\n");
+	if (insn_has_delayslot(prev_insn)) {
+		pr_notice("Kprobes for branch delayslot are not supported\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -138,9 +138,20 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	 * In the kprobe->ainsn.insn[] array we store the original
 	 * instruction at index zero and a break trap instruction at
 	 * index one.
+	 *
+	 * On MIPS arch if the instruction at probed address is a
+	 * branch instruction, we need to execute the instruction at
+	 * Branch Delayslot (BD) at the time of probe hit. As MIPS also
+	 * doesn't have single stepping support, the BD instruction can
+	 * not be executed in-line and it would be executed on SSOL slot
+	 * using a normal breakpoint instruction in the next slot.
+	 * So, read the instruction and save it for later execution.
 	 */
+	if (insn_has_delayslot(insn))
+		memcpy(&p->ainsn.insn[0], p->addr + 1, sizeof(kprobe_opcode_t));
+	else
+		memcpy(&p->ainsn.insn[0], p->addr, sizeof(kprobe_opcode_t));
 
-	memcpy(&p->ainsn.insn[0], p->addr, sizeof(kprobe_opcode_t));
 	p->ainsn.insn[1] = breakpoint2_insn;
 	p->opcode = *p->addr;
 
@@ -191,16 +202,297 @@ static void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 	kcb->kprobe_saved_epc = regs->cp0_epc;
 }
 
-static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+/*
+ * Borrowed heavily from arch/mips/kernel/branch.c:__compute_return_epc()
+ *
+ * Evaluate the branch instruction at probed address during probe hit. The
+ * result of evaluation would be the updated epc. The insturction in delayslot
+ * would actually be single stepped using a normal breakpoint) on SSOL slot.
+ *
+ * The result is also saved in the kprobe control block for later use,
+ * in case we need to execute the delayslot instruction. The latter will be
+ * false for NOP instruction in dealyslot and the branch-likely instructions
+ * when the branch is taken. And for those cases we set a flag as
+ * SKIP_DELAYSLOT in the kprobe control block
+ */
+static int evaluate_branch_instruction(struct kprobe *p, struct pt_regs *regs,
+					struct kprobe_ctlblk *kcb)
 {
+	union mips_instruction insn = p->opcode;
+	unsigned int dspcontrol;
+	long epc;
+
+	epc = regs->cp0_epc;
+	if (epc & 3)
+		goto unaligned;
+
+	if (p->ainsn.insn->word == 0)
+		kcb->flags |= SKIP_DELAYSLOT;
+	else
+		kcb->flags &= ~SKIP_DELAYSLOT;
+
+	switch (insn.i_format.opcode) {
+	/*
+	 * jr and jalr are in r_format format.
+	 */
+	case spec_op:
+		switch (insn.r_format.func) {
+		case jalr_op:
+			regs->regs[insn.r_format.rd] = epc + 8;
+
+			/* Fall through */
+		case jr_op:
+			regs->cp0_epc = regs->regs[insn.r_format.rs];
+			break;
+		}
+		break;
+
+	/*
+	 * This group contains:
+	 * bltz_op, bgez_op, bltzl_op, bgezl_op,
+	 * bltzal_op, bgezal_op, bltzall_op, bgezall_op.
+	 */
+	case bcond_op:
+		switch (insn.i_format.rt) {
+		case bltz_op:
+			if ((long)regs->regs[insn.i_format.rs] < 0)
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+			else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bltzl_op:
+			if ((long)regs->regs[insn.i_format.rs] < 0) {
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+				kcb->flags |= SKIP_DELAYSLOT;
+			} else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bgez_op:
+			if ((long)regs->regs[insn.i_format.rs] >= 0)
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+			else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+		case bgezl_op:
+			if ((long)regs->regs[insn.i_format.rs] >= 0) {
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+				kcb->flags |= SKIP_DELAYSLOT;
+			} else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bltzal_op:
+			regs->regs[31] = epc + 8;
+			if ((long)regs->regs[insn.i_format.rs] < 0)
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+			else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bltzall_op:
+			regs->regs[31] = epc + 8;
+			if ((long)regs->regs[insn.i_format.rs] < 0) {
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+				kcb->flags |= SKIP_DELAYSLOT;
+			} else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bgezal_op:
+			regs->regs[31] = epc + 8;
+			if ((long)regs->regs[insn.i_format.rs] >= 0)
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+			else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bgezall_op:
+			regs->regs[31] = epc + 8;
+			if ((long)regs->regs[insn.i_format.rs] >= 0) {
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+				kcb->flags |= SKIP_DELAYSLOT;
+			} else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+
+		case bposge32_op:
+			if (!cpu_has_dsp)
+				goto sigill;
+
+			dspcontrol = rddsp(0x01);
+
+			if (dspcontrol >= 32)
+				epc = epc + 4 + (insn.i_format.simmediate << 2);
+			else
+				epc += 8;
+			regs->cp0_epc = epc;
+			break;
+		}
+		break;
+
+	/*
+	 * These are unconditional and in j_format.
+	 */
+	case jal_op:
+		regs->regs[31] = regs->cp0_epc + 8;
+	case j_op:
+		epc += 4;
+		epc >>= 28;
+		epc <<= 28;
+		epc |= (insn.j_format.target << 2);
+		regs->cp0_epc = epc;
+		break;
+
+	/*
+	 * These are conditional and in i_format.
+	 */
+	case beq_op:
+		if (regs->regs[insn.i_format.rs] ==
+		    regs->regs[insn.i_format.rt])
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case beql_op:
+		if (regs->regs[insn.i_format.rs] ==
+		    regs->regs[insn.i_format.rt]) {
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+			kcb->flags |= SKIP_DELAYSLOT;
+		} else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case bne_op:
+		if (regs->regs[insn.i_format.rs] !=
+		    regs->regs[insn.i_format.rt])
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case bnel_op:
+		if (regs->regs[insn.i_format.rs] !=
+		    regs->regs[insn.i_format.rt]) {
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+			kcb->flags |= SKIP_DELAYSLOT;
+		} else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case blez_op: /* not really i_format */
+		/* rt field assumed to be zero */
+		if ((long)regs->regs[insn.i_format.rs] <= 0)
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case blezl_op:
+		/* rt field assumed to be zero */
+		if ((long)regs->regs[insn.i_format.rs] <= 0) {
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+			kcb->flags |= SKIP_DELAYSLOT;
+		} else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case bgtz_op:
+		/* rt field assumed to be zero */
+		if ((long)regs->regs[insn.i_format.rs] > 0)
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+
+	case bgtzl_op:
+		/* rt field assumed to be zero */
+		if ((long)regs->regs[insn.i_format.rs] > 0) {
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+			kcb->flags |= SKIP_DELAYSLOT;
+		} else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+	}
+
+	kcb->target_epc = regs->cp0_epc;
+
+	return 1;
+
+unaligned:
+	printk(KERN_ERR "%s: unaligned epc - sending SIGBUS.\n", current->comm);
+	force_sig(SIGBUS, current);
+	return -EFAULT;
+
+sigill:
+	printk(KERN_ERR "%s: DSP branch but not DSP ASE - sending SIGBUS.\n",
+		current->comm);
+	force_sig(SIGBUS, current);
+	return -EFAULT;
+
+}
+
+static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs,
+						struct kprobe_ctlblk *kcb)
+{
+	int ret = 0;
+
 	regs->cp0_status &= ~ST0_IE;
 
 	/* single step inline if the instruction is a break */
 	if (p->opcode.word == breakpoint_insn.word ||
 	    p->opcode.word == breakpoint2_insn.word)
 		regs->cp0_epc = (unsigned long)p->addr;
-	else
-		regs->cp0_epc = (unsigned long)&p->ainsn.insn[0];
+	else if (insn_has_delayslot(p->opcode)) {
+		ret = evaluate_branch_instruction(p, regs, kcb);
+		if (ret < 0) {
+			printk(KERN_ERR "Kprobes: Error evaluating branch\n");
+			return;
+		}
+	}
+	regs->cp0_epc = (unsigned long)&p->ainsn.insn[0];
+}
+
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "break 0"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn.
+ *
+ * This function prepares to return from the post-single-step
+ * breakpoint trap. In case of branch instructions, the target
+ * epc to be restored.
+ */
+static void __kprobes resume_execution(struct kprobe *p,
+				       struct pt_regs *regs,
+				       struct kprobe_ctlblk *kcb)
+{
+	if (insn_has_delayslot(p->opcode))
+		regs->cp0_epc = kcb->target_epc;
+	else {
+		unsigned long orig_epc = kcb->kprobe_saved_epc;
+		regs->cp0_epc = orig_epc + 4;
+	}
 }
 
 static int __kprobes kprobe_handler(struct pt_regs *regs)
@@ -239,8 +531,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
 			kprobes_inc_nmissed_count(p);
-			prepare_singlestep(p, regs);
+			prepare_singlestep(p, regs, kcb);
 			kcb->kprobe_status = KPROBE_REENTER;
+			if (kcb->flags & SKIP_DELAYSLOT) {
+				resume_execution(p, regs, kcb);
+				restore_previous_kprobe(kcb);
+				preempt_enable_no_resched();
+			}
 			return 1;
 		} else {
 			if (addr->word != breakpoint_insn.word) {
@@ -284,8 +581,15 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	}
 
 ss_probe:
-	prepare_singlestep(p, regs);
-	kcb->kprobe_status = KPROBE_HIT_SS;
+	prepare_singlestep(p, regs, kcb);
+	if (kcb->flags & SKIP_DELAYSLOT) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		if (p->post_handler)
+			p->post_handler(p, regs, 0);
+		resume_execution(p, regs, kcb);
+	} else
+		kcb->kprobe_status = KPROBE_HIT_SS;
+
 	return 1;
 
 no_kprobe:
@@ -294,25 +598,6 @@ no_kprobe:
 
 }
 
-/*
- * Called after single-stepping.  p->addr is the address of the
- * instruction whose first byte has been replaced by the "break 0"
- * instruction.  To avoid the SMP problems that can occur when we
- * temporarily put back the original opcode to single-step, we
- * single-stepped a copy of the instruction.  The address of this
- * copy is p->ainsn.insn.
- *
- * This function prepares to return from the post-single-step
- * breakpoint trap.
- */
-static void __kprobes resume_execution(struct kprobe *p,
-				       struct pt_regs *regs,
-				       struct kprobe_ctlblk *kcb)
-{
-	unsigned long orig_epc = kcb->kprobe_saved_epc;
-	regs->cp0_epc = orig_epc + 4;
-}
-
 static inline int post_kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
-- 
1.7.1

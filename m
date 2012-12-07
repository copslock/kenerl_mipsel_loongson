Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:07:36 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60314 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824761Ab2LGFFx11Rwi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:05:53 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgq8A-0007MA-MX; Thu, 06 Dec 2012 23:05:46 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH v99,05/13] MIPS: microMIPS: Support handling of delay slots.
Date:   Thu,  6 Dec 2012 23:05:29 -0600
Message-Id: <1354856737-28678-6-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354856737-28678-1-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
X-archive-position: 35216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add logic needed to properly calculate exceptions for delay slots
when in microMIPS or MIPS16e modes.

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/branch.h |   33 +++++++-
 arch/mips/include/asm/inst.h   |    3 +
 arch/mips/kernel/branch.c      |  183 +++++++++++++++++++++++++++++++++++++++-
 arch/mips/kernel/unaligned.c   |    3 +
 4 files changed, 219 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/branch.h b/arch/mips/include/asm/branch.h
index 888766a..ccc938a 100644
--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -16,11 +16,16 @@ static inline int delay_slot(struct pt_regs *regs)
 	return regs->cp0_cause & CAUSEF_BD;
 }
 
+extern int __isa_exception_epc(struct pt_regs *regs);
+
 static inline unsigned long exception_epc(struct pt_regs *regs)
 {
-	if (!delay_slot(regs))
+	if (likely(!delay_slot(regs)))
 		return regs->cp0_epc;
 
+	if (is16mode(regs))
+		return __isa_exception_epc(regs);
+
 	return regs->cp0_epc + 4;
 }
 
@@ -29,9 +34,20 @@ static inline unsigned long exception_epc(struct pt_regs *regs)
 extern int __compute_return_epc(struct pt_regs *regs);
 extern int __compute_return_epc_for_insn(struct pt_regs *regs,
 					 union mips_instruction insn);
+extern int __MIPS16e_compute_return_epc(struct pt_regs *regs);
+extern int __microMIPS_compute_return_epc(struct pt_regs *regs);
 
+/*  only for MIPS32/64 but not 16bits variants */
 static inline int compute_return_epc(struct pt_regs *regs)
 {
+	if (is16mode(regs)) {
+		if (cpu_has_mips16)
+			return __MIPS16e_compute_return_epc(regs);
+		if (cpu_has_mmips)
+			return __microMIPS_compute_return_epc(regs);
+		return regs->cp0_epc;
+	}
+
 	if (!delay_slot(regs)) {
 		regs->cp0_epc += 4;
 		return 0;
@@ -40,4 +56,19 @@ static inline int compute_return_epc(struct pt_regs *regs)
 	return __compute_return_epc(regs);
 }
 
+static inline int MIPS16e_compute_return_epc(struct pt_regs *regs,
+					     union mips16e_instruction *inst)
+{
+	if (likely(!delay_slot(regs))) {
+		if (inst->ri.opcode == MIPS16e_extend_op) {
+			regs->cp0_epc += 4;
+			return 0;
+		}
+		regs->cp0_epc += 2;
+		return 0;
+	}
+
+	return __MIPS16e_compute_return_epc(regs);
+}
+
 #endif /* _ASM_BRANCH_H */
diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index 2b2e0e3..c97b854 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -1122,6 +1122,9 @@ struct decoded_instn {
 	int micro_mips_mode;
 };
 
+/* Recode table from MIPS16e register notation to GPR. */
+extern const int mips16e_reg2gpr[];
+
 union mips16e_instruction {
 	unsigned int full:16;
 	struct rr rr;
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d735d0..01b4e91 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -14,10 +14,188 @@
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/fpu.h>
+#include <asm/fpu_emulator.h>
 #include <asm/inst.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
+/*
+ * Calculate and return exception epc in case of
+ * branch delay slot for microMIPS/MIPS16e
+ * It doesn't clear ISA mode bit.
+ */
+int __isa_exception_epc(struct pt_regs *regs)
+{
+	long epc;
+	union mips16e_instruction inst;
+
+	/* calc exception pc in branch delay slot */
+	epc = regs->cp0_epc;
+	if (__get_user(inst.full, (u16 __user *) (epc & ~MIPS_ISA_MODE))) {
+		/* it should never happens... because delay slot was checked */
+		force_sig(SIGSEGV, current);
+		return epc;
+	}
+	if (cpu_has_mips16) {
+		if (inst.ri.opcode == MIPS16e_jal_op)
+			epc += 4;
+		else
+			epc += 2;
+	} else if (mm_is16bit(inst.full))
+		epc += 2;
+	else
+		epc += 4;
+
+	return epc;
+}
+
+/*
+ * Compute the return address and do emulate branch simulation in MIPS16e mode,
+ * if required.
+ * After exception only - doesn't do 'compact' branch/jumps and can't be used
+ * during interrupt (compact B/J doesn't do exception)
+ */
+int __MIPS16e_compute_return_epc(struct pt_regs *regs)
+{
+	u16 __user *addr;
+	union mips16e_instruction inst;
+	u16 inst2;
+	u32 fullinst;
+	long epc;
+
+	epc = regs->cp0_epc;
+	/*
+	 * Read the instruction
+	 */
+	addr = (u16 __user *) (epc & ~MIPS_ISA_MODE);
+	if (__get_user(inst.full, addr)) {
+		force_sig(SIGSEGV, current);
+		return -EFAULT;
+	}
+
+	switch (inst.ri.opcode) {
+	case MIPS16e_extend_op:
+		regs->cp0_epc += 4;
+		return 0;
+
+		/*
+		 *  JAL and JALX in MIPS16e mode
+		 */
+	case MIPS16e_jal_op:
+		addr += 1;
+		if (__get_user(inst2, addr)) {
+			force_sig(SIGSEGV, current);
+			return -EFAULT;
+		}
+		fullinst = ((unsigned)inst.full << 16) | inst2;
+		regs->regs[31] = epc + 6;
+		epc += 4;
+		epc >>= 28;
+		epc <<= 28;
+		/*
+		 * JAL:5 X:1 TARGET[20-16]:5 TARGET[25:21]:5 TARGET[15:0]:16
+		 *
+		 * ......TARGET[15:0].................TARGET[20:16]...........
+		 * ......TARGET[25:21]
+		 */
+		epc |=
+		    ((fullinst & 0xffff) << 2) | ((fullinst & 0x3e00000) >> 3) |
+		    ((fullinst & 0x1f0000) << 7);
+		if (!inst.jal.x)
+			epc |= MIPS_ISA_MODE;	/* set ISA mode 1 */
+		regs->cp0_epc = epc;
+		return 0;
+
+		/*
+		 *  J(AL)R(C)
+		 */
+	case MIPS16e_rr_op:
+		if (inst.rr.func == MIPS16e_jr_func) {
+
+			if (inst.rr.ra)
+				regs->cp0_epc = regs->regs[31];
+			else
+				regs->cp0_epc =
+				    regs->regs[mips16e_reg2gpr[inst.rr.rx]];
+
+			if (inst.rr.l) {
+				if (inst.rr.nd)
+					regs->regs[31] = epc + 2;
+				else
+					regs->regs[31] = epc + 4;
+			}
+			return 0;
+		}
+		break;
+	}
+
+	/* all other cases have no branch delay slot and are 16bits,
+	   and branches do not do exception */
+	regs->cp0_epc += 2;
+
+	return 0;
+}
+
+/*
+ * Compute the return address and do emulate branch simulation in
+ * microMIPS mode, if required.
+ * After exception only - doesn't do 'compact' branch/jumps and can't be used
+ * during interrupt (compact B/J doesn't do exception)
+ */
+int __microMIPS_compute_return_epc(struct pt_regs *regs)
+{
+	u16 __user *pc16;
+	u16 halfword;
+	unsigned int word;
+	unsigned long contpc;
+	struct decoded_instn mminst = { 0 };
+
+	mminst.micro_mips_mode = 1;
+
+	/*
+	 * This load never faults.
+	 */
+	pc16 = (unsigned short __user *)(regs->cp0_epc & ~MIPS_ISA_MODE);
+	__get_user(halfword, pc16);
+	pc16++;
+	contpc = regs->cp0_epc + 2;
+	word = ((unsigned int)halfword << 16);
+	mminst.pc_inc = 2;
+
+	if (!mm_is16bit(halfword)) {
+		__get_user(halfword, pc16);
+		pc16++;
+		contpc = regs->cp0_epc + 4;
+		mminst.pc_inc = 4;
+		word |= halfword;
+	}
+	mminst.insn = word;
+
+	if (get_user(halfword, pc16))
+		goto sigsegv;
+	mminst.next_pc_inc = 2;
+	word = ((unsigned int)halfword << 16);
+
+	if (!mm_is16bit(halfword)) {
+		pc16++;
+		if (get_user(halfword, pc16))
+			goto sigsegv;
+		mminst.next_pc_inc = 4;
+		word |= halfword;
+	}
+	mminst.next_insn = word;
+
+	mm_isBranchInstr(regs, mminst, &contpc);
+
+	regs->cp0_epc = contpc;
+
+	return 0;
+
+sigsegv:
+	force_sig(SIGSEGV, current);
+	return -EFAULT;
+}
+
 /**
  * __compute_return_epc_for_insn - Computes the return address and do emulate
  *				    branch simulation, if required.
@@ -57,7 +235,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	 */
 	case bcond_op:
 		switch (insn.i_format.rt) {
-	 	case bltz_op:
+		case bltz_op:
 		case bltzl_op:
 			if ((long)regs->regs[insn.i_format.rs] < 0) {
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -129,6 +307,8 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		epc <<= 28;
 		epc |= (insn.j_format.target << 2);
 		regs->cp0_epc = epc;
+		if (insn.i_format.opcode == jalx_op)
+			regs->cp0_epc |= MIPS_ISA_MODE;
 		break;
 
 	/*
@@ -289,5 +469,4 @@ unaligned:
 	printk("%s: unaligned epc - sending SIGBUS.\n", current->comm);
 	force_sig(SIGBUS, current);
 	return -EFAULT;
-
 }
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 9c58bdf..ad855db 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -102,6 +102,9 @@ static u32 unaligned_action;
 #endif
 extern void show_registers(struct pt_regs *regs);
 
+/* Recode table from MIPS16e register notation to GPR. */
+const int mips16e_reg2gpr[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+
 static void emulate_load_store_insn(struct pt_regs *regs,
 	void __user *addr, unsigned int __user *pc)
 {
-- 
1.7.9.5

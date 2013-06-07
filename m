Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:06:02 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54712 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835086Ab3FGXDx40e4H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:53 +0200
Received: by mail-ie0-f173.google.com with SMTP id k5so5431913iea.32
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UhAmJxogRs5jkYeRpqye9OFC8AIUxINRlz+/v+jNGXU=;
        b=YgtXCZgLkGvS8lCdED9TqC4EXE8J4qtqvABbOgqbmjzUAyU4BPV4pdxGiX4/lNBaqH
         mEJ5j6mnHgjuW6gB0WtWIJz91YBBwrNC58AgU3Z/hNZGCojL0BXwYM/ANmY/FYXzvrTI
         RMSlHJTd5Qwo4J3od53xinnSrXmVrubfUCFCetcct4r6kg603qDmwAMWdPvnrE8k0JeF
         8QIhvFAvEhyyxvM55yDgbEsaRb6WeMR8Bq+dfcrw5gayJZ9ZUTEm7n/0YphpyS0D6qMK
         v7ybUjsG+Od+5hdirA06o7ktadDxHR0XBlhWvbTWgPCokebACI/RFsfsiuHKldDPp9Tp
         NRzQ==
X-Received: by 10.50.3.36 with SMTP id 4mr2306589igz.69.1370646227622;
        Fri, 07 Jun 2013 16:03:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt6sm135884igb.10.2013.06.07.16.03.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3iXx006634;
        Fri, 7 Jun 2013 16:03:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3ixC006633;
        Fri, 7 Jun 2013 16:03:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 06/31] mips/kvm: Rename kvm_vcpu_arch.pc to  kvm_vcpu_arch.epc
Date:   Fri,  7 Jun 2013 16:03:10 -0700
Message-Id: <1370646215-6543-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The proper MIPS name for this register is EPC, so use that.

Change the asm-offsets name to KVM_VCPU_ARCH_EPC, so that the symbol
name prefix matches the structure name.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm_host.h |   2 +-
 arch/mips/kernel/asm-offsets.c   |   2 +-
 arch/mips/kvm/kvm_locore.S       |   6 +-
 arch/mips/kvm/kvm_mips.c         |  12 ++--
 arch/mips/kvm/kvm_mips_emul.c    | 140 +++++++++++++++++++--------------------
 arch/mips/kvm/kvm_mips_int.c     |   8 +--
 arch/mips/kvm/kvm_trap_emul.c    |  20 +++---
 7 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 4d6fa0b..d9ee320 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -363,7 +363,7 @@ struct kvm_vcpu_arch {
 	unsigned long gprs[32];
 	unsigned long hi;
 	unsigned long lo;
-	unsigned long pc;
+	unsigned long epc;
 
 	/* FPU State */
 	struct mips_fpu_struct fpu;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0845091..22bf8f5 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -385,7 +385,7 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_R31, kvm_vcpu_arch, gprs[31]);
 	OFFSET(VCPU_LO, kvm_vcpu_arch, lo);
 	OFFSET(VCPU_HI, kvm_vcpu_arch, hi);
-	OFFSET(VCPU_PC, kvm_vcpu_arch, pc);
+	OFFSET(KVM_VCPU_ARCH_EPC, kvm_vcpu_arch, epc);
 	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
 	OFFSET(VCPU_GUEST_KERNEL_ASID, kvm_vcpu_arch, guest_kernel_asid);
 	OFFSET(VCPU_GUEST_USER_ASID, kvm_vcpu_arch, guest_user_asid);
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index e86fa2a..a434bbe 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -151,7 +151,7 @@ FEXPORT(__kvm_mips_vcpu_run)
 
 
 	/* Set Guest EPC */
-	LONG_L		t0, VCPU_PC(k1)
+	LONG_L		t0, KVM_VCPU_ARCH_EPC(k1)
 	mtc0		t0, CP0_EPC
 
 FEXPORT(__kvm_mips_load_asid)
@@ -330,7 +330,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 
     /* Save Host level EPC, BadVaddr and Cause to VCPU, useful to process the exception */
     mfc0    k0,CP0_EPC
-    LONG_S  k0, VCPU_PC(k1)
+    LONG_S  k0, KVM_VCPU_ARCH_EPC(k1)
 
     mfc0    k0, CP0_BADVADDR
     LONG_S  k0, VCPU_HOST_CP0_BADVADDR(k1)
@@ -438,7 +438,7 @@ __kvm_mips_return_to_guest:
 
 
 	/* Set Guest EPC */
-	LONG_L		t0, VCPU_PC(k1)
+	LONG_L		t0, KVM_VCPU_ARCH_EPC(k1)
 	mtc0		t0, CP0_EPC
 
     /* Set the ASID for the Guest Kernel */
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 6018e2a..4ac5ab4 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -583,7 +583,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 		v = (long)vcpu->arch.lo;
 		break;
 	case KVM_REG_MIPS_PC:
-		v = (long)vcpu->arch.pc;
+		v = (long)vcpu->arch.epc;
 		break;
 
 	case KVM_REG_MIPS_CP0_INDEX:
@@ -658,7 +658,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 		vcpu->arch.lo = v;
 		break;
 	case KVM_REG_MIPS_PC:
-		vcpu->arch.pc = v;
+		vcpu->arch.epc = v;
 		break;
 
 	case KVM_REG_MIPS_CP0_INDEX:
@@ -890,7 +890,7 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
 		return -1;
 
 	printk("VCPU Register Dump:\n");
-	printk("\tpc = 0x%08lx\n", vcpu->arch.pc);;
+	printk("\tepc = 0x%08lx\n", vcpu->arch.epc);;
 	printk("\texceptions: %08lx\n", vcpu->arch.pending_exceptions);
 
 	for (i = 0; i < 32; i += 4) {
@@ -920,7 +920,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
 	vcpu->arch.hi = regs->hi;
 	vcpu->arch.lo = regs->lo;
-	vcpu->arch.pc = regs->pc;
+	vcpu->arch.epc = regs->pc;
 
 	return 0;
 }
@@ -934,7 +934,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	regs->hi = vcpu->arch.hi;
 	regs->lo = vcpu->arch.lo;
-	regs->pc = vcpu->arch.pc;
+	regs->pc = vcpu->arch.epc;
 
 	return 0;
 }
@@ -1014,7 +1014,7 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	uint32_t cause = vcpu->arch.host_cp0_cause;
 	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index a2c6687..7cbc3bc 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -213,17 +213,17 @@ enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
 	enum emulation_result er = EMULATE_DONE;
 
 	if (cause & CAUSEF_BD) {
-		branch_pc = kvm_compute_return_epc(vcpu, vcpu->arch.pc);
+		branch_pc = kvm_compute_return_epc(vcpu, vcpu->arch.epc);
 		if (branch_pc == KVM_INVALID_INST) {
 			er = EMULATE_FAIL;
 		} else {
-			vcpu->arch.pc = branch_pc;
-			kvm_debug("BD update_pc(): New PC: %#lx\n", vcpu->arch.pc);
+			vcpu->arch.epc = branch_pc;
+			kvm_debug("BD update_pc(): New PC: %#lx\n", vcpu->arch.epc);
 		}
 	} else
-		vcpu->arch.pc += 4;
+		vcpu->arch.epc += 4;
 
-	kvm_debug("update_pc(): New PC: %#lx\n", vcpu->arch.pc);
+	kvm_debug("update_pc(): New PC: %#lx\n", vcpu->arch.epc);
 
 	return er;
 }
@@ -255,17 +255,17 @@ enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 	enum emulation_result er = EMULATE_DONE;
 
 	if (kvm_read_c0_guest_status(cop0) & ST0_EXL) {
-		kvm_debug("[%#lx] ERET to %#lx\n", vcpu->arch.pc,
+		kvm_debug("[%#lx] ERET to %#lx\n", vcpu->arch.epc,
 			  kvm_read_c0_guest_epc(cop0));
 		kvm_clear_c0_guest_status(cop0, ST0_EXL);
-		vcpu->arch.pc = kvm_read_c0_guest_epc(cop0);
+		vcpu->arch.epc = kvm_read_c0_guest_epc(cop0);
 
 	} else if (kvm_read_c0_guest_status(cop0) & ST0_ERL) {
 		kvm_clear_c0_guest_status(cop0, ST0_ERL);
-		vcpu->arch.pc = kvm_read_c0_guest_errorepc(cop0);
+		vcpu->arch.epc = kvm_read_c0_guest_errorepc(cop0);
 	} else {
 		printk("[%#lx] ERET when MIPS_SR_EXL|MIPS_SR_ERL == 0\n",
-		       vcpu->arch.pc);
+		       vcpu->arch.epc);
 		er = EMULATE_FAIL;
 	}
 
@@ -276,7 +276,7 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DONE;
 
-	kvm_debug("[%#lx] !!!WAIT!!! (%#lx)\n", vcpu->arch.pc,
+	kvm_debug("[%#lx] !!!WAIT!!! (%#lx)\n", vcpu->arch.epc,
 		  vcpu->arch.pending_exceptions);
 
 	++vcpu->stat.wait_exits;
@@ -304,7 +304,7 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_FAIL;
-	uint32_t pc = vcpu->arch.pc;
+	uint32_t pc = vcpu->arch.epc;
 
 	printk("[%#x] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
 	return er;
@@ -317,7 +317,7 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	int index = kvm_read_c0_guest_index(cop0);
 	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
-	uint32_t pc = vcpu->arch.pc;
+	uint32_t pc = vcpu->arch.epc;
 
 	if (index < 0 || index >= KVM_MIPS_GUEST_TLB_SIZE) {
 		printk("%s: illegal index: %d\n", __func__, index);
@@ -356,7 +356,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
-	uint32_t pc = vcpu->arch.pc;
+	uint32_t pc = vcpu->arch.epc;
 	int index;
 
 #if 1
@@ -397,7 +397,7 @@ enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	long entryhi = kvm_read_c0_guest_entryhi(cop0);
 	enum emulation_result er = EMULATE_DONE;
-	uint32_t pc = vcpu->arch.pc;
+	uint32_t pc = vcpu->arch.epc;
 	int index = -1;
 
 	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
@@ -417,14 +417,14 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	int32_t rt, rd, copz, sel, co_bit, op;
-	uint32_t pc = vcpu->arch.pc;
+	uint32_t pc = vcpu->arch.epc;
 	unsigned long curr_pc;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
 	 * an error and we want to rollback the PC
 	 */
-	curr_pc = vcpu->arch.pc;
+	curr_pc = vcpu->arch.epc;
 	er = update_pc(vcpu, cause);
 	if (er == EMULATE_FAIL) {
 		return er;
@@ -585,7 +585,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 		case dmtc_op:
 			printk
 			    ("!!!!!!![%#lx]dmtc_op: rt: %d, rd: %d, sel: %d!!!!!!\n",
-			     vcpu->arch.pc, rt, rd, sel);
+			     vcpu->arch.epc, rt, rd, sel);
 			er = EMULATE_FAIL;
 			break;
 
@@ -600,11 +600,11 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 			/* EI */
 			if (inst & 0x20) {
 				kvm_debug("[%#lx] mfmcz_op: EI\n",
-					  vcpu->arch.pc);
+					  vcpu->arch.epc);
 				kvm_set_c0_guest_status(cop0, ST0_IE);
 			} else {
 				kvm_debug("[%#lx] mfmcz_op: DI\n",
-					  vcpu->arch.pc);
+					  vcpu->arch.epc);
 				kvm_clear_c0_guest_status(cop0, ST0_IE);
 			}
 
@@ -629,7 +629,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 		default:
 			printk
 			    ("[%#lx]MachEmulateCP0: unsupported COP0, copz: 0x%x\n",
-			     vcpu->arch.pc, copz);
+			     vcpu->arch.epc, copz);
 			er = EMULATE_FAIL;
 			break;
 		}
@@ -640,7 +640,7 @@ done:
 	 * Rollback PC only if emulation was unsuccessful
 	 */
 	if (er == EMULATE_FAIL) {
-		vcpu->arch.pc = curr_pc;
+		vcpu->arch.epc = curr_pc;
 	}
 
 dont_update_pc:
@@ -667,7 +667,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 	 * Update PC and hold onto current PC in case there is
 	 * an error and we want to rollback the PC
 	 */
-	curr_pc = vcpu->arch.pc;
+	curr_pc = vcpu->arch.epc;
 	er = update_pc(vcpu, cause);
 	if (er == EMULATE_FAIL)
 		return er;
@@ -723,7 +723,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		*(uint32_t *) data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SW: eaddr: %#lx, gpr: %#lx, data: %#x\n",
-			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
+			  vcpu->arch.epc, vcpu->arch.host_cp0_badvaddr,
 			  vcpu->arch.gprs[rt], *(uint32_t *) data);
 		break;
 
@@ -748,7 +748,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 		*(uint16_t *) data = vcpu->arch.gprs[rt];
 
 		kvm_debug("[%#lx] OP_SH: eaddr: %#lx, gpr: %#lx, data: %#x\n",
-			  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
+			  vcpu->arch.epc, vcpu->arch.host_cp0_badvaddr,
 			  vcpu->arch.gprs[rt], *(uint32_t *) data);
 		break;
 
@@ -762,7 +762,7 @@ kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 	 * Rollback PC if emulation was unsuccessful
 	 */
 	if (er == EMULATE_FAIL) {
-		vcpu->arch.pc = curr_pc;
+		vcpu->arch.epc = curr_pc;
 	}
 
 	return er;
@@ -926,7 +926,7 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 	 * Update PC and hold onto current PC in case there is
 	 * an error and we want to rollback the PC
 	 */
-	curr_pc = vcpu->arch.pc;
+	curr_pc = vcpu->arch.epc;
 	er = update_pc(vcpu, cause);
 	if (er == EMULATE_FAIL)
 		return er;
@@ -948,7 +948,7 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 	if (op == MIPS_CACHE_OP_INDEX_INV) {
 		kvm_debug
 		    ("@ %#lx/%#lx CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
-		     vcpu->arch.pc, vcpu->arch.gprs[31], cache, op, base,
+		     vcpu->arch.epc, vcpu->arch.gprs[31], cache, op, base,
 		     arch->gprs[base], offset);
 
 		if (cache == MIPS_CACHE_DCACHE)
@@ -1055,7 +1055,7 @@ skip_fault:
 	/*
 	 * Rollback PC
 	 */
-	vcpu->arch.pc = curr_pc;
+	vcpu->arch.epc = curr_pc;
       done:
 	return er;
 }
@@ -1120,7 +1120,7 @@ kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1128,13 +1128,13 @@ kvm_mips_emulate_syscall(unsigned long cause, uint32_t *opc,
 		else
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
-		kvm_debug("Delivering SYSCALL @ pc %#lx\n", arch->pc);
+		kvm_debug("Delivering SYSCALL @ pc %#lx\n", arch->epc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
 					  (T_SYSCALL << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
 	} else {
 		printk("Trying to deliver SYSCALL when EXL is already set\n");
@@ -1156,7 +1156,7 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1165,16 +1165,16 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
 		kvm_debug("[EXL == 0] delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
+			  arch->epc);
 
 		/* set pc to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x0;
+		arch->epc = KVM_GUEST_KSEG0 + 0x0;
 
 	} else {
 		kvm_debug("[EXL == 1] delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
+			  arch->epc);
 
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
@@ -1203,7 +1203,7 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1212,15 +1212,15 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
 		kvm_debug("[EXL == 0] delivering TLB INV @ pc %#lx\n",
-			  arch->pc);
+			  arch->epc);
 
 		/* set pc to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
 	} else {
 		kvm_debug("[EXL == 1] delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+			  arch->epc);
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
@@ -1248,7 +1248,7 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1257,14 +1257,14 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
 		kvm_debug("[EXL == 0] Delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
+			  arch->epc);
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x0;
+		arch->epc = KVM_GUEST_KSEG0 + 0x0;
 	} else {
 		kvm_debug("[EXL == 1] Delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+			  arch->epc);
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
@@ -1292,7 +1292,7 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1301,14 +1301,14 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
 		kvm_debug("[EXL == 0] Delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
+			  arch->epc);
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	} else {
 		kvm_debug("[EXL == 1] Delivering TLB MISS @ pc %#lx\n",
-			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+			  arch->epc);
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
@@ -1363,7 +1363,7 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1372,13 +1372,13 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
 		kvm_debug("[EXL == 0] Delivering TLB MOD @ pc %#lx\n",
-			  arch->pc);
+			  arch->epc);
 
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	} else {
 		kvm_debug("[EXL == 1] Delivering TLB MOD @ pc %#lx\n",
-			  arch->pc);
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+			  arch->epc);
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff), (T_TLB_MOD << CAUSEB_EXCCODE));
@@ -1403,7 +1403,7 @@ kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1413,7 +1413,7 @@ kvm_mips_emulate_fpu_exc(unsigned long cause, uint32_t *opc,
 
 	}
 
-	arch->pc = KVM_GUEST_KSEG0 + 0x180;
+	arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
 				  (T_COP_UNUSABLE << CAUSEB_EXCCODE));
@@ -1432,7 +1432,7 @@ kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1440,13 +1440,13 @@ kvm_mips_emulate_ri_exc(unsigned long cause, uint32_t *opc,
 		else
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
-		kvm_debug("Delivering RI @ pc %#lx\n", arch->pc);
+		kvm_debug("Delivering RI @ pc %#lx\n", arch->epc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
 					  (T_RES_INST << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
 	} else {
 		kvm_err("Trying to deliver RI when EXL is already set\n");
@@ -1466,7 +1466,7 @@ kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1474,13 +1474,13 @@ kvm_mips_emulate_bp_exc(unsigned long cause, uint32_t *opc,
 		else
 			kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
-		kvm_debug("Delivering BP @ pc %#lx\n", arch->pc);
+		kvm_debug("Delivering BP @ pc %#lx\n", arch->epc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
 					  (T_BREAK << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
 	} else {
 		printk("Trying to deliver BP when EXL is already set\n");
@@ -1521,7 +1521,7 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 	 * Update PC and hold onto current PC in case there is
 	 * an error and we want to rollback the PC
 	 */
-	curr_pc = vcpu->arch.pc;
+	curr_pc = vcpu->arch.epc;
 	er = update_pc(vcpu, cause);
 	if (er == EMULATE_FAIL)
 		return er;
@@ -1587,7 +1587,7 @@ kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
 	 * Rollback PC only if emulation was unsuccessful
 	 */
 	if (er == EMULATE_FAIL) {
-		vcpu->arch.pc = curr_pc;
+		vcpu->arch.epc = curr_pc;
 	}
 	return er;
 }
@@ -1609,7 +1609,7 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	 * Update PC and hold onto current PC in case there is
 	 * an error and we want to rollback the PC
 	 */
-	curr_pc = vcpu->arch.pc;
+	curr_pc = vcpu->arch.epc;
 	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
 	if (er == EMULATE_FAIL)
 		return er;
@@ -1637,7 +1637,7 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->arch.pending_load_cause & CAUSEF_BD)
 		kvm_debug
 		    ("[%#lx] Completing %d byte BD Load to gpr %d (0x%08lx) type %d\n",
-		     vcpu->arch.pc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
+		     vcpu->arch.epc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
 		     vcpu->mmio_needed);
 
 done:
@@ -1655,7 +1655,7 @@ kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
-		kvm_write_c0_guest_epc(cop0, arch->pc);
+		kvm_write_c0_guest_epc(cop0, arch->epc);
 		kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 		if (cause & CAUSEF_BD)
@@ -1667,7 +1667,7 @@ kvm_mips_emulate_exc(unsigned long cause, uint32_t *opc,
 					  (exccode << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
-		arch->pc = KVM_GUEST_KSEG0 + 0x180;
+		arch->epc = KVM_GUEST_KSEG0 + 0x180;
 		kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
 
 		kvm_debug("Delivering EXC %d @ pc %#lx, badVaddr: %#lx\n",
diff --git a/arch/mips/kvm/kvm_mips_int.c b/arch/mips/kvm/kvm_mips_int.c
index 1e5de16..c1ba08b 100644
--- a/arch/mips/kvm/kvm_mips_int.c
+++ b/arch/mips/kvm/kvm_mips_int.c
@@ -167,7 +167,7 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 
 		if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 			/* save old pc */
-			kvm_write_c0_guest_epc(cop0, arch->pc);
+			kvm_write_c0_guest_epc(cop0, arch->epc);
 			kvm_set_c0_guest_status(cop0, ST0_EXL);
 
 			if (cause & CAUSEF_BD)
@@ -175,7 +175,7 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 			else
 				kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
 
-			kvm_debug("Delivering INT @ pc %#lx\n", arch->pc);
+			kvm_debug("Delivering INT @ pc %#lx\n", arch->epc);
 
 		} else
 			kvm_err("Trying to deliver interrupt when EXL is already set\n");
@@ -185,9 +185,9 @@ kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 
 		/* XXXSL Set PC to the interrupt exception entry point */
 		if (kvm_read_c0_guest_cause(cop0) & CAUSEF_IV)
-			arch->pc = KVM_GUEST_KSEG0 + 0x200;
+			arch->epc = KVM_GUEST_KSEG0 + 0x200;
 		else
-			arch->pc = KVM_GUEST_KSEG0 + 0x180;
+			arch->epc = KVM_GUEST_KSEG0 + 0x180;
 
 		clear_bit(priority, &vcpu->arch.pending_exceptions);
 	}
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 30d7253..8d0ab12 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -43,7 +43,7 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -77,7 +77,7 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -124,7 +124,7 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -174,7 +174,7 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -190,7 +190,7 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
 #ifdef DEBUG
 		kvm_debug("USER ADDR TLB ST fault: PC: %#lx, BadVaddr: %#lx\n",
-			  vcpu->arch.pc, badvaddr);
+			  vcpu->arch.epc, badvaddr);
 #endif
 
 		/* User Address (UA) fault, this could happen if
@@ -228,7 +228,7 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -261,7 +261,7 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
@@ -294,7 +294,7 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -312,7 +312,7 @@ static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
@@ -330,7 +330,7 @@ static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
+	uint32_t __user *opc = (uint32_t __user *) vcpu->arch.epc;
 	unsigned long cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
-- 
1.7.11.7

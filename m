Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:53:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13724 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014075AbbLPXuPlJaN0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:15 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id CEE3BB8C06720;
        Wed, 16 Dec 2015 23:50:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:08 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 08/16] MIPS: Move Cause.ExcCode trap codes to mipsregs.h
Date:   Wed, 16 Dec 2015 23:49:33 +0000
Message-ID: <1450309781-28030-9-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Move the Cause.ExcCode trap code definitions from kvm_host.h to
mipsregs.h, since they describe architectural bits rather than KVM
specific constants, and change the prefix from T_ to EXCCODE_.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 28 ----------------
 arch/mips/include/asm/mipsregs.h | 24 ++++++++++++++
 arch/mips/kvm/emulate.c          | 71 ++++++++++++++++++++--------------------
 arch/mips/kvm/interrupt.c        |  8 ++---
 arch/mips/kvm/mips.c             | 32 +++++++++---------
 5 files changed, 80 insertions(+), 83 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 16f647347357..ba8d9acdba30 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -281,34 +281,6 @@ enum mips_mmu_types {
 	MMU_TYPE_R8000
 };
 
-/*
- * Trap codes
- */
-#define T_INT			0	/* Interrupt pending */
-#define T_TLB_MOD		1	/* TLB modified fault */
-#define T_TLB_LD_MISS		2	/* TLB miss on load or ifetch */
-#define T_TLB_ST_MISS		3	/* TLB miss on a store */
-#define T_ADDR_ERR_LD		4	/* Address error on a load or ifetch */
-#define T_ADDR_ERR_ST		5	/* Address error on a store */
-#define T_BUS_ERR_IFETCH	6	/* Bus error on an ifetch */
-#define T_BUS_ERR_LD_ST		7	/* Bus error on a load or store */
-#define T_SYSCALL		8	/* System call */
-#define T_BREAK			9	/* Breakpoint */
-#define T_RES_INST		10	/* Reserved instruction exception */
-#define T_COP_UNUSABLE		11	/* Coprocessor unusable */
-#define T_OVFLOW		12	/* Arithmetic overflow */
-
-/*
- * Trap definitions added for r4000 port.
- */
-#define T_TRAP			13	/* Trap instruction */
-#define T_VCEI			14	/* Virtual coherency exception */
-#define T_MSAFPE		14	/* MSA floating point exception */
-#define T_FPE			15	/* Floating point exception */
-#define T_MSADIS		21	/* MSA disabled exception */
-#define T_WATCH			23	/* Watch address reference */
-#define T_VCED			31	/* Virtual coherency data */
-
 /* Resume Flags */
 #define RESUME_FLAG_DR		(1<<0)	/* Reload guest nonvolatile state? */
 #define RESUME_FLAG_HOST	(1<<1)	/* Resume host? */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index af36d2be4d0d..eb89b877c6c9 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -404,6 +404,30 @@
 #define CAUSEF_BD		(_ULCAST_(1)   << 31)
 
 /*
+ * Cause.ExcCode trap codes.
+ */
+#define EXCCODE_INT		0	/* Interrupt pending */
+#define EXCCODE_MOD		1	/* TLB modified fault */
+#define EXCCODE_TLBL		2	/* TLB miss on load or ifetch */
+#define EXCCODE_TLBS		3	/* TLB miss on a store */
+#define EXCCODE_ADEL		4	/* Address error on a load or ifetch */
+#define EXCCODE_ADES		5	/* Address error on a store */
+#define EXCCODE_IBE		6	/* Bus error on an ifetch */
+#define EXCCODE_DBE		7	/* Bus error on a load or store */
+#define EXCCODE_SYS		8	/* System call */
+#define EXCCODE_BP		9	/* Breakpoint */
+#define EXCCODE_RI		10	/* Reserved instruction exception */
+#define EXCCODE_CPU		11	/* Coprocessor unusable */
+#define EXCCODE_OV		12	/* Arithmetic overflow */
+#define EXCCODE_TR		13	/* Trap instruction */
+#define EXCCODE_VCEI		14	/* Virtual coherency exception */
+#define EXCCODE_MSAFPE		14	/* MSA floating point exception */
+#define EXCCODE_FPE		15	/* Floating point exception */
+#define EXCCODE_MSADIS		21	/* MSA disabled exception */
+#define EXCCODE_WATCH		23	/* Watch address reference */
+#define EXCCODE_VCED		31	/* Virtual coherency data */
+
+/*
  * Bits in the coprocessor 0 config register.
  */
 /* Generic bits.  */
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 95b83a6582ef..6ff1dcfc9ef1 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1780,7 +1780,7 @@ enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
 		kvm_debug("Delivering SYSCALL @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_SYSCALL << CAUSEB_EXCCODE));
+					  (EXCCODE_SYS << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -1827,7 +1827,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
-				  (T_TLB_LD_MISS << CAUSEB_EXCCODE));
+				  (EXCCODE_TLBL << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
@@ -1873,7 +1873,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
-				  (T_TLB_LD_MISS << CAUSEB_EXCCODE));
+				  (EXCCODE_TLBL << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
@@ -1917,7 +1917,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
-				  (T_TLB_ST_MISS << CAUSEB_EXCCODE));
+				  (EXCCODE_TLBS << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
@@ -1961,7 +1961,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
 	}
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
-				  (T_TLB_ST_MISS << CAUSEB_EXCCODE));
+				  (EXCCODE_TLBS << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
@@ -2032,7 +2032,8 @@ enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
 	}
 
-	kvm_change_c0_guest_cause(cop0, (0xff), (T_TLB_MOD << CAUSEB_EXCCODE));
+	kvm_change_c0_guest_cause(cop0, (0xff),
+				  (EXCCODE_MOD << CAUSEB_EXCCODE));
 
 	/* setup badvaddr, context and entryhi registers for the guest */
 	kvm_write_c0_guest_badvaddr(cop0, vcpu->arch.host_cp0_badvaddr);
@@ -2067,7 +2068,7 @@ enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
 	arch->pc = KVM_GUEST_KSEG0 + 0x180;
 
 	kvm_change_c0_guest_cause(cop0, (0xff),
-				  (T_COP_UNUSABLE << CAUSEB_EXCCODE));
+				  (EXCCODE_CPU << CAUSEB_EXCCODE));
 	kvm_change_c0_guest_cause(cop0, (CAUSEF_CE), (0x1 << CAUSEB_CE));
 
 	return EMULATE_DONE;
@@ -2095,7 +2096,7 @@ enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
 		kvm_debug("Delivering RI @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_RES_INST << CAUSEB_EXCCODE));
+					  (EXCCODE_RI << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -2130,7 +2131,7 @@ enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 		kvm_debug("Delivering BP @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_BREAK << CAUSEB_EXCCODE));
+					  (EXCCODE_BP << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -2165,7 +2166,7 @@ enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 		kvm_debug("Delivering TRAP @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_TRAP << CAUSEB_EXCCODE));
+					  (EXCCODE_TR << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -2200,7 +2201,7 @@ enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
 		kvm_debug("Delivering MSAFPE @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_MSAFPE << CAUSEB_EXCCODE));
+					  (EXCCODE_MSAFPE << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -2235,7 +2236,7 @@ enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
 		kvm_debug("Delivering FPE @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_FPE << CAUSEB_EXCCODE));
+					  (EXCCODE_FPE << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -2270,7 +2271,7 @@ enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
 		kvm_debug("Delivering MSADIS @ pc %#lx\n", arch->pc);
 
 		kvm_change_c0_guest_cause(cop0, (0xff),
-					  (T_MSADIS << CAUSEB_EXCCODE));
+					  (EXCCODE_MSADIS << CAUSEB_EXCCODE));
 
 		/* Set PC to the exception entry point */
 		arch->pc = KVM_GUEST_KSEG0 + 0x180;
@@ -2479,25 +2480,25 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 
 	if (usermode) {
 		switch (exccode) {
-		case T_INT:
-		case T_SYSCALL:
-		case T_BREAK:
-		case T_RES_INST:
-		case T_TRAP:
-		case T_MSAFPE:
-		case T_FPE:
-		case T_MSADIS:
+		case EXCCODE_INT:
+		case EXCCODE_SYS:
+		case EXCCODE_BP:
+		case EXCCODE_RI:
+		case EXCCODE_TR:
+		case EXCCODE_MSAFPE:
+		case EXCCODE_FPE:
+		case EXCCODE_MSADIS:
 			break;
 
-		case T_COP_UNUSABLE:
+		case EXCCODE_CPU:
 			if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 0)
 				er = EMULATE_PRIV_FAIL;
 			break;
 
-		case T_TLB_MOD:
+		case EXCCODE_MOD:
 			break;
 
-		case T_TLB_LD_MISS:
+		case EXCCODE_TLBL:
 			/*
 			 * We we are accessing Guest kernel space, then send an
 			 * address error exception to the guest
@@ -2506,12 +2507,12 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 				kvm_debug("%s: LD MISS @ %#lx\n", __func__,
 					  badvaddr);
 				cause &= ~0xff;
-				cause |= (T_ADDR_ERR_LD << CAUSEB_EXCCODE);
+				cause |= (EXCCODE_ADEL << CAUSEB_EXCCODE);
 				er = EMULATE_PRIV_FAIL;
 			}
 			break;
 
-		case T_TLB_ST_MISS:
+		case EXCCODE_TLBS:
 			/*
 			 * We we are accessing Guest kernel space, then send an
 			 * address error exception to the guest
@@ -2520,26 +2521,26 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
 				kvm_debug("%s: ST MISS @ %#lx\n", __func__,
 					  badvaddr);
 				cause &= ~0xff;
-				cause |= (T_ADDR_ERR_ST << CAUSEB_EXCCODE);
+				cause |= (EXCCODE_ADES << CAUSEB_EXCCODE);
 				er = EMULATE_PRIV_FAIL;
 			}
 			break;
 
-		case T_ADDR_ERR_ST:
+		case EXCCODE_ADES:
 			kvm_debug("%s: address error ST @ %#lx\n", __func__,
 				  badvaddr);
 			if ((badvaddr & PAGE_MASK) == KVM_GUEST_COMMPAGE_ADDR) {
 				cause &= ~0xff;
-				cause |= (T_TLB_ST_MISS << CAUSEB_EXCCODE);
+				cause |= (EXCCODE_TLBS << CAUSEB_EXCCODE);
 			}
 			er = EMULATE_PRIV_FAIL;
 			break;
-		case T_ADDR_ERR_LD:
+		case EXCCODE_ADEL:
 			kvm_debug("%s: address error LD @ %#lx\n", __func__,
 				  badvaddr);
 			if ((badvaddr & PAGE_MASK) == KVM_GUEST_COMMPAGE_ADDR) {
 				cause &= ~0xff;
-				cause |= (T_TLB_LD_MISS << CAUSEB_EXCCODE);
+				cause |= (EXCCODE_TLBL << CAUSEB_EXCCODE);
 			}
 			er = EMULATE_PRIV_FAIL;
 			break;
@@ -2585,9 +2586,9 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 		      (va & VPN2_MASK) |
 		      (kvm_read_c0_guest_entryhi(vcpu->arch.cop0) & ASID_MASK));
 	if (index < 0) {
-		if (exccode == T_TLB_LD_MISS) {
+		if (exccode == EXCCODE_TLBL) {
 			er = kvm_mips_emulate_tlbmiss_ld(cause, opc, run, vcpu);
-		} else if (exccode == T_TLB_ST_MISS) {
+		} else if (exccode == EXCCODE_TLBS) {
 			er = kvm_mips_emulate_tlbmiss_st(cause, opc, run, vcpu);
 		} else {
 			kvm_err("%s: invalid exc code: %d\n", __func__,
@@ -2602,10 +2603,10 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 		 * exception to the guest
 		 */
 		if (!TLB_IS_VALID(*tlb, va)) {
-			if (exccode == T_TLB_LD_MISS) {
+			if (exccode == EXCCODE_TLBL) {
 				er = kvm_mips_emulate_tlbinv_ld(cause, opc, run,
 								vcpu);
-			} else if (exccode == T_TLB_ST_MISS) {
+			} else if (exccode == EXCCODE_TLBS) {
 				er = kvm_mips_emulate_tlbinv_st(cause, opc, run,
 								vcpu);
 			} else {
diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
index 9b4445940c2b..95f790663b0c 100644
--- a/arch/mips/kvm/interrupt.c
+++ b/arch/mips/kvm/interrupt.c
@@ -128,7 +128,7 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 		    && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
 		    && (kvm_read_c0_guest_status(cop0) & IE_IRQ5)) {
 			allowed = 1;
-			exccode = T_INT;
+			exccode = EXCCODE_INT;
 		}
 		break;
 
@@ -137,7 +137,7 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 		    && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
 		    && (kvm_read_c0_guest_status(cop0) & IE_IRQ0)) {
 			allowed = 1;
-			exccode = T_INT;
+			exccode = EXCCODE_INT;
 		}
 		break;
 
@@ -146,7 +146,7 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 		    && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
 		    && (kvm_read_c0_guest_status(cop0) & IE_IRQ1)) {
 			allowed = 1;
-			exccode = T_INT;
+			exccode = EXCCODE_INT;
 		}
 		break;
 
@@ -155,7 +155,7 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 		    && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
 		    && (kvm_read_c0_guest_status(cop0) & IE_IRQ2)) {
 			allowed = 1;
-			exccode = T_INT;
+			exccode = EXCCODE_INT;
 		}
 		break;
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 5848b616d5a0..1b688faf2cf3 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1264,8 +1264,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	switch (exccode) {
-	case T_INT:
-		kvm_debug("[%d]T_INT @ %p\n", vcpu->vcpu_id, opc);
+	case EXCCODE_INT:
+		kvm_debug("[%d]EXCCODE_INT @ %p\n", vcpu->vcpu_id, opc);
 
 		++vcpu->stat.int_exits;
 		trace_kvm_exit(vcpu, INT_EXITS);
@@ -1276,8 +1276,8 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = RESUME_GUEST;
 		break;
 
-	case T_COP_UNUSABLE:
-		kvm_debug("T_COP_UNUSABLE: @ PC: %p\n", opc);
+	case EXCCODE_CPU:
+		kvm_debug("EXCCODE_CPU: @ PC: %p\n", opc);
 
 		++vcpu->stat.cop_unusable_exits;
 		trace_kvm_exit(vcpu, COP_UNUSABLE_EXITS);
@@ -1287,13 +1287,13 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		break;
 
-	case T_TLB_MOD:
+	case EXCCODE_MOD:
 		++vcpu->stat.tlbmod_exits;
 		trace_kvm_exit(vcpu, TLBMOD_EXITS);
 		ret = kvm_mips_callbacks->handle_tlb_mod(vcpu);
 		break;
 
-	case T_TLB_ST_MISS:
+	case EXCCODE_TLBS:
 		kvm_debug("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
 			  cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
 			  badvaddr);
@@ -1303,7 +1303,7 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_tlb_st_miss(vcpu);
 		break;
 
-	case T_TLB_LD_MISS:
+	case EXCCODE_TLBL:
 		kvm_debug("TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
 			  cause, opc, badvaddr);
 
@@ -1312,55 +1312,55 @@ int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		ret = kvm_mips_callbacks->handle_tlb_ld_miss(vcpu);
 		break;
 
-	case T_ADDR_ERR_ST:
+	case EXCCODE_ADES:
 		++vcpu->stat.addrerr_st_exits;
 		trace_kvm_exit(vcpu, ADDRERR_ST_EXITS);
 		ret = kvm_mips_callbacks->handle_addr_err_st(vcpu);
 		break;
 
-	case T_ADDR_ERR_LD:
+	case EXCCODE_ADEL:
 		++vcpu->stat.addrerr_ld_exits;
 		trace_kvm_exit(vcpu, ADDRERR_LD_EXITS);
 		ret = kvm_mips_callbacks->handle_addr_err_ld(vcpu);
 		break;
 
-	case T_SYSCALL:
+	case EXCCODE_SYS:
 		++vcpu->stat.syscall_exits;
 		trace_kvm_exit(vcpu, SYSCALL_EXITS);
 		ret = kvm_mips_callbacks->handle_syscall(vcpu);
 		break;
 
-	case T_RES_INST:
+	case EXCCODE_RI:
 		++vcpu->stat.resvd_inst_exits;
 		trace_kvm_exit(vcpu, RESVD_INST_EXITS);
 		ret = kvm_mips_callbacks->handle_res_inst(vcpu);
 		break;
 
-	case T_BREAK:
+	case EXCCODE_BP:
 		++vcpu->stat.break_inst_exits;
 		trace_kvm_exit(vcpu, BREAK_INST_EXITS);
 		ret = kvm_mips_callbacks->handle_break(vcpu);
 		break;
 
-	case T_TRAP:
+	case EXCCODE_TR:
 		++vcpu->stat.trap_inst_exits;
 		trace_kvm_exit(vcpu, TRAP_INST_EXITS);
 		ret = kvm_mips_callbacks->handle_trap(vcpu);
 		break;
 
-	case T_MSAFPE:
+	case EXCCODE_MSAFPE:
 		++vcpu->stat.msa_fpe_exits;
 		trace_kvm_exit(vcpu, MSA_FPE_EXITS);
 		ret = kvm_mips_callbacks->handle_msa_fpe(vcpu);
 		break;
 
-	case T_FPE:
+	case EXCCODE_FPE:
 		++vcpu->stat.fpe_exits;
 		trace_kvm_exit(vcpu, FPE_EXITS);
 		ret = kvm_mips_callbacks->handle_fpe(vcpu);
 		break;
 
-	case T_MSADIS:
+	case EXCCODE_MSADIS:
 		++vcpu->stat.msa_disabled_exits;
 		trace_kvm_exit(vcpu, MSA_DISABLED_EXITS);
 		ret = kvm_mips_callbacks->handle_msa_disabled(vcpu);
-- 
2.4.10

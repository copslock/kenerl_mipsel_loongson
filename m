Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:21:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56598 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040861AbcFINToB7z2i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AF1047A50B087;
        Thu,  9 Jun 2016 14:19:33 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 06/18] MIPS: KVM: Make various Cause variables 32-bit
Date:   Thu, 9 Jun 2016 14:19:09 +0100
Message-ID: <1465478361-7431-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53920
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

The CP0 Cause register is passed around in KVM quite a bit, often as an
unsigned long, even though it is always 32-bits long.

Resize it to u32 throughout MIPS KVM.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 40 +++++++++++++++++++-------------------
 arch/mips/kvm/emulate.c          | 38 ++++++++++++++++++------------------
 arch/mips/kvm/locore.S           |  2 +-
 arch/mips/kvm/trap_emul.c        | 42 ++++++++++++++++++++--------------------
 4 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 9250b59acd18..dceb49422e3b 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -344,8 +344,8 @@ struct kvm_vcpu_arch {
 
 	/* Host CP0 registers used when handling exits from guest */
 	unsigned long host_cp0_badvaddr;
-	unsigned long host_cp0_cause;
 	unsigned long host_cp0_epc;
+	u32 host_cp0_cause;
 
 	/* GPRS */
 	unsigned long gprs[32];
@@ -386,7 +386,7 @@ struct kvm_vcpu_arch {
 	/* Bitmask of pending exceptions to be cleared */
 	unsigned long pending_exceptions_clr;
 
-	unsigned long pending_load_cause;
+	u32 pending_load_cause;
 
 	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
 	unsigned long preempt_entryhi;
@@ -637,12 +637,12 @@ extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 						unsigned long *hpa0,
 						unsigned long *hpa1);
 
-extern enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
+extern enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause,
+extern enum emulation_result kvm_mips_handle_tlbmod(u32 cause,
 						    u32 *opc,
 						    struct kvm_run *run,
 						    struct kvm_vcpu *vcpu);
@@ -668,77 +668,77 @@ extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
 u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu);
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
 
-extern enum emulation_result kvm_mips_emulate_inst(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_inst(u32 cause,
 						   u32 *opc,
 						   struct kvm_run *run,
 						   struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_syscall(u32 cause,
 						      u32 *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(u32 cause,
 							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_tlbinv_ld(u32 cause,
 							u32 *opc,
 							struct kvm_run *run,
 							struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_tlbmiss_st(u32 cause,
 							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_tlbinv_st(u32 cause,
 							u32 *opc,
 							struct kvm_run *run,
 							struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_tlbmod(u32 cause,
 						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_fpu_exc(u32 cause,
 						      u32 *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_handle_ri(unsigned long cause,
+extern enum emulation_result kvm_mips_handle_ri(u32 cause,
 						u32 *opc,
 						struct kvm_run *run,
 						struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_ri_exc(u32 cause,
 						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_bp_exc(u32 cause,
 						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_trap_exc(u32 cause,
 						       u32 *opc,
 						       struct kvm_run *run,
 						       struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_msafpe_exc(u32 cause,
 							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_fpe_exc(u32 cause,
 						      u32 *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
-extern enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
+extern enum emulation_result kvm_mips_emulate_msadis_exc(u32 cause,
 							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
@@ -757,7 +757,7 @@ void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu);
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_mips_count_timeout(struct kvm_vcpu *vcpu);
 
-enum emulation_result kvm_mips_check_privilege(unsigned long cause,
+enum emulation_result kvm_mips_check_privilege(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 8f4f3242a655..3baab5ec3d3b 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1688,7 +1688,7 @@ dont_update_pc:
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_inst(unsigned long cause, u32 *opc,
+enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
@@ -1735,7 +1735,7 @@ enum emulation_result kvm_mips_emulate_inst(unsigned long cause, u32 *opc,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
+enum emulation_result kvm_mips_emulate_syscall(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
@@ -1770,7 +1770,7 @@ enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
+enum emulation_result kvm_mips_emulate_tlbmiss_ld(u32 cause,
 						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
@@ -1816,7 +1816,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
 	return EMULATE_DONE;
 }
 
-enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
+enum emulation_result kvm_mips_emulate_tlbinv_ld(u32 cause,
 						 u32 *opc,
 						 struct kvm_run *run,
 						 struct kvm_vcpu *vcpu)
@@ -1862,7 +1862,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
 	return EMULATE_DONE;
 }
 
-enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
+enum emulation_result kvm_mips_emulate_tlbmiss_st(u32 cause,
 						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
@@ -1906,7 +1906,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
 	return EMULATE_DONE;
 }
 
-enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
+enum emulation_result kvm_mips_emulate_tlbinv_st(u32 cause,
 						 u32 *opc,
 						 struct kvm_run *run,
 						 struct kvm_vcpu *vcpu)
@@ -1951,7 +1951,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
 }
 
 /* TLBMOD: store into address matching TLB with Dirty bit off */
-enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, u32 *opc,
+enum emulation_result kvm_mips_handle_tlbmod(u32 cause, u32 *opc,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
@@ -1979,7 +1979,7 @@ enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, u32 *opc,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
+enum emulation_result kvm_mips_emulate_tlbmod(u32 cause,
 					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
@@ -2022,7 +2022,7 @@ enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
 	return EMULATE_DONE;
 }
 
-enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_fpu_exc(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
@@ -2051,7 +2051,7 @@ enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
 	return EMULATE_DONE;
 }
 
-enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_ri_exc(u32 cause,
 					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
@@ -2086,7 +2086,7 @@ enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_bp_exc(u32 cause,
 					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
@@ -2121,7 +2121,7 @@ enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_trap_exc(u32 cause,
 						u32 *opc,
 						struct kvm_run *run,
 						struct kvm_vcpu *vcpu)
@@ -2156,7 +2156,7 @@ enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_msafpe_exc(u32 cause,
 						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
@@ -2191,7 +2191,7 @@ enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_fpe_exc(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
@@ -2226,7 +2226,7 @@ enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
+enum emulation_result kvm_mips_emulate_msadis_exc(u32 cause,
 						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
@@ -2276,7 +2276,7 @@ enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
 #define SYNC   0x0000000f
 #define RDHWR  0x0000003b
 
-enum emulation_result kvm_mips_handle_ri(unsigned long cause, u32 *opc,
+enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
 					 struct kvm_run *run,
 					 struct kvm_vcpu *vcpu)
 {
@@ -2406,7 +2406,7 @@ done:
 	return er;
 }
 
-static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
+static enum emulation_result kvm_mips_emulate_exc(u32 cause,
 						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
@@ -2444,7 +2444,7 @@ static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_check_privilege(unsigned long cause,
+enum emulation_result kvm_mips_check_privilege(u32 cause,
 					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
@@ -2540,7 +2540,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
  * (2) TLB entry is present in the Guest TLB but not in the shadow, in this
  *     case we inject the TLB from the Guest TLB into the shadow host TLB
  */
-enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
+enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 5ad2d507b125..43c8ef847efa 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -306,7 +306,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 	LONG_S	k0, VCPU_HOST_CP0_BADVADDR(k1)
 
 	mfc0	k0, CP0_CAUSE
-	LONG_S	k0, VCPU_HOST_CP0_CAUSE(k1)
+	sw	k0, VCPU_HOST_CP0_CAUSE(k1)
 
 	/* Now restore the host state just enough to run the handlers */
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 4aa5d77b0d6a..ecf0068bc95e 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -41,7 +41,7 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -89,13 +89,13 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
 	if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 	    || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug("USER/KSEG23 ADDR TLB MOD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_debug("USER/KSEG23 ADDR TLB MOD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
 			  cause, opc, badvaddr);
 		er = kvm_mips_handle_tlbmod(cause, opc, run, vcpu);
 
@@ -111,14 +111,14 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 		 * when we are not using HIGHMEM. Need to address this in a
 		 * HIGHMEM kernel
 		 */
-		kvm_err("TLB MOD fault not handled, cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_err("TLB MOD fault not handled, cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
 	} else {
-		kvm_err("Illegal TLB Mod fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_err("Illegal TLB Mod fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
@@ -133,7 +133,7 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -145,7 +145,7 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug("USER ADDR TLB LD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_debug("USER ADDR TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
 			  cause, opc, badvaddr);
 		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
 		if (er == EMULATE_DONE)
@@ -165,7 +165,7 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err("Illegal TLB LD fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_err("Illegal TLB LD fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
@@ -180,7 +180,7 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -219,7 +219,7 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err("Illegal TLB ST fault address , cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_err("Illegal TLB ST fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
@@ -234,7 +234,7 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -251,7 +251,7 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err("Address Error (STORE): cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_err("Address Error (STORE): cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
@@ -264,7 +264,7 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -280,7 +280,7 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err("Address Error (LOAD): cause %#lx, PC: %p, BadVaddr: %#lx\n",
+		kvm_err("Address Error (LOAD): cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
@@ -293,7 +293,7 @@ static int kvm_trap_emul_handle_syscall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -311,7 +311,7 @@ static int kvm_trap_emul_handle_res_inst(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -329,7 +329,7 @@ static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -347,7 +347,7 @@ static int kvm_trap_emul_handle_trap(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *)vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -365,7 +365,7 @@ static int kvm_trap_emul_handle_msa_fpe(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *)vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -383,7 +383,7 @@ static int kvm_trap_emul_handle_fpe(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *)vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
@@ -408,7 +408,7 @@ static int kvm_trap_emul_handle_msa_disabled(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
-	unsigned long cause = vcpu->arch.host_cp0_cause;
+	u32 cause = vcpu->arch.host_cp0_cause;
 	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
-- 
2.4.10

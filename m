Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:51:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8551 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdAPMtvB3kek (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 35381DCFAEEB5;
        Mon, 16 Jan 2017 12:49:41 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:44 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 3/13] KVM: MIPS/T&E: Abstract bad access handling
Date:   Mon, 16 Jan 2017 12:49:24 +0000
Message-ID: <de7beb0a1327a52aa31e785495bbbc9470e6adbe.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56322
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

Abstract the handling of bad guest loads and stores which may need to
trigger an MMIO, so that the same code can be used in a later patch for
guest KSeg0 addresses (TLB exception handling) as well as for host KSeg1
addresses (existing address error exception and TLB exception handling).

We now use kvm_mips_emulate_store() and kvm_mips_emulate_load() directly
rather than the more generic kvm_mips_emulate_inst(), as there is no
need to expose emulation of any other instructions.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 119 +++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 47 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 33888f1a89f4..79c30a0baad1 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -85,6 +85,75 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_mips_bad_load(u32 cause, u32 *opc, struct kvm_run *run,
+			     struct kvm_vcpu *vcpu)
+{
+	enum emulation_result er;
+	union mips_instruction inst;
+	int err;
+
+	/* A code fetch fault doesn't count as an MMIO */
+	if (kvm_is_ifetch_fault(&vcpu->arch)) {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return RESUME_HOST;
+	}
+
+	/* Fetch the instruction. */
+	if (cause & CAUSEF_BD)
+		opc += 1;
+	err = kvm_get_badinstr(opc, vcpu, &inst.word);
+	if (err) {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return RESUME_HOST;
+	}
+
+	/* Emulate the load */
+	er = kvm_mips_emulate_load(inst, cause, run, vcpu);
+	if (er == EMULATE_FAIL) {
+		kvm_err("Emulate load from MMIO space failed\n");
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	} else {
+		run->exit_reason = KVM_EXIT_MMIO;
+	}
+	return RESUME_HOST;
+}
+
+static int kvm_mips_bad_store(u32 cause, u32 *opc, struct kvm_run *run,
+			      struct kvm_vcpu *vcpu)
+{
+	enum emulation_result er;
+	union mips_instruction inst;
+	int err;
+
+	/* Fetch the instruction. */
+	if (cause & CAUSEF_BD)
+		opc += 1;
+	err = kvm_get_badinstr(opc, vcpu, &inst.word);
+	if (err) {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return RESUME_HOST;
+	}
+
+	/* Emulate the store */
+	er = kvm_mips_emulate_store(inst, cause, run, vcpu);
+	if (er == EMULATE_FAIL) {
+		kvm_err("Emulate store to MMIO space failed\n");
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	} else {
+		run->exit_reason = KVM_EXIT_MMIO;
+	}
+	return RESUME_HOST;
+}
+
+static int kvm_mips_bad_access(u32 cause, u32 *opc, struct kvm_run *run,
+			       struct kvm_vcpu *vcpu, bool store)
+{
+	if (store)
+		return kvm_mips_bad_store(cause, opc, run, vcpu);
+	else
+		return kvm_mips_bad_load(cause, opc, run, vcpu);
+}
+
 static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -178,28 +247,11 @@ static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 		}
 	} else if (KVM_GUEST_KERNEL_MODE(vcpu)
 		   && (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1)) {
-		/* A code fetch fault doesn't count as an MMIO */
-		if (!store && kvm_is_ifetch_fault(&vcpu->arch)) {
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			return RESUME_HOST;
-		}
-
 		/*
 		 * With EVA we may get a TLB exception instead of an address
 		 * error when the guest performs MMIO to KSeg1 addresses.
 		 */
-		kvm_debug("Emulate %s MMIO space\n",
-			  store ? "Store to" : "Load from");
-		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
-		if (er == EMULATE_FAIL) {
-			kvm_err("Emulate %s MMIO space failed\n",
-				store ? "Store to" : "Load from");
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		} else {
-			run->exit_reason = KVM_EXIT_MMIO;
-			ret = RESUME_HOST;
-		}
+		ret = kvm_mips_bad_access(cause, opc, run, vcpu, store);
 	} else {
 		kvm_err("Illegal TLB %s fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
 			store ? "ST" : "LD", cause, opc, badvaddr);
@@ -227,21 +279,11 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	u32 cause = vcpu->arch.host_cp0_cause;
-	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
 	if (KVM_GUEST_KERNEL_MODE(vcpu)
 	    && (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1)) {
-		kvm_debug("Emulate Store to MMIO space\n");
-		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
-		if (er == EMULATE_FAIL) {
-			kvm_err("Emulate Store to MMIO space failed\n");
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		} else {
-			run->exit_reason = KVM_EXIT_MMIO;
-			ret = RESUME_HOST;
-		}
+		ret = kvm_mips_bad_store(cause, opc, run, vcpu);
 	} else {
 		kvm_err("Address Error (STORE): cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
@@ -257,32 +299,15 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	u32 cause = vcpu->arch.host_cp0_cause;
-	enum emulation_result er = EMULATE_DONE;
 	int ret = RESUME_GUEST;
 
 	if (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1) {
-		/* A code fetch fault doesn't count as an MMIO */
-		if (kvm_is_ifetch_fault(&vcpu->arch)) {
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			return RESUME_HOST;
-		}
-
-		kvm_debug("Emulate Load from MMIO space @ %#lx\n", badvaddr);
-		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
-		if (er == EMULATE_FAIL) {
-			kvm_err("Emulate Load from MMIO space failed\n");
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		} else {
-			run->exit_reason = KVM_EXIT_MMIO;
-			ret = RESUME_HOST;
-		}
+		ret = kvm_mips_bad_load(cause, opc, run, vcpu);
 	} else {
 		kvm_err("Address Error (LOAD): cause %#x, PC: %p, BadVaddr: %#lx\n",
 			cause, opc, badvaddr);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
-		er = EMULATE_FAIL;
 	}
 	return ret;
 }
-- 
git-series 0.8.10

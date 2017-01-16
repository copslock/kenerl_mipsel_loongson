Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:52:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993882AbdAPMtzCTCck (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B37B685E48A0C;
        Mon, 16 Jan 2017 12:49:42 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:45 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 5/13] KVM: MIPS/T&E: Handle read only GPA in TLB mod
Date:   Mon, 16 Jan 2017 12:49:26 +0000
Message-ID: <8ee0b56012ef4927fc98e4acdfbc613df5b3ca7f.1484570878.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56325
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

Rewrite TLB modified exception handling to handle read only GPA memory
regions, instead of unconditionally passing the exception to the guest.

If the guest TLB is not the cause of the exception we call into the
normal TLB fault handling depending on the memory segment, which will
soon attempt to remap the physical page to be writable (handling dirty
page tracking or copy on write in the process).

Failing that we fall back to treating it as MMIO, due to a read only
memory region. Once the capability is enabled, this will allow read only
memory regions (such as the Malta boot flash as emulated by QEMU) to
have writes treated as MMIO, while still allowing reads to run
untrapped.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  5 +--
 arch/mips/kvm/emulate.c          | 31 +---------------
 arch/mips/kvm/trap_emul.c        | 69 ++++++++++++++++++++-------------
 3 files changed, 43 insertions(+), 62 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 70c2dd353468..da401a75a204 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -614,11 +614,6 @@ extern enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 						     struct kvm_vcpu *vcpu,
 						     bool write_fault);
 
-extern enum emulation_result kvm_mips_handle_tlbmod(u32 cause,
-						    u32 *opc,
-						    struct kvm_run *run,
-						    struct kvm_vcpu *vcpu);
-
 extern void kvm_mips_dump_host_tlbs(void);
 extern void kvm_mips_dump_guest_tlbs(struct kvm_vcpu *vcpu);
 extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index a47f8af9193e..eaa2fa091808 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2125,37 +2125,6 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(u32 cause,
 	return EMULATE_DONE;
 }
 
-/* TLBMOD: store into address matching TLB with Dirty bit off */
-enum emulation_result kvm_mips_handle_tlbmod(u32 cause, u32 *opc,
-					     struct kvm_run *run,
-					     struct kvm_vcpu *vcpu)
-{
-	enum emulation_result er = EMULATE_DONE;
-#ifdef DEBUG
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-			(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
-	bool kernel = KVM_GUEST_KERNEL_MODE(vcpu);
-	int index;
-
-	/* If address not in the guest TLB, then we are in trouble */
-	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
-	if (index < 0) {
-		/* XXXKYMA Invalidate and retry */
-		kvm_mips_host_tlb_inv(vcpu, vcpu->arch.host_cp0_badvaddr,
-				      !kernel, kernel);
-		kvm_err("%s: host got TLBMOD for %#lx but entry not present in Guest TLB\n",
-		     __func__, entryhi);
-		kvm_mips_dump_guest_tlbs(vcpu);
-		kvm_mips_dump_host_tlbs();
-		return EMULATE_FAIL;
-	}
-#endif
-
-	er = kvm_mips_emulate_tlbmod(cause, opc, run, vcpu);
-	return er;
-}
-
 enum emulation_result kvm_mips_emulate_tlbmod(u32 cause,
 					      u32 *opc,
 					      struct kvm_run *run,
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 236390db6219..da5acd0ac005 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -159,46 +159,63 @@ static int kvm_mips_bad_access(u32 cause, u32 *opc, struct kvm_run *run,
 
 static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 {
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
 	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
 	u32 cause = vcpu->arch.host_cp0_cause;
-	enum emulation_result er = EMULATE_DONE;
-	int ret = RESUME_GUEST;
+	struct kvm_mips_tlb *tlb;
+	unsigned long entryhi;
+	int index;
 
 	if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 	    || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug("USER/KSEG23 ADDR TLB MOD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
-			  cause, opc, badvaddr);
-		er = kvm_mips_handle_tlbmod(cause, opc, run, vcpu);
+		/*
+		 * First find the mapping in the guest TLB. If the failure to
+		 * write was due to the guest TLB, it should be up to the guest
+		 * to handle it.
+		 */
+		entryhi = (badvaddr & VPN2_MASK) |
+			  (kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
+		index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
 
-		if (er == EMULATE_DONE)
-			ret = RESUME_GUEST;
-		else {
+		/*
+		 * These should never happen.
+		 * They would indicate stale host TLB entries.
+		 */
+		if (unlikely(index < 0)) {
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
+			return RESUME_HOST;
 		}
-	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
+		tlb = vcpu->arch.guest_tlb + index;
+		if (unlikely(!TLB_IS_VALID(*tlb, badvaddr))) {
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
+
 		/*
-		 * XXXKYMA: The guest kernel does not expect to get this fault
-		 * when we are not using HIGHMEM. Need to address this in a
-		 * HIGHMEM kernel
+		 * Guest entry not dirty? That would explain the TLB modified
+		 * exception. Relay that on to the guest so it can handle it.
 		 */
-		kvm_err("TLB MOD fault not handled, cause %#x, PC: %p, BadVaddr: %#lx\n",
-			cause, opc, badvaddr);
-		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = RESUME_HOST;
+		if (!TLB_IS_DIRTY(*tlb, badvaddr)) {
+			kvm_mips_emulate_tlbmod(cause, opc, run, vcpu);
+			return RESUME_GUEST;
+		}
+
+		if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, badvaddr,
+							 true))
+			/* Not writable, needs handling as MMIO */
+			return kvm_mips_bad_store(cause, opc, run, vcpu);
+		return RESUME_GUEST;
+	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
+		if (kvm_mips_handle_kseg0_tlb_fault(badvaddr, vcpu, true) < 0)
+			/* Not writable, needs handling as MMIO */
+			return kvm_mips_bad_store(cause, opc, run, vcpu);
+		return RESUME_GUEST;
 	} else {
-		kvm_err("Illegal TLB Mod fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
-			cause, opc, badvaddr);
-		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = RESUME_HOST;
+		/* host kernel addresses are all handled as MMIO */
+		return kvm_mips_bad_store(cause, opc, run, vcpu);
 	}
-	return ret;
 }
 
 static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
-- 
git-series 0.8.10

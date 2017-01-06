Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 15:46:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7122 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992278AbdAFOqGAhq0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 15:46:06 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CB7BF888C9223;
        Fri,  6 Jan 2017 14:45:56 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 14:45:59 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/3] KVM: MIPS/T&E: Don't treat code fetch faults as MMIO
Date:   Fri, 6 Jan 2017 14:44:41 +0000
Message-ID: <f6e2756cffab5376dbf1b2f2aaba106a4ceee8de.1483713106.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.bf96bfd5329a1b0bbde5c97362c9284cafcc0300.1483713106.git-series.james.hogan@imgtec.com>
References: <cover.bf96bfd5329a1b0bbde5c97362c9284cafcc0300.1483713106.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56217
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

In order to make use of the CP0_BadInstr & CP0_BadInstrP registers we
need to be a bit more careful not to treat code fetch faults as MMIO,
lest we hit an UNPREDICTABLE register value when we try to emulate the
MMIO load instruction but there was no valid instruction word available
to the hardware.

Add a kvm_is_ifetch_fault() helper to try to figure out whether a load
fault was due to a code fetch, and prevent MMIO instruction emulation in
that case.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 27 +++++++++++++++++++++++++++
 arch/mips/kvm/trap_emul.c        | 12 ++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 06bdcf215a37..3c39ccd8856e 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -640,6 +640,33 @@ void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu);
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
 
+/**
+ * kvm_is_ifetch_fault() - Find whether a TLBL exception is due to ifetch fault.
+ * @vcpu:	Virtual CPU.
+ *
+ * Returns:	Whether the TLBL exception was likely due to an instruction
+ *		fetch fault rather than a data load fault.
+ */
+static inline bool kvm_is_ifetch_fault(struct kvm_vcpu_arch *vcpu)
+{
+	unsigned long badvaddr = vcpu->host_cp0_badvaddr;
+	unsigned long epc = msk_isa16_mode(vcpu->pc);
+	u32 cause = vcpu->host_cp0_cause;
+
+	if (epc == badvaddr)
+		return true;
+
+	/*
+	 * Branches may be 32-bit or 16-bit instructions.
+	 * This isn't exact, but we don't really support MIPS16 or microMIPS yet
+	 * in KVM anyway.
+	 */
+	if ((cause & CAUSEF_BD) && badvaddr - epc <= 4)
+		return true;
+
+	return false;
+}
+
 extern enum emulation_result kvm_mips_emulate_inst(u32 cause,
 						   u32 *opc,
 						   struct kvm_run *run,
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 17e6d9bd01cf..a92772098294 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -178,6 +178,12 @@ static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 		}
 	} else if (KVM_GUEST_KERNEL_MODE(vcpu)
 		   && (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1)) {
+		/* A code fetch fault doesn't count as an MMIO */
+		if (!store && kvm_is_ifetch_fault(&vcpu->arch)) {
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
+
 		/*
 		 * With EVA we may get a TLB exception instead of an address
 		 * error when the guest performs MMIO to KSeg1 addresses.
@@ -255,6 +261,12 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 	int ret = RESUME_GUEST;
 
 	if (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1) {
+		/* A code fetch fault doesn't count as an MMIO */
+		if (kvm_is_ifetch_fault(&vcpu->arch)) {
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
+
 		kvm_debug("Emulate Load from MMIO space @ %#lx\n", badvaddr);
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
 		if (er == EMULATE_FAIL) {
-- 
git-series 0.8.10

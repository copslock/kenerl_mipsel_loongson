Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 14:05:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16226 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcITMFBGJLq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 14:05:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B3492F00761ED;
        Tue, 20 Sep 2016 13:04:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Sep 2016 13:04:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/4] KVM: MIPS: Drop other CPU ASIDs on guest MMU changes
Date:   Tue, 20 Sep 2016 13:04:35 +0100
Message-ID: <ff750c4cb2531029952254f71d028e804b84e256.1474372617.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
In-Reply-To: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
References: <cover.b4aaacd5414bd20c4eb4d53417956b268d69d1af.1474372617.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55209
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

When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
TLB entries on the local CPU. This doesn't work correctly on an SMP host
when the guest is migrated to a different physical CPU, as it could pick
up stale TLB mappings from the last time the vCPU ran on that physical
CPU.

Therefore invalidate both user and kernel host ASIDs on other CPUs,
which will cause new ASIDs to be generated when it next runs on those
CPUs.

We're careful only do do this if the TLB entry was already valid, and
only for the kernel ASID where the virtual address it mapped is outside
of the guest user address range.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10.x-
---
 arch/mips/kvm/emulate.c | 63 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index e788515f766b..43853ec6e160 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -846,6 +846,47 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 	return EMULATE_FAIL;
 }
 
+/**
+ * kvm_mips_invalidate_guest_tlb() - Indicates a change in guest MMU map.
+ * @vcpu:	VCPU with changed mappings.
+ * @tlb:	TLB entry being removed.
+ *
+ * This is called to indicate a single change in guest MMU mappings, so that we
+ * can arrange TLB flushes on this and other CPUs.
+ */
+static void kvm_mips_invalidate_guest_tlb(struct kvm_vcpu *vcpu,
+					  struct kvm_mips_tlb *tlb)
+{
+	int cpu, i;
+	bool user;
+
+	/* No need to flush for entries which are already invalid */
+	if (!((tlb->tlb_lo[0] | tlb->tlb_lo[1]) & ENTRYLO_V))
+		return;
+	/* User address space doesn't need flushing for KSeg2/3 changes */
+	user = tlb->tlb_hi < KVM_GUEST_KSEG0;
+
+	preempt_disable();
+
+	/*
+	 * Probe the shadow host TLB for the entry being overwritten, if one
+	 * matches, invalidate it
+	 */
+	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+
+	/* Invalidate the whole ASID on other CPUs */
+	cpu = smp_processor_id();
+	for_each_possible_cpu(i) {
+		if (i == cpu)
+			continue;
+		if (user)
+			vcpu->arch.guest_user_asid[i] = 0;
+		vcpu->arch.guest_kernel_asid[i] = 0;
+	}
+
+	preempt_enable();
+}
+
 /* Write Guest TLB Entry @ Index */
 enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 {
@@ -865,11 +906,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	}
 
 	tlb = &vcpu->arch.guest_tlb[index];
-	/*
-	 * Probe the shadow host TLB for the entry being overwritten, if one
-	 * matches, invalidate it
-	 */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -898,11 +936,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 	tlb = &vcpu->arch.guest_tlb[index];
 
-	/*
-	 * Probe the shadow host TLB for the entry being overwritten, if one
-	 * matches, invalidate it
-	 */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -1026,6 +1060,7 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 	enum emulation_result er = EMULATE_DONE;
 	u32 rt, rd, sel;
 	unsigned long curr_pc;
+	int cpu, i;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -1135,8 +1170,16 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 							& KVM_ENTRYHI_ASID,
 						nasid);
 
+					preempt_disable();
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
+					cpu = smp_processor_id();
+					for_each_possible_cpu(i)
+						if (i != cpu) {
+							vcpu->arch.guest_user_asid[i] = 0;
+							vcpu->arch.guest_kernel_asid[i] = 0;
+						}
+					preempt_enable();
 				}
 				kvm_write_c0_guest_entryhi(cop0,
 							   vcpu->arch.gprs[rt]);
-- 
git-series 0.8.10

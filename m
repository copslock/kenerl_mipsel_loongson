Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 15:46:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63490 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992836AbcKIOqhs1keE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 15:46:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6257DAB7C32E9;
        Wed,  9 Nov 2016 14:46:28 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 9 Nov 2016 14:46:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Jiri Slaby <jslaby@suse.cz>, <stable@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on guest MMU changes
Date:   Wed, 9 Nov 2016 14:46:24 +0000
Message-ID: <20161109144624.16683-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55747
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

commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.

When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
TLB entries on the local CPU. This doesn't work correctly on an SMP host
when the guest is migrated to a different physical CPU, as it could pick
up stale TLB mappings from the last time the vCPU ran on that physical
CPU.

Therefore invalidate both user and kernel host ASIDs on other CPUs,
which will cause new ASIDs to be generated when it next runs on those
CPUs.

We're careful only to do this if the TLB entry was already valid, and
only for the kernel ASID where the virtual address it mapped is outside
of the guest user address range.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10.x-
Cc: Jiri Slaby <jslaby@suse.cz>
[james.hogan@imgtec.com: Backport to 3.10..3.16]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
Unfortunately the original commit went in to v3.12.65 as commit
168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
already had a correct backport outstanding (sorry!). That commit should
be reverted before applying this backport to 3.12.
---
 arch/mips/kvm/kvm_mips_emul.c | 61 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 1983678883c9..d0eb34279955 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -817,6 +817,47 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 	return er;
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
+	if (!((tlb->tlb_lo0 | tlb->tlb_lo1) & MIPS3_PG_V))
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
@@ -838,10 +879,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 	}
 
 	tlb = &vcpu->arch.guest_tlb[index];
-#if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
+
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -880,10 +919,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 
 	tlb = &vcpu->arch.guest_tlb[index];
 
-#if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -926,6 +962,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 	int32_t rt, rd, copz, sel, co_bit, op;
 	uint32_t pc = vcpu->arch.pc;
 	unsigned long curr_pc;
+	int cpu, i;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -1037,8 +1074,16 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 					     ASID_MASK,
 					     vcpu->arch.gprs[rt] & ASID_MASK);
 
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
2.10.1

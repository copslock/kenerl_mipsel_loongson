Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 09:48:05 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:42470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992232AbcJQHrycu1KE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Oct 2016 09:47:54 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05972AD13;
        Mon, 17 Oct 2016 07:47:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] KVM: MIPS: Drop other CPU ASIDs on guest MMU changes
Date:   Mon, 17 Oct 2016 09:47:48 +0200
Message-Id: <20161017074748.20426-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161017074748.20426-1-jslaby@suse.cz>
References: <20161017074748.20426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips_emul.c | 57 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 9f7643874fba..8ab9958767bb 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -310,6 +310,47 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
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
@@ -332,8 +373,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 
 	tlb = &vcpu->arch.guest_tlb[index];
 #if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 #endif
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
@@ -374,8 +415,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 	tlb = &vcpu->arch.guest_tlb[index];
 
 #if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 #endif
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
@@ -419,6 +459,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 	int32_t rt, rd, copz, sel, co_bit, op;
 	uint32_t pc = vcpu->arch.pc;
 	unsigned long curr_pc;
+	int cpu, i;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -538,8 +579,16 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
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

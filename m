Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 13:41:22 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56721 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbcJNLlN7aXqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 13:41:13 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC57A93E;
        Fri, 14 Oct 2016 11:41:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.4 11/21] KVM: MIPS: Drop other CPU ASIDs on guest MMU changes
Date:   Fri, 14 Oct 2016 13:40:49 +0200
Message-Id: <20161014114025.234713460@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161014114024.667943585@linuxfoundation.org>
References: <20161014114024.667943585@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/emulate.c |   63 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 10 deletions(-)

--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -807,6 +807,47 @@ enum emulation_result kvm_mips_emul_tlbr
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
@@ -826,11 +867,8 @@ enum emulation_result kvm_mips_emul_tlbw
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
@@ -859,11 +897,7 @@ enum emulation_result kvm_mips_emul_tlbw
 
 	tlb = &vcpu->arch.guest_tlb[index];
 
-	/*
-	 * Probe the shadow host TLB for the entry being overwritten, if one
-	 * matches, invalidate it
-	 */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -982,6 +1016,7 @@ enum emulation_result kvm_mips_emulate_C
 	int32_t rt, rd, copz, sel, co_bit, op;
 	uint32_t pc = vcpu->arch.pc;
 	unsigned long curr_pc;
+	int cpu, i;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -1089,8 +1124,16 @@ enum emulation_result kvm_mips_emulate_C
 						vcpu->arch.gprs[rt]
 						& ASID_MASK);
 
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

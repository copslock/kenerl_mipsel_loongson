Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:07:44 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38097 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993035AbcKNCE3ijaJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:29 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66dD-0005pS-UO; Mon, 14 Nov 2016 02:04:24 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66dC-0000tZ-RU; Mon, 14 Nov 2016 02:04:22 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date:   Mon, 14 Nov 2016 00:14:21 +0000
Message-ID: <lsq.1479082461.470417468@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 346/346] KVM: MIPS: Drop other CPU ASIDs on guest MMU
 changes
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

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
[james.hogan@imgtec.com: Backport to 3.10..3.16]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kvm/kvm_mips_emul.c | 61 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 8 deletions(-)

--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -817,6 +817,47 @@ enum emulation_result kvm_mips_emul_tlbr
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
@@ -838,10 +879,8 @@ enum emulation_result kvm_mips_emul_tlbw
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
@@ -880,10 +919,7 @@ enum emulation_result kvm_mips_emul_tlbw
 
 	tlb = &vcpu->arch.guest_tlb[index];
 
-#if 1
-	/* Probe the shadow host TLB for the entry being overwritten, if one matches, invalidate it */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
-#endif
+	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
 
 	tlb->tlb_mask = kvm_read_c0_guest_pagemask(cop0);
 	tlb->tlb_hi = kvm_read_c0_guest_entryhi(cop0);
@@ -926,6 +962,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint
 	int32_t rt, rd, copz, sel, co_bit, op;
 	uint32_t pc = vcpu->arch.pc;
 	unsigned long curr_pc;
+	int cpu, i;
 
 	/*
 	 * Update PC and hold onto current PC in case there is
@@ -1037,8 +1074,16 @@ kvm_mips_emulate_CP0(uint32_t inst, uint
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

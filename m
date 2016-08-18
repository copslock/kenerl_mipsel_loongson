Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 11:24:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22907 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993200AbcHRJXX0RKrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 11:23:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 160C7B7ACA618;
        Thu, 18 Aug 2016 10:23:05 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 18 Aug 2016 10:23:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH BACKPORT 3.10-3.15 4/4] MIPS: KVM: Propagate kseg0/mapped tlb fault errors
Date:   Thu, 18 Aug 2016 10:22:55 +0100
Message-ID: <f985ed835cfcabe5c7f313abd1de1bb3ee8737f9.1471021142.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
References: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54594
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

commit 9b731bcfdec4c159ad2e4312e25d69221709b96a upstream.

Propagate errors from kvm_mips_handle_kseg0_tlb_fault() and
kvm_mips_handle_mapped_seg_tlb_fault(), usually triggering an internal
error since they normally indicate the guest accessed bad physical
memory or the commpage in an unexpected way.

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Fixes: e685c689f3a8 ("KVM/MIPS32: Privileged instruction/target branch emulation.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[james.hogan@imgtec.com: Backport to v3.10.y - v3.15.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/kvm/kvm_mips_emul.c | 33 ++++++++++++++++++++++++---------
 arch/mips/kvm/kvm_tlb.c       | 14 ++++++++++----
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index e3fec99941a7..090f7be2bd13 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -965,8 +965,13 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 	preempt_disable();
 	if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
 
-		if (kvm_mips_host_tlb_lookup(vcpu, va) < 0) {
-			kvm_mips_handle_kseg0_tlb_fault(va, vcpu);
+		if (kvm_mips_host_tlb_lookup(vcpu, va) < 0 &&
+		    kvm_mips_handle_kseg0_tlb_fault(va, vcpu)) {
+			kvm_err("%s: handling mapped kseg0 tlb fault for %lx, vcpu: %p, ASID: %#lx\n",
+				__func__, va, vcpu, read_c0_entryhi());
+			er = EMULATE_FAIL;
+			preempt_enable();
+			goto done;
 		}
 	} else if ((KVM_GUEST_KSEGX(va) < KVM_GUEST_KSEG0) ||
 		   KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG23) {
@@ -999,11 +1004,16 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 								run, vcpu);
 				preempt_enable();
 				goto dont_update_pc;
-			} else {
-				/* We fault an entry from the guest tlb to the shadow host TLB */
-				kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
-								     NULL,
-								     NULL);
+			}
+			/* We fault an entry from the guest tlb to the shadow host TLB */
+			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
+								 NULL, NULL)) {
+				kvm_err("%s: handling mapped seg tlb fault for %lx, index: %u, vcpu: %p, ASID: %#lx\n",
+					__func__, va, index, vcpu,
+					read_c0_entryhi());
+				er = EMULATE_FAIL;
+				preempt_enable();
+				goto done;
 			}
 		}
 	} else {
@@ -1816,8 +1826,13 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 			     tlb->tlb_hi, tlb->tlb_lo0, tlb->tlb_lo1);
 #endif
 			/* OK we have a Guest TLB entry, now inject it into the shadow host TLB */
-			kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, NULL,
-							     NULL);
+			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
+								 NULL, NULL)) {
+				kvm_err("%s: handling mapped seg tlb fault for %lx, index: %u, vcpu: %p, ASID: %#lx\n",
+					__func__, va, index, vcpu,
+					read_c0_entryhi());
+				er = EMULATE_FAIL;
+			}
 		}
 	}
 
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 7966086d4225..356b8aa03a70 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -797,10 +797,16 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 				local_irq_restore(flags);
 				return KVM_INVALID_INST;
 			}
-			kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
-							     &vcpu->arch.
-							     guest_tlb[index],
-							     NULL, NULL);
+			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
+						&vcpu->arch.guest_tlb[index],
+						NULL, NULL)) {
+				kvm_err("%s: handling mapped seg tlb fault failed for %p, index: %u, vcpu: %p, ASID: %#lx\n",
+					__func__, opc, index, vcpu,
+					read_c0_entryhi());
+				kvm_mips_dump_guest_tlbs(vcpu);
+				local_irq_restore(flags);
+				return KVM_INVALID_INST;
+			}
 			inst = *(opc);
 		}
 		local_irq_restore(flags);
-- 
git-series 0.8.8

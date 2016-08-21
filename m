Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 17:33:15 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55510 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992318AbcHUPdI0uot3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2016 17:33:08 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u7LFWGDp013308;
        Sun, 21 Aug 2016 17:32:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 053/180] MIPS: KVM: Propagate kseg0/mapped tlb fault errors
Date:   Sun, 21 Aug 2016 17:29:43 +0200
Message-Id: <1471793510-13022-54-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1471793510-13022-1-git-send-email-w@1wt.eu>
References: <1471793510-13022-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kvm/kvm_mips_emul.c | 33 ++++++++++++++++++++++++---------
 arch/mips/kvm/kvm_tlb.c       | 14 ++++++++++----
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 3308581..9f76438 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -972,8 +972,13 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
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
@@ -1006,11 +1011,16 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
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
@@ -1821,8 +1831,13 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
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
index 5a3c373..4bee439 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -926,10 +926,16 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
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
2.8.0.rc2.1.gbe9624a

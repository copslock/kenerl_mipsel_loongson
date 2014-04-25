Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 17:26:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:35626 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843058AbaDYPUqsVuAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 17:20:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E213B597642;
        Fri, 25 Apr 2014 16:20:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 16:20:44 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 25 Apr 2014 16:20:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 19/21] MIPS: KVM: Remove ifdef DEBUG around kvm_debug
Date:   Fri, 25 Apr 2014 16:20:02 +0100
Message-ID: <1398439204-26171-20-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39941
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

kvm_debug() uses pr_debug() which is already compiled out in the absence
of a DEBUG define, so remove the unnecessary ifdef DEBUG lines around
kvm_debug() calls which are littered around arch/mips/kvm/.

As well as generally cleaning up, this prevents future bit-rot due to
DEBUG not being commonly used.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_emul.c |  2 --
 arch/mips/kvm/kvm_tlb.c       | 14 --------------
 arch/mips/kvm/kvm_trap_emul.c | 12 ------------
 3 files changed, 28 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index ba7519b78985..698f4cb47d7e 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -2370,11 +2370,9 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 				er = EMULATE_FAIL;
 			}
 		} else {
-#ifdef DEBUG
 			kvm_debug
 			    ("Injecting hi: %#lx, lo0: %#lx, lo1: %#lx into shadow host TLB\n",
 			     tlb->tlb_hi, tlb->tlb_lo0, tlb->tlb_lo1);
-#endif
 			/* OK we have a Guest TLB entry, now inject it into the shadow host TLB */
 			kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, NULL,
 							     NULL);
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 53a39d32b5e0..51e7866ea893 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -232,11 +232,9 @@ kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 		tlb_write_indexed();
 	tlbw_use_hazard();
 
-#ifdef DEBUG
 	kvm_debug("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0(R): 0x%08lx, entrylo1(R): 0x%08lx\n",
 		  vcpu->arch.pc, idx, read_c0_entryhi(),
 		  read_c0_entrylo0(), read_c0_entrylo1());
-#endif
 
 	/* Flush D-cache */
 	if (flush_dcache_mask) {
@@ -343,11 +341,9 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	mtc0_tlbw_hazard();
 	tlbw_use_hazard();
 
-#ifdef DEBUG
 	kvm_debug ("@ %#lx idx: %2d [entryhi(R): %#lx] entrylo0 (R): 0x%08lx, entrylo1(R): 0x%08lx\n",
 	     vcpu->arch.pc, read_c0_index(), read_c0_entryhi(),
 	     read_c0_entrylo0(), read_c0_entrylo1());
-#endif
 
 	/* Restore old ASID */
 	write_c0_entryhi(old_entryhi);
@@ -395,10 +391,8 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 	entrylo1 = mips3_paddr_to_tlbpfn(pfn1 << PAGE_SHIFT) | (0x3 << 3) |
 			(tlb->tlb_lo1 & MIPS3_PG_D) | (tlb->tlb_lo1 & MIPS3_PG_V);
 
-#ifdef DEBUG
 	kvm_debug("@ %#lx tlb_lo0: 0x%08lx tlb_lo1: 0x%08lx\n", vcpu->arch.pc,
 		  tlb->tlb_lo0, tlb->tlb_lo1);
-#endif
 
 	return kvm_mips_host_tlb_write(vcpu, entryhi, entrylo0, entrylo1,
 				       tlb->tlb_mask);
@@ -419,10 +413,8 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 		}
 	}
 
-#ifdef DEBUG
 	kvm_debug("%s: entryhi: %#lx, index: %d lo0: %#lx, lo1: %#lx\n",
 		  __func__, entryhi, index, tlb[i].tlb_lo0, tlb[i].tlb_lo1);
-#endif
 
 	return index;
 }
@@ -456,9 +448,7 @@ int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 
 	local_irq_restore(flags);
 
-#ifdef DEBUG
 	kvm_debug("Host TLB lookup, %#lx, idx: %2d\n", vaddr, idx);
-#endif
 
 	return idx;
 }
@@ -503,11 +493,9 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	local_irq_restore(flags);
 
-#ifdef DEBUG
 	if (idx > 0)
 		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
 			  (va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu), idx);
-#endif
 
 	return 0;
 }
@@ -658,9 +646,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	unsigned long flags;
 	int newasid = 0;
 
-#ifdef DEBUG
 	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
-#endif
 
 	/* Alocate new kernel and user ASIDs if needed */
 
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 30cef8e6da81..04ed46783a45 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -32,9 +32,7 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 		gpa = KVM_INVALID_ADDR;
 	}
 
-#ifdef DEBUG
 	kvm_debug("%s: gva %#lx, gpa: %#llx\n", __func__, gva, gpa);
-#endif
 
 	return gpa;
 }
@@ -85,11 +83,9 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 
 	if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 	    || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-#ifdef DEBUG
 		kvm_debug
 		    ("USER/KSEG23 ADDR TLB MOD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
 		     cause, opc, badvaddr);
-#endif
 		er = kvm_mips_handle_tlbmod(cause, opc, run, vcpu);
 
 		if (er == EMULATE_DONE)
@@ -138,11 +134,9 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-#ifdef DEBUG
 		kvm_debug
 		    ("USER ADDR TLB LD fault: cause %#lx, PC: %p, BadVaddr: %#lx\n",
 		     cause, opc, badvaddr);
-#endif
 		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
 		if (er == EMULATE_DONE)
 			ret = RESUME_GUEST;
@@ -188,10 +182,8 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-#ifdef DEBUG
 		kvm_debug("USER ADDR TLB ST fault: PC: %#lx, BadVaddr: %#lx\n",
 			  vcpu->arch.pc, badvaddr);
-#endif
 
 		/* User Address (UA) fault, this could happen if
 		 * (1) TLB entry not present/valid in both Guest and shadow host TLBs, in this
@@ -236,9 +228,7 @@ static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 
 	if (KVM_GUEST_KERNEL_MODE(vcpu)
 	    && (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1)) {
-#ifdef DEBUG
 		kvm_debug("Emulate Store to MMIO space\n");
-#endif
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
 		if (er == EMULATE_FAIL) {
 			printk("Emulate Store to MMIO space failed\n");
@@ -268,9 +258,7 @@ static int kvm_trap_emul_handle_addr_err_ld(struct kvm_vcpu *vcpu)
 	int ret = RESUME_GUEST;
 
 	if (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1) {
-#ifdef DEBUG
 		kvm_debug("Emulate Load from MMIO space @ %#lx\n", badvaddr);
-#endif
 		er = kvm_mips_emulate_inst(cause, opc, run, vcpu);
 		if (er == EMULATE_FAIL) {
 			printk("Emulate Load from MMIO space failed\n");
-- 
1.8.1.2

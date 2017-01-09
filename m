Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:57:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59284 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993878AbdAIUxesREgP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E319A8BA789F7;
        Mon,  9 Jan 2017 20:53:23 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:27 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 9/10] KVM: MIPS/Emulate: Use lockless GVA helpers for cache emulation
Date:   Mon, 9 Jan 2017 20:52:01 +0000
Message-ID: <9817d1f5e7179b8bdd77efdd9dae359999f93d97.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56244
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

Use the lockless GVA helpers to implement the reading of guest
instructions for emulation. This will allow it to handle asynchronous
TLB flushes when they are implemented.

This is a little more complicated than the other two cases (get_inst()
and dynamic translation) due to the need to emulate the appropriate
guest TLB exception when the address isn't present or isn't valid in the
guest TLB.

Since there are several protected cache ops that may need to be
performed safely, this is abstracted by kvm_mips_guest_cache_op() which
is passed a protected cache op function pointer and takes care of the
lockless operation and fault handling / retry if the op should fail,
taking advantage of the new errors which the protected cache ops can now
return. This allows the existing advance fault handling which relied on
host TLB lookups to be removed, along with the now unused
kvm_mips_host_tlb_lookup(),

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   2 +-
 arch/mips/kvm/emulate.c          | 149 ++++++++++++++------------------
 arch/mips/kvm/tlb.c              |  35 +--------
 3 files changed, 67 insertions(+), 119 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 491689fcbaac..de20a6da5a4d 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -226,6 +226,7 @@ enum emulation_result {
 	EMULATE_FAIL,		/* can't emulate this instruction */
 	EMULATE_WAIT,		/* WAIT instruction */
 	EMULATE_PRIV_FAIL,
+	EMULATE_EXCEPT,		/* A guest exception has been generated */
 };
 
 #define mips3_paddr_to_tlbpfn(x) \
@@ -614,7 +615,6 @@ extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi,
 
 extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
 				     unsigned long entryhi);
-extern int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr);
 
 /* MMU handling */
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index b295a4a1496f..72eb307a61a7 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1697,12 +1697,57 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 	return er;
 }
 
+static enum emulation_result kvm_mips_guest_cache_op(int (*fn)(unsigned long),
+						     unsigned long curr_pc,
+						     unsigned long addr,
+						     struct kvm_run *run,
+						     struct kvm_vcpu *vcpu,
+						     u32 cause)
+{
+	int err;
+
+	for (;;) {
+		/* Carefully attempt the cache operation */
+		kvm_trap_emul_gva_lockless_begin(vcpu);
+		err = fn(addr);
+		kvm_trap_emul_gva_lockless_end(vcpu);
+
+		if (likely(!err))
+			return EMULATE_DONE;
+
+		/*
+		 * Try to handle the fault and retry, maybe we just raced with a
+		 * GVA invalidation.
+		 */
+		switch (kvm_trap_emul_gva_fault(vcpu, addr, false)) {
+		case KVM_MIPS_GVA:
+		case KVM_MIPS_GPA:
+			/* bad virtual or physical address */
+			return EMULATE_FAIL;
+		case KVM_MIPS_TLB:
+			/* no matching guest TLB */
+			vcpu->arch.host_cp0_badvaddr = addr;
+			vcpu->arch.pc = curr_pc;
+			kvm_mips_emulate_tlbmiss_ld(cause, NULL, run, vcpu);
+			return EMULATE_EXCEPT;
+		case KVM_MIPS_TLBINV:
+			/* invalid matching guest TLB */
+			vcpu->arch.host_cp0_badvaddr = addr;
+			vcpu->arch.pc = curr_pc;
+			kvm_mips_emulate_tlbinv_ld(cause, NULL, run, vcpu);
+			return EMULATE_EXCEPT;
+		default:
+			break;
+		};
+	}
+}
+
+
 enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 					     u32 *opc, u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	u32 cache, op_inst, op, base;
 	s16 offset;
@@ -1759,81 +1804,16 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 		goto done;
 	}
 
-	preempt_disable();
-	if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
-		if (kvm_mips_host_tlb_lookup(vcpu, va) < 0 &&
-		    kvm_mips_handle_kseg0_tlb_fault(va, vcpu)) {
-			kvm_err("%s: handling mapped kseg0 tlb fault for %lx, vcpu: %p, ASID: %#lx\n",
-				__func__, va, vcpu, read_c0_entryhi());
-			er = EMULATE_FAIL;
-			preempt_enable();
-			goto done;
-		}
-	} else if ((KVM_GUEST_KSEGX(va) < KVM_GUEST_KSEG0) ||
-		   KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG23) {
-		int index;
-
-		/* If an entry already exists then skip */
-		if (kvm_mips_host_tlb_lookup(vcpu, va) >= 0)
-			goto skip_fault;
-
-		/*
-		 * If address not in the guest TLB, then give the guest a fault,
-		 * the resulting handler will do the right thing
-		 */
-		index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
-						  (kvm_read_c0_guest_entryhi
-						   (cop0) & KVM_ENTRYHI_ASID));
-
-		if (index < 0) {
-			vcpu->arch.host_cp0_badvaddr = va;
-			vcpu->arch.pc = curr_pc;
-			er = kvm_mips_emulate_tlbmiss_ld(cause, NULL, run,
-							 vcpu);
-			preempt_enable();
-			goto dont_update_pc;
-		} else {
-			struct kvm_mips_tlb *tlb = &vcpu->arch.guest_tlb[index];
-			/*
-			 * Check if the entry is valid, if not then setup a TLB
-			 * invalid exception to the guest
-			 */
-			if (!TLB_IS_VALID(*tlb, va)) {
-				vcpu->arch.host_cp0_badvaddr = va;
-				vcpu->arch.pc = curr_pc;
-				er = kvm_mips_emulate_tlbinv_ld(cause, NULL,
-								run, vcpu);
-				preempt_enable();
-				goto dont_update_pc;
-			}
-			/*
-			 * We fault an entry from the guest tlb to the
-			 * shadow host TLB
-			 */
-			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
-								 va)) {
-				kvm_err("%s: handling mapped seg tlb fault for %lx, index: %u, vcpu: %p, ASID: %#lx\n",
-					__func__, va, index, vcpu,
-					read_c0_entryhi());
-				er = EMULATE_FAIL;
-				preempt_enable();
-				goto done;
-			}
-		}
-	} else {
-		kvm_err("INVALID CACHE INDEX/ADDRESS (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
-			cache, op, base, arch->gprs[base], offset);
-		er = EMULATE_FAIL;
-		preempt_enable();
-		goto done;
-
-	}
-
-skip_fault:
 	/* XXXKYMA: Only a subset of cache ops are supported, used by Linux */
 	if (op_inst == Hit_Writeback_Inv_D || op_inst == Hit_Invalidate_D) {
-		protected_writeback_dcache_line(va);
-
+		/*
+		 * Perform the dcache part of icache synchronisation on the
+		 * guest's behalf.
+		 */
+		er = kvm_mips_guest_cache_op(protected_writeback_dcache_line,
+					     curr_pc, va, run, vcpu, cause);
+		if (er != EMULATE_DONE)
+			goto done;
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 		/*
 		 * Replace the CACHE instruction, with a SYNCI, not the same,
@@ -1842,8 +1822,15 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 		kvm_mips_trans_cache_va(inst, opc, vcpu);
 #endif
 	} else if (op_inst == Hit_Invalidate_I) {
-		protected_writeback_dcache_line(va);
-		protected_flush_icache_line(va);
+		/* Perform the icache synchronisation on the guest's behalf */
+		er = kvm_mips_guest_cache_op(protected_writeback_dcache_line,
+					     curr_pc, va, run, vcpu, cause);
+		if (er != EMULATE_DONE)
+			goto done;
+		er = kvm_mips_guest_cache_op(protected_flush_icache_line,
+					     curr_pc, va, run, vcpu, cause);
+		if (er != EMULATE_DONE)
+			goto done;
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 		/* Replace the CACHE instruction, with a SYNCI */
@@ -1855,17 +1842,13 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 		er = EMULATE_FAIL;
 	}
 
-	preempt_enable();
 done:
 	/* Rollback PC only if emulation was unsuccessful */
 	if (er == EMULATE_FAIL)
 		vcpu->arch.pc = curr_pc;
-
-dont_update_pc:
-	/*
-	 * This is for exceptions whose emulation updates the PC, so do not
-	 * overwrite the PC under any circumstances
-	 */
+	/* Guest exception needs guest to resume */
+	if (er == EMULATE_EXCEPT)
+		er = EMULATE_DONE;
 
 	return er;
 }
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 4b0528361f56..085f8f48233e 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -117,41 +117,6 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_guest_tlb_lookup);
 
-int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
-{
-	unsigned long old_entryhi, flags;
-	int idx;
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
-
-	if (KVM_GUEST_KERNEL_MODE(vcpu))
-		write_c0_entryhi((vaddr & VPN2_MASK) |
-				 kvm_mips_get_kernel_asid(vcpu));
-	else {
-		write_c0_entryhi((vaddr & VPN2_MASK) |
-				 kvm_mips_get_user_asid(vcpu));
-	}
-
-	mtc0_tlbw_hazard();
-
-	tlb_probe();
-	tlb_probe_hazard();
-	idx = read_c0_index();
-
-	/* Restore old ASID */
-	write_c0_entryhi(old_entryhi);
-	mtc0_tlbw_hazard();
-
-	local_irq_restore(flags);
-
-	kvm_debug("Host TLB lookup, %#lx, idx: %2d\n", vaddr, idx);
-
-	return idx;
-}
-EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_lookup);
-
 static int _kvm_mips_host_tlb_inv(unsigned long entryhi)
 {
 	int idx;
-- 
git-series 0.8.10

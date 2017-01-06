Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:45:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59399 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993139AbdAFBd5Ykofu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 15029B45F10E8;
        Fri,  6 Jan 2017 01:33:48 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:48 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 26/30] KVM: MIPS: Use uaccess to read/modify guest instructions
Date:   Fri, 6 Jan 2017 01:32:58 +0000
Message-ID: <76070a2afba788c8e5fc5067edf53b802d3c87bf.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56201
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

Now that we have GVA page tables, use standard user accesses with page
faults disabled to read & modify guest instructions. This should be more
robust (than the rather dodgy method of accessing guest mapped segments
by just directly addressing them) and will also work with Enhanced
Virtual Addressing (EVA) host kernel configurations where dedicated
instructions are needed for accessing user mode memory.

For simplicity and speed we do this regardless of the guest segment the
address resides in, rather than handling guest KSeg0 specially with
kmap_atomic() as before.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/mips/kvm/dyntrans.c         | 28 +++---------
 arch/mips/kvm/mmu.c              | 77 ++-------------------------------
 arch/mips/kvm/trap_emul.c        |  9 ++++-
 4 files changed, 22 insertions(+), 94 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f4e9bb04350e..1191b3002773 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -636,8 +636,6 @@ void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
 				  bool user);
-extern unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
-						   unsigned long gva);
 extern void kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 				    struct kvm_vcpu *vcpu);
 extern void kvm_local_flush_tlb_all(void);
diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index 010cef240688..60ebf5862d2b 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/kvm_host.h>
+#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/bootmem.h>
@@ -29,28 +30,15 @@
 static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc,
 				  union mips_instruction replace)
 {
-	unsigned long paddr, flags;
-	void *vaddr;
-
-	if (KVM_GUEST_KSEGX((unsigned long)opc) == KVM_GUEST_KSEG0) {
-		paddr = kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
-							    (unsigned long)opc);
-		vaddr = kmap_atomic(pfn_to_page(PHYS_PFN(paddr)));
-		vaddr += paddr & ~PAGE_MASK;
-		memcpy(vaddr, (void *)&replace, sizeof(u32));
-		local_flush_icache_range((unsigned long)vaddr,
-					 (unsigned long)vaddr + 32);
-		kunmap_atomic(vaddr);
-	} else if (KVM_GUEST_KSEGX((unsigned long) opc) == KVM_GUEST_KSEG23) {
-		local_irq_save(flags);
-		memcpy((void *)opc, (void *)&replace, sizeof(u32));
-		__local_flush_icache_user_range((unsigned long)opc,
-						(unsigned long)opc + 32);
-		local_irq_restore(flags);
-	} else {
+	unsigned long vaddr = (unsigned long)opc;
+	int err;
+
+	err = put_user(replace.word, opc);
+	if (unlikely(err)) {
 		kvm_err("%s: Invalid address: %p\n", __func__, opc);
-		return -EFAULT;
+		return err;
 	}
+	__local_flush_icache_user_range(vaddr, vaddr + 4);
 
 	return 0;
 }
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 98f1a7715a68..c4e9c65065ea 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -11,6 +11,7 @@
 
 #include <linux/highmem.h>
 #include <linux/kvm_host.h>
+#include <linux/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
@@ -134,34 +135,6 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
 	return err;
 }
 
-/* Translate guest KSEG0 addresses to Host PA */
-unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
-						    unsigned long gva)
-{
-	gfn_t gfn;
-	unsigned long offset = gva & ~PAGE_MASK;
-	struct kvm *kvm = vcpu->kvm;
-
-	if (KVM_GUEST_KSEGX(gva) != KVM_GUEST_KSEG0) {
-		kvm_err("%s/%p: Invalid gva: %#lx\n", __func__,
-			__builtin_return_address(0), gva);
-		return KVM_INVALID_PAGE;
-	}
-
-	gfn = (KVM_GUEST_CPHYSADDR(gva) >> PAGE_SHIFT);
-
-	if (gfn >= kvm->arch.guest_pmap_npages) {
-		kvm_err("%s: Invalid gfn: %#llx, GVA: %#lx\n", __func__, gfn,
-			gva);
-		return KVM_INVALID_PAGE;
-	}
-
-	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
-		return KVM_INVALID_ADDR;
-
-	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
-}
-
 static pte_t *kvm_trap_emul_pte_for_gva(struct kvm_vcpu *vcpu,
 					unsigned long addr)
 {
@@ -551,51 +524,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	unsigned long paddr, flags, vpn2, asid;
-	unsigned long va = (unsigned long)opc;
-	void *vaddr;
 	u32 inst;
-	int index;
-
-	if (KVM_GUEST_KSEGX(va) < KVM_GUEST_KSEG0 ||
-	    KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG23) {
-		local_irq_save(flags);
-		index = kvm_mips_host_tlb_lookup(vcpu, va);
-		if (index >= 0) {
-			inst = *(opc);
-		} else {
-			vpn2 = va & VPN2_MASK;
-			asid = kvm_read_c0_guest_entryhi(cop0) &
-						KVM_ENTRYHI_ASID;
-			index = kvm_mips_guest_tlb_lookup(vcpu, vpn2 | asid);
-			if (index < 0) {
-				kvm_err("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
-					__func__, opc, vcpu, read_c0_entryhi());
-				kvm_mips_dump_host_tlbs();
-				kvm_mips_dump_guest_tlbs(vcpu);
-				local_irq_restore(flags);
-				return KVM_INVALID_INST;
-			}
-			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu,
-					&vcpu->arch.guest_tlb[index], va)) {
-				kvm_err("%s: handling mapped seg tlb fault failed for %p, index: %u, vcpu: %p, ASID: %#lx\n",
-					__func__, opc, index, vcpu,
-					read_c0_entryhi());
-				kvm_mips_dump_guest_tlbs(vcpu);
-				local_irq_restore(flags);
-				return KVM_INVALID_INST;
-			}
-			inst = *(opc);
-		}
-		local_irq_restore(flags);
-	} else if (KVM_GUEST_KSEGX(va) == KVM_GUEST_KSEG0) {
-		paddr = kvm_mips_translate_guest_kseg0_to_hpa(vcpu, va);
-		vaddr = kmap_atomic(pfn_to_page(PHYS_PFN(paddr)));
-		vaddr += paddr & ~PAGE_MASK;
-		inst = *(u32 *)vaddr;
-		kunmap_atomic(vaddr);
-	} else {
+	int err;
+
+	err = get_user(inst, opc);
+	if (unlikely(err)) {
 		kvm_err("%s: illegal address: %p\n", __func__, opc);
 		return KVM_INVALID_INST;
 	}
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 087f73dfec9f..7b6ccd2ce26b 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
+#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
@@ -800,6 +801,12 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 	kvm_trap_emul_vcpu_reenter(run, vcpu);
 
+	/*
+	 * We use user accessors to access guest memory, but we don't want to
+	 * invoke Linux page faulting.
+	 */
+	pagefault_disable();
+
 	/* Disable hardware page table walking while in guest */
 	htw_stop();
 
@@ -827,6 +834,8 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 	htw_start();
 
+	pagefault_enable();
+
 	return r;
 }
 
-- 
git-series 0.8.10

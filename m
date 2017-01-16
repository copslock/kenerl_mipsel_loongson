Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:50:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24760 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993021AbdAPMtuZa9Nk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:50 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3FEA5A1DC786C;
        Mon, 16 Jan 2017 12:49:40 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:43 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/13] KVM: MIPS: Pass type of fault down to kvm_mips_map_page()
Date:   Mon, 16 Jan 2017 12:49:23 +0000
Message-ID: <f720e8075ed761779d325bd968b5d51c97c85793.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56321
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

kvm_mips_map_page() will need to know whether the fault was due to a
read or a write in order to support dirty page tracking,
KVM_CAP_SYNC_MMU, and read only memory regions, so get that information
passed down to it via new bool write_fault arguments to various
functions.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  9 ++++++---
 arch/mips/kvm/emulate.c          |  7 ++++---
 arch/mips/kvm/mmu.c              | 21 +++++++++++++--------
 arch/mips/kvm/trap_emul.c        |  4 ++--
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c24c1c23196b..70c2dd353468 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -597,19 +597,22 @@ u32 kvm_get_user_asid(struct kvm_vcpu *vcpu);
 u32 kvm_get_commpage_asid (struct kvm_vcpu *vcpu);
 
 extern int kvm_mips_handle_kseg0_tlb_fault(unsigned long badbaddr,
-					   struct kvm_vcpu *vcpu);
+					   struct kvm_vcpu *vcpu,
+					   bool write_fault);
 
 extern int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 					      struct kvm_vcpu *vcpu);
 
 extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 						struct kvm_mips_tlb *tlb,
-						unsigned long gva);
+						unsigned long gva,
+						bool write_fault);
 
 extern enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 						     u32 *opc,
 						     struct kvm_run *run,
-						     struct kvm_vcpu *vcpu);
+						     struct kvm_vcpu *vcpu,
+						     bool write_fault);
 
 extern enum emulation_result kvm_mips_handle_tlbmod(u32 cause,
 						    u32 *opc,
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 72eb307a61a7..a47f8af9193e 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -2705,7 +2705,8 @@ enum emulation_result kvm_mips_check_privilege(u32 cause,
 enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 					      u32 *opc,
 					      struct kvm_run *run,
-					      struct kvm_vcpu *vcpu)
+					      struct kvm_vcpu *vcpu,
+					      bool write_fault)
 {
 	enum emulation_result er = EMULATE_DONE;
 	u32 exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
@@ -2761,8 +2762,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(u32 cause,
 			 * OK we have a Guest TLB entry, now inject it into the
 			 * shadow host TLB
 			 */
-			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb,
-								 va)) {
+			if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, va,
+								 write_fault)) {
 				kvm_err("%s: handling mapped seg tlb fault for %lx, index: %u, vcpu: %p, ASID: %#lx\n",
 					__func__, va, index, vcpu,
 					read_c0_entryhi());
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index b3da473e1569..1af65f2e6bb7 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -308,6 +308,7 @@ bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
  * kvm_mips_map_page() - Map a guest physical page.
  * @vcpu:		VCPU pointer.
  * @gpa:		Guest physical address of fault.
+ * @write_fault:	Whether the fault was due to a write.
  * @out_entry:		New PTE for @gpa (written on success unless NULL).
  * @out_buddy:		New PTE for @gpa's buddy (written on success unless
  *			NULL).
@@ -327,6 +328,7 @@ bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
  *		as an MMIO access.
  */
 static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
+			     bool write_fault,
 			     pte_t *out_entry, pte_t *out_buddy)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -558,7 +560,8 @@ void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags)
 
 /* XXXKYMA: Must be called with interrupts disabled */
 int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
-				    struct kvm_vcpu *vcpu)
+				    struct kvm_vcpu *vcpu,
+				    bool write_fault)
 {
 	unsigned long gpa;
 	kvm_pfn_t pfn0, pfn1;
@@ -576,10 +579,11 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	gpa = KVM_GUEST_CPHYSADDR(badvaddr & (PAGE_MASK << 1));
 	vaddr = badvaddr & (PAGE_MASK << 1);
 
-	if (kvm_mips_map_page(vcpu, gpa, &pte_gpa[0], NULL) < 0)
+	if (kvm_mips_map_page(vcpu, gpa, write_fault, &pte_gpa[0], NULL) < 0)
 		return -1;
 
-	if (kvm_mips_map_page(vcpu, gpa | PAGE_SIZE, &pte_gpa[1], NULL) < 0)
+	if (kvm_mips_map_page(vcpu, gpa | PAGE_SIZE, write_fault, &pte_gpa[1],
+			      NULL) < 0)
 		return -1;
 
 	pfn0 = pte_pfn(pte_gpa[0]);
@@ -604,7 +608,8 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 
 int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 					 struct kvm_mips_tlb *tlb,
-					 unsigned long gva)
+					 unsigned long gva,
+					 bool write_fault)
 {
 	kvm_pfn_t pfn;
 	long tlb_lo = 0;
@@ -621,8 +626,8 @@ int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 		tlb_lo = tlb->tlb_lo[idx];
 
 	/* Find host PFN */
-	if (kvm_mips_map_page(vcpu, mips3_tlbpfn_to_paddr(tlb_lo), &pte_gpa,
-			      NULL) < 0)
+	if (kvm_mips_map_page(vcpu, mips3_tlbpfn_to_paddr(tlb_lo), write_fault,
+			      &pte_gpa, NULL) < 0)
 		return -1;
 	pfn = pte_pfn(pte_gpa);
 
@@ -757,7 +762,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 	int index;
 
 	if (KVM_GUEST_KSEGX(gva) == KVM_GUEST_KSEG0) {
-		if (kvm_mips_handle_kseg0_tlb_fault(gva, vcpu) < 0)
+		if (kvm_mips_handle_kseg0_tlb_fault(gva, vcpu, write) < 0)
 			return KVM_MIPS_GPA;
 	} else if ((KVM_GUEST_KSEGX(gva) < KVM_GUEST_KSEG0) ||
 		   KVM_GUEST_KSEGX(gva) == KVM_GUEST_KSEG23) {
@@ -774,7 +779,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 		if (write && !TLB_IS_DIRTY(*tlb, gva))
 			return KVM_MIPS_TLBMOD;
 
-		if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, gva))
+		if (kvm_mips_handle_mapped_seg_tlb_fault(vcpu, tlb, gva, write))
 			return KVM_MIPS_GPA;
 	} else {
 		return KVM_MIPS_GVA;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 970ab216b355..33888f1a89f4 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -159,7 +159,7 @@ static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 		 *     into the shadow host TLB
 		 */
 
-		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
+		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu, store);
 		if (er == EMULATE_DONE)
 			ret = RESUME_GUEST;
 		else {
@@ -172,7 +172,7 @@ static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 		 * not expect to ever get them
 		 */
 		if (kvm_mips_handle_kseg0_tlb_fault
-		    (vcpu->arch.host_cp0_badvaddr, vcpu) < 0) {
+		    (vcpu->arch.host_cp0_badvaddr, vcpu, store) < 0) {
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		}
-- 
git-series 0.8.10

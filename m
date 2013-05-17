Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 23:26:35 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:43944 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835016Ab3EQVZr5KYSL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 May 2013 23:25:47 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 17 May 2013 14:25:36 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 33E6A630052; Fri, 17 May 2013 14:25:20 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 3/3] KVM/MIPS32: Fix up KVM breakage caused by d532f3d26716a39dfd4b88d687bd344fbe77e390 which allows ASID mask and increment to be determined @ runtime.
Date:   Fri, 17 May 2013 14:25:12 -0700
Message-Id: <1368825912-23562-4-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

The ASID paramters have default values which are then patched @ runtime
as part of the TLB initialization.  The fixup does not work since KVM
is a kernel module and we end up with the default mask of 0xfc0 instead of
the standard ASID mask of 0xff for MIPS32R2 processors.

I've posted the issue on the MIPS mailing list and until a solution is found,
For now define KVM_ASID_MASK as 0xFF to fix this issue up for Linux 3.10.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h |  5 +++++
 arch/mips/kvm/kvm_mips_emul.c    | 22 +++++++++++-----------
 arch/mips/kvm/kvm_tlb.c          | 20 ++++++++++----------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index e68781e..747c193 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -71,6 +71,11 @@
 #define CAUSEB_DC       27
 #define CAUSEF_DC       (_ULCAST_(1)   << 27)
 
+/* KVM supports MIPS32R2 and beyond, so ASID_MASK is always 0xFF.
+ * This is to work around the bug introduced by commit d532f3d26716a39dfd4b88d687bd344fbe77e390
+ */
+#define KVM_ASID_MASK(x) ((x) & 0xFF)
+
 struct kvm;
 struct kvm_run;
 struct kvm_vcpu;
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 2b2bac9..b8eee34 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -525,16 +525,16 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				printk("MTCz, cop0->reg[EBASE]: %#lx\n",
 				       kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
-				uint32_t nasid = ASID_MASK(vcpu->arch.gprs[rt]);
+				uint32_t nasid = KVM_ASID_MASK(vcpu->arch.gprs[rt]);
 				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0)
 				    &&
-				    (ASID_MASK(kvm_read_c0_guest_entryhi(cop0))
+				    (KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0))
 				      != nasid)) {
 
 					kvm_debug
 					    ("MTCz, change ASID from %#lx to %#lx\n",
-					     ASID_MASK(kvm_read_c0_guest_entryhi(cop0)),
-					     ASID_MASK(vcpu->arch.gprs[rt]));
+					     KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0)),
+					     KVM_ASID_MASK(vcpu->arch.gprs[rt]));
 
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
@@ -986,7 +986,7 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		 * resulting handler will do the right thing
 		 */
 		index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
-						  ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
+						  KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
 
 		if (index < 0) {
 			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
@@ -1151,7 +1151,7 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.  host_cp0_badvaddr & VPN2_MASK) |
-				ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+				KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1198,7 +1198,7 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi =
 		(vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+		KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1243,7 +1243,7 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+				KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1287,7 +1287,7 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+		KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1356,7 +1356,7 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
+				KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1783,7 +1783,7 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu,
 					  (va & VPN2_MASK) |
-					  ASID_MASK(kvm_read_c0_guest_entryhi
+					  KVM_ASID_MASK(kvm_read_c0_guest_entryhi
 					   (vcpu->arch.cop0)));
 	if (index < 0) {
 		if (exccode == T_TLB_LD_MISS) {
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index ab2e9b0..2a02051 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -54,13 +54,13 @@ EXPORT_SYMBOL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
-	return ASID_MASK(vcpu->arch.guest_kernel_asid[smp_processor_id()]);
+	return KVM_ASID_MASK(vcpu->arch.guest_kernel_asid[smp_processor_id()]);
 }
 
 
 uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
-	return ASID_MASK(vcpu->arch.guest_user_asid[smp_processor_id()]);
+	return KVM_ASID_MASK(vcpu->arch.guest_user_asid[smp_processor_id()]);
 }
 
 inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
@@ -87,7 +87,7 @@ void kvm_mips_dump_host_tlbs(void)
 	old_pagemask = read_c0_pagemask();
 
 	printk("HOST TLBs:\n");
-	printk("ASID: %#lx\n", ASID_MASK(read_c0_entryhi()));
+	printk("ASID: %#lx\n", KVM_ASID_MASK(read_c0_entryhi()));
 
 	for (i = 0; i < current_cpu_data.tlbsize; i++) {
 		write_c0_index(i);
@@ -446,7 +446,7 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
 		if (((TLB_VPN2(tlb[i]) & ~tlb[i].tlb_mask) == ((entryhi & VPN2_MASK) & ~tlb[i].tlb_mask)) &&
-			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == ASID_MASK(entryhi)))) {
+			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == KVM_ASID_MASK(entryhi)))) {
 			index = i;
 			break;
 		}
@@ -539,7 +539,7 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 #ifdef DEBUG
 	if (idx > 0) {
 		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
-			  (va & VPN2_MASK) | (vcpu->arch.asid_map[va & ASID_MASK] & ASID_MASK), idx);
+			  (va & VPN2_MASK) | (vcpu->arch.asid_map[va & KVM_ASID_MASK] & KVM_ASID_MASK), idx);
 	}
 #endif
 
@@ -644,7 +644,7 @@ kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 {
 	unsigned long asid = asid_cache(cpu);
 
-	if (!(ASID_MASK(ASID_INC(asid)))) {
+	if (!KVM_ASID_MASK((asid = ASID_INC(asid)))) {
 		if (cpu_has_vtag_icache) {
 			flush_icache_all();
 		}
@@ -822,7 +822,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (!newasid) {
 		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
 		if (current->flags & PF_VCPU) {
-			write_c0_entryhi(ASID_MASK(vcpu->arch.preempt_entryhi));
+			write_c0_entryhi(KVM_ASID_MASK(vcpu->arch.preempt_entryhi));
 			ehb();
 		}
 	} else {
@@ -834,10 +834,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		if (current->flags & PF_VCPU) {
 			if (KVM_GUEST_KERNEL_MODE(vcpu))
-				write_c0_entryhi(ASID_MASK(vcpu->arch.
+				write_c0_entryhi(KVM_ASID_MASK(vcpu->arch.
 						 guest_kernel_asid[cpu]));
 			else
-				write_c0_entryhi(ASID_MASK(vcpu->arch.
+				write_c0_entryhi(KVM_ASID_MASK(vcpu->arch.
 						 guest_user_asid[cpu]));
 			ehb();
 		}
@@ -897,7 +897,7 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 			    kvm_mips_guest_tlb_lookup(vcpu,
 						      ((unsigned long) opc & VPN2_MASK)
 						      |
-						      ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
+						      KVM_ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
 			if (index < 0) {
 				kvm_err
 				    ("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
-- 
1.7.11.3

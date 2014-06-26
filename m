Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 21:13:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44757 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860046AbaFZTMbaqrM0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 21:12:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E507E43A6144C;
        Thu, 26 Jun 2014 20:12:19 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 26 Jun
 2014 20:12:23 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 26 Jun 2014 20:12:23 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 26 Jun
 2014 12:12:14 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 3/7] MIPS: KVM: Simplify functions by removing redundancy
Date:   Thu, 26 Jun 2014 12:11:36 -0700
Message-ID: <1403809900-17454-4-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

No logic changes inside.

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Changes:
v3 - v2:
o Add err removal in kvm_arch_commit_memory_region().
o Revert the changes to kvm_arch_vm_ioctl().

 arch/mips/include/asm/kvm_host.h  |  2 +-
 arch/mips/kvm/kvm_mips.c          | 18 ++++--------------
 arch/mips/kvm/kvm_mips_commpage.c |  2 --
 arch/mips/kvm/kvm_mips_emul.c     | 34 +++++++++++-----------------------
 arch/mips/kvm/kvm_mips_stats.c    |  4 +---
 5 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 3f813f2..7a3fc67 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -764,7 +764,7 @@ extern int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc,
 			       struct kvm_vcpu *vcpu);
 
 /* Misc */
-extern int kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
+extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
 extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
 
 
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 330b3af..289b4d2 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -97,9 +97,7 @@ void kvm_arch_hardware_unsetup(void)
 
 void kvm_arch_check_processor_compat(void *rtn)
 {
-	int *r = (int *)rtn;
-	*r = 0;
-	return;
+	*(int *)rtn = 0;
 }
 
 static void kvm_mips_init_tlbs(struct kvm *kvm)
@@ -225,7 +223,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   enum kvm_mr_change change)
 {
 	unsigned long npages = 0;
-	int i, err = 0;
+	int i;
 
 	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
 		  __func__, kvm, mem->slot, mem->guest_phys_addr,
@@ -243,8 +241,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 			if (!kvm->arch.guest_pmap) {
 				kvm_err("Failed to allocate guest PMAP");
-				err = -ENOMEM;
-				goto out;
+				return;
 			}
 
 			kvm_debug("Allocated space for Guest PMAP Table (%ld pages) @ %p\n",
@@ -255,8 +252,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				kvm->arch.guest_pmap[i] = KVM_INVALID_PAGE;
 		}
 	}
-out:
-	return;
 }
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
@@ -845,16 +840,12 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 
 int kvm_arch_init(void *opaque)
 {
-	int ret;
-
 	if (kvm_mips_callbacks) {
 		kvm_err("kvm: module already exists\n");
 		return -EEXIST;
 	}
 
-	ret = kvm_mips_emulation_init(&kvm_mips_callbacks);
-
-	return ret;
+	return kvm_mips_emulation_init(&kvm_mips_callbacks);
 }
 
 void kvm_arch_exit(void)
@@ -1008,7 +999,6 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 {
-	return;
 }
 
 int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/kvm_mips_commpage.c
index ab7096e..4b5612b 100644
--- a/arch/mips/kvm/kvm_mips_commpage.c
+++ b/arch/mips/kvm/kvm_mips_commpage.c
@@ -33,6 +33,4 @@ void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
 	/* Specific init values for fields */
 	vcpu->arch.cop0 = &page->cop0;
 	memset(vcpu->arch.cop0, 0, sizeof(struct mips_coproc));
-
-	return;
 }
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index bdd1421..f9b4f0f 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -761,8 +761,6 @@ enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
 
 enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 {
-	enum emulation_result er = EMULATE_DONE;
-
 	kvm_debug("[%#lx] !!!WAIT!!! (%#lx)\n", vcpu->arch.pc,
 		  vcpu->arch.pending_exceptions);
 
@@ -782,7 +780,7 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	return er;
+	return EMULATE_DONE;
 }
 
 /*
@@ -792,11 +790,10 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	enum emulation_result er = EMULATE_FAIL;
 	uint32_t pc = vcpu->arch.pc;
 
 	kvm_err("[%#x] COP0_TLBR [%ld]\n", pc, kvm_read_c0_guest_index(cop0));
-	return er;
+	return EMULATE_FAIL;
 }
 
 /* Write Guest TLB Entry @ Index */
@@ -804,7 +801,6 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int index = kvm_read_c0_guest_index(cop0);
-	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
 	uint32_t pc = vcpu->arch.pc;
 
@@ -836,14 +832,13 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
 		  kvm_read_c0_guest_entrylo1(cop0),
 		  kvm_read_c0_guest_pagemask(cop0));
 
-	return er;
+	return EMULATE_DONE;
 }
 
 /* Write Guest TLB Entry @ Random Index */
 enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	enum emulation_result er = EMULATE_DONE;
 	struct kvm_mips_tlb *tlb = NULL;
 	uint32_t pc = vcpu->arch.pc;
 	int index;
@@ -874,14 +869,13 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 		  kvm_read_c0_guest_entrylo0(cop0),
 		  kvm_read_c0_guest_entrylo1(cop0));
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	long entryhi = kvm_read_c0_guest_entryhi(cop0);
-	enum emulation_result er = EMULATE_DONE;
 	uint32_t pc = vcpu->arch.pc;
 	int index = -1;
 
@@ -892,7 +886,7 @@ enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
 	kvm_debug("[%#x] COP0_TLBP (entryhi: %#lx), index: %d\n", pc, entryhi,
 		  index);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
@@ -1638,7 +1632,6 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.  host_cp0_badvaddr & VPN2_MASK) |
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
@@ -1675,7 +1668,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
 	/* Blow away the shadow host TLBs */
 	kvm_mips_flush_host_tlb(1);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
@@ -1685,7 +1678,6 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi =
 		(vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
 		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
@@ -1722,7 +1714,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
 	/* Blow away the shadow host TLBs */
 	kvm_mips_flush_host_tlb(1);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
@@ -1732,7 +1724,6 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
@@ -1767,7 +1758,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
 	/* Blow away the shadow host TLBs */
 	kvm_mips_flush_host_tlb(1);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
@@ -1777,7 +1768,6 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
 		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 
@@ -1812,7 +1802,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
 	/* Blow away the shadow host TLBs */
 	kvm_mips_flush_host_tlb(1);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 /* TLBMOD: store into address matching TLB with Dirty bit off */
@@ -1853,7 +1843,6 @@ enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
 				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	enum emulation_result er = EMULATE_DONE;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1884,7 +1873,7 @@ enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
 	/* Blow away the shadow host TLBs */
 	kvm_mips_flush_host_tlb(1);
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
@@ -1894,7 +1883,6 @@ enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
-	enum emulation_result er = EMULATE_DONE;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1914,7 +1902,7 @@ enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
 				  (T_COP_UNUSABLE << CAUSEB_EXCCODE));
 	kvm_change_c0_guest_cause(cop0, (CAUSEF_CE), (0x1 << CAUSEB_CE));
 
-	return er;
+	return EMULATE_DONE;
 }
 
 enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
index 1ae9f88..a74d602 100644
--- a/arch/mips/kvm/kvm_mips_stats.c
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -63,7 +63,7 @@ char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
 	"DESAVE"
 };
 
-int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
+void kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
 	int i, j;
@@ -77,6 +77,4 @@ int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 		}
 	}
 #endif
-
-	return 0;
 }
-- 
1.8.5.3

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:09:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14868 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993920AbdBBMFIDS0Ev (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:08 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id ED571520146D4;
        Thu,  2 Feb 2017 12:05:02 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 17/30] KVM: MIPS: Add fast path TLB refill handler
Date:   Thu, 2 Feb 2017 12:04:30 +0000
Message-ID: <ab0bef77b53d5c9110206a8e3bb2de50dbcf1023.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56599
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

Use functions from the general MIPS TLB exception vector generation code
(tlbex.c) to construct a fast path TLB refill handler similar to the
general one, but cut down and capable of preserving K0 and K1.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  1 +-
 arch/mips/kvm/entry.c            | 78 +++++++++++++++++++++++++++++++++-
 arch/mips/kvm/mips.c             |  8 +--
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index fea538fc5331..80928ffa0150 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -554,6 +554,7 @@ extern int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu);
 /* Building of entry/exception code */
 int kvm_mips_entry_setup(void);
 void *kvm_mips_build_vcpu_run(void *addr);
+void *kvm_mips_build_tlb_refill_exception(void *addr, void *handler);
 void *kvm_mips_build_exception(void *addr, void *handler);
 void *kvm_mips_build_exit(void *addr);
 
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 7424d3d566ff..1ae33e0e675c 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -16,6 +16,7 @@
 #include <asm/mmu_context.h>
 #include <asm/msa.h>
 #include <asm/setup.h>
+#include <asm/tlbex.h>
 #include <asm/uasm.h>
 
 /* Register names */
@@ -122,6 +123,9 @@ int kvm_mips_entry_setup(void)
 	 */
 	unsigned int kscratch_mask = cpu_data[0].kscratch_mask;
 
+	if (pgd_reg != -1)
+		kscratch_mask &= ~BIT(pgd_reg);
+
 	/* Pick a scratch register for storing VCPU */
 	if (kscratch_mask) {
 		scratch_vcpu[0] = c0_kscratch();
@@ -381,6 +385,80 @@ static void *kvm_mips_build_enter_guest(void *addr)
 }
 
 /**
+ * kvm_mips_build_tlb_refill_exception() - Assemble TLB refill handler.
+ * @addr:	Address to start writing code.
+ * @handler:	Address of common handler (within range of @addr).
+ *
+ * Assemble TLB refill exception fast path handler for guest execution.
+ *
+ * Returns:	Next address after end of written function.
+ */
+void *kvm_mips_build_tlb_refill_exception(void *addr, void *handler)
+{
+	u32 *p = addr;
+	struct uasm_label labels[2];
+	struct uasm_reloc relocs[2];
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	/* Save guest k1 into scratch register */
+	UASM_i_MTC0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
+
+	/* Get the VCPU pointer from the VCPU scratch register */
+	UASM_i_MFC0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
+
+	/* Save guest k0 into VCPU structure */
+	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu, arch.gprs[K0]), K1);
+
+	/*
+	 * Some of the common tlbex code uses current_cpu_type(). For KVM we
+	 * assume symmetry and just disable preemption to silence the warning.
+	 */
+	preempt_disable();
+
+	/*
+	 * Now for the actual refill bit. A lot of this can be common with the
+	 * Linux TLB refill handler, however we don't need to handle so many
+	 * cases. We only need to handle user mode refills, and user mode runs
+	 * with 32-bit addressing.
+	 *
+	 * Therefore the branch to label_vmalloc generated by build_get_pmde64()
+	 * that isn't resolved should never actually get taken and is harmless
+	 * to leave in place for now.
+	 */
+
+#ifdef CONFIG_64BIT
+	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
+#else
+	build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
+#endif
+
+	/* we don't support huge pages yet */
+
+	build_get_ptep(&p, K0, K1);
+	build_update_entries(&p, K0, K1);
+	build_tlb_write_entry(&p, &l, &r, tlb_random);
+
+	preempt_enable();
+
+	/* Get the VCPU pointer from the VCPU scratch register again */
+	UASM_i_MFC0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
+
+	/* Restore the guest's k0/k1 registers */
+	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu, arch.gprs[K0]), K1);
+	uasm_i_ehb(&p);
+	UASM_i_MFC0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
+
+	/* Jump to guest */
+	uasm_i_eret(&p);
+
+	return p;
+}
+
+/**
  * kvm_mips_build_exception() - Assemble first level guest exception handler.
  * @addr:	Address to start writing code.
  * @handler:	Address of common handler (within range of @addr).
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 39792ec73a6d..3cf720790ce6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -264,7 +264,7 @@ static inline void dump_handler(const char *symbol, void *start, void *end)
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	int err, size;
-	void *gebase, *p, *handler;
+	void *gebase, *p, *handler, *refill_start, *refill_end;
 	int i;
 
 	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
@@ -317,8 +317,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	/* Build guest exception vectors dynamically in unmapped memory */
 	handler = gebase + 0x2000;
 
-	/* TLB Refill, EXL = 0 */
-	kvm_mips_build_exception(gebase, handler);
+	/* TLB refill */
+	refill_start = gebase;
+	refill_end = kvm_mips_build_tlb_refill_exception(refill_start, handler);
 
 	/* General Exception Entry point */
 	kvm_mips_build_exception(gebase + 0x180, handler);
@@ -344,6 +345,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	pr_debug("#include <asm/regdef.h>\n");
 	pr_debug("\n");
 	dump_handler("kvm_vcpu_run", vcpu->arch.vcpu_run, p);
+	dump_handler("kvm_tlb_refill", refill_start, refill_end);
 	dump_handler("kvm_gen_exc", gebase + 0x180, gebase + 0x200);
 	dump_handler("kvm_exit", gebase + 0x2000, vcpu->arch.vcpu_run);
 
-- 
git-series 0.8.10

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:51:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26536 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993875AbdAPMtzBWAQk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6718853E0C9AE;
        Mon, 16 Jan 2017 12:49:43 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:46 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 6/13] KVM: MIPS/MMU: Add GPA PT mkclean helper
Date:   Mon, 16 Jan 2017 12:49:27 +0000
Message-ID: <d505ad17f16e57eb33a2387772117785f5b39e3d.1484570878.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56324
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

Add a helper function to make a range of guest physical address (GPA)
mappings in the GPA page table clean so that writes can be caught. This
will be used in a few places to manage dirty page logging.

Note that until the dirty bit is transferred from GPA page table entries
to GVA page table entries in an upcoming patch this won't trigger a TLB
modified exception on write.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   1 +-
 arch/mips/kvm/mmu.c              | 124 ++++++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index da401a75a204..8f12385ccebd 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -640,6 +640,7 @@ enum kvm_mips_flush {
 };
 void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags);
 bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn);
+int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn);
 pgd_t *kvm_pgd_alloc(void);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 void kvm_trap_emul_invalidate_gva(struct kvm_vcpu *vcpu, unsigned long addr,
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 934bcc3732da..892fd0ede718 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -304,6 +304,130 @@ bool kvm_mips_flush_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
 				      end_gfn << PAGE_SHIFT);
 }
 
+#define BUILD_PTE_RANGE_OP(name, op)					\
+static int kvm_mips_##name##_pte(pte_t *pte, unsigned long start,	\
+				 unsigned long end)			\
+{									\
+	int ret = 0;							\
+	int i_min = __pte_offset(start);				\
+	int i_max = __pte_offset(end);					\
+	int i;								\
+	pte_t old, new;							\
+									\
+	for (i = i_min; i <= i_max; ++i) {				\
+		if (!pte_present(pte[i]))				\
+			continue;					\
+									\
+		old = pte[i];						\
+		new = op(old);						\
+		if (pte_val(new) == pte_val(old))			\
+			continue;					\
+		set_pte(pte + i, new);					\
+		ret = 1;						\
+	}								\
+	return ret;							\
+}									\
+									\
+/* returns true if anything was done */					\
+static int kvm_mips_##name##_pmd(pmd_t *pmd, unsigned long start,	\
+				 unsigned long end)			\
+{									\
+	int ret = 0;							\
+	pte_t *pte;							\
+	unsigned long cur_end = ~0ul;					\
+	int i_min = __pmd_offset(start);				\
+	int i_max = __pmd_offset(end);					\
+	int i;								\
+									\
+	for (i = i_min; i <= i_max; ++i, start = 0) {			\
+		if (!pmd_present(pmd[i]))				\
+			continue;					\
+									\
+		pte = pte_offset(pmd + i, 0);				\
+		if (i == i_max)						\
+			cur_end = end;					\
+									\
+		ret |= kvm_mips_##name##_pte(pte, start, cur_end);	\
+	}								\
+	return ret;							\
+}									\
+									\
+static int kvm_mips_##name##_pud(pud_t *pud, unsigned long start,	\
+				 unsigned long end)			\
+{									\
+	int ret = 0;							\
+	pmd_t *pmd;							\
+	unsigned long cur_end = ~0ul;					\
+	int i_min = __pud_offset(start);				\
+	int i_max = __pud_offset(end);					\
+	int i;								\
+									\
+	for (i = i_min; i <= i_max; ++i, start = 0) {			\
+		if (!pud_present(pud[i]))				\
+			continue;					\
+									\
+		pmd = pmd_offset(pud + i, 0);				\
+		if (i == i_max)						\
+			cur_end = end;					\
+									\
+		ret |= kvm_mips_##name##_pmd(pmd, start, cur_end);	\
+	}								\
+	return ret;							\
+}									\
+									\
+static int kvm_mips_##name##_pgd(pgd_t *pgd, unsigned long start,	\
+				 unsigned long end)			\
+{									\
+	int ret = 0;							\
+	pud_t *pud;							\
+	unsigned long cur_end = ~0ul;					\
+	int i_min = pgd_index(start);					\
+	int i_max = pgd_index(end);					\
+	int i;								\
+									\
+	for (i = i_min; i <= i_max; ++i, start = 0) {			\
+		if (!pgd_present(pgd[i]))				\
+			continue;					\
+									\
+		pud = pud_offset(pgd + i, 0);				\
+		if (i == i_max)						\
+			cur_end = end;					\
+									\
+		ret |= kvm_mips_##name##_pud(pud, start, cur_end);	\
+	}								\
+	return ret;							\
+}
+
+/*
+ * kvm_mips_mkclean_gpa_pt.
+ * Mark a range of guest physical address space clean (writes fault) in the VM's
+ * GPA page table to allow dirty page tracking.
+ */
+
+BUILD_PTE_RANGE_OP(mkclean, pte_mkclean)
+
+/**
+ * kvm_mips_mkclean_gpa_pt() - Make a range of guest physical addresses clean.
+ * @kvm:	KVM pointer.
+ * @start_gfn:	Guest frame number of first page in GPA range to flush.
+ * @end_gfn:	Guest frame number of last page in GPA range to flush.
+ *
+ * Make a range of GPA mappings clean so that guest writes will fault and
+ * trigger dirty page logging.
+ *
+ * The caller must hold the @kvm->mmu_lock spinlock.
+ *
+ * Returns:	Whether any GPA mappings were modified, which would require
+ *		derived mappings (GVA page tables & TLB enties) to be
+ *		invalidated.
+ */
+int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
+{
+	return kvm_mips_mkclean_pgd(kvm->arch.gpa_mm.pgd,
+				    start_gfn << PAGE_SHIFT,
+				    end_gfn << PAGE_SHIFT);
+}
+
 /**
  * kvm_mips_map_page() - Map a guest physical page.
  * @vcpu:		VCPU pointer.
-- 
git-series 0.8.10

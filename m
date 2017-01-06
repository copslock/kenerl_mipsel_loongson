Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:41:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51099 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993119AbdAFBdpsADnu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:45 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B6F545AA5F079;
        Fri,  6 Jan 2017 01:33:38 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:39 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 14/30] KVM: MIPS/T&E: Allocate GVA -> HPA page tables
Date:   Fri, 6 Jan 2017 01:32:46 +0000
Message-ID: <c978135cc5cebda56db83717a0698910e7ae5056.1483665879.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56193
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

Allocate GVA -> HPA page tables for guest kernel and guest user mode on
each VCPU, to allow for fast path TLB refill handling to be added later.

In the process kvm_arch_vcpu_init() needs updating to pass on any error
from the vcpu_init() callback.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c      |  7 +++-
 arch/mips/kvm/trap_emul.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c3f2207a37a0..39792ec73a6d 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1343,7 +1343,12 @@ static enum hrtimer_restart kvm_mips_comparecount_wakeup(struct hrtimer *timer)
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	kvm_mips_callbacks->vcpu_init(vcpu);
+	int err;
+
+	err = kvm_mips_callbacks->vcpu_init(vcpu);
+	if (err)
+		return err;
+
 	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
 	vcpu->arch.comparecount_timer.function = kvm_mips_comparecount_wakeup;
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index f3c3afd57738..34aa9b6871fb 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -14,6 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/vmalloc.h>
 #include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
 
 #include "interrupt.h"
 
@@ -435,13 +436,75 @@ static int kvm_trap_emul_vm_init(struct kvm *kvm)
 
 static int kvm_trap_emul_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
+	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
+
 	vcpu->arch.kscratch_enabled = 0xfc;
 
+	/*
+	 * Allocate GVA -> HPA page tables.
+	 * MIPS doesn't use the mm_struct pointer argument.
+	 */
+	kern_mm->pgd = pgd_alloc(kern_mm);
+	if (!kern_mm->pgd)
+		return -ENOMEM;
+
+	user_mm->pgd = pgd_alloc(user_mm);
+	if (!user_mm->pgd) {
+		pgd_free(kern_mm, kern_mm->pgd);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
+static void kvm_mips_emul_free_gva_pt(pgd_t *pgd)
+{
+	/* Don't free host kernel page tables copied from init_mm.pgd */
+	const unsigned long end = 0x80000000;
+	unsigned long pgd_va, pud_va, pmd_va;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int i, j, k;
+
+	for (i = 0; i < USER_PTRS_PER_PGD; i++) {
+		if (pgd_none(pgd[i]))
+			continue;
+
+		pgd_va = (unsigned long)i << PGDIR_SHIFT;
+		if (pgd_va >= end)
+			break;
+		pud = pud_offset(pgd + i, 0);
+		for (j = 0; j < PTRS_PER_PUD; j++) {
+			if (pud_none(pud[j]))
+				continue;
+
+			pud_va = pgd_va | ((unsigned long)j << PUD_SHIFT);
+			if (pud_va >= end)
+				break;
+			pmd = pmd_offset(pud + j, 0);
+			for (k = 0; k < PTRS_PER_PMD; k++) {
+				if (pmd_none(pmd[k]))
+					continue;
+
+				pmd_va = pud_va | (k << PMD_SHIFT);
+				if (pmd_va >= end)
+					break;
+				pte = pte_offset(pmd + k, 0);
+				pte_free_kernel(NULL, pte);
+			}
+			pmd_free(NULL, pmd);
+		}
+		pud_free(NULL, pud);
+	}
+	pgd_free(NULL, pgd);
+}
+
 static void kvm_trap_emul_vcpu_uninit(struct kvm_vcpu *vcpu)
 {
+	kvm_mips_emul_free_gva_pt(vcpu->arch.guest_kernel_mm.pgd);
+	kvm_mips_emul_free_gva_pt(vcpu->arch.guest_user_mm.pgd);
 }
 
 static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
-- 
git-series 0.8.10

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:08:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38546 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993922AbdBBMFID0iWv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:08 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id 2F05940546B87;
        Thu,  2 Feb 2017 12:05:01 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 15/30] KVM: MIPS/T&E: Activate GVA page tables in guest context
Date:   Thu, 2 Feb 2017 12:04:28 +0000
Message-ID: <41a9370dbe968a326a6bbb2a006b4a1045913926.1486036366.git-series.james.hogan@imgtec.com>
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
X-archive-position: 56597
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

Activate the GVA page tables when in guest context. This will allow the
normal Linux TLB refill handler to fill from it when guest memory is
read, as well as preventing accidental reading from user memory.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/mmu_context.h |  4 +++-
 arch/mips/kvm/entry.c               | 16 +++++++++++++++-
 arch/mips/kvm/trap_emul.c           | 10 ++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index ddd57ade1aa8..16eb8521398e 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -29,9 +29,11 @@ do {									\
 	}								\
 } while (0)
 
+extern void tlbmiss_handler_setup_pgd(unsigned long);
+
+/* Note: This is also implemented with uasm in arch/mips/kvm/entry.c */
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
-	extern void tlbmiss_handler_setup_pgd(unsigned long);		\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 	htw_set_pwbase((unsigned long)pgd);				\
 } while (0)
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index f81888704caa..f683d123172c 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -13,6 +13,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/log2.h>
+#include <asm/mmu_context.h>
 #include <asm/msa.h>
 #include <asm/setup.h>
 #include <asm/uasm.h>
@@ -316,7 +317,20 @@ static void *kvm_mips_build_enter_guest(void *addr)
 #else
 	uasm_i_andi(&p, K0, K0, MIPS_ENTRYHI_ASID);
 #endif
-	uasm_i_mtc0(&p, K0, C0_ENTRYHI);
+
+	/*
+	 * Set up KVM T&E GVA pgd.
+	 * This does roughly the same as TLBMISS_HANDLER_SETUP_PGD():
+	 * - call tlbmiss_handler_setup_pgd(mm->pgd)
+	 * - but skips write into CP0_PWBase for now
+	 */
+	UASM_i_LW(&p, A0, (int)offsetof(struct mm_struct, pgd) -
+			  (int)offsetof(struct mm_struct, context.asid), T1);
+
+	UASM_i_LA(&p, T9, (unsigned long)tlbmiss_handler_setup_pgd);
+	uasm_i_jalr(&p, RA, T9);
+	 uasm_i_mtc0(&p, K0, C0_ENTRYHI);
+
 	uasm_i_ehb(&p);
 
 	/* Disable RDHWR access */
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 183150a963ec..f39d427649dc 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -704,6 +704,7 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct mm_struct *kern_mm = &vcpu->arch.guest_kernel_mm;
 	struct mm_struct *user_mm = &vcpu->arch.guest_user_mm;
+	struct mm_struct *mm;
 
 	/* Allocate new kernel and user ASIDs if needed */
 
@@ -733,10 +734,9 @@ static int kvm_trap_emul_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 * on the mode of the Guest (Kernel/User)
 	 */
 	if (current->flags & PF_VCPU) {
-		if (KVM_GUEST_KERNEL_MODE(vcpu))
-			write_c0_entryhi(cpu_asid(cpu, kern_mm));
-		else
-			write_c0_entryhi(cpu_asid(cpu, user_mm));
+		mm = KVM_GUEST_KERNEL_MODE(vcpu) ? kern_mm : user_mm;
+		write_c0_entryhi(cpu_asid(cpu, mm));
+		TLBMISS_HANDLER_SETUP_PGD(mm->pgd);
 		kvm_mips_suspend_mm(cpu);
 		ehb();
 	}
@@ -757,6 +757,7 @@ static int kvm_trap_emul_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 			get_new_mmu_context(current->mm, cpu);
 		}
 		write_c0_entryhi(cpu_asid(cpu, current->mm));
+		TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
 		kvm_mips_resume_mm(cpu);
 		ehb();
 	}
@@ -821,6 +822,7 @@ static int kvm_trap_emul_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	     asid_version_mask(cpu)))
 		get_new_mmu_context(current->mm, cpu);
 	write_c0_entryhi(cpu_asid(cpu, current->mm));
+	TLBMISS_HANDLER_SETUP_PGD(current->mm->pgd);
 	kvm_mips_resume_mm(cpu);
 
 	htw_start();
-- 
git-series 0.8.10

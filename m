Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 16:55:19 +0200 (CEST)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:33289
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeJMOzAiEl0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 16:55:00 +0200
Received: by mail-pf1-x441.google.com with SMTP id 78-v6so5216426pfq.0;
        Sat, 13 Oct 2018 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=21JXo1a6qbMXtwcp2TBGK2ryQyI3qBTJhIDvjYKHda4=;
        b=U3HO/OV5TAQzrYkMH2G1hosInsbAnhSCs8BmV8/V85CJ6rwY5ll+gXSfkX/hNj1dvV
         6ajNscFJv31McxitOsrDRYKXxS/rZe8ho4huEXzWVanfB3RIGs9DSbRxh7utdJtFMsbR
         hr7cT8A8FQJvLgm/8ZvLKxVoXWgAogMcTrxMRhUiArfznLnvCH3FIWKxveJzRvmYxULT
         jIH8mLONaxVCbIYOG+qhgjo3J1OafG/iDHWN7W8GXXJKBms2YtEkdVLsAAktEfs35zJQ
         xxG8ujjLg9sRzXWd03kkxVEHFfjISWpz8KZw5B/piKFzu/J+wLNSq0mok5K9gYHCEsht
         MjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=21JXo1a6qbMXtwcp2TBGK2ryQyI3qBTJhIDvjYKHda4=;
        b=c+ubybwR0cPBIiAu+Yg1zF0bycrIMaWwcohGdqixYqWsvTumpz5V3gk7wKzAYIi5R/
         /tMCR3W726d2qtuIxbBBH7VSVJovwewWl/UAVXtJulISZA6xR1lg9gvmOQXY52HEGp7d
         i1ueSDHxrtDt4XCa76ABNn9xFCr3yiJonV7MAFuDuNb+N+H2O83G1tyXY50Lq1MUKQJI
         JHStZ8QwNtUpwyQzlgmuzulh3Tyzqt3MJZeCCjLYWqpaM19X5KBNv3nwif7EHNl394Xz
         hjPjIgeYleikah5F9BhYTf1NCSuWs5cRPT/t0jU3B+yZGpU8n2BKdK9mobDHXUGwY81y
         +ZBw==
X-Gm-Message-State: ABuFfoiku/b77Y58gXbtVSlyT8c6t4KVxpP4dWR45GDKE1NQaWhnODAl
        VOUO9GximmztvoIyFYqvziw=
X-Google-Smtp-Source: ACcGV61KyFTVKIA05Vq2QH/Q56bnFPWbxn2qw06p58DUaJF1jm3PteiHaWZI77FP0tk44zB7AGOACw==
X-Received: by 2002:a63:720c:: with SMTP id n12-v6mr9627997pgc.193.1539442494378;
        Sat, 13 Oct 2018 07:54:54 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:54:53 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org, catalin.marinas@arm.com,
        will.deacon@arm.com, jhogan@kernel.org, ralf@linux-mips.org,
        paul.burton@mips.com, paulus@ozlabs.org, benh@kernel.crashing.org,
        mpe@ellerman.id.au, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 4/15] KVM: Make kvm_set_spte_hva() return int
Date:   Sat, 13 Oct 2018 22:53:55 +0800
Message-Id: <20181013145406.4911-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lantianyu1986@gmail.com
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

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The patch is to make kvm_set_spte_hva() return int and caller can
check return value to determine flush tlb or not.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/arm/include/asm/kvm_host.h     | 2 +-
 arch/arm64/include/asm/kvm_host.h   | 2 +-
 arch/mips/include/asm/kvm_host.h    | 2 +-
 arch/mips/kvm/mmu.c                 | 3 ++-
 arch/powerpc/include/asm/kvm_host.h | 2 +-
 arch/powerpc/kvm/book3s.c           | 3 ++-
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 arch/x86/include/asm/kvm_host.h     | 2 +-
 arch/x86/kvm/mmu.c                  | 3 ++-
 virt/kvm/arm/mmu.c                  | 6 ++++--
 10 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3ad482d2f1eb..efb820bdad2c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -225,7 +225,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d6d7336f871..2e506c0b3eb7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -358,7 +358,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2c1c53d12179..71c3f21d80d5 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -933,7 +933,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d8dcdb350405..97e538a8c1be 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -551,7 +551,7 @@ static int kvm_set_spte_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	       (pte_dirty(old_pte) && !pte_dirty(hva_pte));
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	int ret;
@@ -559,6 +559,7 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	ret = handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pte);
 	if (ret)
 		kvm_mips_callbacks->flush_shadow_all(kvm);
+	return 0;
 }
 
 static int kvm_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fac6f631ed29..ab23379c53a9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -72,7 +72,7 @@ extern int kvm_unmap_hva_range(struct kvm *kvm,
 			       unsigned long start, unsigned long end);
 extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
-extern void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 #define HPTEG_CACHE_NUM			(1 << 15)
 #define HPTEG_HASH_BITS_PTE		13
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index fd9893bc7aa1..437613bb609a 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -850,9 +850,10 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 	return kvm->arch.kvm_ops->test_age_hva(kvm, hva);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	kvm->arch.kvm_ops->set_spte_hva(kvm, hva, pte);
+	return 0;
 }
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 8f2985e46f6f..c3f312b2bcb3 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -757,10 +757,11 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 	return 0;
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	/* The page will get remapped properly on its next fault */
 	kvm_unmap_hva(kvm, hva);
+	return 0;
 }
 
 /*****************************************/
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fea95aa77319..19985c602ed6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1504,7 +1504,7 @@ asmlinkage void kvm_spurious_fault(void);
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9b9db36df103..fd24a4dc45e9 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1918,9 +1918,10 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm_handle_hva_range(kvm, start, end, 0, kvm_unmap_rmapp);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
+	return 0;
 }
 
 static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ed162a6c57c5..89a9c5fa9fd7 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1845,14 +1845,14 @@ static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data
 }
 
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	kvm_pfn_t pfn = pte_pfn(pte);
 	pte_t stage2_pte;
 
 	if (!kvm->arch.pgd)
-		return;
+		return 0;
 
 	trace_kvm_set_spte_hva(hva);
 
@@ -1863,6 +1863,8 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	clean_dcache_guest_page(pfn, PAGE_SIZE);
 	stage2_pte = pfn_pte(pfn, PAGE_S2);
 	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
+
+	return 0;
 }
 
 static int kvm_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
-- 
2.14.4

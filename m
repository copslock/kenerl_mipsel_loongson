Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 15:47:36 +0100 (CET)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:42344
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993048AbeKHOrXkOGbv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 15:47:23 +0100
Received: by mail-pf1-x443.google.com with SMTP id u10-v6so3645571pfn.9;
        Thu, 08 Nov 2018 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j64bsuj3x4K+30VilhvqfE2jLibklRus8fQn4GALxqw=;
        b=kSRs6yszY4IfNoC8OPqCy4ksjyyfO8vPsN92AYgcgXtqlwYrp7W9CsBb2pFWYCOWYT
         hzLAcMLmlTe+72KX5oE2NnIPaiws0ZyzwJ1rivC0GnmGbAZX9qFQcKu7IRKTTa5fcNt7
         AntjL+6k2KUftFi1oRrs1ffyS4sDX3FeUL6voPxTS87oBXQHQsw9+BohJqmSGOD0u38j
         wxTVXVp6bSM0RFLXlLNxSCfv+y2byQousc+mACuHCor4/2CnpmJGhCYH2YpOgjKjrhJ5
         W3G1FjZFxRVZeNqXFC1H1e5VsjKK0ew0oJJ2igzrk6MVip4mlHEpR0D+IwRk8W/isF9o
         qR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j64bsuj3x4K+30VilhvqfE2jLibklRus8fQn4GALxqw=;
        b=DmR4ybKL7vkaDR/kUcO+ZAZB6TowXbJHMMr7QNZYuFZ1M50WLFhLp4fZZTtDgwoKC0
         g+YTRbMrqjU8llfq9Z4sVlRcPelCJ+qCGWjOFLulqJsLAeF0bm5RCu9Pv1Tln0Y0REws
         xD4SWpy3M8Yzj4elr592j6sSSBj7gfF2WGwU7ZqZFQTP6m6fbQGgCssNRD2fI+b93v4G
         zEVCmZw4MNiOVmrE/hIPF4ym5hD0HrAwNpcUaRfPSs1d+1P99tihf2nYzJ7hWIG6pSf0
         CZ73wn//tw6TdGIgO1Je5vsqD86a6LVuP35oZwTxmlp7g2pet3DNKaaMncX5FJOn9IQm
         oWwg==
X-Gm-Message-State: AGRZ1gImgnUwkHnry9erq40AfdEIv900qEBog5hlRudn9lr+a/TUwN9q
        FhWz4ztSMjqNUnpPZJAznAo=
X-Google-Smtp-Source: AJdET5f41UCbLn034dxs1ngicJBuoodp6p58X0q0RKH54NooSvsVOJCzcR34aj+o0PpgSKVU2xXoug==
X-Received: by 2002:a63:1766:: with SMTP id 38mr2232968pgx.299.1541688442907;
        Thu, 08 Nov 2018 06:47:22 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:22 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 5/10] KVM/MMU: Add tlb flush with range helper function
Date:   Thu,  8 Nov 2018 22:46:34 +0800
Message-Id: <20181108144639.11206-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67165
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

This patch is to add wrapper functions for tlb_remote_flush_with_range
callback and flush tlb directly in kvm_mmu_zap_collapsible_spte().
kvm_mmu_zap_collapsible_spte() returns flush request to the
slot_handle_leaf() and the latter does flush on demand. When
range flush is available, make kvm_mmu_zap_collapsible_spte()
to flush tlb with range directly to avoid returning range back
to slot_handle_leaf().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since V4:
       Remove flush list interface and flush tlb directly in
       kvm_mmu_zap_collapsible_spte().
Change since V3:
       Remove code of updating "tlbs_dirty"
Change since V2:
       Fix comment in the kvm_flush_remote_tlbs_with_range()
---
 arch/x86/kvm/mmu.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf5f572f2305..c1d383532066 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,6 +264,35 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
+
+static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
+{
+	int ret = -ENOTSUPP;
+
+	if (range && kvm_x86_ops->tlb_remote_flush_with_range)
+		ret = kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+
+	if (ret)
+		kvm_flush_remote_tlbs(kvm);
+}
+
+static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+		u64 start_gfn, u64 pages)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn = start_gfn;
+	range.pages = pages;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
 {
 	BUG_ON((mmio_mask & mmio_value) != mmio_value);
@@ -5680,7 +5709,13 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 			!kvm_is_reserved_pfn(pfn) &&
 			PageTransCompoundMap(pfn_to_page(pfn))) {
 			pte_list_remove(rmap_head, sptep);
-			need_tlb_flush = 1;
+
+			if (kvm_available_flush_tlb_with_range())
+				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+					KVM_PAGES_PER_HPAGE(sp->role.level));
+			else
+				need_tlb_flush = 1;
+
 			goto restart;
 		}
 	}
-- 
2.14.4

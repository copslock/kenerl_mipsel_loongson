Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 16:54:50 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:35974
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeJMOyohptIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 16:54:44 +0200
Received: by mail-pf1-x444.google.com with SMTP id l81-v6so7603967pfg.3;
        Sat, 13 Oct 2018 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCaq3R6VmH1wWlGObzsIcMHnr3COIkQBYeAae2u7kcQ=;
        b=ZVICMHN0AFLfvRfTF9yl5eF1LtUJio6d6J3YKdxugmdHzEsj5NXvND7pZv/SidDdek
         6My4+c84eQCZREXmERXD0Z2ujNZD/ldNJn5zEVz37wk9/OYXYVpkpLkWRnABYIWyAmcK
         GF3oatbiLja/B2Ge3yx9NqdUaA+1W+keyw3OOvxZQdmm2aUfq3sYKOwk9jVqTHCjDbgk
         Wu2MFL9RTrN06WtDIlRlDY8nRY339wsHGB9T0q606/Yg7WI6wxRXmG77b0oOXGVz8pzE
         fl3VV6iszqco6/a9twuZ2bk9dauQqmQkRQ+Pzgk77Aph5Hld8/GC2Ur3ANhrpNdgLvHZ
         gQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCaq3R6VmH1wWlGObzsIcMHnr3COIkQBYeAae2u7kcQ=;
        b=E8/Q6E4HFMZ3wbk3fAoqUg1UM66mtBEQmIOijb+P++nuXL/qTEHBHuqoiRuDBN8TKk
         zAFWUznAt0H4WRxtvkhSJNuowvbeWebD389BJc9PBoOWYpMKAaIFPOvMTuvhDUXSBRkr
         SR/XffF5+X47Ti+VQuF+1xNvNVbe2La+mEyXOzJW217+I0PCfI3jFIlHDENqUwbXnHY7
         dk0pIzre6/w2SM5OajgCB4h6jjgfAVpDVCVsx3OpztzVlji7TA674sGcJtOiyVpsI9JA
         N1NEDlT9+YwyBPG/ylhxQamMH7v1/I7p193uUEu+QnKlzgcC8k+IGTRiEnSWG/FBhtn2
         9oJw==
X-Gm-Message-State: ABuFfog2tjm/nNb8c8bKDOOy/HhrRD9XUZv20TtWijPpRkjL5FF/c8U7
        fzDwHJJ3a7B9vVq48LYi2TY=
X-Google-Smtp-Source: ACcGV62EdGNQnQ/sKcjwUyLn1xDKyo7VDncjRak4c7jj414oGg3zSQN7txG6tEyPXVxX5UwcU5idzA==
X-Received: by 2002:a65:4103:: with SMTP id w3-v6mr9732885pgp.284.1539442478487;
        Sat, 13 Oct 2018 07:54:38 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:54:37 -0700 (PDT)
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
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Date:   Sat, 13 Oct 2018 22:53:53 +0800
Message-Id: <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66818
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
callback.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change sicne V3:
       Remove code of updating "tlbs_dirty"
Change since V2:
       Fix comment in the kvm_flush_remote_tlbs_with_range()
---
 arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c73d9f650de7..ff656d85903a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
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
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list = flush_list;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+		u64 start_gfn, u64 pages)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn = start_gfn;
+	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
 {
 	BUG_ON((mmio_mask & mmio_value) != mmio_value);
-- 
2.14.4

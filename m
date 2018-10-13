Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 16:54:41 +0200 (CEST)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:40583
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbeJMOyg6GZOw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 16:54:36 +0200
Received: by mail-pl1-x643.google.com with SMTP id 1-v6so7261049plv.7;
        Sat, 13 Oct 2018 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=px0gV+gBnpOH60iOcTCGqmbUjehg++DRdbAxzx/hWFA=;
        b=rp6f8txFq2Z++vvFYXV5hUS6IcLak/IyxBJWHXWM8AkS6KURSFVAfxx/YE97efIsUU
         E4e/KL8csquVEaxBw0R1BoISOtQsd75AZA16eXP5lGPyMZZxTDY94QRtVOd9z8gB+BGz
         EyyW4yykMzbdZnZ0H78W4ERR3OJ+/BR8mDkbAw89wA4dlzgDzcDqopu7pUYAGrfWcCvd
         nwDcS3oU1IPTjODCkh8Q1L6F4qsiz8g5B8mROcu6prFhM2YZP6/b8phF8BgMKTw+LKgf
         2oxwPYzgHQER/la4dzJ2wKp21z2Nx7HtMZdVuZl42f8NzQV9qo+aq6M+MgYi1fijdt/y
         cMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=px0gV+gBnpOH60iOcTCGqmbUjehg++DRdbAxzx/hWFA=;
        b=C4D0r9+kD+ngRzt1rq53k3OVllGHcKS6ldaKYbak0WO2E0mRqib5MFmXHIWHSEmE7b
         3QJd54vVObuVGxyu79TeyN0W70ei7tEwrCRfVpa/jNDHEBnovg5VQXeJDL1+QJ5Bf52y
         3fGPPcZ46lzvPYTJQYXWW3whDU/ljGCZfE/bximX1/Ei/T0LWMKW1gW/Inrm4q7a+Zth
         AcytGKOZiqwsMvB/vcaotox6j2rTfoTHtkWDOf/X2xZNfJEnA07f010Xh5Z2kSkQ9TWh
         l1fHFhhTcrnxHrYEO8trrkeU2ayA3XuQA+FNHKvZWcRegVU/guqCaufCDCdMGGM3LzaZ
         /tGA==
X-Gm-Message-State: ABuFfogugmz5VVCeIRxm6ZEczF2323yeFI7lQAolxWMuWdaL3d/zqUYI
        jPKMp1zFHYZdToK/XXHNxww=
X-Google-Smtp-Source: ACcGV62HWs3gWO94ingYjrTNOd2X4hqsmsPW7d3NRYDQAgfnfqDU4fT7925KW4ssd+32230A+ZzFJA==
X-Received: by 2002:a17:902:2825:: with SMTP id e34-v6mr1226708plb.244.1539442470478;
        Sat, 13 Oct 2018 07:54:30 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:54:29 -0700 (PDT)
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
Subject: [PATCH V4 1/15] KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
Date:   Sat, 13 Oct 2018 22:53:52 +0800
Message-Id: <20181013145406.4911-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66817
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

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4b09d4aa9bf4..fea95aa77319 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,12 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+	struct list_head *flush_list;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1039,6 +1045,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 15:46:55 +0100 (CET)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:39535
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992922AbeKHOqv6OI9v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 15:46:51 +0100
Received: by mail-pf1-x443.google.com with SMTP id n11-v6so9398438pfb.6;
        Thu, 08 Nov 2018 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yiyADj8185+lR6YtIPxI/9OlNcR1QogQW5VAb4fNZlE=;
        b=u+Ieh8f3qfjTxqUeTZ2algF1CEGnXeJx1sAg9socsFBe0+RezxQX80e5prVeAOHZmY
         icR0KXzvJL4vGN0ROj0jg1ryZEx+Gi3Fb4hx4weXtMyfy2+eiUizNHGkrTX/olcFiFOY
         WZDOeg/4+xYx2ZTTYnRZtDTF/z8OjLoSW8BJtUozZVa1lLhI07D3GmBImm1/oN+GD7e7
         qA6K3aelJQQxFTmV3yZnIF5dj3IwsYxjYYEkhbLD0J3ibcbJSOoMKgjPuJL6BfT+XihI
         F62rPzVl+6qgi2bTAfx30crPQUsf/q/kFe8Ej9KOG8ocX811swqDCQUfbN03fBEreMOi
         Hnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yiyADj8185+lR6YtIPxI/9OlNcR1QogQW5VAb4fNZlE=;
        b=Ep1WBN4D6gboI6LlU6AW4ofyZT9yEp55Ze7n8fUn6a81IpgbdY4A75OgTbPOOZuyfl
         fk4zsiZK6iIRwEgplyyAcPZic/cZppXR5PEitP1xoYKojIu8VgGywW5r85ysOCDFtZKA
         M7QewWHpCt3QYlSVmBc+PNXdb+Fch28/jSyx9kDZbCdiHaMfkehArGn/BF8Sk4f/Oyc7
         MtQ0tRcDfJBe0Mh984cag5dSmhYJTIpHZzTaSU92yKu/l1UE5uoxqwRp/Q5330HBAnMy
         Cy0iR6531LJ3foF0P1zinxziaxJX51vcfGAsVaFtTCUDqzjOfXI6DRN/63tfZ8aKRd+u
         g77A==
X-Gm-Message-State: AGRZ1gJU4V8pUcymvVTBy4IsRXF1pTbrPzGTtwPVH9c+cPWoRE7bfFxc
        qSUwU7EwHb4xnJ8IlBQ9h8A=
X-Google-Smtp-Source: AJdET5feGS/RXRvm4uJ38TQRmWSiiTRsWmdCxatvMEDX3Rva1bkcCH0h71uVKtGhhB9g0GT/xwrfeg==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr4024148pgb.101.1541688411056;
        Thu, 08 Nov 2018 06:46:51 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:46:50 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 1/10] KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
Date:   Thu,  8 Nov 2018 22:46:30 +0800
Message-Id: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67162
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
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff7e421..c8a65f0a7107 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,11 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1042,6 +1047,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

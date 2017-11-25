Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:01:22 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:41218
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdKYU5eT1Os6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:34 +0100
Received: by mail-wr0-x243.google.com with SMTP id z14so22997997wrb.8
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ui5mN1YFQ4xoRI57vbCAGUgorxDcqfto5Fqw+/t0EH8=;
        b=IuqAmmS/XqxdikR/NooGXBGp5lHAdQmFvTybNDlcXrbiaUtWyhNFQ+z3Rr7vQUmnPU
         4EryX4GhZ9H6CHsLXMQclunCVGR9e+Z0g3Fosu89VtGGTBhXrcxT25RiAq0GngemodXC
         EifAgOQsVnsP7gvwggkmtF8L1DYZJMqbNO6ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ui5mN1YFQ4xoRI57vbCAGUgorxDcqfto5Fqw+/t0EH8=;
        b=p+K96ueMXSX0Ui2HfXO1tH+rMcdg7YWSwElxPn2q/pIGfTfTZHlZZkP8L6ekIgi42f
         g+AhG3GTxHlISAzDt6VByN9rjKWiQKn/8au1WaJk0GGU/WwnQIVDZBlRC429EZmdlry5
         i3idmf5d/JTKO44A0Oviwv48zFQdeUjXA6uaMgPuL9c794YPrUDPGEy/bRjJnoAI0PkH
         HBulMlMde7cQJlbbJ4rhyhacWKQQSvRhPMSaSbIyDkvmDe96Gj31dY8L+96c61Z6fUT4
         kgWjUMU6elKiyLonBQvFJlE5gU4t6eaycImgQbGvSvK7EnS6+rnopBUPI01Fh/kVqQqy
         itHA==
X-Gm-Message-State: AJaThX7NQT1I4tiVMEG8XSZBW7Ote1w4HQ5+4pr1qCWD/s6tXZlnLJmA
        RFwA3sG0oAHWBux5uKlcHSUz1g==
X-Google-Smtp-Source: AGs4zMaJ6QA2oT9qIhdCM7Ee5szQBtmE1+FC0zXt1DNfQ3dlWmWt0jL9ut0wCDCEzn7KT8q/uYrlqw==
X-Received: by 10.223.164.22 with SMTP id d22mr30855660wra.232.1511643449007;
        Sat, 25 Nov 2017 12:57:29 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:28 -0800 (PST)
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: [PATCH 10/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
Date:   Sat, 25 Nov 2017 21:57:13 +0100
Message-Id: <20171125205718.7731-11-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christoffer.dall@linaro.org
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

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_translate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/booke.c | 4 ++++
 arch/x86/kvm/x86.c       | 6 ++++++
 virt/kvm/kvm_main.c      | 4 ----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 59d1d0bd6909..8069d93bf654 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1804,7 +1804,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 {
 	int r;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	r = kvmppc_core_vcpu_translate(vcpu, tr);
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a4fa1f2fa46..ae8685155d11 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7654,6 +7654,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	unsigned long vaddr = tr->linear_address;
 	gpa_t gpa;
 	int idx;
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
@@ -7663,6 +7668,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	tr->writeable = 1;
 	tr->usermode = 0;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bcfdb4800e44..173f98d9c58d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2635,11 +2635,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:59:50 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:39341
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdKYU51HUyN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:27 +0100
Received: by mail-wr0-x244.google.com with SMTP id 11so19673387wrb.6
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zrY9wnaKokWnAolmrxh9O3IQDcVtQpq4BORcfzDbKds=;
        b=dgGLukwFVeq8sB2eOr7PZPaVA4IKc0sP+CD5yE4K9M0TMGFbgtFzM/9lh16lMOM3Oj
         4SRELHGOj1dDkItO62EYjnH2K+GcndVQsMP4CaSoTWxJQWovNVdjHf1NOCjXWjV0fBNr
         xO1Q0awaY8IUXFivfROYZQULwPXsTtffmIf9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zrY9wnaKokWnAolmrxh9O3IQDcVtQpq4BORcfzDbKds=;
        b=KVZz61+K0R5ODgDIGXZlg7flwZy6A4X5tXmJhZR+w9kDT0Ee+crtIJR71oHU+c7/5V
         dIjJX9MYJxIZF3xMnmNYID3DEnFSDQjHHQo8s/ONhHbupH7V7eYW16ZopfJJCOn9j/T9
         xtz6wq8AiOYI7IpgXrazq4bLZ24NCwrTVNfMlYksr5MLVTte9NfB7oGdOukps4a+BFw4
         4yi/46+cgWJ1N/1+hDVwehs5Rc8YHAXHam+DU73NETSsEGnSwY5IiF960yxrxNyTkV7S
         3H5OFxm2kveWtVQ8u435YukOQAzLdp6TKy2Llxjq/4zjJzNoLFQNwc5Yn82jQtdr2l+L
         fhKA==
X-Gm-Message-State: AJaThX7RfcOaIQXaLv2r9GJbSI39snYMyyp4zznKoQJfDIlF5yVI+yRf
        ha2dhVDn1kN3H2jwrcjXuBSkOw==
X-Google-Smtp-Source: AGs4zMY/c0UWlAUU3bgeVNDasXCBKV6miVh2JkuDzknzSCn/XyWfjujNhzZYZci7eBGUz2/eCJyycw==
X-Received: by 10.223.135.243 with SMTP id c48mr25188642wrc.140.1511643441783;
        Sat, 25 Nov 2017 12:57:21 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:21 -0800 (PST)
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
Subject: [PATCH 06/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
Date:   Sat, 25 Nov 2017 21:57:09 +0100
Message-Id: <20171125205718.7731-7-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61083
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
implementations of kvm_arch_vcpu_ioctl_get_sregs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/book3s.c | 10 +++++++++-
 arch/powerpc/kvm/booke.c  | 11 ++++++++++-
 arch/s390/kvm/kvm-s390.c  |  8 ++++++++
 arch/x86/kvm/x86.c        |  6 ++++++
 virt/kvm/kvm_main.c       |  4 ----
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 047d3178d70f..b7db75010843 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -484,7 +484,15 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 47b3d11345ed..d770f465cb9d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1620,11 +1620,20 @@ int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
                                   struct kvm_sregs *sregs)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	sregs->pvr = vcpu->arch.pvr;
 
 	get_sregs_base(vcpu, sregs);
 	get_sregs_arch206(vcpu, sregs);
-	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index eb2724d6e524..93a19e7e4f59 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2746,8 +2746,16 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	memcpy(&sregs->acrs, &vcpu->run->s.regs.acrs, sizeof(sregs->acrs));
 	memcpy(&sregs->crs, &vcpu->arch.sie_block->gcr, sizeof(sregs->crs));
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e4e34af97ba0..7faa9479e8d8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7381,8 +7381,13 @@ EXPORT_SYMBOL_GPL(kvm_get_cs_db_l_bits);
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	int r;
 	struct desc_ptr dt;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	kvm_get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
 	kvm_get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
 	kvm_get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
@@ -7414,6 +7419,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 		set_bit(vcpu->arch.interrupt.nr,
 			(unsigned long *)sregs->interrupt_bitmap);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7671ebb5971f..dbfaf190fca3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2589,11 +2589,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:43:58 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:39886
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990484AbdK2Qle1oPna (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:34 +0100
Received: by mail-wm0-x243.google.com with SMTP id i11so7184694wmf.4
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+x7Tj1ma7JNOaL50EYqTseGo42XF3O2SwSjAwDF+Wbw=;
        b=KNJZx6rOmR7Ud97yP0Dpurj2gFyehl7NCP/FShf4lpCkACcZF0JnQOFweebKMoIJGs
         a5YAQkRGr2sTUVlJS9MakC2iFzQNhMn27gqF5WcNjXhZuKZxx98PLfCSvqjsH8eNKLGS
         e+kGX8Ln9qat+tW585xuhxUlAKcz0+wt+GQCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+x7Tj1ma7JNOaL50EYqTseGo42XF3O2SwSjAwDF+Wbw=;
        b=OtGAxtsg09PwrRHaZLdCL55rHzP+rsb2kJSV2sBRu1zmIlda75ylMnvgUdsadSS5G3
         IaDJFIHpfe0O2NUD0E+/1kBEHLP5l5+maFAZmxjORcWAnVgMx2e6ZstSJeXc4a3kocAc
         Eat5hA6S+94pZfVQSrGUcoYQheylxKLfi0DuRJ+0L58b1sf/7aMgcSPRERDAs29nEh5y
         d9yFyhp19M+UGLnM0xwUHl6omzIQSQRujyWkh0vuVpkZaq9FTPSyuySLKsYKJr2WlXuQ
         nF5+sxiMQaRMWNTfRSqRP+GT51wDj4wBtAVj/XUjZ8fsKqCGU4KiK59+EMkOmIG61Lnf
         aTcQ==
X-Gm-Message-State: AJaThX6jSoScswo9B81PhlVLgrFXLiWTjknYl1doB2Yk9nRLQySu+0SG
        GwFTadTnLcRCkIPcJpZRJVrVEQ==
X-Google-Smtp-Source: AGs4zMZcPT1zG/d/V2nEM5C8lXr+7/bDIsyScfv7hwUSlupwMwUoRxR3z52PooLq05QqJlY2iObryA==
X-Received: by 10.28.63.9 with SMTP id m9mr3184329wma.137.1511973689102;
        Wed, 29 Nov 2017 08:41:29 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:28 -0800 (PST)
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
Subject: [PATCH v2 06/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
Date:   Wed, 29 Nov 2017 17:41:06 +0100
Message-Id: <20171129164116.16167-7-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61199
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
 arch/powerpc/kvm/book3s.c | 8 +++++++-
 arch/powerpc/kvm/booke.c  | 9 ++++++++-
 arch/s390/kvm/kvm-s390.c  | 4 ++++
 arch/x86/kvm/x86.c        | 3 +++
 virt/kvm/kvm_main.c       | 2 --
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 24bc7aa..6cc2377 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -484,7 +484,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	int ret;
+
+	vcpu_load(vcpu);
+	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	vcpu_put(vcpu);
+
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index bcbbedd..f647e12 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1613,11 +1613,18 @@ int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
                                   struct kvm_sregs *sregs)
 {
+	int ret;
+
+	vcpu_load(vcpu);
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
index e347643..18011fc 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2737,8 +2737,12 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	vcpu_load(vcpu);
+
 	memcpy(&sregs->acrs, &vcpu->run->s.regs.acrs, sizeof(sregs->acrs));
 	memcpy(&sregs->crs, &vcpu->arch.sie_block->gcr, sizeof(sregs->crs));
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 75eacce..20a5f67 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7400,6 +7400,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 {
 	struct desc_ptr dt;
 
+	vcpu_load(vcpu);
+
 	kvm_get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
 	kvm_get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
 	kvm_get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
@@ -7431,6 +7433,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 		set_bit(vcpu->arch.interrupt.nr,
 			(unsigned long *)sregs->interrupt_bitmap);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 963e249..779c03e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2581,9 +2581,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.7.4

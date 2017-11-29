Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:43:08 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36008
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdK2QlbOCnaa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:31 +0100
Received: by mail-wm0-x243.google.com with SMTP id b76so7246967wmg.1
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZKJLXcBq/VoFewJmxYKuASa3tMI1Xukcd4eZpT/bVs=;
        b=g4l8Qpv8L1J6qujmG4dekt7hN1skQ81yqOIGtzX3C+eURpjCVqgrFTkAUS2OX25k86
         /NHH1NWyS1wFBdTtEd7dbvGQZ5HF10ygShSKMtW+2Rf5JW/KISWClhKP1/oGIdtyawjb
         4v3HiyFuQQfbiJ35o+5vApHes8VtB9mUM41L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZKJLXcBq/VoFewJmxYKuASa3tMI1Xukcd4eZpT/bVs=;
        b=tZzTX5kJJaxeYCuTF6GTKh7l1ehF9kBOi7Te4jX10zqy1d25Vga6aaMMaNy7ADMo7j
         Nm5u9PMOqiA2gIlVj+NNV6YcNLjJGek+VMtzx0QAbQXvUvQJuBCOFUC/U56JUp4daVzF
         FYg+j35pU+N90iCAiLCsPY6feCt/Iqmb1yl/CGi8li9pBY4w3yZXzefYg7nM6dPlmTlH
         NmI+gv1+YtHxSIl2E22ZZcYLGcnLzzpVKN3JUPnjdgxGl9v5M6nOGU9WrcI89/Z7vdHo
         OXnVvno3Ay4iwY0Jm/wdEzSrlqT/ffoC128lNQPTVSN3I5Vm6mAvsVsKVDGThEqeof7f
         EJ/w==
X-Gm-Message-State: AJaThX5+Shi4ilJOW1cwwV62uQuI1JwKfsPjFP1e1D/urAHEz5UqEh1u
        LQ/1P/WJolH+90vyPjDn3HmTSg==
X-Google-Smtp-Source: AGs4zMb3QKYxDALsk2XYjJ6Bx2QsTiNSDd2APUKqaf0bEPEmMNy/89c/BU/SS2bJIOHdoWzeBy+jBQ==
X-Received: by 10.28.111.146 with SMTP id c18mr3056589wmi.123.1511973685833;
        Wed, 29 Nov 2017 08:41:25 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:24 -0800 (PST)
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
Subject: [PATCH v2 04/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
Date:   Wed, 29 Nov 2017 17:41:04 +0100
Message-Id: <20171129164116.16167-5-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61197
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
implementations of kvm_arch_vcpu_ioctl_get_regs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c      | 3 +++
 arch/powerpc/kvm/book3s.c | 3 +++
 arch/powerpc/kvm/booke.c  | 3 +++
 arch/s390/kvm/kvm-s390.c  | 2 ++
 arch/x86/kvm/x86.c        | 3 +++
 virt/kvm/kvm_main.c       | 2 --
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index b5c28f0..adfca57 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1165,6 +1165,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		regs->gpr[i] = vcpu->arch.gprs[i];
 
@@ -1172,6 +1174,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->lo = vcpu->arch.lo;
 	regs->pc = vcpu->arch.pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 72d977e..d85bfd7 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -497,6 +497,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	regs->pc = kvmppc_get_pc(vcpu);
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = kvmppc_get_ctr(vcpu);
@@ -518,6 +520,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 83b4858..e0e4f04 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1431,6 +1431,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	regs->pc = vcpu->arch.pc;
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = vcpu->arch.ctr;
@@ -1452,6 +1454,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2b3e874..37b7caa 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2718,7 +2718,9 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	vcpu_load(vcpu);
 	memcpy(&regs->gprs, &vcpu->run->s.regs.gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9deb62..597e1f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7309,6 +7309,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	vcpu_load(vcpu);
+
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
 		/*
 		 * We are here if userspace calls get_regs() in the middle of
@@ -7342,6 +7344,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->rip = kvm_rip_read(vcpu);
 	regs->rflags = kvm_get_rflags(vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 198f2f9..843d481 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2552,9 +2552,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
-- 
2.7.4

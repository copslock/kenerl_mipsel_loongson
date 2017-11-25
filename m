Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:58:58 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:38811
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdKYU5Xs-Uc6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:23 +0100
Received: by mail-wm0-x244.google.com with SMTP id n74so2544558wmi.3
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVmoETU56I1towG78R7tWvbffvKmfEFMIrlJGTg0eS4=;
        b=McsFX9qXNdI2Zespvgnyky0tB0juuvU+vCHDM5ZWZV1SuowdqhU56L19JGaifNQiai
         jUmWbzEI+AE5+LqPMdsJMqa+bQCjMuBT10m2TBBMxS9moC+Qc6hoJsqs3xcskv4/vQ8a
         LoZqwDm+0vEW9YaUUZ7jGObt4s43OhHTdqgC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVmoETU56I1towG78R7tWvbffvKmfEFMIrlJGTg0eS4=;
        b=BL2WPOm3g/dacuDwoV7ZXy+8nSv6EZ6DaePGr/vl5CEXupR1SWrvUY2kciipYqkjdY
         OaC+DA/i4JgVxY2yH8+fvbWfVipaa+9q4clWUzhcodjrxKKabmFgWL4js/yad7hn10Im
         Q3CWml3j0mG9rikpFoxJhiG/zkK5G7lWmMECtHvUuMxReGhSrFTTC9ZGy8x5eWXIFO8I
         4BgjZz2UASgl1S4WfQwW2/y4W/4ygrxQmxkLNB5/s1L4W3OuClg5J4jyyDMDFs9ex5HR
         CoKM5Eyg3Y6Orq+7MmQ6J6M1bk2lIESmetNzU06NqluBU9P2f5YaNprcGl4xJkmbxd37
         Ms8w==
X-Gm-Message-State: AJaThX7FxtQkrI5gkciiXlMwof2axsfEXAuVZyVaRArdjsZN9oDQjKi3
        2sQo8D5wB8guz4fTKW0jBbSbBg==
X-Google-Smtp-Source: AGs4zMaC/5o0JYTLSOK8lBc4iJGFIoZ3X8hteIPSVSrEu7gZ2q+7jv5dntIbEzcquj6ZKDCUdFWqQg==
X-Received: by 10.28.174.140 with SMTP id x134mr4497318wme.103.1511643438463;
        Sat, 25 Nov 2017 12:57:18 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:17 -0800 (PST)
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
Subject: [PATCH 04/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
Date:   Sat, 25 Nov 2017 21:57:07 +0100
Message-Id: <20171125205718.7731-5-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61081
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
 arch/mips/kvm/mips.c      | 6 ++++++
 arch/powerpc/kvm/book3s.c | 6 ++++++
 arch/powerpc/kvm/booke.c  | 6 ++++++
 arch/s390/kvm/kvm-s390.c  | 6 ++++++
 arch/x86/kvm/x86.c        | 6 ++++++
 virt/kvm/kvm_main.c       | 4 ----
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c93620e4b01f..1cb1020e044f 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1167,8 +1167,13 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		regs->gpr[i] = vcpu->arch.gprs[i];
 
@@ -1176,6 +1181,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->lo = vcpu->arch.lo;
 	regs->pc = vcpu->arch.pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 72d977e30952..04cfe6749858 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -495,8 +495,13 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	regs->pc = kvmppc_get_pc(vcpu);
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = kvmppc_get_ctr(vcpu);
@@ -518,6 +523,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 071b87ee682f..19b6299a5aad 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1430,8 +1430,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	regs->pc = vcpu->arch.pc;
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = vcpu->arch.ctr;
@@ -1453,6 +1458,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index aaeae92983a6..51ad3c6fc694 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2719,7 +2719,13 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	memcpy(&regs->gprs, &vcpu->run->s.regs.gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 18e39666ada7..f6594eb2b3be 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7285,6 +7285,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
 		/*
 		 * We are here if userspace calls get_regs() in the middle of
@@ -7318,6 +7323,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->rip = kvm_rip_read(vcpu);
 	regs->rflags = kvm_get_rflags(vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b6941320d6e5..759f3a1e042e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2560,11 +2560,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
-- 
2.14.2

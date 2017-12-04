Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:37:36 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:46284
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990492AbdLDUf7OVOJ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:35:59 +0100
Received: by mail-wm0-x242.google.com with SMTP id r78so8214483wme.5
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Yr7TSGZ1SuH5TipZy09dDY8RrRITMYHvX4N+nyLNNE=;
        b=Ht753t+l3AJ+HfX6vA8PYSME7tm9RyvUEA/mQkrQnjJsPrAcs3A+VUp7MULXMlDAxd
         Cj1KmGoKNvU2WM+oEPLRjVvDxtt4h4JQojVdHPYspEWGfIUODkeT9ICRvDTncTw8rUuK
         5KL7fuzUNmApOxPTT8WozXL280Rhsy3++t1ekOK8cX1tBCwdasfnAtMfjKW9KQSyWixK
         FJve9C83+mzU9PAQgxkRwB3ZGK9X2A6PQ5L/pDuSlecwUlKXPeUQo8rhfmz0vFbazXLh
         IluKMWerczrlARrmk2qN9j1hqLt0aYQutrp/LASeQlYaL4XPAUFtTxfb5tqwbxt5eVX6
         Mjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0Yr7TSGZ1SuH5TipZy09dDY8RrRITMYHvX4N+nyLNNE=;
        b=LHqlAZvSBILJJTOW/2nhDstvAmJ/I05EbEkVWTKQggBwV5ddH7RAmjZHkvXGvewP0H
         +skwIwqa4uq1Cyjz4uGZp/t4n12wN5wSWe3iDhG/oT/HQuPfXLWP8Hwd+rbBDwKQtx5m
         CPyMjyS6sx9WAF1wrinfRKD9gx/iV1ctYoGF9YXtHI0K0ARJQ0REVaaBknbqhrECYf/W
         KXMCCfWgKXps6jwhm/NlAKUu0tAit2qhsft4SsssC3YuEOKizVHvIeRAt3d9Zpv8TqNh
         QZe5xoGL6jPvf/xzCeZC6sUKV5ULkxezhHQGQ0fzjHiIigvuEkqHpuYUTofgaWFw4HX8
         UCbA==
X-Gm-Message-State: AJaThX4f2PIu0KpUb2PbfJDCg7q9uYpoi5Ev4E09JjZoWLy3I8uHS6kc
        RnuO3+zVFdTLQFT8vSRHhUUsKg==
X-Google-Smtp-Source: AGs4zMZp4cInuCcS7A8havJuFc+Zvr9QDO5gDyaCtlv5Vovu2CO2j5ajwQEqs3oTUb7QOdvukvZJIQ==
X-Received: by 10.80.140.33 with SMTP id p30mr31856860edp.19.1512419753928;
        Mon, 04 Dec 2017 12:35:53 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:53 -0800 (PST)
From:   Christoffer Dall <cdall@kernel.org>
To:     kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: [PATCH v3 04/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
Date:   Mon,  4 Dec 2017 21:35:26 +0100
Message-Id: <20171204203538.8370-5-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cdall@kernel.org
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

From: Christoffer Dall <christoffer.dall@linaro.org>

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
index b5c28f0730f8..adfca57420d1 100644
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
index 72d977e30952..d85bfd733ccd 100644
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
index 83b485810aea..e0e4f04c5535 100644
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
index 2b3e874ea76c..37b7caae2484 100644
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
index d9deb6222055..597e1f8fc8da 100644
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
index 198f2f9edcaf..843d481f58cb 100644
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
2.14.2

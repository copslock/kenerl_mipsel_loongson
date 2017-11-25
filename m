Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:02:07 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36038
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992196AbdKYU5iIZcr6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:38 +0100
Received: by mail-wm0-x243.google.com with SMTP id r68so28281784wmr.1
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMHtK4XT1rnBlaXMNbXsVNbWuHXe49QHEAm+dEIpggU=;
        b=CXCEBfrHxjufX/7hq2EEOeL0ebUREZO8WgVju1Krey6aIS/RHQAY3qMFwXmYPkuz7G
         QXvae8ttZjxTdNehVOqIu0Jw5vauMktbU3bePgyKe+89IPSEw3ELq5gL/DyV7px5QRdp
         Ke3fJmmPJAIXULusD2pamhEFozRJrLALdiZXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VMHtK4XT1rnBlaXMNbXsVNbWuHXe49QHEAm+dEIpggU=;
        b=j2KjrSGly9OMgNY47UcKOTurDpW0MbwbMFPeVVnKGIK9l2trRdljwvLuKSZ+AcxvPh
         n2sERZwotP2HH6pCYqnK8SBP3Y6bZBrHGdePFPyZRxNMl5awXpDddgLoQeYml/FXcdES
         qb0hEYMxqeGpyXxlgj5dKcBwGskP8KlehofZqTxK0TifdL29dzgR5SjwWO8VwFZaSFQp
         IhUeyB/4AKp2iQeYOvV06p0PwJrgJ7JeSfMHy9mRL/NsRO0Ujq6F32GfG00pEDS9BsZW
         6Y8N+3NOUj6+1dr6hWm8ZS3c7VsBc7E20khbpAPkINz12LxD7dHhAh/Sktbj/eB6Vta8
         RZ1Q==
X-Gm-Message-State: AJaThX6G5uqeAcUq49lfhA9giiBNIWSlk6199ikE5lyfDYKvM59F1yz/
        mFQQM0JBp8xZR2RGQKxrwEXhhQ==
X-Google-Smtp-Source: AGs4zMZ/roYukCLNH+M/yuVclPVPbaIYdDaF4G14v4FsTIovrInaUEBMezbTooTXVjoOnxogk0b+Mw==
X-Received: by 10.28.131.203 with SMTP id f194mr14114056wmd.39.1511643452770;
        Sat, 25 Nov 2017 12:57:32 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:31 -0800 (PST)
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
Subject: [PATCH 12/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
Date:   Sat, 25 Nov 2017 21:57:15 +0100
Message-Id: <20171125205718.7731-13-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61089
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
implementations of kvm_arch_vcpu_ioctl_get_fpu().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c |  8 ++++++++
 arch/x86/kvm/x86.c       | 10 ++++++++--
 virt/kvm/kvm_main.c      |  4 ----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ac26d95444c9..e4ddf6a5cb4e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2782,6 +2782,12 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	/* make sure we have the latest values */
 	save_fpu_regs();
 	if (MACHINE_HAS_VX)
@@ -2790,6 +2796,8 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	else
 		memcpy(fpu->fprs, vcpu->run->s.regs.fprs, sizeof(fpu->fprs));
 	fpu->fpc = vcpu->run->s.regs.fpc;
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09135bd759a4..f275fefbc4e0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7678,9 +7678,14 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	int r;
+	struct fxregs_state *fxsave;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 	memcpy(fpu->fpr, fxsave->st_space, 128);
 	fpu->fcw = fxsave->cwd;
 	fpu->fsw = fxsave->swd;
@@ -7690,6 +7695,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->last_dp = fxsave->rdp;
 	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6b87c24c60da..8f767922fbbd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2681,11 +2681,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

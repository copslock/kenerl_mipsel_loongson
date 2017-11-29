Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:46:29 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:41553
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991339AbdK2QlozlVka (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:44 +0100
Received: by mail-wm0-x241.google.com with SMTP id g75so7692791wme.0
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bXfLhAEXBmFfhF4Y9EDpbD2ojmAQNtJrWASQpFnQlEs=;
        b=IwSwInD36GPInvsJ0rPss88a+UA6wsQ8lggIfAwjr3lAtr/3k5WXNcg9GNkbu4ca0f
         p96o1AHcYIPWFYraqTzXnq/hiGimLCq8/FfIWYtm5bG/aSWv9+3EKj+/lQ9+Vm3sMT0y
         6QKLG7P9R8wkxOdHl53Jzmj2GdKyWalPeTD2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bXfLhAEXBmFfhF4Y9EDpbD2ojmAQNtJrWASQpFnQlEs=;
        b=IFl4R7BFt6a8W0YsTZDIf0p9p0Pr7rudOMRn6qq1hqTowfOzhQPdPpDV4qQcYqc2rB
         Gp43InlKs4RKtUy0Dh2f+XHVmteLQScDM6a6jEsvzo8Di6/PX5wTjb36oMXAnF2J6a3W
         RLQTq5+G8e31//1LA6XK7f2uWG4hCSHWTFdmrPW7ledUTzRJy4geyp5p/DEP6bS2p1sy
         DjbCuwXoU7qBfXK72DwbYgJO23rIXVJDsTmOg2FArNIBi/02ZRVLmYp7muXIid3pSBqM
         OzZ5bsohhaNYHPOgRH/9vjILdlvPbusMA+tBnyXtGtteQs4NW5QP4ARHtRM5x6F2+SR5
         oVig==
X-Gm-Message-State: AJaThX6kn6URbuEv7cWvTMUGpOakC+67851I2AyOX8mIe4hHkKOGcoAz
        ViUrNZt11xqpSz3MC+oXAkCGsg==
X-Google-Smtp-Source: AGs4zMbv+G1mcEGiWdi3mpvG9Runv4gYfnIkUrUzinx+nm7bxOIVZQoI1SLzwC/GXbalj4pstlCC2g==
X-Received: by 10.28.46.136 with SMTP id u130mr2680657wmu.127.1511973699600;
        Wed, 29 Nov 2017 08:41:39 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:38 -0800 (PST)
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
Subject: [PATCH v2 12/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
Date:   Wed, 29 Nov 2017 17:41:12 +0100
Message-Id: <20171129164116.16167-13-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61205
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
 arch/s390/kvm/kvm-s390.c | 4 ++++
 arch/x86/kvm/x86.c       | 7 +++++--
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4bf80b5..88dcb89 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2765,6 +2765,8 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
+	vcpu_load(vcpu);
+
 	/* make sure we have the latest values */
 	save_fpu_regs();
 	if (MACHINE_HAS_VX)
@@ -2773,6 +2775,8 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	else
 		memcpy(fpu->fprs, vcpu->run->s.regs.fprs, sizeof(fpu->fprs));
 	fpu->fpc = vcpu->run->s.regs.fpc;
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a074b0bd..8b54567 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7679,9 +7679,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	struct fxregs_state *fxsave;
 
+	vcpu_load(vcpu);
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 	memcpy(fpu->fpr, fxsave->st_space, 128);
 	fpu->fcw = fxsave->cwd;
 	fpu->fsw = fxsave->swd;
@@ -7691,6 +7693,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->last_dp = fxsave->rdp;
 	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c688eb7..73ad70a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2673,9 +2673,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.7.4

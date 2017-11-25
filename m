Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:03:22 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:42727
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992206AbdKYU5nrJEJ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:43 +0100
Received: by mail-wm0-x241.google.com with SMTP id 124so10890323wmv.1
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmh69YdXQ9v239cQEb7aUvanC5tbQkPr6uCJ6FFCp20=;
        b=NYF/C4lDPkh150iGl2i1WfVw0h82y3DAl4zpI1/bQQKhzlvn9jKPMTl3HEQzHigl+5
         f8OgN5RJTJRL/qGwHOJRlMSxLd57GLkjZJ2Nn04F6h0nSIe6kXoWHn8KjstDp7E8JHZF
         LaEiTR3P0W+zxPt9U2KMam6PjX9XTpxNH7bnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmh69YdXQ9v239cQEb7aUvanC5tbQkPr6uCJ6FFCp20=;
        b=d+dRH5h5rb0NMttbRjN+boFX6NWe9tm6/6kPliFsi11UOk1JB4gd5U1vkB2c7VobAL
         xuWDYVBjyBI03F8p37tgACBZOFCCcqILvhzUh7w4Ox4eMEIzi99aHp1TojRkn/+6E4ca
         dfubUq7A3wRuyhC8Cr/G0sZqXFYo0ZGKE7nMLEL75ogr0EcHqV28SusRLZErcBPYt/oC
         VHE04MMtn7cEagqcNX+eiOPSpvIg771or/xjGDz+ZlIzK/Ka+7BTxTTbTNYcKo0W/n6W
         XbG+J+diWXF+PUObTgnhGPLH6U4x2ylzdn3BImm7XU13uqankQbRlJalny64fiN/i3lG
         DfWQ==
X-Gm-Message-State: AJaThX7NZGh3o2MMgSPF1XdDxIOFtSNYtXC/Be/UbaF/p6lu7MLDmEJq
        w83C02ofaEa6W6TFKo9rvS6+zg==
X-Google-Smtp-Source: AGs4zMZPZzh+/lkBGu/qYcT6IdSyKm4cwvAREsGOp3hedZf3kY7NWWinMXxyY9t4/BzoPGTTEB+kmw==
X-Received: by 10.28.132.213 with SMTP id g204mr4653790wmd.90.1511643458400;
        Sat, 25 Nov 2017 12:57:38 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:37 -0800 (PST)
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
Subject: [PATCH 15/15] KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
Date:   Sat, 25 Nov 2017 21:57:18 +0100
Message-Id: <20171125205718.7731-16-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61092
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

Calling vcpu_load() takes the vcpu->mutex, registers preempt notifiers
for this vcpu, and calls kvm_arch_vcpu_load().  The latter will soon be
doing a lot of heavy lifting on arm/arm64 and will try to do things such
as enabling the virtual timer and setting us up to handle interrupts
from the timer hardware.

Loading state onto hardware registers and enabling hardware to signal
interrupts can be problematic when we're not actually about to run the
VCPU, because it makes it difficult to establish the right context when
handling interrupts from the timer, and it makes the register access
code difficult to reason about.

Luckily, now when we call vcpu_load in each ioctl implementation, we can
simply change the non-KVM_RUN vcpu ioctls to only take the vcpu->mutex
instead of calling vcpu_load(), and our kvm_arch_vcpu_load() is only
used for loading vcpu content to the physical CPU when we're actually
going to run the vcpu.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c |  8 ++++----
 virt/kvm/arm/arm.c     | 25 ++++++++++---------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 0375d1f977c8..891d5c5e6e4f 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -363,9 +363,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	int ret;
 
-	ret = vcpu_load(vcpu);
-	if (ret)
-		return ret;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	trace_kvm_set_guest_debug(vcpu, dbg->control);
 
@@ -387,8 +386,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		vcpu->guest_debug = 0;
 	}
 
+	ret = 0;
 out:
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return ret;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a1b486a71e85..5095366d3b21 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,29 +381,25 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	int ret;
-
-	ret = vcpu_load(vcpu);
-	if (ret)
-		return ret;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	int ret;
+	int ret = 0;
 
-	ret = vcpu_load(vcpu);
-	if (ret)
-		return ret;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
@@ -416,7 +412,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		ret = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return ret;
 }
 
@@ -1009,9 +1005,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_device_attr attr;
 	long r;
 
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	switch (ioctl) {
 	case KVM_ARM_VCPU_INIT: {
@@ -1089,7 +1084,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return r;
 }
 
-- 
2.14.2

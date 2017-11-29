Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:47:45 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:39102
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990591AbdK2QluQMAea (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:50 +0100
Received: by mail-wr0-x242.google.com with SMTP id a41so2106111wra.6
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SMAMCHKSC1HcI/GbmUe7V6halIvCVXcjhvzl4oipgAs=;
        b=RMToeji08XwRVgbkZaS+cH6tIJWPo7MmHK4OK3EVuLjylKkQamKAoG5NasiVcOGioG
         I2CIq9BsF9/o15Zs2zgZl7n99F6UR5i+vCUu2muKHETwdU0PEjYd84NjEQxh/ZbfQ2JZ
         5UBub6+u3JSyl4u6xjBUAkIKuQPp9M/QopRKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SMAMCHKSC1HcI/GbmUe7V6halIvCVXcjhvzl4oipgAs=;
        b=pNnLIbInc/MhCi5xLM4rnS63ChotjHdMjsNhHx9C9IhAz9y2OXB/IeGq3YbnmHTzvT
         acT10ArucR9W5DXVd/Eq0010Kx94ep6jUFzLCSWXnlTdPG5gFg0QBsbjFb3k816rvBCo
         1M1hP3/+dDnnc/pMBF3ZkLcG1ZAx7M2b+W1gu5FUsrogwXzVOqLvHIdGuymvTIUSNlg4
         sUHDjQx+XR/Ehr6THOld6LcfjlSen+IqXd7Gx/7S8t/pvTLP3Ab/X0g7c0eGANi1UvNx
         7yChMW2LSnEb5j3/y/P+tD4jmqkvHTfdM38851NfVEwtDWf97TSiVaJXfnKl0blbs6Ke
         zclw==
X-Gm-Message-State: AJaThX4QTr1AYdpKL/UCULdCTdtEpDWL1WcGVhKNiNQCdJzjk/D0iQnQ
        harotZxv6koIrWaym8gWtnTiiQ==
X-Google-Smtp-Source: AGs4zMYVc8nZoRG5cuuoZN1HaIpzmLYSjJUtDuN39WyFPmFdQwf2cXDAWWBIO8D4oUShK5GUlZMYEw==
X-Received: by 10.223.190.2 with SMTP id n2mr2954077wrh.44.1511973704899;
        Wed, 29 Nov 2017 08:41:44 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:43 -0800 (PST)
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
Subject: [PATCH v2 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
Date:   Wed, 29 Nov 2017 17:41:15 +0100
Message-Id: <20171129164116.16167-16-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61208
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

Calling vcpu_load() registers preempt notifiers for this vcpu and calls
kvm_arch_vcpu_load().  The latter will soon be doing a lot of heavy
lifting on arm/arm64 and will try to do things such as enabling the
virtual timer and setting us up to handle interrupts from the timer
hardware.

Loading state onto hardware registers and enabling hardware to signal
interrupts can be problematic when we're not actually about to run the
VCPU, because it makes it difficult to establish the right context when
handling interrupts from the timer, and it makes the register access
code difficult to reason about.

Luckily, now when we call vcpu_load in each ioctl implementation, we can
simply remove the call from the non-KVM_RUN vcpu ioctls, and our
kvm_arch_vcpu_load() is only used for loading vcpu content to the
physical CPU when we're actually going to run the vcpu.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c | 3 ---
 virt/kvm/arm/arm.c     | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index d7e3299..959e50d 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -363,8 +363,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	int ret = 0;
 
-	vcpu_load(vcpu);
-
 	trace_kvm_set_guest_debug(vcpu, dbg->control);
 
 	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK) {
@@ -386,7 +384,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	}
 
 out:
-	vcpu_put(vcpu);
 	return ret;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 8223c59..a760ef1 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,14 +381,11 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	vcpu_load(vcpu);
-
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
-	vcpu_put(vcpu);
 	return 0;
 }
 
@@ -397,8 +394,6 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 {
 	int ret = 0;
 
-	vcpu_load(vcpu);
-
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.power_off = false;
@@ -410,7 +405,6 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		ret = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
 	return ret;
 }
 
@@ -1003,8 +997,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_device_attr attr;
 	long r;
 
-	vcpu_load(vcpu);
-
 	switch (ioctl) {
 	case KVM_ARM_VCPU_INIT: {
 		struct kvm_vcpu_init init;
@@ -1081,7 +1073,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
 	return r;
 }
 
-- 
2.7.4

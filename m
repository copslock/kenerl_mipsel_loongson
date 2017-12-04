Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:42:18 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:38195
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994627AbdLDUgOsx7g6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:14 +0100
Received: by mail-wm0-x244.google.com with SMTP id 64so16585992wme.3
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZmUolxszHLEISu3ZCcad6hveUOgpZrBDUcufGrh29MM=;
        b=BWZOtAiw74nC4Aw7zNCxXliCOmljsMPrESGG+AliK4NGWRgCEbrBagi5kGShWhauXb
         +NgATAcrJP7plzBT+9aw6u+bx1qUHmV9GMa8oalViIaYnCMOAi5KH80gAZ3ShBCr/NPw
         6kLd4gfzEy/shZEl4MfSw5/tNCeOAQmGiBhxnEzCaJ6yeTBC2JWg6yTFn7qo0aCTW/lO
         urfOVp3IZ1zjKgZWTer0S3jcRdNh5RJoIMWuDHtTlmDb3gv0J1kW091YArl/jULfLxMI
         pH+k4XVk0K17wPQpB6Qio1iXRBrHDfVThdQYrXaaPKGINsmbwnruq4yTWRymKLWKneWm
         Aj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZmUolxszHLEISu3ZCcad6hveUOgpZrBDUcufGrh29MM=;
        b=R5sZIhj6i9wnr8hCXZSFfDa4fYCgJFTQSZiP+4f6MdIpqoy6s8fSLvbbHVGdpzV+aY
         K5JpJw1RVgSBt6ha363GNeq0aoOaMIlRty6i01AcgZgjYCZPE6gZp9nqPcdboQJlZ/us
         HY3ZvcxSWHszk1ojkmYruXOv+IR9kaLvRboOcpLUA316QWzXQUGSuaJfI9Wyk8LGt74f
         kwqiLkkYr5yHkQchxPmnsN2TVUZvaj+81B4f+eLRUI68TgN2WMuGx2LovK4FUvZDqpTK
         cSRlV1DqhcQeM2BWIT1mp0LiDoyfq33xZ7eTGmVY0QWJml+F+ke9G8YRlBXSqGw+l288
         jqnw==
X-Gm-Message-State: AJaThX67dGiCotfO2XI5iJOqvVQFcc0dJwtEE8f+pEcYojXGPfeJXfs5
        gIAqUmr3IGIViA2FrvMXG1engw==
X-Google-Smtp-Source: AGs4zMZ6RQMSK9ZZHPcHqXGZEVSH5h6Btv7MZMLsYoV2/qLrjYNMM4UZL5FJ2Vv36wQGmcUDiPVlfQ==
X-Received: by 10.80.166.34 with SMTP id d31mr32321894edc.96.1512419769523;
        Mon, 04 Dec 2017 12:36:09 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:08 -0800 (PST)
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
Subject: [PATCH v3 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
Date:   Mon,  4 Dec 2017 21:35:37 +0100
Message-Id: <20171204203538.8370-16-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61302
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
index d7e3299a7734..959e50d2588c 100644
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
index 8223c59be507..a760ef1803be 100644
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
2.14.2

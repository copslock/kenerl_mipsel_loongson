Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:00:36 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:39065
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKYU5cq9jq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:32 +0100
Received: by mail-wm0-x242.google.com with SMTP id x63so28040046wmf.4
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x5Fl7ZbU8WHXQH0NNsg7YpG7IqvScDT5k45o/NtmXJ0=;
        b=IQUkbuDAvQmVZIXM+rl8ssKYDNqAmd/7F8eeJFBcoaUTkhaWKquT+UwP+actdj8f0p
         K2gM8W1wXMaumhxPyGw4ok93aYBu9ZGzJqO+DjqbTGgc3Fh+Fek1tOV2ETL+T5bmbOTK
         Pej6OWy1Gax+qo1blUv0XVunfTVRMMqF5q7wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x5Fl7ZbU8WHXQH0NNsg7YpG7IqvScDT5k45o/NtmXJ0=;
        b=Vj8YRUn5SMM2DlFSOMMkaSXy/Q9kXrb+LRuh54amE5FocsG5D11STDh5cPfdEfoRn+
         HXkYL4KWJoPimM4rRVdUvbWJFFLxXTvaWlGPv+2vQ7W8l6Jan/QDAk3HMOhgRgXKMb/Q
         PYDqPajfvUTMhKrcOovH8SZTBJWGqDKY8k/rup9cYHIJZNbe778KZ5Hg7MiIxA8/5TQw
         bl7ZW05GD6/IB0m4X4TDpROg/z6xauVphU6/94HiYAwRkv9S6z3yO/ucMBmveiE9/l6/
         eOvItEqQitJiURmx+J2u3AhlJ1IGzdao7p+ZXZHtZjfxBRaaxMWu0PrWHmf3jNnwRtNh
         kmRg==
X-Gm-Message-State: AJaThX5blGaWav/RuXNhUTVYTQZ9oEpjyPAqNiGfU/94imFwlMCyQ3aj
        oqJnIwDyPz6rhOVEWkhFzK7DeA==
X-Google-Smtp-Source: AGs4zMYHXXL4EqCPPpXTzA7/PzDgPg5b9lMzwkTOcOaoDmWEJ0LudnOIacS5iDPVFlOLjayAO5elMg==
X-Received: by 10.28.159.15 with SMTP id i15mr12563282wme.58.1511643447145;
        Sat, 25 Nov 2017 12:57:27 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:26 -0800 (PST)
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
Subject: [PATCH 09/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
Date:   Sat, 25 Nov 2017 21:57:12 +0100
Message-Id: <20171125205718.7731-10-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61085
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
implementations of kvm_arch_vcpu_ioctl_set_mpstate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c |  7 ++++++-
 arch/x86/kvm/x86.c       | 17 ++++++++++++++---
 virt/kvm/arm/arm.c       | 11 +++++++++--
 virt/kvm/kvm_main.c      |  4 ----
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ccaf5088b73e..aa76d2988178 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2870,7 +2870,11 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	int rc = 0;
+	int rc;
+
+	rc = vcpu_load(vcpu);
+	if (rc)
+		return rc;
 
 	/* user space knows about this interface - let it control the state */
 	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
@@ -2889,6 +2893,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		rc = -ENXIO;
 	}
 
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71f0572a4e4a..1a4fa1f2fa46 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7446,15 +7446,22 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	if (!lapic_in_kernel(vcpu) &&
 	    mp_state->mp_state != KVM_MP_STATE_RUNNABLE)
-		return -EINVAL;
+		goto out;
 
 	/* INITs are latched while in SMM */
 	if ((is_smm(vcpu) || vcpu->arch.smi_pending) &&
 	    (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED ||
 	     mp_state->mp_state == KVM_MP_STATE_INIT_RECEIVED))
-		return -EINVAL;
+		goto out;
 
 	if (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
 		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
@@ -7462,7 +7469,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	} else
 		vcpu->arch.mp_state = mp_state->mp_state;
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
-	return 0;
+
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 4f36e6dd4d5e..631d04d87b25 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -399,6 +399,12 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.power_off = false;
@@ -407,10 +413,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		vcpu_power_off(vcpu);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	vcpu_put(vcpu);
+	return ret;
 }
 
 /**
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b7c821e0244..bcfdb4800e44 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2626,11 +2626,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
-- 
2.14.2

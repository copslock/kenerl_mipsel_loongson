Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:44:49 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:43963
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdK2QliKKqVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:38 +0100
Received: by mail-wr0-x241.google.com with SMTP id z34so3970134wrz.10
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZPnP6nGssexHqRuGMm7Nw54fNn3j2sNXvS0KdU9Vuo=;
        b=N4lc+1TZ4IuA94W0xVQkItJ9hkWjsMe7X1qFj282paEauSldcq7uwimNtQjdrE8y9A
         pk9cxbHmMRTwyMeHEKe1PQlVOSDK6IcKvbMTS6KKfM0t+pt8BT2wg5tzRbH9W2YttYkr
         Ktepx0k5Am9tnRF0ZU06q/Uvd8j9SPQkA28SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZPnP6nGssexHqRuGMm7Nw54fNn3j2sNXvS0KdU9Vuo=;
        b=TYqg5GSW+PWOCy6KbWA8svfW+NKrvs5zbdjG1i3M0uW1qz0QvNGuAR5ipkTLTIGIRP
         KNAOh20Up7HVfSpmukqbGBhz9RrysqjTncljmBGj8TSkIwOu1U1lDhGNvqlz1CrXE5/8
         Zn4HauL/z3B1Z7NchKZ/hev8W5nre1hzm0zAuAiQfep4ggZQg7TZlMqp/KZyYEZYIOLr
         p28IoIQ3mvq9b25zfQLM/yKrj3pFACpNJTWWhhToDEgE2W0wxr6pwD2xmAWEY5GT8meF
         zjKlt0AANZqIn+S8znTGT1k3JEVuB8wjYiNiP+nOL1X4fsIB26P6pAx+UeDCtzjhgRa+
         VzRA==
X-Gm-Message-State: AJaThX5mD6TKvClH11fFjq+lIwVj/4H/wly0QNqxnq8nTqN7QrBmHR2l
        S0xsz47uBcG5M3YOPNj0HYeHwA==
X-Google-Smtp-Source: AGs4zMZtutc7gal9/VY5Igy84dOd0GGM9MySY12GMSde5kHkdTZl62fPX0BE31Dd0sb0E41oxoQFkQ==
X-Received: by 10.223.188.81 with SMTP id a17mr2862652wrh.146.1511973692836;
        Wed, 29 Nov 2017 08:41:32 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:32 -0800 (PST)
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
Subject: [PATCH v2 08/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
Date:   Wed, 29 Nov 2017 17:41:08 +0100
Message-Id: <20171129164116.16167-9-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61201
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
implementations of kvm_arch_vcpu_ioctl_get_mpstate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 11 +++++++++--
 arch/x86/kvm/x86.c       |  3 +++
 virt/kvm/arm/arm.c       |  3 +++
 virt/kvm/kvm_main.c      |  2 --
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d95b4f1..396fc3d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2836,9 +2836,16 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	vcpu_load(vcpu);
+
 	/* CHECK_STOP and LOAD are not supported yet */
-	return is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
-				       KVM_MP_STATE_OPERATING;
+	ret = is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
+				      KVM_MP_STATE_OPERATING;
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a31a80a..9bf62c3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7440,6 +7440,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	vcpu_load(vcpu);
+
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
 					vcpu->arch.pv.pv_unhalted)
@@ -7447,6 +7449,7 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 1f448b2..a717170 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,11 +381,14 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	vcpu_load(vcpu);
+
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 19cf2d1..eac3c29 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2603,9 +2603,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.7.4

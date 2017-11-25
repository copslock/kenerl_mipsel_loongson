Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:00:56 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:35850
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992157AbdKYU5crftI6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:32 +0100
Received: by mail-wr0-x241.google.com with SMTP id y42so23043729wrd.3
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6IFBzjgEr22DUAF1SgjokiML2Oq/bb3KXNMGvCdaxVA=;
        b=c/1nKChPnRPfGwaH/OhQWxQQaY1TL6rwrhvobEwSSfy7ey2PN4Kml3r32Wk83AuMDu
         ybiwa2WOWMBHJltG7EatXFPYIlSS+9a0OGqY2w2M/+K1r2Gj22HmW0WAbfiVD52xfRj1
         8tZvov9WvcA4eKhE+iG6jpzCmyYSPnFQveaeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6IFBzjgEr22DUAF1SgjokiML2Oq/bb3KXNMGvCdaxVA=;
        b=jNS819UC94HlN2qEcso+VgtMVx0XTEFWpCZjBhcYxXqJK0xmAwTUCEUW7AGPWAeUX7
         hEAdnEbpN4bvklZw5vR6bEptgMir6btxl2dUBcpI2ugh6eUObd2F9W7kOWu5hMIpEB0a
         Cx2k/Y+SnNnGKgEJtgBSsgb1iaPbT+ZnA/WMpBZSaMcvwfEMQqtwsYkWyGerR/JK3/nu
         FCLVRzo9g5JeoIFGxM7R9oy+cG0LWm4ESbLQoWhEmy/T76T1YzTnCEOmICA8cZFuRYzL
         Lx7SVGXL+qX/hsqzMxew6Mrr8z//4VOZQaITzTiqdwHu5eESLBnVH1X/VWi5T2f/g1u9
         qz3g==
X-Gm-Message-State: AJaThX7S6S9zk11UUAG0czgnoDd5YpMzFbim9DegOgMfBgRoG41E/uaM
        H8OCfDEpfFSdbHCAGzWsCruQQw==
X-Google-Smtp-Source: AGs4zMbbWO1URsTuHDQ0XIoN07qbqUsnsunu6cpxJfR9gqQ18lBKx3Ezk0fBxRvSbkBxQvnpv+meGQ==
X-Received: by 10.223.151.49 with SMTP id r46mr30309902wrb.238.1511643445218;
        Sat, 25 Nov 2017 12:57:25 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:24 -0800 (PST)
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
Subject: [PATCH 08/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
Date:   Sat, 25 Nov 2017 21:57:11 +0100
Message-Id: <20171125205718.7731-9-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61086
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
 arch/s390/kvm/kvm-s390.c | 13 +++++++++++--
 arch/x86/kvm/x86.c       |  7 +++++++
 virt/kvm/arm/arm.c       |  7 +++++++
 virt/kvm/kvm_main.c      |  4 ----
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 51569cc97a07..ccaf5088b73e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2853,9 +2853,18 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
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
index 1a701a2f25a3..71f0572a4e4a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7426,6 +7426,12 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
 					vcpu->arch.pv.pv_unhalted)
@@ -7433,6 +7439,7 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 54d9aa533df9..4f36e6dd4d5e 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,11 +381,18 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f68f45e64967..8b7c821e0244 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2611,11 +2611,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

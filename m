Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:40:59 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35997
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbdLDUgKa5pP6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:10 +0100
Received: by mail-wm0-x241.google.com with SMTP id b76so16707824wmg.1
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0jA6jwwKq/w9QX6Sb+PJi/1faDcXiI97NtbAWON3tMM=;
        b=Cw6UZNtTULNDo1fU/X6OUgrpJg6o7i9Nxa/HjHIEpXefoNbs+a0eJG418L0b5/7c5q
         HBm8ga56pJaFMEDdHW2g90eMPfTwB/FKVDQKS66BuA4Pz7vWwjM0Jozd7GOLEDfETpjN
         Sj19ZmNRe13XXGzsNdsQoweK++GQ0YpJrFMmgSzxMHh4nvtpsKbc0oPYsmx92f8ij4VD
         GGimReEl2WbpMIYKdUgzmzligAU111zSBHm5xH2VEY0m0WicFRAC5iZ+M18LF/XYxn2L
         1ksvYdUf4ATG0FK89qsINutfP0KCrhgkgclJkJTLdQ2+ghjWBO0tO1fctBo3823VKLt8
         wPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0jA6jwwKq/w9QX6Sb+PJi/1faDcXiI97NtbAWON3tMM=;
        b=ESaEKMThA2t8XP7r2iCc+0n9tBnSoChUpBL/TshTez3zOX3eLs7vWSErDKADWiQecp
         u268H3oroiKpBew9QwVDv4iVWywkQIsAdjAQC8+H4lY7oNlYgLRF6A8D1eIb2ThjXta/
         SsrLjnxk59o8L2t1QqBi+VOQVZeSLusK63r/6uOtp8UJMeZxb5hzXF0r/61UwXP3LwRG
         ZguLIANeZaJCylzMJrEXTEs0yDR0k+bPYNCixKf7t0xeZAgG9Vv4a4lZ28aOgWk3uVBk
         lpxvjMYxtIlO6iBcOG2Wy+R8QXhp2KxHNeBMu+3Zm1w46AmxBrssGuM0opXFKhGtEdPc
         3hAg==
X-Gm-Message-State: AKGB3mJXzPpgrTNeNrN+NvwSbhSNX6CkuDSNuFzGMi3RHfZOvB2AX2fg
        avs9qO4tfh6KPKTjMas5dwWE6A==
X-Google-Smtp-Source: AGs4zMbcOXdLLFKvrX6kVFhAZhjqnoumP7Njt+KqnF197iTzI7VZxnVTA52ADCtTBDNjLrc70j5hcA==
X-Received: by 10.80.165.41 with SMTP id y38mr1230084edb.72.1512419765211;
        Mon, 04 Dec 2017 12:36:05 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:04 -0800 (PST)
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
Subject: [PATCH v3 12/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
Date:   Mon,  4 Dec 2017 21:35:34 +0100
Message-Id: <20171204203538.8370-13-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61299
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
implementations of kvm_arch_vcpu_ioctl_get_fpu().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 4 ++++
 arch/x86/kvm/x86.c       | 7 +++++--
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4bf80b57b5c1..88dcb89656be 100644
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
index 5d19caee6d51..19b70e016858 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7678,9 +7678,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
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
@@ -7690,6 +7692,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->last_dp = fxsave->rdp;
 	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c688eb777bec..73ad70af6b2d 100644
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
2.14.2

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:02:36 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:42726
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdKYU5jsCSQ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:39 +0100
Received: by mail-wm0-x242.google.com with SMTP id 124so10890190wmv.1
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCt8PKDwj8NdxkYkTRO/tiMpMynrFEUWAHQZsoHGuu0=;
        b=BdbI7PVMIMYMxkUy3u4R0Q4g97BuVrAwOSUge58npKm/ZtzXrvPPO/Ob/Du/OC+jPG
         Gafnzc3ImU3VR4C+5weSq1ATmc5XCFoQLy2lqACLcioCNwnpN6F8x0w2kEz0oQF61fME
         3vfBKOTglO0btuPh2Ogyzp1vvDg3g87vTjc/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SCt8PKDwj8NdxkYkTRO/tiMpMynrFEUWAHQZsoHGuu0=;
        b=kHyA8pk75IN87YrqA/R4bdKijoUi4v8iHoJln9eGGoRYujk9IWIE/bLLCvnRN29h89
         VwaTLTK95lzbbP69Blq8crdu6Q+OFF8E7Uq9RmU5JLw94Ctle5onMbXPIJj/bfvYSo8o
         IkcBLiVMErbZzDTy+FGtjQCCzti55x+0l7QOFf5OqVwfhJDEhsol/XQDO2gJZkX+9Ulk
         ME1SSVFbfXrmw9Etpay67AxoRqDkCElToSxOcI9TpwliiNuu7LpDm/+GyQXoyRJwOQdJ
         TIh8cs5OE04AIFeMwwZARHoR5wQ8P3jAtxUG3HznpTaIAl062HD/A71bYqXRwTnSTi14
         6mdA==
X-Gm-Message-State: AJaThX7t2OP3o4wPz+AaQER5nMUTifxdQtvdJPZ4krOrYK3n+Qk9H3/f
        I8ChkX3lnRWZi8UVX3xqPzfpwQ==
X-Google-Smtp-Source: AGs4zMY77LHfAeb6uGAIzKVGOux3ismS1De3ouZmiwNriq5l2t82Whhcup9P/F17f2lKcmZ5vqARsw==
X-Received: by 10.28.6.2 with SMTP id 2mr12557438wmg.37.1511643454449;
        Sat, 25 Nov 2017 12:57:34 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:33 -0800 (PST)
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
Subject: [PATCH 13/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
Date:   Sat, 25 Nov 2017 21:57:16 +0100
Message-Id: <20171125205718.7731-14-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61090
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
implementations of kvm_arch_vcpu_ioctl_set_fpu().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 15 +++++++++++++--
 arch/x86/kvm/x86.c       | 11 +++++++++--
 virt/kvm/kvm_main.c      |  4 ----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4ddf6a5cb4e..46d015083136 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2769,15 +2769,26 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	if (test_fp_ctl(fpu->fpc))
-		return -EINVAL;
+		goto out;
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
 				 (freg_t *) fpu->fprs);
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
-	return 0;
+
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f275fefbc4e0..230d552cdc4b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7701,8 +7701,14 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	int ret;
+	struct fxregs_state *fxsave;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
@@ -7713,6 +7719,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->rdp = fpu->last_dp;
 	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8f767922fbbd..08a610619572 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2697,11 +2697,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		break;
 	}
 	default:
-- 
2.14.2

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:41:23 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:37747
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994626AbdLDUgLugfl6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:11 +0100
Received: by mail-wm0-x241.google.com with SMTP id f140so16627589wmd.2
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sNphlMbDKiBIPVVmKYnzJtUTOvcCdWKJRmCkp2sPiM=;
        b=Nmc6iqaEKdu5Hdp4B5yzpdUuFxFm2p2hvoG7wnOxBCjreTYVuM5SerPbgwacQNkjzf
         txyAuBwsbZ+etzg8fCl2Dsg/3BYCgOGLJvCbcRFPNxgj43yIJFMKJ+k1H8kjwE6nasq8
         27FLr7sb5zyGapwjSl8gvs9hF0islUOft1oBuamehtP5+6dAL0Tp2n3BsFtV5wbzHeZ2
         tuqrug5gHWY9b94bnH2FN+mfzHzpNC/IFG6cQz3rXit5DZr1mPu6wnBJOmO/Tbgo1psG
         IAWGl2D1VEJfL4xd0PiPTCC0khPmuURyFz1B62yhK2MlxlmfVHeFhLviKCsCiPHFWa0M
         S0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/sNphlMbDKiBIPVVmKYnzJtUTOvcCdWKJRmCkp2sPiM=;
        b=PhJlyz2pakxcFHC3UHttbxKDnlh/s3MlH2MYFMFU1nAeT5Rnnb9V1C92O21R+dQW4u
         h5MC6AgLU5vxYcNcC8iiskVyPyz/jtyQdR1g0OTENsvsM07hHRPR4zLM4GnpQGIS+Z0M
         prPtzJZDQmnGKQ4U5W7sj5NjUza1uRUAabhxVWoJozO3/GLkzvzX00ty8jrdNx61ruOV
         QtP4Z5Ri7NtUzojX+iZ4tzYEFQx4FhjUajIaWrFwUsqy1A2F6qdpYIqRNJwy9zJN5E5N
         FPmIlXlYG1ZR99aalcckBsXdfnmtZ7GIc60cpWfRcGADQYXi4OqcBTleTMlj71aPM4Ju
         kP1w==
X-Gm-Message-State: AJaThX7FMTxNPSCRgYLIwseAxeejOk5k8kY3bVsduUs/i7sYwGoWXxYn
        Zq4jC3gKflbn0vs6dKERrd1Kyg==
X-Google-Smtp-Source: AGs4zMaJwFMjVdWw9m5Qy4MWHBdyMWWc3tiO59muy39op+PH76epdv+6jwgx1v/OVLzvXxFArVOE+w==
X-Received: by 10.80.240.200 with SMTP id a8mr32259168edm.288.1512419766569;
        Mon, 04 Dec 2017 12:36:06 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:05 -0800 (PST)
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
Subject: [PATCH v3 13/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
Date:   Mon,  4 Dec 2017 21:35:35 +0100
Message-Id: <20171204203538.8370-14-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61300
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
implementations of kvm_arch_vcpu_ioctl_set_fpu().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 15 ++++++++++++---
 arch/x86/kvm/x86.c       |  8 ++++++--
 virt/kvm/kvm_main.c      |  2 --
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 88dcb89656be..43278f334ce3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2752,15 +2752,24 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	if (test_fp_ctl(fpu->fpc))
-		return -EINVAL;
+	int ret = 0;
+
+	vcpu_load(vcpu);
+
+	if (test_fp_ctl(fpu->fpc)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
 				 (freg_t *) fpu->fprs);
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
-	return 0;
+
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19b70e016858..95a329580c8b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7698,8 +7698,11 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	struct fxregs_state *fxsave;
+
+	vcpu_load(vcpu);
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
@@ -7710,6 +7713,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->rdp = fpu->last_dp;
 	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 73ad70af6b2d..06751bbecd58 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2689,9 +2689,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		break;
 	}
 	default:
-- 
2.14.2

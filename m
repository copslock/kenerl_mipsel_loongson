Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:38:56 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:33108
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991526AbdLDUgDqg0O6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:03 +0100
Received: by mail-wm0-x244.google.com with SMTP id g130so16222143wme.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=av+QFbSSrODWlW8ibViZv5MIzeuxutucuP1Fj2b4Bjc=;
        b=aQ52aevwRj2dUdIn2wESr23Ptly6NjOVrZfoEfYikfprlCe5I2JPO4etW8OWN2HGlP
         Ge8fAZ34zgbW2tVSh8Odf16oOuIsavZq6GJY1Jp2DeLw16suvwk9chhh1i0HvZcr6SyM
         eg2KekoOWMOTHgFEkusW07Y5X+kd4Kk/8B/sD8ndwpy/r/OPaOp7pjIYfHiP96Z+8tkP
         1RANOWjffbgJU8j6ylMG5t4DpWk5iRAAimT1nMH1dY4xOD3sXFpYZ/G1KLSOI5GFc3Bx
         UxLPpVfRO5TpqnfUBNeQCeDBakOl18EjG0iMSJPGfa7vECPxLGYPPAM8tDN/9wOLBbyT
         VC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=av+QFbSSrODWlW8ibViZv5MIzeuxutucuP1Fj2b4Bjc=;
        b=S7OnY98+g6ANgvxDULHH610z7l03eShCRWkSdKmxK1ldoWsxepvXyZTvVJpkdQ/LDR
         5YZkxakeMyZiuQoBplgSDEU3fb8+dAMJbIYKDjRYv/cLCUPMewpybxbxqFnrMTD3diOP
         lQ1qdMx2f4EGBpj9Yw6vvcxz7PF4TycoJ+20oe+pkcb54TIOP5eunHTAZfAjGx1uxZdR
         x8UmzRMuhi/RSweZ/do1sUitHLC1XOeU5cUzfLzK58/E9WFiKO8B2h2wWAcvxeLHzm7e
         pOvxwK17/KCA8SdWRBCdQNMLKUnIpvaZfiqR8UpjjiHbYOdIGZOGweMw5/VVkzpeDCRY
         o3YQ==
X-Gm-Message-State: AJaThX7yKvJ+efBrjbCNdt90uU4XMyw3dHwqVSqz4cy154hccoXbmvtp
        8WfQzOEHJdgBXta16MAGZQozEQ==
X-Google-Smtp-Source: AGs4zMZZfTSx6V6cq8gtgpyYjoKkfPKtPlQtiPg3/7ypFfZ6CYOJ+GhigZUrx85J6Tw2oflYoQPI7g==
X-Received: by 10.80.137.244 with SMTP id h49mr32741040edh.303.1512419758100;
        Mon, 04 Dec 2017 12:35:58 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:57 -0800 (PST)
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
Subject: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
Date:   Mon,  4 Dec 2017 21:35:29 +0100
Message-Id: <20171204203538.8370-8-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61294
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
implementations of kvm_arch_vcpu_ioctl_set_sregs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/book3s.c |  8 +++++++-
 arch/powerpc/kvm/booke.c  | 15 +++++++++++----
 arch/s390/kvm/kvm-s390.c  |  4 ++++
 arch/x86/kvm/x86.c        | 13 ++++++++++---
 virt/kvm/kvm_main.c       |  2 --
 5 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 6cc2377549f7..047651622cb8 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -496,7 +496,13 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+	int ret;
+
+	vcpu_load(vcpu);
+	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+	vcpu_put(vcpu);
+
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f647e121070e..cdf0be02c95a 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1632,18 +1632,25 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 {
 	int ret;
 
+	vcpu_load(vcpu);
+
+	ret = -EINVAL;
 	if (vcpu->arch.pvr != sregs->pvr)
-		return -EINVAL;
+		goto out;
 
 	ret = set_sregs_base(vcpu, sregs);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = set_sregs_arch206(vcpu, sregs);
 	if (ret < 0)
-		return ret;
+		goto out;
+
+	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
 
-	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 18011fc4ac49..d95b4f15e52b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2729,8 +2729,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	vcpu_load(vcpu);
+
 	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
 	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 20a5f6776eea..a31a80aee0b9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7500,15 +7500,19 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	int mmu_reset_needed = 0;
 	int pending_vec, max_bits, idx;
 	struct desc_ptr dt;
+	int ret;
+
+	vcpu_load(vcpu);
 
+	ret = -EINVAL;
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 			(sregs->cr4 & X86_CR4_OSXSAVE))
-		return -EINVAL;
+		goto out;
 
 	apic_base_msr.data = sregs->apic_base;
 	apic_base_msr.host_initiated = true;
 	if (kvm_set_apic_base(vcpu, &apic_base_msr))
-		return -EINVAL;
+		goto out;
 
 	dt.size = sregs->idt.limit;
 	dt.address = sregs->idt.base;
@@ -7574,7 +7578,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-	return 0;
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 779c03e39fa4..19cf2d11f80f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2597,9 +2597,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
-- 
2.14.2

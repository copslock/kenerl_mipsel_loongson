Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:00:13 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:46179
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992128AbdKYU52wYsd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:28 +0100
Received: by mail-wm0-x243.google.com with SMTP id u83so27776638wmb.5
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBPDH1YJd3lnWwvJDXZnwgQMZySEthOe/5MAal9840U=;
        b=XP3kr4vTjBzRq0mjaknciSRaP7k6SqX3k3z9xuQRgo0hyH9rva7ETjRYDb/VcPkb/O
         hwiKD4XkYBjnTZy6tM5zS+FM1Qx6fTlviEIE/LQuAiSiZhobxyNj/YeuYjXnRTsO63ky
         bs9iowVCBJqj2HmaEf9Sw5LNZViXRfnAdUen4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBPDH1YJd3lnWwvJDXZnwgQMZySEthOe/5MAal9840U=;
        b=FTyzb5rxg+ZmjPWpzRS3p4kQ1qTnzs4H1icP/aFPIc+DsCFg3sLFsPknqpScpR5eHi
         SWbaEqyc3G0fcAM/qhh4TjMsppuGcCSumIhRrVTus/ucCGF09pHXbGK2qVYrK15Y+kY/
         4nBQ0/qyyOOrHyUp3JvCPCx7uH/CC7Bxz61n3QEvBxw+yHS/otfyjYf2Hl6dvj/k3WOb
         L6pR57elkH5ThZe2AlHTYhcwFZkYFHHZMFv7to9jQE6NsFx4GOmzOmJ8uXAlw4K3MCTz
         mbyi8LCr4IaUyOKXJ9xZahCYB1asQ0V3jWrmfhQFcfasBfnAn536mIGwaWW06iZfRSi4
         RjmQ==
X-Gm-Message-State: AJaThX4OV7DbsclPuaU2CH49B4IxSo2upQurpVHQqjtvJkYvryXIsXH8
        V35uIWlJdYNI3ISlOBthbGibcg==
X-Google-Smtp-Source: AGs4zMY1/OvIFFWfI4nW7FvUWUQbDlUKl6cYWdFiG0gsdtmWx78TCzdJWttcNrKuHpvE85C8xIRvng==
X-Received: by 10.28.131.203 with SMTP id f194mr14113888wmd.39.1511643443502;
        Sat, 25 Nov 2017 12:57:23 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:22 -0800 (PST)
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
Subject: [PATCH 07/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
Date:   Sat, 25 Nov 2017 21:57:10 +0100
Message-Id: <20171125205718.7731-8-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61084
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
implementations of kvm_arch_vcpu_ioctl_set_sregs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/book3s.c | 10 +++++++++-
 arch/powerpc/kvm/booke.c  | 17 +++++++++++++----
 arch/s390/kvm/kvm-s390.c  |  8 ++++++++
 arch/x86/kvm/x86.c        | 15 ++++++++++++---
 virt/kvm/kvm_main.c       |  4 ----
 5 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b7db75010843..63e68c24af0e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -498,7 +498,15 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index d770f465cb9d..59d1d0bd6909 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1641,18 +1641,27 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 {
 	int ret;
 
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
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
index 93a19e7e4f59..51569cc97a07 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2738,8 +2738,16 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
 	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7faa9479e8d8..1a701a2f25a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7486,15 +7486,21 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	int mmu_reset_needed = 0;
 	int pending_vec, max_bits, idx;
 	struct desc_ptr dt;
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
 
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
@@ -7560,7 +7566,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-	return 0;
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dbfaf190fca3..f68f45e64967 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2605,11 +2605,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
-- 
2.14.2

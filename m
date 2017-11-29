Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:44:23 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:38664
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990829AbdK2QlgdaRUa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:36 +0100
Received: by mail-wm0-x241.google.com with SMTP id 64so7182151wme.3
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=viNGUJLHWXAK25tf/G0VP0ciIKHrjx6wBS2KqBzuEDQ=;
        b=GuKIEWJBPjOhVypJXJLnzRHg66WTR+bCuKVqC3YUEwOV/sutBxvguap5hE+9n2WsjH
         jz9kHESW1E1RtgsPKc0wM97Y9eOpEKWLeWcnBLWVI1Fd3vwD+SIIn8smJ1NMihTMI6wF
         7VZ/DTwCCNVJph/djjyiSTUxmHtqsb/Lwe7PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=viNGUJLHWXAK25tf/G0VP0ciIKHrjx6wBS2KqBzuEDQ=;
        b=dacOcYkwu065AuXENwV2bu0/C6jCP62li6VQSeNgC2Z5wJ6Ua3bk37+JAPqO0eR4Nq
         JDZY7QJ7O+ufzopzQMCFChzfSJ/aT/ms838+LY4mgk64ZkhrNQoH2zIgM56vEkIsAZ5i
         ddeFCy/kNwxpU10e9t3htvgUTtni7+/RJDkE7949dqbkmPBXaFp5Z+RdAsuQSgH9C2Rz
         VFcAsdwS7A6EtEE+BI/Efvohvn6j6QuZAZMqEvBEuBXEJkvhgWEtM2KnZdex2XafPeie
         /5E8CZbI05pYZzAh6LuXyQCzexFJzP1DqKEtC2CUjlLR8ONndRsNXuqUPlkk1YAHbTIv
         zvVQ==
X-Gm-Message-State: AJaThX6ywGG1YxgXXOhEzmUtAdrEATzR70+hDkLyj+Wm/z2UKDeu5y+O
        AzF5UcXxcdMH07hA3FUc4eVECQ==
X-Google-Smtp-Source: AGs4zMb48bLCOhYGzwbL+P4A1EYCQeP/PLBtmYrSJvqOmGBmAgI9MOVmwtNXN3IEsXKM8YCXtaHWFQ==
X-Received: by 10.28.50.70 with SMTP id y67mr3030571wmy.159.1511973691187;
        Wed, 29 Nov 2017 08:41:31 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:29 -0800 (PST)
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
Subject: [PATCH v2 07/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
Date:   Wed, 29 Nov 2017 17:41:07 +0100
Message-Id: <20171129164116.16167-8-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61200
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
 arch/powerpc/kvm/book3s.c |  8 +++++++-
 arch/powerpc/kvm/booke.c  | 15 +++++++++++----
 arch/s390/kvm/kvm-s390.c  |  4 ++++
 arch/x86/kvm/x86.c        | 13 ++++++++++---
 virt/kvm/kvm_main.c       |  2 --
 5 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 6cc2377..0476516 100644
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
index f647e12..cdf0be0 100644
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
index 18011fc..d95b4f1 100644
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
index 20a5f67..a31a80a 100644
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
index 779c03e..19cf2d1 100644
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
2.7.4

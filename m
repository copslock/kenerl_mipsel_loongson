Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:02:57 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:46992
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992197AbdKYU5mJp1x6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:42 +0100
Received: by mail-wr0-x241.google.com with SMTP id r2so16577436wra.13
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IIQ9hxKtMruUhs40PUkHN2E//9YK01zKXvgfo2hunag=;
        b=O+rqVMoRL1B7X4Q8B520iYpDWxQ4caMTzRDcx/mLRPESs+6NKjt4x4Js1ud7XTTw5b
         luDCwKy9OJjxXW0N0RVA8rRqvo8E2Fmn96gpvd0dD1ohiHHc7fg+8oSrDj3Lt1Dd0nbi
         Ex1hHNrMpjkvLhfpn8vYtQDqRsU2ZW4j0pACU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IIQ9hxKtMruUhs40PUkHN2E//9YK01zKXvgfo2hunag=;
        b=n6DbnAGzV9Ev2TentRwnfQ9pH+oHJW8YXvYNdZmUBBNnfm7GoIToK3DsRVGZgFkFXs
         R9mn/BUGhgw7WdH942zhZAxMQJJEBXVXnISIToA+pT+xZpkH+D08xgCa47fkEWsI38wk
         3E+TBvGNnnT4AGYOsTmJDOvq61BiMn/+j7DSywY4+ocYG6cDOzYZZrP9kYFCfg3g9A31
         VFwGgmXoO1vWCQMAHMVPDyCBkd/3mrXAatVlO6sYZmC7DePiOys746Ob2TGQF1ze4ag8
         mkFI9PSsqSPGvSRemb/9OuM0/fGWAwb+Y6MgFFEg2g4EIEqFPwLNSWClafxe+soVPXWO
         InDw==
X-Gm-Message-State: AJaThX7O7/tEVJxdnAuE9dKq+RabZqLF5RXdKPVt8QJ107UMMhXQElse
        CHVslxJYZqALKUecHTJ6pRtWow==
X-Google-Smtp-Source: AGs4zMa0fv/CuOpGxpZIAWJ/suLrFSZ/qtMQLLYaHPsgkHv2VA94C0D50m36G70NenPJKLsDP4Msfg==
X-Received: by 10.223.148.166 with SMTP id 35mr26170663wrr.245.1511643456738;
        Sat, 25 Nov 2017 12:57:36 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:35 -0800 (PST)
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
Subject: [PATCH 14/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
Date:   Sat, 25 Nov 2017 21:57:17 +0100
Message-Id: <20171125205718.7731-15-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61091
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

Move the calls to vcpu_load() and vcpu_put() in to the architecture
specific implementations of kvm_arch_vcpu_ioctl() which dispatches
further architecture-specific ioctls on to other functions.

Some architectures support asynchronous vcpu ioctls which cannot call
vcpu_load() or take the vcpu->mutex, because that would prevent
concurrent execution with a running VCPU, which is the intended purpose
of these ioctls, for example because they inject interrupts.

We move the checks for these specifics into the architecture code for
MIPS, S390 and PPC, and it has the added benefit of getting rid of the
ifdef in the generic dispatcher.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c       | 51 +++++++++++++++++++++++----------------
 arch/powerpc/kvm/powerpc.c | 15 +++++++-----
 arch/s390/kvm/kvm-s390.c   | 21 +++++++++-------
 arch/x86/kvm/x86.c         | 24 ++++++++++++++-----
 virt/kvm/arm/arm.c         | 60 ++++++++++++++++++++++++++++++++--------------
 virt/kvm/kvm_main.c        | 15 +-----------
 6 files changed, 114 insertions(+), 72 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 55d2e6e2c4e6..4b3eb1796216 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -917,56 +917,67 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 	void __user *argp = (void __user *)arg;
 	long r;
 
+	if (ioctl == KVM_INTERRUPT) {
+		struct kvm_mips_interrupt irq;
+
+		if (copy_from_user(&irq, argp, sizeof(irq)))
+			return -EFAULT;
+		kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
+			  irq.irq);
+
+		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+	}
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	switch (ioctl) {
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
 
+		r = -EFAULT;
 		if (copy_from_user(&reg, argp, sizeof(reg)))
-			return -EFAULT;
+			break;
 		if (ioctl == KVM_SET_ONE_REG)
-			return kvm_mips_set_reg(vcpu, &reg);
+			r = kvm_mips_set_reg(vcpu, &reg);
 		else
-			return kvm_mips_get_reg(vcpu, &reg);
+			r = kvm_mips_get_reg(vcpu, &reg);
+		break;
 	}
 	case KVM_GET_REG_LIST: {
 		struct kvm_reg_list __user *user_list = argp;
 		struct kvm_reg_list reg_list;
 		unsigned n;
 
+		r = -EFAULT;
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
-			return -EFAULT;
+			break;
 		n = reg_list.n;
 		reg_list.n = kvm_mips_num_regs(vcpu);
 		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
-			return -EFAULT;
+			break;
+		r = -E2BIG;
 		if (n < reg_list.n)
-			return -E2BIG;
-		return kvm_mips_copy_reg_indices(vcpu, user_list->reg);
-	}
-	case KVM_INTERRUPT:
-		{
-			struct kvm_mips_interrupt irq;
-
-			if (copy_from_user(&irq, argp, sizeof(irq)))
-				return -EFAULT;
-			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
-				  irq.irq);
-
-			r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
 			break;
-		}
+		r = kvm_mips_copy_reg_indices(vcpu, user_list->reg);
+		break;
+	}
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
 
+		r = -EFAULT;
 		if (copy_from_user(&cap, argp, sizeof(cap)))
-			return -EFAULT;
+			break;
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
 	default:
 		r = -ENOIOCTLCMD;
 	}
+
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 66e5c2445a87..027a6259c3c4 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1621,16 +1621,18 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 	long r;
 
-	switch (ioctl) {
-	case KVM_INTERRUPT: {
+	if (ioctl == KVM_INTERRUPT) {
 		struct kvm_interrupt irq;
-		r = -EFAULT;
 		if (copy_from_user(&irq, argp, sizeof(irq)))
-			goto out;
-		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
-		goto out;
+			return -EFAULT;
+		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
 	}
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
+	switch (ioctl) {
 	case KVM_ENABLE_CAP:
 	{
 		struct kvm_enable_cap cap;
@@ -1670,6 +1672,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 
 out:
+	vcpu_put(r);
 	return r;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 46d015083136..f9a4920c6f21 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3773,24 +3773,27 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_S390_IRQ: {
 		struct kvm_s390_irq s390irq;
 
-		r = -EFAULT;
 		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
-			break;
-		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
-		break;
+			return -EFAULT;
+		return kvm_s390_inject_vcpu(vcpu, &s390irq);
 	}
 	case KVM_S390_INTERRUPT: {
 		struct kvm_s390_interrupt s390int;
 		struct kvm_s390_irq s390irq;
 
-		r = -EFAULT;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
-			break;
+			return -EFAULT;
 		if (s390int_to_s390irq(&s390int, &s390irq))
 			return -EINVAL;
-		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
-		break;
+		return kvm_s390_inject_vcpu(vcpu, &s390irq);
+	}
 	}
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
+	switch (ioctl) {
 	case KVM_S390_STORE_STATUS:
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_s390_vcpu_store_status(vcpu, arg);
@@ -3913,6 +3916,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	default:
 		r = -ENOTTY;
 	}
+
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 230d552cdc4b..be552616ce87 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3453,6 +3453,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		void *buffer;
 	} u;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	u.buffer = NULL;
 	switch (ioctl) {
 	case KVM_GET_LAPIC: {
@@ -3478,8 +3482,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!lapic_in_kernel(vcpu))
 			goto out;
 		u.lapic = memdup_user(argp, sizeof(*u.lapic));
-		if (IS_ERR(u.lapic))
-			return PTR_ERR(u.lapic);
+		if (IS_ERR(u.lapic)) {
+			r = PTR_ERR(u.lapic);
+			goto out_nofree;
+		}
 
 		r = kvm_vcpu_ioctl_set_lapic(vcpu, u.lapic);
 		break;
@@ -3653,8 +3659,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 	case KVM_SET_XSAVE: {
 		u.xsave = memdup_user(argp, sizeof(*u.xsave));
-		if (IS_ERR(u.xsave))
-			return PTR_ERR(u.xsave);
+		if (IS_ERR(u.xsave)) {
+			r = PTR_ERR(u.xsave);
+			goto out_nofree;
+		}
 
 		r = kvm_vcpu_ioctl_x86_set_xsave(vcpu, u.xsave);
 		break;
@@ -3676,8 +3684,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 	case KVM_SET_XCRS: {
 		u.xcrs = memdup_user(argp, sizeof(*u.xcrs));
-		if (IS_ERR(u.xcrs))
-			return PTR_ERR(u.xcrs);
+		if (IS_ERR(u.xcrs)) {
+			r = PTR_ERR(u.xcrs);
+			goto out_nofree;
+		}
 
 		r = kvm_vcpu_ioctl_x86_set_xcrs(vcpu, u.xcrs);
 		break;
@@ -3721,6 +3731,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 out:
 	kfree(u.buffer);
+out_nofree:
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 631d04d87b25..a1b486a71e85 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1007,66 +1007,90 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
 	struct kvm_device_attr attr;
+	long r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 
 	switch (ioctl) {
 	case KVM_ARM_VCPU_INIT: {
 		struct kvm_vcpu_init init;
 
+		r = -EFAULT;
 		if (copy_from_user(&init, argp, sizeof(init)))
-			return -EFAULT;
+			break;
 
-		return kvm_arch_vcpu_ioctl_vcpu_init(vcpu, &init);
+		r = kvm_arch_vcpu_ioctl_vcpu_init(vcpu, &init);
+		break;
 	}
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
 
+		r = -ENOEXEC;
 		if (unlikely(!kvm_vcpu_initialized(vcpu)))
-			return -ENOEXEC;
+			break;
 
+		r = -EFAULT;
 		if (copy_from_user(&reg, argp, sizeof(reg)))
-			return -EFAULT;
+			break;
+
 		if (ioctl == KVM_SET_ONE_REG)
-			return kvm_arm_set_reg(vcpu, &reg);
+			r = kvm_arm_set_reg(vcpu, &reg);
 		else
-			return kvm_arm_get_reg(vcpu, &reg);
+			r = kvm_arm_get_reg(vcpu, &reg);
+		break;
 	}
 	case KVM_GET_REG_LIST: {
 		struct kvm_reg_list __user *user_list = argp;
 		struct kvm_reg_list reg_list;
 		unsigned n;
 
+		r = -ENOEXEC;
 		if (unlikely(!kvm_vcpu_initialized(vcpu)))
-			return -ENOEXEC;
+			break;
 
+		r = -EFAULT;
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
-			return -EFAULT;
+			break;
 		n = reg_list.n;
 		reg_list.n = kvm_arm_num_regs(vcpu);
 		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
-			return -EFAULT;
+			break;
+		r = -E2BIG;
 		if (n < reg_list.n)
-			return -E2BIG;
-		return kvm_arm_copy_reg_indices(vcpu, user_list->reg);
+			break;
+		r = kvm_arm_copy_reg_indices(vcpu, user_list->reg);
+		break;
 	}
 	case KVM_SET_DEVICE_ATTR: {
+		r = -EFAULT;
 		if (copy_from_user(&attr, argp, sizeof(attr)))
-			return -EFAULT;
-		return kvm_arm_vcpu_set_attr(vcpu, &attr);
+			break;
+		r = kvm_arm_vcpu_set_attr(vcpu, &attr);
+		break;
 	}
 	case KVM_GET_DEVICE_ATTR: {
+		r = -EFAULT;
 		if (copy_from_user(&attr, argp, sizeof(attr)))
-			return -EFAULT;
-		return kvm_arm_vcpu_get_attr(vcpu, &attr);
+			break;
+		r = kvm_arm_vcpu_get_attr(vcpu, &attr);
+		break;
 	}
 	case KVM_HAS_DEVICE_ATTR: {
+		r = -EFAULT;
 		if (copy_from_user(&attr, argp, sizeof(attr)))
-			return -EFAULT;
-		return kvm_arm_vcpu_has_attr(vcpu, &attr);
+			break;
+		r = kvm_arm_vcpu_has_attr(vcpu, &attr);
+		break;
 	}
 	default:
-		return -EINVAL;
+		r = -EINVAL;
 	}
+
+	vcpu_put(vcpu);
+	return r;
 }
 
 /**
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 08a610619572..bd0355abdcee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2535,15 +2535,6 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	if (unlikely(_IOC_TYPE(ioctl) != KVMIO))
 		return -EINVAL;
 
-#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_MIPS)
-	/*
-	 * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
-	 * so vcpu_load() would break it.
-	 */
-	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_S390_IRQ || ioctl == KVM_INTERRUPT)
-		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
-#endif
-
 	switch (ioctl) {
 	case KVM_RUN: {
 		r = -EINVAL;
@@ -2701,11 +2692,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	default:
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
-		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
-		vcpu_put(vcpu);
+		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 	}
 out:
 	kfree(fpu);
-- 
2.14.2

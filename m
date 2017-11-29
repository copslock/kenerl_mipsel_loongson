Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:47:19 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:42793
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990825AbdK2Qls2DIda (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:48 +0100
Received: by mail-wr0-x243.google.com with SMTP id s66so3953686wrc.9
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5822WIbwisemP5V9uKiM0rLY+4Ovd/Raz9GeUUc2Uc=;
        b=cO4CIyNIOOJVqo+7KB0svtd+3t28L8gWQpz53wADTJiFe5WNG8sj5nBX63vTUOsnGZ
         FUdBLrFc7Z1YJ9H7L34DD5+CO1x06Bz1WWnW1SUBenInYQlczN0y9mHnRQnBKe/9VaYE
         zngorqy6UbpLT3YJSfVpL6jmHDUWBxh+M/kmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5822WIbwisemP5V9uKiM0rLY+4Ovd/Raz9GeUUc2Uc=;
        b=lyArEaO+0JKDrjJB35MaktU3+GFwVCZLbCSsBd9FqFlhhsSHc/xH7jPdw/YPgkMUCE
         lH34kDDa1kxtuDDJQ8omAmK84F3GX+P1mgm5886fZukUg0ipHW1pzhUXJFvle5Wi/4kQ
         cKXlsWhOa4tmZpjw2/MzMgmrXhYtWD9RXj1wyxDGZzBi2Ru5sy5FlTgvHikhJf/jkn7z
         JCRULeA98SBkYwqySPZCYCk5JsFhP0ygtAXZASFILaeRYSrIV3G1Z6/HevJ2WlyYOu4d
         TovizHbGHaxAzpbIKv3llSCShChON+yrivMCYKj8U0JPzEfSvXu21134+UWLB2Ve/uyK
         tG4g==
X-Gm-Message-State: AJaThX44NBsksc1EuOASxE0Q1fJel1mGH3JhUnnyLnEfn4Jao3u8AQ9O
        GNz2+t4rCf8c0wG3rhoyOwCrAA==
X-Google-Smtp-Source: AGs4zMYJKHSF461ajFmkrMfhpfO2zsa7oMhHxyrA2oCVHY6jhmzGf6vHHInjia3fuZDUdadZmf5GRA==
X-Received: by 10.223.151.34 with SMTP id r31mr2972415wrb.164.1511973703057;
        Wed, 29 Nov 2017 08:41:43 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:42 -0800 (PST)
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
Subject: [PATCH v2 14/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
Date:   Wed, 29 Nov 2017 17:41:14 +0100
Message-Id: <20171129164116.16167-15-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61207
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

We repeat the separate checks for these specifics in the architecture
code for MIPS, S390 and PPC, and avoid taking the vcpu->mutex and
calling vcpu_load for these ioctls.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c       | 49 +++++++++++++++++++++++----------------
 arch/powerpc/kvm/powerpc.c | 13 ++++++-----
 arch/s390/kvm/kvm-s390.c   | 19 ++++++++-------
 arch/x86/kvm/x86.c         | 22 +++++++++++++-----
 virt/kvm/arm/arm.c         | 58 ++++++++++++++++++++++++++++++++--------------
 virt/kvm/kvm_main.c        |  2 --
 6 files changed, 103 insertions(+), 60 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3a89871..4a03934 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -913,56 +913,65 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
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
+	vcpu_load(vcpu);
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
index c06bc95..6b5dd3a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1617,16 +1617,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
 
+	vcpu_load(vcpu);
+
+	switch (ioctl) {
 	case KVM_ENABLE_CAP:
 	{
 		struct kvm_enable_cap cap;
@@ -1666,6 +1666,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 
 out:
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 43278f3..cd067b6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3743,24 +3743,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
 	}
+	}
+
+	vcpu_load(vcpu);
+
+	switch (ioctl) {
 	case KVM_S390_STORE_STATUS:
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_s390_vcpu_store_status(vcpu, arg);
@@ -3883,6 +3884,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	default:
 		r = -ENOTTY;
 	}
+
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd8b92f..0148a51 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3458,6 +3458,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		void *buffer;
 	} u;
 
+	vcpu_load(vcpu);
+
 	u.buffer = NULL;
 	switch (ioctl) {
 	case KVM_GET_LAPIC: {
@@ -3483,8 +3485,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -3658,8 +3662,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -3681,8 +3687,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -3726,6 +3734,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 out:
 	kfree(u.buffer);
+out_nofree:
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9a3acbc..8223c59 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1001,66 +1001,88 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
 	struct kvm_device_attr attr;
+	long r;
+
+	vcpu_load(vcpu);
 
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
index 06751bb..ad5f831 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2693,9 +2693,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	default:
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
-		vcpu_put(vcpu);
 	}
 out:
 	mutex_unlock(&vcpu->mutex);
-- 
2.7.4

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:41:51 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:33109
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdLDUgNaPro6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:13 +0100
Received: by mail-wm0-x244.google.com with SMTP id g130so16222661wme.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfDSnJ/GQKI8/UW6TR1Y63NOj7WdwDNJf+Je71TtP+8=;
        b=TMP7pEyVEvzMOQ4i1dnDsF1UKYe0zjD/xcs63lL0G4hFBuVuklqrS8WIPAalH1YmRf
         ixoyfCo10NzhMjzBNdFeqWtI1mnj7FN8aJUSI3dLEC9G5uSd+GiGMqevb83CycjQxUJj
         ZaF2rQuOgjjgCUXc+cXUKV59JV0ao6ueJ8RJnCV5QcHzEGGOnfYq/jsCVhxRn4bt7Jel
         qFgcYC4R4z7xp3L0M0QPOL9x+Y1BTzde17rl9YZRqkWX19fZ/TFLyFNChqO6rdrWFIYZ
         guGDZn5fVi/905riO2kVtnVssRuEs+ooEkHCzr03GrUpMyBcc+0YfmfZ7dO4aLc4ExEw
         UdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YfDSnJ/GQKI8/UW6TR1Y63NOj7WdwDNJf+Je71TtP+8=;
        b=W+0SgOY1qBoZKrnnGQF6YdJhW4mbRgb1ja/o1jW5e3IITbpirB2tY43p+c5LQEPoce
         1oh2ksJYbkdXnIINUjxeGoYTs6/7/84ZUEHTnMVj+MbiScezKZnmg38tttB+sG7GUuVv
         iBTKV4Ib8lV5ZbYICxuI6vywrTlbNtzwMybBxJB+fAlBNXbqValTUFM/xx7Qyex6GG2I
         tu4AbYjKXN+ifEgf9f6XG//Pg1i4DAPa7x7q4wr9qIeTsdMOdMgbrPyUil3siOySCR8G
         E1R9cukEqPB1AEIFulE3TWGXqQDwy8XMeI3zUcDdy8vSlcBaallC5uAqLhFNeMcm7evW
         sLPw==
X-Gm-Message-State: AKGB3mJ8FZeh15+LbmGtkb5myBURoJw12vBma8NVL00Ly7/Nby1sDV5V
        jO93Jlwa6XUoxjrWOPMLkPk6iQ==
X-Google-Smtp-Source: AGs4zMZE4zY6nq8HZHjVn0idoG4F742GGo+oJq/AsROCbt439lF8O3P2xMvu04BVdphnKba4Jc5LZQ==
X-Received: by 10.80.151.36 with SMTP id c33mr4042278edb.8.1512419768072;
        Mon, 04 Dec 2017 12:36:08 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:07 -0800 (PST)
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
Subject: [PATCH v3 14/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
Date:   Mon,  4 Dec 2017 21:35:36 +0100
Message-Id: <20171204203538.8370-15-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61301
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
index 3a898712d6cd..4a039341dc29 100644
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
index c06bc9552438..6b5dd3a25fe8 100644
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
index 43278f334ce3..cd067b63d77f 100644
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
index 95a329580c8b..e35d9d340d7f 100644
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
index 9a3acbcf542c..8223c59be507 100644
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
index 06751bbecd58..ad5f83159a15 100644
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
2.14.2

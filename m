Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:57:46 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35669
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbdKYU5Sm1pC6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:18 +0100
Received: by mail-wr0-x243.google.com with SMTP id w95so23073767wrc.2
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V3Vm+6ixly0ib2qMFBLoowg7G+ZdIZG9b7wCLe/d1AM=;
        b=R99SEGxEvSBqQLuepATEK3sLqKur2HXnHU31MIq/bpsChrIuXm2P8cvFYe9hFlpGyC
         YVcFonDdf/abbUzLfT0u92mXpxrplAekGP0YTIpDqqghFqu/n3NyVi5z76vHNx+OTlud
         9fsaiynwxt1xN6g0GkvoCLyoqEXfr+bj34Mqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V3Vm+6ixly0ib2qMFBLoowg7G+ZdIZG9b7wCLe/d1AM=;
        b=cQOSEQRs7yDK4RHay50ungVKnXUnnKLerRB5I9z0tJ0ZKzIk1YeviUb2aDSrrxSVaw
         1qrLDN5xm8kNBtamKY/hs09vm/rcrGB1TT4HD6xi6PdR6A48MonW9+Zl1rDo7w944wcI
         +2YYFE3CDV8jkHnaj6JLSW4YXSo0nOwYS4faCUFBosglV9LUo7SdHDK40q53jCYB8hIA
         y2ZZH9SY3v+kK1d63t3JMk1/cde7VHwGXOkHVUz6wHeBwqmRxNLMdRsnguL4Tm+3Ui6g
         J8fs2Iqyf1Y6jRY7zpurMG51JmU9Cdn3zW4T+DgRf55bO//t0RZSVa0i4mSNCTuBubAM
         yPWw==
X-Gm-Message-State: AJaThX7OoLGlKj4XTaO3+087NY4sYqQh3a89P+lEJ0tFtuiae/Na6qa4
        29sbQcfivH2CQQX43l6ufP/kzA==
X-Google-Smtp-Source: AGs4zMa76xrf/tEpClZTJRAaiWxp2GgHtbESLQHWUKGIWwlBZjmhvCUw6oJnvio824F8fWPwcXVqnA==
X-Received: by 10.223.150.46 with SMTP id b43mr21007257wra.5.1511643433303;
        Sat, 25 Nov 2017 12:57:13 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:12 -0800 (PST)
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
Subject: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
Date:   Sat, 25 Nov 2017 21:57:04 +0100
Message-Id: <20171125205718.7731-2-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61078
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

In preparation for moving calls to vcpu_load() and vcpu_put() into the
architecture specific implementations of the KVM vcpu ioctls, move the
calls in the main kvm_vcpu_ioctl() dispatcher function to each case
of the ioctl select statement.  This allows us to move the vcpu_load()
and vcpu_put() calls into architecture specific implementations of vcpu
ioctls, one by one.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/kvm_main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a245b83..fafafcc38b5a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2528,16 +2528,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 #endif
 
-
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		oldpid = rcu_access_pointer(vcpu->pid);
 		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
 			/* The thread running this VCPU changed. */
@@ -2549,6 +2548,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			put_pid(oldpid);
 		}
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
+		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
@@ -2559,7 +2559,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
@@ -2579,7 +2583,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
@@ -2588,7 +2596,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2604,13 +2616,21 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2625,7 +2645,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
@@ -2634,7 +2658,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2649,7 +2677,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
@@ -2680,7 +2712,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2696,14 +2732,21 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		break;
 	}
 	default:
+		r = vcpu_load(vcpu);
+		if (r)
+			goto out;
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
+		vcpu_put(vcpu);
 	}
 out:
-	vcpu_put(vcpu);
 	kfree(fpu);
 	kfree(kvm_sregs);
 	return r;
-- 
2.14.2

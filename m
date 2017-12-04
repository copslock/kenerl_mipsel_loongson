Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:36:49 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:35677
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990480AbdLDUf4ihvY6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:35:56 +0100
Received: by mail-wm0-x244.google.com with SMTP id f9so16711007wmh.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3UHU6SKbUaYY+fJMVRFGAOcJOcW4NAOt6j9Jv1qXKw=;
        b=hkyyIOgNiD2yk/QiH/b+ZJ7bja7odRW6fhLeq4vgJnhFUk2R88fLvHgC4F0jZTP2yz
         g0SW2fbYTDFzw3ek2jtatoLIq3AOzjBzcqhDpbiWPbQBrEbglZfWaZ3hkI9MpOtJgVXm
         UYLcHUriynwBE2BJvAyniPBQ0XPLbk+Fk9Ledy/T8Xi2Zy0Tfs4yamv5fyx0MuK6cduZ
         KTOO8rBSNjr3eif7G/nL/FW9E9ye8mofVeCJnOgfxpxdY1ROLmEabYkdSwVKw2se2BhR
         9JesGNFfhdvHYNJvjiMaeNILL4xcXA+nATFysw5jxMAoJzOEVrfPAMGVRqy/u3AXHpD8
         9hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=H3UHU6SKbUaYY+fJMVRFGAOcJOcW4NAOt6j9Jv1qXKw=;
        b=hIS2ImpVpo7TnpBsP1gp84y45gMM7PmvwqqBxyYoKD1rO/peebzLwpPlxzEO1EyuIj
         XDzBxSJyahx3ycwR5IxPl6GvkeLel10oAvVFGteczhAre7g7BjqFRnMtQYdkphwgsfbY
         HeXFx295mwKIbwGEVs5klpNEBlBh3GOrAjvwt3xeiJ+7R7IwigL1on4x4Atmen3D+ISr
         sFqDyOZPEFBnhjfZ8BVMuOExiyGTd5TSkBe1DIPFjDTaUciO4P9ANJ9ar/grCikNVSgc
         PmAWC9wRaZvZfDbE1c/UvolA6MN5R16SMDAlpOs9oAz0s6RzX87iWE6Mm4DA3BLz5G5M
         OwIw==
X-Gm-Message-State: AJaThX7WsMrx84tMjtg499mkc8caIzC4TYhvlAVjkuPp76QmosE1NAZR
        b/9uS9wOwAt5PVPgmgZi9QJIow==
X-Google-Smtp-Source: AGs4zMbDMue5elYQG0Qj67flH6S0CBtUJHSvJQzXWc0cgaUKLO5d9dMaTzs65/Cdbu2A7tDAW6YdEg==
X-Received: by 10.80.152.66 with SMTP id h2mr31815408edb.192.1512419751247;
        Mon, 04 Dec 2017 12:35:51 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:50 -0800 (PST)
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
Subject: [PATCH v3 02/16] KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
Date:   Mon,  4 Dec 2017 21:35:24 +0100
Message-Id: <20171204203538.8370-3-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61289
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

In preparation for moving calls to vcpu_load() and vcpu_put() into the
architecture specific implementations of the KVM vcpu ioctls, move the
calls in the main kvm_vcpu_ioctl() dispatcher function to each case
of the ioctl select statement.  This allows us to move the vcpu_load()
and vcpu_put() calls into architecture specific implementations of vcpu
ioctls, one by one.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/kvm_main.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 39961fb8aef7..480b16c48f6b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2525,13 +2525,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
 
 	if (mutex_lock_killable(&vcpu->mutex))
 		return -EINTR;
-	vcpu_load(vcpu);
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
 			goto out;
+		vcpu_load(vcpu);
 		oldpid = rcu_access_pointer(vcpu->pid);
 		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
 			/* The thread running this VCPU changed. */
@@ -2543,6 +2543,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			put_pid(oldpid);
 		}
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
+		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
@@ -2553,7 +2554,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
@@ -2573,7 +2576,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
@@ -2582,7 +2587,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2598,13 +2605,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2619,7 +2630,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
@@ -2628,7 +2641,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2643,7 +2658,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
@@ -2674,7 +2691,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2690,14 +2709,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		break;
 	}
 	default:
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
+		vcpu_put(vcpu);
 	}
 out:
-	vcpu_put(vcpu);
 	mutex_unlock(&vcpu->mutex);
 	kfree(fpu);
 	kfree(kvm_sregs);
-- 
2.14.2

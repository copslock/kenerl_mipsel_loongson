Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:58:34 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:35849
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991163AbdKYU5WIR436 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:22 +0100
Received: by mail-wr0-x242.google.com with SMTP id y42so23043568wrd.3
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dz8Vx95G1CWvoJM35PjdOdtHCmiqRzw2IUObyY4JeH4=;
        b=M8xSoEDaUVa3cV4NGpqvh5R78wuzp3JWdxPvjfIvixFHDm1QBd5quCEgeh21775/YS
         2Xsj+aMQ/ouxb8k3Q6LbNf8LKieAZiVm5OKs/aPCxGYNl7S5clMC3scPYgf5vmdqjXfy
         YZTi9ONcSfbEgeIvFBd035a1ma9suso+cjNec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dz8Vx95G1CWvoJM35PjdOdtHCmiqRzw2IUObyY4JeH4=;
        b=YJVKurMPAtTaIAD7beUxKzKGy1bCHmHOZS+L4lUDAON7ScBFp29uYDyY1njD871Em8
         GvIcrv4BumacBtCKfaSAgpOCDEEXbuEomypAi/dqt9Ny1TQ/DjK5ckE+9zdSJCkUnRGv
         998R6pXZwec/UNxpZszsKMA0g0GEqF7uMi7/Fmt8O5UtgxQYk74PiCF/YFEIOQzbm+FL
         L0u8YUseqv5brcvVMwjAkPip8T7iy5/MgLmqqv+4QhEVVSM4ILHIzIG8mknX+Gef0LhI
         rEf64ufmVwjaSycf1Geb7xhitw5kB3iRDon1DlbDZNBccoZijDTIfsIzpyFW9/0QAan+
         MdsA==
X-Gm-Message-State: AJaThX4oRhI0ciGE/ZQxpncoIlsWYCFmloyVeJmsMqjTL1+I7gomNh63
        vxs6lOPeTlOli5If0YlakC81DA==
X-Google-Smtp-Source: AGs4zMYqm3nIL/NvU55CCSdfuDHiO25cuXnhGksljq/BVfMBMs1u5TXzt3lCK1bKbAN49kwL6j01hg==
X-Received: by 10.223.164.22 with SMTP id d22mr30855405wra.232.1511643436754;
        Sat, 25 Nov 2017 12:57:16 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:15 -0800 (PST)
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
Subject: [PATCH 03/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
Date:   Sat, 25 Nov 2017 21:57:06 +0100
Message-Id: <20171125205718.7731-4-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61080
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
implementations of kvm_arch_vcpu_ioctl_run().

We take care to call kvm_vcpu_run_adjust_pid() in every implementation
after having successfully called vcpu_load().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c       |  9 ++++++++-
 arch/powerpc/kvm/powerpc.c |  9 ++++++++-
 arch/s390/kvm/kvm-s390.c   | 13 +++++++++++--
 arch/x86/kvm/x86.c         |  6 ++++++
 virt/kvm/arm/arm.c         | 18 ++++++++++++++----
 virt/kvm/kvm_main.c        |  5 -----
 6 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index d535edc01434..c93620e4b01f 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -444,9 +444,14 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	int r = -EINTR;
+	int r;
 	sigset_t sigsaved;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+	kvm_vcpu_run_adjust_pid(vcpu);
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -456,6 +461,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu->mmio_needed = 0;
 	}
 
+	r = -EINTR;
 	if (run->immediate_exit)
 		goto out;
 
@@ -483,6 +489,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3480faaf1ef8..66e5c2445a87 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1410,6 +1410,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r;
 	sigset_t sigsaved;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+	kvm_vcpu_run_adjust_pid(vcpu);
+
 	if (vcpu->mmio_needed) {
 		vcpu->mmio_needed = 0;
 		if (!vcpu->mmio_is_write)
@@ -1424,7 +1429,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			r = kvmppc_emulate_mmio_vsx_loadstore(vcpu, run);
 			if (r == RESUME_HOST) {
 				vcpu->mmio_needed = 1;
-				return r;
+				goto out;
 			}
 		}
 #endif
@@ -1460,6 +1465,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+out:
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40d0a1a97889..aaeae92983a6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3378,9 +3378,15 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (kvm_run->immediate_exit)
 		return -EINTR;
 
+	rc = vcpu_load(vcpu);
+	if (rc)
+		return rc;
+	kvm_vcpu_run_adjust_pid(vcpu);
+
 	if (guestdbg_exit_pending(vcpu)) {
 		kvm_s390_prepare_debug_exit(vcpu);
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
 	if (vcpu->sigset_active)
@@ -3391,7 +3397,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	} else if (is_vcpu_stopped(vcpu)) {
 		pr_err_ratelimited("can't run stopped vcpu %d\n",
 				   vcpu->vcpu_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	sync_regs(vcpu, kvm_run);
@@ -3422,6 +3429,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	vcpu->stat.exit_userspace++;
+out:
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 03869eb7fcd6..18e39666ada7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7225,6 +7225,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int r;
 	sigset_t sigsaved;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+	kvm_vcpu_run_adjust_pid(vcpu);
+
 	fpu__initialize(fpu);
 
 	if (vcpu->sigset_active)
@@ -7274,6 +7279,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 01e575b9f78b..54d9aa533df9 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -620,18 +620,25 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	ret = kvm_vcpu_first_run_init(vcpu);
+	ret = vcpu_load(vcpu);
 	if (ret)
 		return ret;
+	kvm_vcpu_run_adjust_pid(vcpu);
+
+	ret = kvm_vcpu_first_run_init(vcpu);
+	if (ret)
+		goto out;
 
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	if (run->immediate_exit)
-		return -EINTR;
+	if (run->immediate_exit) {
+		ret = -EINTR;
+		goto out;
+	}
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
@@ -768,6 +775,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+out:
+	vcpu_put(vcpu);
 	return ret;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c9549d44c489..b6941320d6e5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2549,12 +2549,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 		if (arg)
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
-		kvm_vcpu_run_adjust_pid(vcpu);
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
-		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
-- 
2.14.2

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:42:44 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:35022
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990596AbdK2Ql3Qmdma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:29 +0100
Received: by mail-wm0-x244.google.com with SMTP id f9so7258642wmh.0
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6zDGNYn/W5V+sBqnML0DEVrl8nUEUFGc6cUrcuvuR8=;
        b=COD0uBxNCe28dE/FXqjRBAIJlKiZc0aoiWEQLYfioyPoE/7h+QldClw6KgeItDnCiU
         +f+AX8o5JcpwT0KW3jgQxtxpBFZzJagFalQL0NHlx2SBPfuF8ZgZvX11FBomwzDgElFX
         kisxPxaoLWvqtoetJBW9Tq2yOiVaBsBJDdB6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6zDGNYn/W5V+sBqnML0DEVrl8nUEUFGc6cUrcuvuR8=;
        b=UyI/l6h/SPQIa6jWR78FvWFz5mTtxpaS9kosLr9/kcCjLgoJBMzodaLKnbKkrfzl2b
         OzR8RJVCT2e5RoFnrbkM5x9SxmOUs2u6Ym27uClFjrAO8MSV/SN5mM66sW8dtuoqpM0s
         S6jocEOT0htBKBWw5reQZW/ysS3i/Umu+5xVaxyR6CKaiSg+RbD1/NFQQr0iMKqdFyhv
         IaB0Vwu/h2NRncPiNouUKN0GTwKIvFHjTHn6u6mLiGREMxXzpVm5R3XEKQkBnVepWX8I
         +2HDuwgH1DqP1ZzLuEn97zzKY2lhn93zrQ8974K4fFfnsnLYpFXBjocxJvzP/qihV+vM
         I1QA==
X-Gm-Message-State: AJaThX4oatzidIeqQ1Ir0LPVxoa3An96JRlwZjeUhcOeLHWwUE57nQaq
        zIToFWkvo6OOKkqfS0wPKnK3aA==
X-Google-Smtp-Source: AGs4zManHOAFJBsw3sRki28Y2hwGePNMNvWGIcfWPuB253ccOW2UwFR7b0euYVZKPgoSLwujeV/J0w==
X-Received: by 10.28.158.212 with SMTP id h203mr2942193wme.157.1511973683913;
        Wed, 29 Nov 2017 08:41:23 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:23 -0800 (PST)
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
Subject: [PATCH v2 03/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
Date:   Wed, 29 Nov 2017 17:41:03 +0100
Message-Id: <20171129164116.16167-4-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61196
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

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c       |  3 +++
 arch/powerpc/kvm/powerpc.c |  6 +++++-
 arch/s390/kvm/kvm-s390.c   | 10 ++++++++--
 arch/x86/kvm/x86.c         |  3 +++
 virt/kvm/arm/arm.c         | 15 +++++++++++----
 virt/kvm/kvm_main.c        |  2 --
 6 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index d535edc..b5c28f0 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -447,6 +447,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r = -EINTR;
 	sigset_t sigsaved;
 
+	vcpu_load(vcpu);
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -483,6 +485,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6b6c53c..c06bc95 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1409,6 +1409,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r;
 	sigset_t sigsaved;
 
+	vcpu_load(vcpu);
+
 	if (vcpu->mmio_needed) {
 		vcpu->mmio_needed = 0;
 		if (!vcpu->mmio_is_write)
@@ -1423,7 +1425,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			r = kvmppc_emulate_mmio_vsx_loadstore(vcpu, run);
 			if (r == RESUME_HOST) {
 				vcpu->mmio_needed = 1;
-				return r;
+				goto out;
 			}
 		}
 #endif
@@ -1459,6 +1461,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+out:
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 98ad8b9..2b3e874 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3377,9 +3377,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (kvm_run->immediate_exit)
 		return -EINTR;
 
+	vcpu_load(vcpu);
+
 	if (guestdbg_exit_pending(vcpu)) {
 		kvm_s390_prepare_debug_exit(vcpu);
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
 	if (vcpu->sigset_active)
@@ -3390,7 +3393,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	} else if (is_vcpu_stopped(vcpu)) {
 		pr_err_ratelimited("can't run stopped vcpu %d\n",
 				   vcpu->vcpu_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	sync_regs(vcpu, kvm_run);
@@ -3421,6 +3425,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	vcpu->stat.exit_userspace++;
+out:
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b8f864..d9deb62 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7252,6 +7252,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int r;
 	sigset_t sigsaved;
 
+	vcpu_load(vcpu);
+
 	fpu__initialize(fpu);
 
 	if (vcpu->sigset_active)
@@ -7301,6 +7303,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a6524ff..1f448b2 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -620,18 +620,22 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
+	vcpu_load(vcpu);
+
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
-		return ret;
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
@@ -771,6 +775,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+out:
+	vcpu_put(vcpu);
 	return ret;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 480b16c..198f2f9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2531,7 +2531,6 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 		if (arg)
 			goto out;
-		vcpu_load(vcpu);
 		oldpid = rcu_access_pointer(vcpu->pid);
 		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
 			/* The thread running this VCPU changed. */
@@ -2543,7 +2542,6 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			put_pid(oldpid);
 		}
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
-		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
-- 
2.7.4

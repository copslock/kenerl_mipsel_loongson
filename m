Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:37:14 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:39853
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990489AbdLDUf5w9JR6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:35:57 +0100
Received: by mail-wm0-x243.google.com with SMTP id i11so16608413wmf.4
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FX5v4r51s95ZEzBxkc3Nl0pmEnX8XegRYZAw6KqEqOU=;
        b=xIb7G7AhzSWTC9AhuN5i87b2sV3BwVFpvdF4jPePrprLuo8i80H4tDRYCUM0lvG3cj
         26LzJm4f7vomrG/uEX0hhY4H3YCNPx+2uiEFt3vcRTlSyjLs74kaA7eLlgHvn/nLxA2X
         /dPva/5B+xTVaAGOdrgw0iIXnzGZjT9MjyTguH+8nHLkpsCHbpZigpaor76m/XEzIg0P
         jK/JXvWnp5C+tY9iVt6sXOnORogCjHZ5j3F1Osrcw2d3PssS1h92BcaLnhVaS7Mre2bp
         AnSgwdbPwl/30mRfR0xhBOeoXKPF7nOl8f1FwFPMXWq6Nu5DjURA8FKkNu+K1j2P9rPG
         pWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FX5v4r51s95ZEzBxkc3Nl0pmEnX8XegRYZAw6KqEqOU=;
        b=OMuyJl1EbXcUhzy0b7ndL+i7dP1NYEX03RGiVTfdp0SsWB4o7RZyj3aia4w3QD+hpo
         S9/AcbXNhd9HRSBhnj+SBZLjynMtgnr4DuUo8ytV1Hz0rQlg8B23nRhlTghlFsF+5GfA
         sgGh/mT0i0jTzx972CNgZnD27n+TSl3mbkKnlu4t196b0wCqHS6olg1v4b6srRdmKXGr
         djQwygJmVAe3t8UTz4ICmwQMuNUhj7AofDy3GVonB/4ES8rvpSXG74+KIiZfbVMp3d5V
         DgoKOI+w+/H1rEaXpp6VDcTw3kFGkZYTvLgypIKBbdFWfWF1FHktoac0RayBYie/nrOw
         VZ4Q==
X-Gm-Message-State: AJaThX7HW4rKs+o6UvqtgRktePLSGd5LMQYiUwkhuwX/mUMvjZk3VHqu
        L45Pd0NQeGCoOjOIpDE5F6JWAw==
X-Google-Smtp-Source: AGs4zMYyCaz/XgxJdqq5fx3pa2qP7LkWTtddgK2h62ARYYvoVBQ6kAVaOVY3RgmZ1Ach8FFfaoQmBg==
X-Received: by 10.80.240.200 with SMTP id a8mr32258521edm.288.1512419752586;
        Mon, 04 Dec 2017 12:35:52 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:51 -0800 (PST)
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
Subject: [PATCH v3 03/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
Date:   Mon,  4 Dec 2017 21:35:25 +0100
Message-Id: <20171204203538.8370-4-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61290
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
index d535edc01434..b5c28f0730f8 100644
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
index 6b6c53c42ac9..c06bc9552438 100644
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
index 98ad8b9e0360..2b3e874ea76c 100644
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
index 9b8f864243c9..d9deb6222055 100644
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
index a6524ff27de4..1f448b208686 100644
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
index 480b16c48f6b..198f2f9edcaf 100644
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
2.14.2

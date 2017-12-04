Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:38:35 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:41933
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdLDUgAeD4o6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:00 +0100
Received: by mail-wm0-x242.google.com with SMTP id g75so8238533wme.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ynrrHX4vUof8oBBvBWFL+mC1gNDs2L/H02b81hETZc8=;
        b=fRZiM2dvDbDLGYV33ppR6T9eb1d+Y7+Kl6dN/FWQuLG4OLDXafCIJcldsWa0G/b/z+
         qFqGiZUCbj/Y+kLxWCrXkpaHIiWBYH9/TnsJyO7JQ6aqf60X41sHm1bpiEjqxUkXYH+A
         vHb4OChRt/cwMPwj2EPnUc4udnqY2BOkBfH8xQfpUyk8YaIkqQfeza9Uti7TPRHytxTQ
         6kIpLpFWi//gys/TX7gv842nsKK+B+7hmMNluHZTkg007mxoxPSbUJ+g6UOHhKz8hXt3
         J5FDmfOsTt1E66SCP5G3lVmLPgRU+SSiyfsEioNP2XOcXjLUbK2x+i6fFRjx4cgT7DXu
         zthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ynrrHX4vUof8oBBvBWFL+mC1gNDs2L/H02b81hETZc8=;
        b=ecpR2iW4gEJoVxeTY9JseH1jV3yD77gsv0oBIrntBjFJg0u1w/21TVTMyFfQaAV/3q
         dumc2lzVWkPiPNHGYLZqQyCWJFZR12p8/pwMkDG1Fu+iCZXoyOFUnpMuAkyEny0xPGRP
         FXaMRxY4cpUF3Xh82TqPgtfUNx5XdvxCqpArBSOo/8LGYVbM7a1BDCkeRadb/V5fGVpc
         +OSzjD0BVn3KyHXIbXRcKVYjv7O2pqag1bHquz/Lfzud0/qWrX3PgYTwJGlkjLZUwwuk
         CofQjPwbnxvijuiy3tQZFRV6vs1PFf+ejpeWhL+bWjI6ek5kJ8LSCrj0XWcca1Rj4TVy
         vFPw==
X-Gm-Message-State: AJaThX6ectVbbkfSvMjiqMw5+muEAYUqGlNLFsZgqmMBzpXYl5u1kA84
        amBQSV0KoNg0NalKR1CApEGSRQ==
X-Google-Smtp-Source: AGs4zMbHCIfhk+rnfzKpLUq1r7UmCSO0Rc5xXU23na8EckL0s6z5czJPmmvZhRi1PhI9dqpRNCwErw==
X-Received: by 10.80.164.209 with SMTP id x17mr31541638edb.158.1512419755265;
        Mon, 04 Dec 2017 12:35:55 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:54 -0800 (PST)
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
Subject: [PATCH v3 05/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
Date:   Mon,  4 Dec 2017 21:35:27 +0100
Message-Id: <20171204203538.8370-6-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61293
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
implementations of kvm_arch_vcpu_ioctl_set_regs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c      | 3 +++
 arch/powerpc/kvm/book3s.c | 3 +++
 arch/powerpc/kvm/booke.c  | 3 +++
 arch/s390/kvm/kvm-s390.c  | 2 ++
 arch/x86/kvm/x86.c        | 3 +++
 virt/kvm/kvm_main.c       | 2 --
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index adfca57420d1..3a898712d6cd 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1151,6 +1151,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		vcpu->arch.gprs[i] = regs->gpr[i];
 	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
@@ -1158,6 +1160,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.lo = regs->lo;
 	vcpu->arch.pc = regs->pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index d85bfd733ccd..24bc7aabfc44 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -528,6 +528,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	kvmppc_set_pc(vcpu, regs->pc);
 	kvmppc_set_cr(vcpu, regs->cr);
 	kvmppc_set_ctr(vcpu, regs->ctr);
@@ -548,6 +550,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index e0e4f04c5535..bcbbeddc3430 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1462,6 +1462,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	vcpu->arch.pc = regs->pc;
 	kvmppc_set_cr(vcpu, regs->cr);
 	vcpu->arch.ctr = regs->ctr;
@@ -1483,6 +1485,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 37b7caae2484..e3476430578a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2712,7 +2712,9 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	vcpu_load(vcpu);
 	memcpy(&vcpu->run->s.regs.gprs, &regs->gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 597e1f8fc8da..75eacce78f59 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7350,6 +7350,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	vcpu_load(vcpu);
+
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 
@@ -7379,6 +7381,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 843d481f58cb..963e249d7b79 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2572,9 +2572,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
-- 
2.14.2

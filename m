Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 22:01:46 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:45443
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdKYU5gMoKz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:36 +0100
Received: by mail-wr0-x242.google.com with SMTP id a63so22999762wrc.12
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jx3F3l4X8mPO2fUbPReyCvyFHiFtJpj35SNJzUecnR0=;
        b=e+Zu0KonvEN8e2dWBvjW8NeVYO7h2El0/cGIRrMBdZeC5O44Y2FeO5Yi2BtfLDZ5KD
         ieRTF3bbCUe0bdkc6QFp1QW8jPfI7CHfuoV3Q0Q4PTp/aZa1imAzZ8BQSqtXKooBtHBp
         +fW8dtpBKk/FGcKUBNvNDOTaM7KDm9+DURFKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jx3F3l4X8mPO2fUbPReyCvyFHiFtJpj35SNJzUecnR0=;
        b=tyEQqn8le9alQYfGlPWRDczRxScwD11PggeA5d6swFUwn1zRIrSN4ei5Rnf4e96m5q
         VJSvBMT2v4MhkJBFSkxc58oDp6gGZ8MDb8eN2RaL3FZ6IJTKdmtq06+AD6HicbFcPuju
         U4GuGwcT+wrZp5HTOZ89u2kkt9jLXQRzwOD55ziIwDvM3sNRhN2o2nXUgkjD1EstDDRX
         UTxTijdMcwUdI8FLwUG2WSz0jE/hCHHJ5QuHfZDZYwSwd2Kd38JlT0JVHVl4rSa8B+Ld
         KZcovUEqt20/ldwMqBFIaIvM1qYFEjZMy4GAUq5m5pOFEwaKCUxwuYXH9dRubzHK/Vz2
         jrUg==
X-Gm-Message-State: AJaThX6tBiHPOqlp2r3NCOgsDe//uOGsHip/gQYsnQS98Iq+4mZkkfMl
        Xd4ZpIGubngyVmYSPgfrpXBxMw==
X-Google-Smtp-Source: AGs4zMamEliV1UyneIaE1O0iDnyddd3R9PMUvGEuDHZdif2YBin1at0XM3bg/uJnu7o7U680Hu5RQQ==
X-Received: by 10.223.166.103 with SMTP id k94mr28303292wrc.22.1511643450825;
        Sat, 25 Nov 2017 12:57:30 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:29 -0800 (PST)
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
Subject: [PATCH 11/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_guest_debug
Date:   Sat, 25 Nov 2017 21:57:14 +0100
Message-Id: <20171125205718.7731-12-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61088
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
implementations of kvm_arch_vcpu_ioctl_set_guest_debug().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c    | 17 ++++++++++++++---
 arch/powerpc/kvm/book3s.c |  6 ++++++
 arch/powerpc/kvm/booke.c  | 21 +++++++++++++++------
 arch/s390/kvm/kvm-s390.c  | 14 +++++++++++---
 arch/x86/kvm/x86.c        |  6 +++++-
 virt/kvm/kvm_main.c       |  4 ----
 6 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5c7f657dd207..0375d1f977c8 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -361,10 +361,18 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	trace_kvm_set_guest_debug(vcpu, dbg->control);
 
-	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
-		return -EINVAL;
+	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
@@ -378,7 +386,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		/* If not enabled clear all flags */
 		vcpu->guest_debug = 0;
 	}
-	return 0;
+
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 63e68c24af0e..6d9885b6e77c 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -765,7 +765,13 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	vcpu->guest_debug = dbg->control;
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8069d93bf654..fcc033a4d958 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -2031,12 +2031,17 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	struct debug_reg *dbg_reg;
 	int n, b = 0, w = 0;
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
 
 	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
 		vcpu->arch.dbg_reg.dbcr0 = 0;
 		vcpu->guest_debug = 0;
 		kvm_guest_protect_msr(vcpu, MSR_DE, false);
-		return 0;
+		goto out;
 	}
 
 	kvm_guest_protect_msr(vcpu, MSR_DE, true);
@@ -2068,8 +2073,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 #endif
 
 	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
-		return 0;
+		goto out;
 
+	ret = -EINVAL;
 	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
 		uint64_t addr = dbg->arch.bp[n].addr;
 		uint32_t type = dbg->arch.bp[n].type;
@@ -2080,21 +2086,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
 			     KVMPPC_DEBUG_WATCH_WRITE |
 			     KVMPPC_DEBUG_BREAKPOINT))
-			return -EINVAL;
+			goto out;
 
 		if (type & KVMPPC_DEBUG_BREAKPOINT) {
 			/* Setting H/W breakpoint */
 			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
-				return -EINVAL;
+				goto out;
 		} else {
 			/* Setting H/W watchpoint */
 			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
 							type, w++))
-				return -EINVAL;
+				goto out;
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index aa76d2988178..ac26d95444c9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2819,15 +2819,20 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
-	int rc = 0;
+	int rc;
+
+	rc = vcpu_load(vcpu);
+	if (rc)
+		return rc;
 
 	vcpu->guest_debug = 0;
 	kvm_s390_clear_bp_data(vcpu);
 
+	rc = -EINVAL;
 	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
-		return -EINVAL;
+		goto out;
 	if (!sclp.has_gpere)
-		return -EINVAL;
+		goto out;
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
@@ -2847,6 +2852,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 	}
 
+	rc = 0;
+out:
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ae8685155d11..09135bd759a4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7596,6 +7596,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	unsigned long rflags;
 	int i, r;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	if (dbg->control & (KVM_GUESTDBG_INJECT_DB | KVM_GUESTDBG_INJECT_BP)) {
 		r = -EBUSY;
 		if (vcpu->arch.exception.pending)
@@ -7641,7 +7645,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	r = 0;
 
 out:
-
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 173f98d9c58d..6b87c24c60da 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2650,11 +2650,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
-- 
2.14.2

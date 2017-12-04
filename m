Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:40:38 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:35997
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993124AbdLDUgJJ0r46 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:09 +0100
Received: by mail-wm0-x242.google.com with SMTP id b76so16707732wmg.1
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/d9FVZXsDm2cbM204hiwjo2FJJzeekXXGvxX0Nlgts=;
        b=qvAl2zNeSztuD+WFtmp6EaFRHOgx6nvWAIs9sSLD8qEQzYIqItW3lmpbCIrMSxJjY4
         JAY1l2fBR7hYRw+2m0goiCYSr06esU29GsH6iE0nB90OzqiWwoJ0XnCSEnClk1+3Igv1
         7xENjhSPTIr3m9KWCFDMuOJOIdu8e3UVVL7uwPfkTY39pbV04oD7uFfE1CIX7YgSgVFt
         nqFFN+Du2nZKziJ249BkY/SHEOjeXnnwvzm5/RkcMpXRlvo+4XI84CicSgJFYkV+5Aux
         PKO2ETtE+bi7wdnZ9ZVKI6yxcDtZ97lFq1Tc6N3x7UWjks1v2Z4z2G9JRkhlPLctzjj6
         rj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=I/d9FVZXsDm2cbM204hiwjo2FJJzeekXXGvxX0Nlgts=;
        b=dnmlkNzQgSKaNBxxIiS6yx8BCDbi4B2lHhj0pZdsDAtANLRoQXKrqhQZbgDT+pZdWB
         Ip6j7Kh9RRhsy2BwnROFIInY1lwV3E0CnRWq3n/3s/20e6OoRFPeKwWN4j+DP4ALetYC
         +MGAyrzOGp2ziVC4eAvVPLBuFg1m7PMBJ5dxxuzvl9Fm8mmvplsFRG7reUIRU5GBBRRL
         ryWaB8pUJiShOu5H/+DJhpcOI1hS2euU9hLmIt2NaK5wPftuSyXRepQIeOG1YrR5tRMs
         hxE8TvT3ZrSzIuEQyzPqltGe3oX/9Il5h3mPPJjVuD6v5qfSZNBeQhvCAQ1kHDuU1zXe
         E1+w==
X-Gm-Message-State: AJaThX4+bdcJLnS8DUNm22GyBrhhI5QB/UQ2NnDZuoabnOBgdFMR6BKc
        usuIRLOOSgHc3Vc/QHoLoR83XfXkqYGvOg==
X-Google-Smtp-Source: AGs4zMaDkwCPdyBl5ty3eiy+Y5iwZK4c3YoWUht4sM/pIJ70qY6MsXA2vOUFXlKbDl6EqdH7beObGw==
X-Received: by 10.80.214.29 with SMTP id x29mr30879746edi.233.1512419763809;
        Mon, 04 Dec 2017 12:36:03 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:03 -0800 (PST)
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
Subject: [PATCH v3 11/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_guest_debug
Date:   Mon,  4 Dec 2017 21:35:33 +0100
Message-Id: <20171204203538.8370-12-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61298
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
implementations of kvm_arch_vcpu_ioctl_set_guest_debug().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c    | 15 ++++++++++++---
 arch/powerpc/kvm/book3s.c |  2 ++
 arch/powerpc/kvm/booke.c  | 19 +++++++++++++------
 arch/s390/kvm/kvm-s390.c  | 16 ++++++++++++----
 arch/x86/kvm/x86.c        |  4 +++-
 virt/kvm/kvm_main.c       |  2 --
 6 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5c7f657dd207..d7e3299a7734 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -361,10 +361,16 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	int ret = 0;
+
+	vcpu_load(vcpu);
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
@@ -378,7 +384,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
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
index 047651622cb8..234531d1bee1 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -755,7 +755,9 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	vcpu_load(vcpu);
 	vcpu->guest_debug = dbg->control;
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 1b491b89cd43..7cb0e2677e60 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -2018,12 +2018,15 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	struct debug_reg *dbg_reg;
 	int n, b = 0, w = 0;
+	int ret = 0;
+
+	vcpu_load(vcpu);
 
 	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
 		vcpu->arch.dbg_reg.dbcr0 = 0;
 		vcpu->guest_debug = 0;
 		kvm_guest_protect_msr(vcpu, MSR_DE, false);
-		return 0;
+		goto out;
 	}
 
 	kvm_guest_protect_msr(vcpu, MSR_DE, true);
@@ -2055,8 +2058,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 #endif
 
 	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
-		return 0;
+		goto out;
 
+	ret = -EINVAL;
 	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
 		uint64_t addr = dbg->arch.bp[n].addr;
 		uint32_t type = dbg->arch.bp[n].type;
@@ -2067,21 +2071,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
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
index 8fade858c790..4bf80b57b5c1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2804,13 +2804,19 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	int rc = 0;
 
+	vcpu_load(vcpu);
+
 	vcpu->guest_debug = 0;
 	kvm_s390_clear_bp_data(vcpu);
 
-	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
-		return -EINVAL;
-	if (!sclp.has_gpere)
-		return -EINVAL;
+	if (dbg->control & ~VALID_GUESTDBG_FLAGS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	if (!sclp.has_gpere) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
@@ -2830,6 +2836,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 	}
 
+out:
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c30ba99e7aa3..5d19caee6d51 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7601,6 +7601,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	unsigned long rflags;
 	int i, r;
 
+	vcpu_load(vcpu);
+
 	if (dbg->control & (KVM_GUESTDBG_INJECT_DB | KVM_GUESTDBG_INJECT_BP)) {
 		r = -EBUSY;
 		if (vcpu->arch.exception.pending)
@@ -7646,7 +7648,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	r = 0;
 
 out:
-
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a8a49073a23..c688eb777bec 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2642,9 +2642,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
-- 
2.14.2

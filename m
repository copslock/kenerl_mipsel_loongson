Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:39:22 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:38190
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdLDUgFBZ1k6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:05 +0100
Received: by mail-wm0-x241.google.com with SMTP id 64so16585240wme.3
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lRmaraAkFVotZnFmOkIUOPaU/TIrZ5gLINwgg3NwmyU=;
        b=KjaKXnoMgK4h7bteJBMPs5km1kBWT6Qo/9sjZpjtQ4bkQ3KZb8w6Pxvb5jz1FZhAeq
         QDvXpf0CWDV90bcjpj32cBOvku76BvR8oDlVaUn+4pbkd6gPkt2hX5sNNia+HIALCNYi
         HDG6ypJdc5E4ld3aSg0w6WsSpSw5bDWGviwpYKyQqJXQ1SFbxCgkmKANieINIoYpyG9y
         vA04f9I9PhKRJ3nDYnIEq8PN7mdenhCXIvMEA74hG4bqZMTiVbtleGzmqTaIavhYyfPj
         GhKWWGv5IfJofJI5jIYGO5j4uPMecUeeHuZxPekEmDZrP91if1JINUk4oa3WcRiziKEq
         4I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=lRmaraAkFVotZnFmOkIUOPaU/TIrZ5gLINwgg3NwmyU=;
        b=r0O2tiqQeGYr6mjcjIaoYEG5rehZTnCw01DvmVvm+9J5ud5HpDtpwowPrx2nSBrGqQ
         pakVZc1hfgU1gHPigNkLauMOtO+lX1ISYq1YTWQLVttW4eifRj9Sf4I6fzw+BDR9sVo4
         owIsU719wzj7y+I/KbcC4l9m0PXhA4Gz/87paEpsTYPcYm2dos1YUbm40AUjWcL/y+WV
         u+SwfEn4IozdtMRs7UAKN563oc/29o5Wi+6VYOpS29xYK3/Oj513WQtrG1wwPReoISDk
         cSOuWb1EqFU3UFDKiCFa/DlPoVYnLOSZEChWuFxV4TWRXE9e8gToDP2WtQmHd3cTzkgm
         eZ7g==
X-Gm-Message-State: AJaThX655UvXEw3qbTtv+PdnG2rCNKr6EJsC4dTwDW5vdZ1GaWabbPg4
        gZT67ZS/N8qKVuhIHQxYJPpsnA==
X-Google-Smtp-Source: AGs4zMaGwXHIMeEzf7tAtQ+e4KLPoKrAmvn3z3AcPAQ5jYr9hj7pR7kkMnWOPKHyPVwcaem5V8fBkw==
X-Received: by 10.80.240.80 with SMTP id u16mr32541537edl.5.1512419759694;
        Mon, 04 Dec 2017 12:35:59 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:59 -0800 (PST)
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
Subject: [PATCH v3 08/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
Date:   Mon,  4 Dec 2017 21:35:30 +0100
Message-Id: <20171204203538.8370-9-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61295
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
implementations of kvm_arch_vcpu_ioctl_get_mpstate().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 11 +++++++++--
 arch/x86/kvm/x86.c       |  3 +++
 virt/kvm/arm/arm.c       |  3 +++
 virt/kvm/kvm_main.c      |  2 --
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d95b4f15e52b..396fc3db6d63 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2836,9 +2836,16 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	vcpu_load(vcpu);
+
 	/* CHECK_STOP and LOAD are not supported yet */
-	return is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
-				       KVM_MP_STATE_OPERATING;
+	ret = is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
+				      KVM_MP_STATE_OPERATING;
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a31a80aee0b9..9bf62c336aa5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7440,6 +7440,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	vcpu_load(vcpu);
+
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
 					vcpu->arch.pv.pv_unhalted)
@@ -7447,6 +7449,7 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 1f448b208686..a7171701df44 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,11 +381,14 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	vcpu_load(vcpu);
+
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 19cf2d11f80f..eac3c29697db 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2603,9 +2603,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

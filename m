Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:39:47 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:37747
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbdLDUgGWu6H6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:06 +0100
Received: by mail-wm0-x243.google.com with SMTP id f140so16627189wmd.2
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCJeEI2Yc8eiVyqKh4MGBqD1y7hf4RhVqlmbDFQkW50=;
        b=L/27JIj8ivYzOkTEbEPfmNSxG/eOz4PIRW87oe2BHXhrLnm768+gWS/IRczHyzcSpT
         WUxgl79PgWJzL6zhLrKFNmMD796WKky0vlJ6dJHosLtC+wwDPYNyymOa+3XM/C3ZuAPB
         VD8eFo2v8Gl7QvIENnQND94dsDIlcXGPOPujiE8hmMJAgYhyGjgW03b7g12p/fzZTxBF
         IBk0SfouaZKudG+K7ZB/DuJVjewz25O6+dVgjwMdQoLcowckG6A6f8s5q/WvXdSWo3Mt
         hdwW+0NHNycvCWhmjGUXDvaBstKCjxeTeSYcbp0wNJjAY8CQmGwwnw1JkGjEguWx0FiV
         20wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=PCJeEI2Yc8eiVyqKh4MGBqD1y7hf4RhVqlmbDFQkW50=;
        b=R6Y1afnrgDs3nW/5/pyoADxeeGLrPtrx2rC6yub7U5m8p6Zt31/7EAx7aLDzROIGQS
         INiqjkYF75V66rkaQiL1jKKoq8x+8kznDkpwMIXDSMdwr+cDyom0xD+qn9sVQ8FNT4Ec
         /Y79lvJ5lXHfv6b5p2D+W9840xNMaXhlDvA3+ZmYBENWbbZo0rbuKzWgtoJRuxOVF3HG
         LsMKEwzDLLFwHymwX7hSirZNlH+7+Mx785Sx7IEyGxjsHUdIy5CM/1297ycaE7EbIzR+
         ilXojkY34qvqouDpkaC8P4qnCIqCbP+Obnoczkr5IX6VCNSk9TS/qs8fTZY+RwpkD3eR
         UT2A==
X-Gm-Message-State: AJaThX7st0hhfvXbIVX/lUPHcXQZlIGL7UM4QDdSxC9FJryQoRS3u9Xe
        PjgbiCp4rVWwYlzFl+iLmt5xEg==
X-Google-Smtp-Source: AGs4zMZW4CzxkQ4hvAivBjN05kmbWIiPsnYygwCEQVxvM5FF9DfMeHCTbQrAKllLen+7bbljVBfELw==
X-Received: by 10.80.173.20 with SMTP id y20mr31785286edc.23.1512419761091;
        Mon, 04 Dec 2017 12:36:01 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:00 -0800 (PST)
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
Subject: [PATCH v3 09/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
Date:   Mon,  4 Dec 2017 21:35:31 +0100
Message-Id: <20171204203538.8370-10-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61296
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
implementations of kvm_arch_vcpu_ioctl_set_mpstate().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c |  3 +++
 arch/x86/kvm/x86.c       | 14 +++++++++++---
 virt/kvm/arm/arm.c       |  9 +++++++--
 virt/kvm/kvm_main.c      |  2 --
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 396fc3db6d63..8fade858c790 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2853,6 +2853,8 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 {
 	int rc = 0;
 
+	vcpu_load(vcpu);
+
 	/* user space knows about this interface - let it control the state */
 	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
 
@@ -2870,6 +2872,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		rc = -ENXIO;
 	}
 
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9bf62c336aa5..8e67428af01b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7456,15 +7456,19 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret = -EINVAL;
+
+	vcpu_load(vcpu);
+
 	if (!lapic_in_kernel(vcpu) &&
 	    mp_state->mp_state != KVM_MP_STATE_RUNNABLE)
-		return -EINVAL;
+		goto out;
 
 	/* INITs are latched while in SMM */
 	if ((is_smm(vcpu) || vcpu->arch.smi_pending) &&
 	    (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED ||
 	     mp_state->mp_state == KVM_MP_STATE_INIT_RECEIVED))
-		return -EINVAL;
+		goto out;
 
 	if (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
 		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
@@ -7472,7 +7476,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	} else
 		vcpu->arch.mp_state = mp_state->mp_state;
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
-	return 0;
+
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a7171701df44..9a3acbcf542c 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -395,6 +395,10 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret = 0;
+
+	vcpu_load(vcpu);
+
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.power_off = false;
@@ -403,10 +407,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		vcpu_power_off(vcpu);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	vcpu_put(vcpu);
+	return ret;
 }
 
 /**
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index eac3c29697db..f3600052adbb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2618,9 +2618,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
-- 
2.14.2

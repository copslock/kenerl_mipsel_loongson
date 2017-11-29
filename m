Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:45:12 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:40627
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdK2Qljs0F4a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:39 +0100
Received: by mail-wr0-x241.google.com with SMTP id q9so3975299wre.7
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0JIc15NQDKD5O+KuNLF3EfrhYvrSsjginc7xaq4VOc=;
        b=Fnxlg91q3ePQGHJTMaKab3ktYWJd7MaJDjG4l9zSmkYB/7QOcPi5h3ecNyEmOcuzZG
         jIXKgEfO6i0p3tLPVpZytLPButqaFYRPKTmE7RBPAwSQi3lKZ2TcAC3btfSvoQritoto
         RfTm8xLP0cn0wMs+P4ECmaXYtaer/g10WWJvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0JIc15NQDKD5O+KuNLF3EfrhYvrSsjginc7xaq4VOc=;
        b=egwJJu/EeklYqEQtRYgij3F4q1H8eFkH8ETZlFDGhrzKvp/H3bOTKOlKkVDB/OVcqW
         fkNksGmR43RAZk2xzgZYbQXeZZ8qhZjltWZImOseSOpJbNoShTKcYXo2B2e3vgMBQMnd
         h6ZYlJ2VWF6rVMeP3LTowCeUPHRqf34lsMDkVJ+lGSPyOnglnGq7/TwHEvdWaozOiM6Z
         U9HgMQixlP73ZsgNY1OyMvVHFozYlS//2YU42Rl3VsS3hW54MSIgU2KX/Imcxv3k8mBD
         ve2ZrIgyNyvwE095f/U1e52hnFIHJpa9PMh52hkZfOrn0LciOtwoO8dIn0PiCcWNS7d7
         u7XQ==
X-Gm-Message-State: AJaThX5qxCIH2psWr0XfIFKonJugnZquT1LX1Wi+uHEFLaU+CooZeGAj
        f/UWzWZMWuNnjjrvg2WFVE6FwQ==
X-Google-Smtp-Source: AGs4zMYujtx2DEVt3sosN/PG+Zy761xUYx8FWfhLMbYyXlKB9Jp+sr1sKhmXPh7WYQrCtLhvi5Lmng==
X-Received: by 10.223.144.204 with SMTP id i70mr3185150wri.57.1511973694473;
        Wed, 29 Nov 2017 08:41:34 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:33 -0800 (PST)
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
Subject: [PATCH v2 09/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
Date:   Wed, 29 Nov 2017 17:41:09 +0100
Message-Id: <20171129164116.16167-10-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61202
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
implementations of kvm_arch_vcpu_ioctl_set_mpstate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c |  3 +++
 arch/x86/kvm/x86.c       | 15 ++++++++++++---
 virt/kvm/arm/arm.c       |  9 +++++++--
 virt/kvm/kvm_main.c      |  2 --
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 396fc3d..8fade85 100644
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
index 9bf62c3..ee357b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7456,15 +7456,20 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	vcpu_load(vcpu);
+
+	ret = -EINVAL;
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
@@ -7472,7 +7477,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
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
index a717170..9a3acbc 100644
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
index eac3c29..f360005 100644
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
2.7.4

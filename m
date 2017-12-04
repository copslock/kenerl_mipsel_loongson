Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:38:04 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:41933
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991258AbdLDUgBffQN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:01 +0100
Received: by mail-wm0-x241.google.com with SMTP id g75so8238670wme.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6sXuqbCDVaNJ0JhSfw/I4+3+m51clULBvpEUyvl9FPA=;
        b=O+u9SW4qaxxG3p+0bbG//MUlrQC+2p6rA4y60kvPEgp9L01lIZSuf06oiemH6HKTD+
         prDzb05tJgnp0MrpaKHlbcTdDCJlYruquFc7BXXcJ/6sHZWCyYtguEkDTfgLV+yJd8VA
         gHm4KOOSI/TqwUBcpUxM5SQk9xnNGj/Jc22K7NT6wz7JYHlGf5reTS7dO5ZOuj6Ub3au
         KBybLbuav/sQYXr1qwzBMHU4IYIvV8Ol6aimfpkCQIwbGtbNhjyXMKp2WyNBHR5V5S59
         lmkCLJn9tcFrG6c+pP1Kl5zzaa+o8723dMOXPJJS3TsTPlnpFSGuRXpeIFchanLP4KNW
         bVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6sXuqbCDVaNJ0JhSfw/I4+3+m51clULBvpEUyvl9FPA=;
        b=Q5lyoQMbH3S8anD9DkUYKkCneyr4XB24bEprAeSN96ZcSfkWZYw+2dztdgmfU7jmvT
         MrbkV5CkS2ckUA2q8GEGo03lv9jnvpv4u3X5P1I1e9J2rvGtUURPXvQs5rdEdTD0ebBQ
         iDID+ZQ6Zqu5zIoZqKw21Z0VGxdNLWiF6fbmtnu619Q4PmofCxsLDgUAv7yVs2yMtvks
         pl6hCs4SemTCfLkJmUNTARzJZgKMdIlWEwxQx7Z8KMaIg/cRwvGzfqbJcuCbmHUEMcHJ
         H9+dPwbUyVBukOX4lTkReEXSUQ4n9m+RA1fZlliwH9fwRSMbFhnocG1KDpMNNayj6pyz
         dKFQ==
X-Gm-Message-State: AJaThX6GgIneXdzTj8vH+LwIUShl9QrLtRAARrM/H7fo+t/cwGH1z/xb
        ap4qit6m0rJSTRUByrWQiIhhLA==
X-Google-Smtp-Source: AGs4zMYK+G1A/wrSV4DAzMfwTOHHYV75h6ETAK+Qhnf1qbbMaYUgogLV0JHO66eMLk7dd59pDzO3bA==
X-Received: by 10.80.166.34 with SMTP id d31mr32321267edc.96.1512419756704;
        Mon, 04 Dec 2017 12:35:56 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:55 -0800 (PST)
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
Subject: [PATCH v3 06/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
Date:   Mon,  4 Dec 2017 21:35:28 +0100
Message-Id: <20171204203538.8370-7-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61292
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
implementations of kvm_arch_vcpu_ioctl_get_sregs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/book3s.c | 8 +++++++-
 arch/powerpc/kvm/booke.c  | 9 ++++++++-
 arch/s390/kvm/kvm-s390.c  | 4 ++++
 arch/x86/kvm/x86.c        | 3 +++
 virt/kvm/kvm_main.c       | 2 --
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 24bc7aabfc44..6cc2377549f7 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -484,7 +484,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	int ret;
+
+	vcpu_load(vcpu);
+	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	vcpu_put(vcpu);
+
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index bcbbeddc3430..f647e121070e 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1613,11 +1613,18 @@ int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
                                   struct kvm_sregs *sregs)
 {
+	int ret;
+
+	vcpu_load(vcpu);
+
 	sregs->pvr = vcpu->arch.pvr;
 
 	get_sregs_base(vcpu, sregs);
 	get_sregs_arch206(vcpu, sregs);
-	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e3476430578a..18011fc4ac49 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2737,8 +2737,12 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	vcpu_load(vcpu);
+
 	memcpy(&sregs->acrs, &vcpu->run->s.regs.acrs, sizeof(sregs->acrs));
 	memcpy(&sregs->crs, &vcpu->arch.sie_block->gcr, sizeof(sregs->crs));
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 75eacce78f59..20a5f6776eea 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7400,6 +7400,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 {
 	struct desc_ptr dt;
 
+	vcpu_load(vcpu);
+
 	kvm_get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
 	kvm_get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
 	kvm_get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
@@ -7431,6 +7433,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 		set_bit(vcpu->arch.interrupt.nr,
 			(unsigned long *)sregs->interrupt_bitmap);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 963e249d7b79..779c03e39fa4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2581,9 +2581,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

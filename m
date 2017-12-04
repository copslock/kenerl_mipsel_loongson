Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:40:11 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:41936
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbdLDUgHmdgm6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:07 +0100
Received: by mail-wm0-x243.google.com with SMTP id g75so8239079wme.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYxEzG8gJrFWEYjTUtFwtsvYBcArbP6viheD4qC/x1Q=;
        b=FsARXudPrzqz0E1/0EiMZETgWYATGyk/M9iBJQ0MreQzJUwvC64BZsx43OOzC1iRHd
         TRMfQ/eh4FGZX57KXOPPuOQl65ZSKS4oykuuGwcyMGI0DPvcVxe30tPeGyr2b0jBVFu7
         Ar+9jIvpKKcVZ9WZ7aPOwrRc+sNZgskNjRlPoTWRy8wvT/INHfegcsPp8rYkEKYvqXJK
         sRnLJie4J7Tn+dzBUNbeiVwa0xqpNo37urpREO2lSDcv/C+PEMpLbM7b4hekEvrf6vvn
         yVvrc52dufoC2rOcLMIRxGJvPVKrh1a9Rr0SIblgDD+vYOitahWeTpngWDbQyX/svoC3
         NevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=BYxEzG8gJrFWEYjTUtFwtsvYBcArbP6viheD4qC/x1Q=;
        b=CKTYznJJLSqj50tnz3KCZU+9D2BwD7IhvjP01KEAlXpr1TvLafV29GIhWFoZ8Q3kS5
         3OKNQdg0VYMsRH4L5+S6bsJd/t2aLuvHX+w3O/3xHUmTsjjUKo8Bbdy6gJGlv6Y591IV
         Ekhch+WqSUTxsXXrRHEaRYxSoiNnhKLHBh7mgfsIVrDxY9pLdzuBISl01BxgMrGCxVay
         XbdpxecreuZGgN7luyykxBy52soQTkfoJ7RdHrlMV2FVTEQAMdooCPh8qr/ktdlyNpi7
         ZL+23Hyy2AQpBQmbq9TdvhgP14o1lavbxk9m9pqNQZz5ti7l54wSvvymo664T2PTx2mM
         9Uaw==
X-Gm-Message-State: AJaThX5bfIAmkmo2UwLDNKlMCaB/6/MOCnigiK4iIb/E/iQgfugXYqtR
        Dt1m94PZGcscJl7Flzwcet5s4w==
X-Google-Smtp-Source: AGs4zMYwIdOa4odb5VniREcjYA1xyjXs7DFupcdKqpjbpXEJEpV0vFy2L0VLm2xoD1i46Iz2dhUe/A==
X-Received: by 10.80.204.72 with SMTP id n8mr22306876edi.64.1512419762441;
        Mon, 04 Dec 2017 12:36:02 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:01 -0800 (PST)
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
Subject: [PATCH v3 10/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
Date:   Mon,  4 Dec 2017 21:35:32 +0100
Message-Id: <20171204203538.8370-11-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61297
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
implementations of kvm_arch_vcpu_ioctl_translate().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/booke.c | 2 ++
 arch/x86/kvm/x86.c       | 3 +++
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index cdf0be02c95a..1b491b89cd43 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1793,7 +1793,9 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 {
 	int r;
 
+	vcpu_load(vcpu);
 	r = kvmppc_core_vcpu_translate(vcpu, tr);
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8e67428af01b..c30ba99e7aa3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7660,6 +7660,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	gpa_t gpa;
 	int idx;
 
+	vcpu_load(vcpu);
+
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
@@ -7668,6 +7670,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	tr->writeable = 1;
 	tr->usermode = 0;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f3600052adbb..0a8a49073a23 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2627,9 +2627,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2

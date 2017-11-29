Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:45:38 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:36009
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991126AbdK2Qll2G8ma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:41 +0100
Received: by mail-wm0-x241.google.com with SMTP id b76so7248040wmg.1
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUilMp8GJQaK/3PwvYsmqwhU9F1Bw7TTcmnJ+kgxAzc=;
        b=EsH0KUchgJnLuoXIMMEHnN34ckAWO+4MwVdrxSl5frx/iFZ2aYA523lyJ75ebG7Jtp
         rIbM73ZP8Tf7a53msbjU+f7fVfDsQM9RFz1MiQWcei0t3uRvS4vlW0pA5EnciFExOtcH
         vpu0eI1K9PGwi1UXwiqabLauYP5/2MpWeWhjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OUilMp8GJQaK/3PwvYsmqwhU9F1Bw7TTcmnJ+kgxAzc=;
        b=sMrX9J069cZKBW0E4MyDLjEVfhjhTAzM94+T4JKPSuZv/aVZbxZKUYMEp6mIYGnw05
         N/GgP8eJ1R6MeLWLmPHJdNBBEt7UOiIRI+akpiEcSaaB5qvYk+WYXm2pZKs2RGX8lBID
         Js1YdiePwPoGuowCZTkSuzCQpnYy79GZY6MRgC0rUQ91pfo4D6/xTjs9yZPnuYUHNBPF
         RCEXaHwOS1agERcwK4t9psnAf3tlu5ZfeRateDSFQq2SRJq43IkhCArhBdNPUniOeHWK
         RvwL2a4Llz2Z+DGn5Fu9eNNiXnB8VKKl/2T25mhH+GJvKRF3GbUiA+TP9cwQYoQYWEJT
         nzow==
X-Gm-Message-State: AJaThX5YE1neE8+aMpCYtjDumEJ8r1HgqMorItLo5O1FBz8yunM5CIss
        PVKoOIVjYW5Ms/G+cqDUAegHiA==
X-Google-Smtp-Source: AGs4zMbGo+mooMxiNm+5eRst+CffGK3w8+C45r9XoZciINunC3heNytjH7jMPD7gcVjWDRH00MBsHA==
X-Received: by 10.28.105.196 with SMTP id z65mr3173915wmh.146.1511973696121;
        Wed, 29 Nov 2017 08:41:36 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:35 -0800 (PST)
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
Subject: [PATCH v2 10/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
Date:   Wed, 29 Nov 2017 17:41:10 +0100
Message-Id: <20171129164116.16167-11-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61203
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
implementations of kvm_arch_vcpu_ioctl_translate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/booke.c | 2 ++
 arch/x86/kvm/x86.c       | 3 +++
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index cdf0be0..1b491b8 100644
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
index ee357b6..eb70974 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7661,6 +7661,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	gpa_t gpa;
 	int idx;
 
+	vcpu_load(vcpu);
+
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
@@ -7669,6 +7671,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	tr->writeable = 1;
 	tr->usermode = 0;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f360005..0a8a490 100644
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
2.7.4

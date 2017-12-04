Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:36:24 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:37745
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990414AbdLDUfzauE96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:35:55 +0100
Received: by mail-wm0-x244.google.com with SMTP id f140so16626481wmd.2
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+zvnQ9tb3neoXAB4uPVa3PmQf0KA1azQazQX4ATnNU=;
        b=b92Q6VWHAkAAfsJCyj5Nrl2l+xx98SKkwMj0OCTR9jxLnGGvB6eZ79c07FLhqdhsg7
         pkCgRQzg3Ot+6jFP1g75WSSBQfw3b4zEnkK92xN+WV4Xkc7A4uhz5Rj8juKtdqDKyYBq
         z/HZW+1EJidBpXxthwf2QGfu2SpoXJ/hFPbi+qyhZxOJbBy0SDE+15yRWwjhMBaVsZbE
         LTDAqGXxARY75SDdTHM/HPXURHIpWEWUEOuOTK1KfDhFyFh+/ldWG1sXKBII4ACHppJL
         YT5fkrhBEzyKaJ1m6OsHg1El55xOVwzeIezokf/7bsBwa37H38XhXOGxbj/CAlLn4jlQ
         J8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x+zvnQ9tb3neoXAB4uPVa3PmQf0KA1azQazQX4ATnNU=;
        b=AG8hqwArqKX5wtWmuckm+Fjhk0ICh46gwL58BKZC/UMn+c/cr86db1tk0GJxp8qL9y
         1O2wroMVoKLPmVYodrX9IrU/R7KnnewjfdihE5DJTB102IVR28eGp87/rFJUbXRq0E/h
         sE23cdOYIWUYeS60gBuzfVygBq+P/+MQASC9z9GfgSqGQdG0UYqiFdpRpNm2FwmdkKut
         9XzeKutLlgEW1VTaskbeEyY99EG1ugAslEk3t9zRDcxgXaIcezZAE/GjuBRHz8zSuQz8
         e7Itx4uHHtEQrOdPFZEBUmBTKJ8DobG/9ZJTM43ZwdIQRAz1Fsjv59HpWLZZVUfa72gU
         DolQ==
X-Gm-Message-State: AJaThX4zQ4dPoi1rR8t27CE10swrsDjdu76Ri7BFsAmm7kvowGg6HrBz
        uF6MFlKP1rHK6p/U+WzymzZEtg==
X-Google-Smtp-Source: AGs4zMYBfw6fIgifowW945uvz7aanJTFR0eAl5gbdfR/iN0GcXcp72jAe8sX8YANT7ZlHwQS0fXSWg==
X-Received: by 10.80.136.228 with SMTP id d91mr31911412edd.296.1512419749892;
        Mon, 04 Dec 2017 12:35:49 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:49 -0800 (PST)
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
Subject: [PATCH v3 01/16] KVM: Take vcpu->mutex outside vcpu_load
Date:   Mon,  4 Dec 2017 21:35:23 +0100
Message-Id: <20171204203538.8370-2-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61288
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

As we're about to call vcpu_load() from architecture-specific
implementations of the KVM vcpu ioctls, but yet we access data
structures protected by the vcpu->mutex in the generic code, factor
this logic out from vcpu_load().

x86 is the only architecture which calls vcpu_load() outside of the main
vcpu ioctl function, and these calls will no longer take the vcpu mutex
following this patch.  However, with the exception of
kvm_arch_vcpu_postcreate (see below), the callers are either in the
creation or destruction path of the VCPU, which means there cannot be
any concurrent access to the data structure, because the file descriptor
is not yet accessible, or is already gone.

kvm_arch_vcpu_postcreate makes the newly created vcpu potentially
accessible by other in-kernel threads through the kvm->vcpus array, and
we therefore take the vcpu mutex in this case directly.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/x86/kvm/vmx.c       |  4 +---
 arch/x86/kvm/x86.c       | 20 +++++++-------------
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 17 ++++++-----------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 714a0673ec3c..e7c46d20e186 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9559,10 +9559,8 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
 {
        struct vcpu_vmx *vmx = to_vmx(vcpu);
-       int r;
 
-       r = vcpu_load(vcpu);
-       BUG_ON(r);
+       vcpu_load(vcpu);
        vmx_switch_vmcs(vcpu, &vmx->vmcs01);
        free_nested(vmx);
        vcpu_put(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 34c85aa2e2d1..9b8f864243c9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7747,16 +7747,12 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	int r;
-
 	kvm_vcpu_mtrr_init(vcpu);
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
-	return r;
+	return 0;
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
@@ -7766,13 +7762,15 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 	kvm_hv_vcpu_postcreate(vcpu);
 
-	if (vcpu_load(vcpu))
+	if (mutex_lock_killable(&vcpu->mutex))
 		return;
+	vcpu_load(vcpu);
 	msr.data = 0x0;
 	msr.index = MSR_IA32_TSC;
 	msr.host_initiated = true;
 	kvm_write_tsc(vcpu, &msr);
 	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 
 	if (!kvmclock_periodic_sync)
 		return;
@@ -7783,11 +7781,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	int r;
 	vcpu->arch.apf.msr_val = 0;
 
-	r = vcpu_load(vcpu);
-	BUG_ON(r);
+	vcpu_load(vcpu);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 
@@ -8155,9 +8151,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 {
-	int r;
-	r = vcpu_load(vcpu);
-	BUG_ON(r);
+	vcpu_load(vcpu);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2e754b7c282c..a000dd8b75f0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -533,7 +533,7 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 
-int __must_check vcpu_load(struct kvm_vcpu *vcpu);
+void vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f169ecc4f2e8..39961fb8aef7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -146,17 +146,12 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-int vcpu_load(struct kvm_vcpu *vcpu)
+void vcpu_load(struct kvm_vcpu *vcpu)
 {
-	int cpu;
-
-	if (mutex_lock_killable(&vcpu->mutex))
-		return -EINTR;
-	cpu = get_cpu();
+	int cpu = get_cpu();
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
 	put_cpu();
-	return 0;
 }
 EXPORT_SYMBOL_GPL(vcpu_load);
 
@@ -166,7 +161,6 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
 	preempt_enable();
-	mutex_unlock(&vcpu->mutex);
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
 
@@ -2529,9 +2523,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 #endif
 
 
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
+	vcpu_load(vcpu);
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
@@ -2704,6 +2698,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	}
 out:
 	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	kfree(fpu);
 	kfree(kvm_sregs);
 	return r;
-- 
2.14.2

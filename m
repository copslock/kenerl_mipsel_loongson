Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:41:56 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:33760
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990592AbdK2Ql0DUCKa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:26 +0100
Received: by mail-wr0-x242.google.com with SMTP id v22so3991157wrb.0
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cE3UQ+UGCvUHsFL/BgBxgkgcOiwL2R9NJZGc0t11Z2w=;
        b=AqMhwxFBkfNqWSd5/g6l9DvYyox2n6JuCe8u8RdJ6XYxr0Q96aosH8Z+/+NN8EAOBg
         R36PCzCV62AWWpy+hcgsqfRT4JpgezvkxIJTSAPr1KUQ3b7HTaXKmck1DiFZb1mui1S3
         6HWq1yqRXUxOmsC7N3XTdiUP3fZQLDGhNuEXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cE3UQ+UGCvUHsFL/BgBxgkgcOiwL2R9NJZGc0t11Z2w=;
        b=WjgwrrHXKSXaY5PMWuoBcwBSLQQPDrVBu1l3A/6t/lUqvuDVDtn5ng1dJG6pWn2MdP
         UR6LPEdeUnL5JxhXozQ7WQrdoCe7/krpI0eBFeXEQShjjsD2wmlt6wQ/TOrf6HrWelU+
         TgZvw5xDUt3i2DsSR6560a6FN5i/Cl+hiQj+1pHHsNhTDSRwe7j/7ArumMmKEiJZjO0A
         oi89qBqCNZpHzxXhm7xz869Jh7gygYxLaoMd94crhqR+UufSZ2jGecd2hPfZmfcQENsB
         gQW7dxP4eq9F2ZgefnT08PcnsMSd/h/2sgTPZbJbcGIJvzqQFCAlzJ8NX/WnzCVZDL8a
         Y46g==
X-Gm-Message-State: AJaThX53hUEThgJ8UJ8Y6BffI9XN8bUio1dj0rCd0oIa+O16zDC+/Wpi
        jHZl6d556L5TrlWot5G/PQjSbQ==
X-Google-Smtp-Source: AGs4zMYi76geJnkazaBOWek0hLM6WBzETAAUX4Ed3Q2VPOiGBOz+9FWqaWbqwa8Gvi5D0Db+W4Osdg==
X-Received: by 10.223.170.143 with SMTP id h15mr3236747wrc.49.1511973680629;
        Wed, 29 Nov 2017 08:41:20 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:19 -0800 (PST)
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
Subject: [PATCH v2 01/16] KVM: Take vcpu->mutex outside vcpu_load
Date:   Wed, 29 Nov 2017 17:41:01 +0100
Message-Id: <20171129164116.16167-2-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61194
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

As we're about to call vcpu_load() from architecture-specific
implementations of the KVM vcpu ioctls, but yet we access data
structures protected by the vcpu->mutex in the generic code, factor
this logic out from vcpu_load().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/x86/kvm/vmx.c       |  4 +---
 arch/x86/kvm/x86.c       | 20 +++++++-------------
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 17 ++++++-----------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 714a067..e7c46d2 100644
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
index 34c85aa..9b8f864 100644
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
index 2e754b7..a000dd8 100644
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
index f169ecc..39961fb 100644
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
2.7.4

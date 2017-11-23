Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 19:32:15 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35160
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990593AbdKWScIz4YGr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 19:32:08 +0100
Received: by mail-wm0-x241.google.com with SMTP id y80so18322211wmd.0
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qPOy+PgCJuAW/0xlV36+ccd6ao0Jb1E0k6qY8aBj7So=;
        b=OFjaFRc5ti6U3KQba9pT3akjNnGcHM2qMnitIpSd4Y3KP2Gu408ZJwTUr6TF6NTDDR
         xHvJzFa9GrhuxD4a6erfjPtYptzcQe01ov5rnrgjp2jOqSGvjIt8bUCEWASuzHeUfhJM
         JyBlPTJGKK+6WOi+5/0Uo8Lsp7Tr9c0t0Egos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qPOy+PgCJuAW/0xlV36+ccd6ao0Jb1E0k6qY8aBj7So=;
        b=mMwhNxl5W0+IsiT1GrT2VR/aIreG0cSAmNFailVE0dI2LW26f3fjglO8Pl/HL1UUBc
         n2Zr28X3Xc0bjwtXc3GzleNc8fwq+Uh/7ecOHASGW39Xw8ifetMhP1nZtLdzV3K9ypV3
         PBZXM+lHGJsBHiB67PFXI+a9Xi+nE8H5/gVnjfytTf7mX6DKsOTsJ6UAVmTTDoCL8nSK
         d/VBvHXkYKpDYhobkm8ZySMB6gL/QJnQ8HOkh7OJ6Zur0w9eou8yT3AxL75fqitvKToL
         HiFSvfOZ6LSJNqslaKjkh6PWbRO68VOM4OJBtQspYwvBAB6+Ek0yMkiBCgHHaWOaQbPC
         wweQ==
X-Gm-Message-State: AJaThX7MRe164EexqtQ+aWQxIiCoO9bYG87ynMvHd/J/Rj9oO1EDbNDZ
        v5xNiRF0k/yufOqyFofjz69J3w==
X-Google-Smtp-Source: AGs4zMYX16M/vbPgJRiaVmvYI2l/iGUuvdY8ebngcWSjvcc8GybF+TKa8uLkvzyaY4xcsQf8Cp0aSQ==
X-Received: by 10.28.54.3 with SMTP id d3mr7945532wma.79.1511461923496;
        Thu, 23 Nov 2017 10:32:03 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id 19sm8212131wmv.41.2017.11.23.10.32.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 10:32:02 -0800 (PST)
Date:   Thu, 23 Nov 2017 19:32:14 +0100
From:   Christoffer Dall <cdall@linaro.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Message-ID: <20171123183214.GC28855@cbox>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
 <20171123174804.GB28855@cbox>
 <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cdall@linaro.org
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

On Thu, Nov 23, 2017 at 07:16:32PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 18:48, Christoffer Dall wrote:
> >>> That doesn't solve my need as I want to *only* do the arch vcpu_load for
> >>> KVM_RUN, I should have been more clear in the commit message.
> >>
> >> That's what you want to do, but it might not be what you need to do.
> > 
> > Well, why would we want to do a lot of work when there's absolutely no
> > need to?
> > 
> > I see that this patch is invasive, and that's why I originally proposed
> > the other approach of recording the ioctl number.
> 
> Because we need to balance performance and maintainability.  The
> following observation is the important one:
> 

Sure.  So I'm curious...  Is it easier to maintain and simpler for other
architectures (x86 in particular) to call vcpu_load for the non-KVM_RUN
ioctl?

I have a vague notion that this may be related to always being able to
do things like VMREAD no matter the context, but I couldn't easily tell
from the code.

It would have been similar for some parts of the ARM code if we only
supported VHE, but since we don't, we anyway have to check if actually
loaded stuff on the CPU or not, any time we access state, so there is no
win there.

> > While it may be possible to call kvm_arch_vcpu_load() for a number of
> > non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult to reason
> > about, especially after my optimization series, because a lot of things
> > can now happen, where we have to consider if we're really in the process
> > of running a vcpu or not.
> 
> ... because outside ARM I couldn't see any maintainability drawback.
> Now I understand (or at least, I understand enough to believe you!).

I'm happy to hear that I don't need stronger evidence to earn some level
of trust :)

> 
> The idea of this patch then is okay, but:
> 
> * x86 can use __vcpu_load/__vcpu_put, because the calls outside the lock
> are all in the destruction path where no one can concurrently take the
> lock.  So the lock+load and put+unlock variants are not necessary.
> 

ok, that simplifies things.

> * Just make a huge series that, one ioctl at a time, pushes down the
> load/put to the arch-specific functions.  No need to figure out where
> it's actually needed, or at least you can leave it to the architecture
> maintainers.
> 

ok, that makes sense.

And just to be clear, you prefer that over storing the ioctl on the vcpu
struct, like this:

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a2b804e10c95..4c1390f1da88 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9491,7 +9491,7 @@ static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
        struct vcpu_vmx *vmx = to_vmx(vcpu);
        int r;
 
-       r = vcpu_load(vcpu);
+       r = vcpu_load(vcpu, 0);
        BUG_ON(r);
        vmx_switch_vmcs(vcpu, &vmx->vmcs01);
        free_nested(vmx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 03869eb7fcd6..22c7ef2cc699 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7723,7 +7723,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	int r;
 
 	kvm_vcpu_mtrr_init(vcpu);
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, 0);
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
@@ -7739,7 +7739,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 	kvm_hv_vcpu_postcreate(vcpu);
 
-	if (vcpu_load(vcpu))
+	if (vcpu_load(vcpu, 0))
 		return;
 	msr.data = 0x0;
 	msr.index = MSR_IA32_TSC;
@@ -7759,7 +7759,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	int r;
 	vcpu->arch.apf.msr_val = 0;
 
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, 0);
 	BUG_ON(r);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
@@ -8116,7 +8116,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 {
 	int r;
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, 0);
 	BUG_ON(r);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..da0acc02d338 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -274,6 +274,7 @@ struct kvm_vcpu {
 	bool preempted;
 	struct kvm_vcpu_arch arch;
 	struct dentry *debugfs_dentry;
+	unsigned int ioctl; /* ioctl currently executing or 0 */
 };
 
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
@@ -533,7 +534,7 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 
-int __must_check vcpu_load(struct kvm_vcpu *vcpu);
+int __must_check vcpu_load(struct kvm_vcpu *vcpu, unsigned int ioctl);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a245b83..12bc019077a7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -147,12 +147,13 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-int vcpu_load(struct kvm_vcpu *vcpu)
+int vcpu_load(struct kvm_vcpu *vcpu, unsigned int ioctl)
 {
 	int cpu;
 
 	if (mutex_lock_killable(&vcpu->mutex))
 		return -EINTR;
+	vcpu->ioctl = ioctl;
 	cpu = get_cpu();
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -167,6 +168,7 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
 	preempt_enable();
+	vcpu->ioctl = 0;
 	mutex_unlock(&vcpu->mutex);
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
@@ -2529,7 +2531,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 #endif
 
 
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, ioctl);
 	if (r)
 		return r;
 	switch (ioctl) {


Thanks,
-Christoffer

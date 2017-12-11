Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 14:13:07 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990436AbdLKNM4AKc58 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 14:12:56 +0100
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD181A8AA;
        Mon, 11 Dec 2017 13:12:48 +0000 (UTC)
Received: from gondolin (ovpn-117-94.ams2.redhat.com [10.36.117.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 737945C6C5;
        Mon, 11 Dec 2017 13:12:45 +0000 (UTC)
Date:   Mon, 11 Dec 2017 14:12:41 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christoffer Dall <cdall@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 14/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
Message-ID: <20171211141241.2129a84c.cohuck@redhat.com>
In-Reply-To: <20171204203538.8370-15-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-15-cdall@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 11 Dec 2017 13:12:48 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cohuck@redhat.com
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

On Mon,  4 Dec 2017 21:35:36 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move the calls to vcpu_load() and vcpu_put() in to the architecture
> specific implementations of kvm_arch_vcpu_ioctl() which dispatches
> further architecture-specific ioctls on to other functions.
> 
> Some architectures support asynchronous vcpu ioctls which cannot call
> vcpu_load() or take the vcpu->mutex, because that would prevent
> concurrent execution with a running VCPU, which is the intended purpose
> of these ioctls, for example because they inject interrupts.
> 
> We repeat the separate checks for these specifics in the architecture
> code for MIPS, S390 and PPC, and avoid taking the vcpu->mutex and
> calling vcpu_load for these ioctls.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c       | 49 +++++++++++++++++++++++----------------
>  arch/powerpc/kvm/powerpc.c | 13 ++++++-----
>  arch/s390/kvm/kvm-s390.c   | 19 ++++++++-------
>  arch/x86/kvm/x86.c         | 22 +++++++++++++-----
>  virt/kvm/arm/arm.c         | 58 ++++++++++++++++++++++++++++++++--------------
>  virt/kvm/kvm_main.c        |  2 --
>  6 files changed, 103 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 3a898712d6cd..4a039341dc29 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -913,56 +913,65 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
>  	void __user *argp = (void __user *)arg;
>  	long r;
>  
> +	if (ioctl == KVM_INTERRUPT) {

I would add a comment here that this ioctl is async to vcpu execution,
so it is understandable why you skip the vcpu_load().

[As an aside, it is nice that this is now more obvious when looking at
the architectures' handlers.]

> +		struct kvm_mips_interrupt irq;
> +
> +		if (copy_from_user(&irq, argp, sizeof(irq)))
> +			return -EFAULT;
> +		kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
> +			  irq.irq);
> +
> +		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> +	}
> +
> +	vcpu_load(vcpu);
> +
>  	switch (ioctl) {

(...)

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index c06bc9552438..6b5dd3a25fe8 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1617,16 +1617,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	void __user *argp = (void __user *)arg;
>  	long r;
>  
> -	switch (ioctl) {
> -	case KVM_INTERRUPT: {
> +	if (ioctl == KVM_INTERRUPT) {

Same here.

>  		struct kvm_interrupt irq;
> -		r = -EFAULT;
>  		if (copy_from_user(&irq, argp, sizeof(irq)))
> -			goto out;
> -		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> -		goto out;
> +			return -EFAULT;
> +		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
>  	}
>  
> +	vcpu_load(vcpu);
> +
> +	switch (ioctl) {
>  	case KVM_ENABLE_CAP:
>  	{
>  		struct kvm_enable_cap cap;
> @@ -1666,6 +1666,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	}
>  
>  out:
> +	vcpu_put(vcpu);
>  	return r;
>  }
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 43278f334ce3..cd067b63d77f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3743,24 +3743,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	case KVM_S390_IRQ: {
>  		struct kvm_s390_irq s390irq;
>  
> -		r = -EFAULT;
>  		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
> -			break;
> -		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
> -		break;
> +			return -EFAULT;
> +		return kvm_s390_inject_vcpu(vcpu, &s390irq);
>  	}
>  	case KVM_S390_INTERRUPT: {
>  		struct kvm_s390_interrupt s390int;
>  		struct kvm_s390_irq s390irq;
>  
> -		r = -EFAULT;
>  		if (copy_from_user(&s390int, argp, sizeof(s390int)))
> -			break;
> +			return -EFAULT;
>  		if (s390int_to_s390irq(&s390int, &s390irq))
>  			return -EINVAL;
> -		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
> -		break;
> +		return kvm_s390_inject_vcpu(vcpu, &s390irq);
>  	}
> +	}

I find the special casing with the immediate return a bit ugly. Maybe
introduce a helper async_vcpu_ioctl() or so that sets -ENOIOCTLCMD in
its default case and return here if ret != -ENOIOCTLCMD? Christian,
what do you think?

> +
> +	vcpu_load(vcpu);
> +
> +	switch (ioctl) {
>  	case KVM_S390_STORE_STATUS:
>  		idx = srcu_read_lock(&vcpu->kvm->srcu);
>  		r = kvm_s390_vcpu_store_status(vcpu, arg);
> @@ -3883,6 +3884,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	default:
>  		r = -ENOTTY;
>  	}
> +
> +	vcpu_put(vcpu);
>  	return r;
>  }
>  

(...)

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 06751bbecd58..ad5f83159a15 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2693,9 +2693,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		break;
>  	}
>  	default:
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> -		vcpu_put(vcpu);
>  	}
>  out:
>  	mutex_unlock(&vcpu->mutex);

It would be nice if we could get rid of the special casing at the
beginning of this function, but as it would involve not taking the
mutex for special cases (and not releasing it for those special cases),
I don't see an elegant way to do that.

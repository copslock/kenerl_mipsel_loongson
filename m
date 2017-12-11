Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 16:22:44 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:38846
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLKPWgYKsoN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 16:22:36 +0100
Received: by mail-wm0-x241.google.com with SMTP id 64so14807081wme.3
        for <linux-mips@linux-mips.org>; Mon, 11 Dec 2017 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IJjPTf2PRnJQN0yIqccUsMxy/K//KENNZECPcIz+hXg=;
        b=VAsgpVA8SkwA5SjqRASisELhY9/8/vElKAEIvlhdwgS/MDTvyjWzyoMKCgIsgm76Va
         9KMjbGCBP4aONCg1sAfX8dwoviztvrEG/7iBmwMz1PjGZz3rngy7xLhl8TnKwZZtstRY
         6fPWWVRWC0XmqYnluTIsEzw+58mKAGeeKU5R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IJjPTf2PRnJQN0yIqccUsMxy/K//KENNZECPcIz+hXg=;
        b=U4H+1GRjyEX07G3qO1gokxg9fQdLhqHI2QSMfJZJPwgNhnPj6Ru81bIfPqw4ijsxA6
         zUcWz6AHCypqSAavFfIcP0zkkC1cvphG4zlXI2akopLx6eIm7RK2bO6NnbxAQvxPeXEu
         RzHJJFx/eyOlruEvEV0IeYUWKf6/idVUvjyfxw8m/jEpNcAtNPmG1YTFjPu95TIKUw+e
         deUsvGNenr9sFQAv61bck29uGgo72MMoqxrtIJlg2Z+wBnOC0Kh6ZVB1kZxwK9ph2Kri
         JwY7e1LyInNyibzhKEeewH4Ps3OV7jKtXewnPZaqlWrMJfjLbydNH0sljo3Dnh69pqX0
         nG6w==
X-Gm-Message-State: AKGB3mKKeuodmiWLqiMLvlC1LqADSxtL8e8v5Zgg/4JP4cNMrIys568L
        HrUVi32UZbjSyPu158Bh25f7iw==
X-Google-Smtp-Source: ACJfBouule4mQB7hPb8IYd9bi4ItXbL0KMtyQqWRh9gzNqtU2QliNbLr977ScPqT7Bguh0JWbC+ObA==
X-Received: by 10.80.214.202 with SMTP id l10mr1523253edj.58.1513005750951;
        Mon, 11 Dec 2017 07:22:30 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id b7sm6504114eda.60.2017.12.11.07.22.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 07:22:29 -0800 (PST)
Date:   Mon, 11 Dec 2017 16:22:26 +0100
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Christoffer Dall <cdall@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 14/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
Message-ID: <20171211152226.GJ910@cbox>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-15-cdall@kernel.org>
 <20171211141241.2129a84c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211141241.2129a84c.cohuck@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61417
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

On Mon, Dec 11, 2017 at 02:12:41PM +0100, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 21:35:36 +0100
> Christoffer Dall <cdall@kernel.org> wrote:
> 
> > From: Christoffer Dall <christoffer.dall@linaro.org>
> > 
> > Move the calls to vcpu_load() and vcpu_put() in to the architecture
> > specific implementations of kvm_arch_vcpu_ioctl() which dispatches
> > further architecture-specific ioctls on to other functions.
> > 
> > Some architectures support asynchronous vcpu ioctls which cannot call
> > vcpu_load() or take the vcpu->mutex, because that would prevent
> > concurrent execution with a running VCPU, which is the intended purpose
> > of these ioctls, for example because they inject interrupts.
> > 
> > We repeat the separate checks for these specifics in the architecture
> > code for MIPS, S390 and PPC, and avoid taking the vcpu->mutex and
> > calling vcpu_load for these ioctls.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/mips/kvm/mips.c       | 49 +++++++++++++++++++++++----------------
> >  arch/powerpc/kvm/powerpc.c | 13 ++++++-----
> >  arch/s390/kvm/kvm-s390.c   | 19 ++++++++-------
> >  arch/x86/kvm/x86.c         | 22 +++++++++++++-----
> >  virt/kvm/arm/arm.c         | 58 ++++++++++++++++++++++++++++++++--------------
> >  virt/kvm/kvm_main.c        |  2 --
> >  6 files changed, 103 insertions(+), 60 deletions(-)
> > 
> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> > index 3a898712d6cd..4a039341dc29 100644
> > --- a/arch/mips/kvm/mips.c
> > +++ b/arch/mips/kvm/mips.c
> > @@ -913,56 +913,65 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
> >  	void __user *argp = (void __user *)arg;
> >  	long r;
> >  
> > +	if (ioctl == KVM_INTERRUPT) {
> 
> I would add a comment here that this ioctl is async to vcpu execution,
> so it is understandable why you skip the vcpu_load().

Yes, that would be appropriate.

> 
> [As an aside, it is nice that this is now more obvious when looking at
> the architectures' handlers.]
> 

Agreed.

> > +		struct kvm_mips_interrupt irq;
> > +
> > +		if (copy_from_user(&irq, argp, sizeof(irq)))
> > +			return -EFAULT;
> > +		kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
> > +			  irq.irq);
> > +
> > +		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> > +	}
> > +
> > +	vcpu_load(vcpu);
> > +
> >  	switch (ioctl) {
> 
> (...)
> 
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index c06bc9552438..6b5dd3a25fe8 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -1617,16 +1617,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >  	void __user *argp = (void __user *)arg;
> >  	long r;
> >  
> > -	switch (ioctl) {
> > -	case KVM_INTERRUPT: {
> > +	if (ioctl == KVM_INTERRUPT) {
> 
> Same here.
> 
> >  		struct kvm_interrupt irq;
> > -		r = -EFAULT;
> >  		if (copy_from_user(&irq, argp, sizeof(irq)))
> > -			goto out;
> > -		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> > -		goto out;
> > +			return -EFAULT;
> > +		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
> >  	}
> >  
> > +	vcpu_load(vcpu);
> > +
> > +	switch (ioctl) {
> >  	case KVM_ENABLE_CAP:
> >  	{
> >  		struct kvm_enable_cap cap;
> > @@ -1666,6 +1666,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >  	}
> >  
> >  out:
> > +	vcpu_put(vcpu);
> >  	return r;
> >  }
> >  
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 43278f334ce3..cd067b63d77f 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -3743,24 +3743,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >  	case KVM_S390_IRQ: {
> >  		struct kvm_s390_irq s390irq;
> >  
> > -		r = -EFAULT;
> >  		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
> > -			break;
> > -		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
> > -		break;
> > +			return -EFAULT;
> > +		return kvm_s390_inject_vcpu(vcpu, &s390irq);
> >  	}
> >  	case KVM_S390_INTERRUPT: {
> >  		struct kvm_s390_interrupt s390int;
> >  		struct kvm_s390_irq s390irq;
> >  
> > -		r = -EFAULT;
> >  		if (copy_from_user(&s390int, argp, sizeof(s390int)))
> > -			break;
> > +			return -EFAULT;
> >  		if (s390int_to_s390irq(&s390int, &s390irq))
> >  			return -EINVAL;
> > -		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
> > -		break;
> > +		return kvm_s390_inject_vcpu(vcpu, &s390irq);
> >  	}
> > +	}
> 
> I find the special casing with the immediate return a bit ugly. Maybe
> introduce a helper async_vcpu_ioctl() or so that sets -ENOIOCTLCMD in
> its default case and return here if ret != -ENOIOCTLCMD? Christian,
> what do you think?
> 
> > +
> > +	vcpu_load(vcpu);
> > +
> > +	switch (ioctl) {
> >  	case KVM_S390_STORE_STATUS:
> >  		idx = srcu_read_lock(&vcpu->kvm->srcu);
> >  		r = kvm_s390_vcpu_store_status(vcpu, arg);
> > @@ -3883,6 +3884,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >  	default:
> >  		r = -ENOTTY;
> >  	}
> > +
> > +	vcpu_put(vcpu);
> >  	return r;
> >  }
> >  
> 
> (...)
> 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 06751bbecd58..ad5f83159a15 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2693,9 +2693,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >  		break;
> >  	}
> >  	default:
> > -		vcpu_load(vcpu);
> >  		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> > -		vcpu_put(vcpu);
> >  	}
> >  out:
> >  	mutex_unlock(&vcpu->mutex);
> 
> It would be nice if we could get rid of the special casing at the
> beginning of this function, but as it would involve not taking the
> mutex for special cases (and not releasing it for those special cases),
> I don't see an elegant way to do that.

I would also have liked that, and that's essentially what I had in the
first version, but Paolo thought the result was too high an increase in
complexity in the architecture-specfic functions throughout.  I don't
have any better suggestions either.

Thanks,
-Christoffer

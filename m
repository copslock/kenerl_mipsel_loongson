Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Nov 2017 10:09:48 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36423
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbdKZJJliXyVx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Nov 2017 10:09:41 +0100
Received: by mail-wm0-x244.google.com with SMTP id r68so29456945wmr.1
        for <linux-mips@linux-mips.org>; Sun, 26 Nov 2017 01:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QGfXjN9c50hB1J1C1rmlaojIn/3pXOOn7wO9ZyJDE0w=;
        b=YK0UnEsejiDGXinae8o+9muqp4j7xrIoE+zAyYsxN6sWoPBnqEUpkE+G07Eire99xW
         g6cIi25HGsQ4sfOzLqann/ZdNt+TNi9f+qI7KArIpC/TrW3vJm2/OakyE2skjLNSG8oY
         pFWuUWpRCgnQ7BoGKWbUbeD3RJmAo6H5exkEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QGfXjN9c50hB1J1C1rmlaojIn/3pXOOn7wO9ZyJDE0w=;
        b=Diq9qZtne37cwFd5Il0JAI2NzmFfTz8mdzEIA5iPMq/HZbAedTMYlBSfPXx6mXTtcQ
         yCfEBiikc1THARxc/XTTgKVoYDPf94Fz5L4mjddg/9aF0CSgdMmtnPFJWtcRIXlrU3AE
         b5WNrnIIcgoQEMJhnQKUdoWjyGk3UIAoc2LwEPBNqkmsMGuLA2vkZ5C+Aj9OMg8+luWD
         sWpZ5hvcwGd1qMt1nOboNRgvKuYXAXkr3gsyw5TqS1x5MKnu7AIl9AhxAm7dHjjS5GiX
         thZS962LSzdt1yaThm9A0VsApOg3pirHNf1qjiWGZkDJSLl3PjEmSlSsfAYYhUe8uC6F
         hkAw==
X-Gm-Message-State: AJaThX4YZyYKULkF+MCOYCbPjbovVuU9FB9c+1GrMvPSpC720UnuZJii
        c2Ge/Kdud4uiOkq5RO/KbaeFJA==
X-Google-Smtp-Source: AGs4zMZj3Ha9Sj3D+bkrhWPUpJatC1dkbn5cpg/o+uej89mdYW8sZzzrWxhUWoJHBcvhSxkCmSYLvQ==
X-Received: by 10.28.29.207 with SMTP id d198mr12765425wmd.106.1511687376122;
        Sun, 26 Nov 2017 01:09:36 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e132sm803382wmd.40.2017.11.26.01.09.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Nov 2017 01:09:35 -0800 (PST)
Date:   Sun, 26 Nov 2017 10:09:43 +0100
From:   Christoffer Dall <cdall@linaro.org>
To:     Christoffer Dall <christoffer.dall@linaro.org>
Cc:     kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 14/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
Message-ID: <20171126090943.GH28855@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-15-christoffer.dall@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171125205718.7731-15-christoffer.dall@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61093
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

Hi,

[replying to myself]

On Sat, Nov 25, 2017 at 09:57:17PM +0100, Christoffer Dall wrote:
> Move the calls to vcpu_load() and vcpu_put() in to the architecture
> specific implementations of kvm_arch_vcpu_ioctl() which dispatches
> further architecture-specific ioctls on to other functions.
> 
> Some architectures support asynchronous vcpu ioctls which cannot call
> vcpu_load() or take the vcpu->mutex, because that would prevent
> concurrent execution with a running VCPU, which is the intended purpose
> of these ioctls, for example because they inject interrupts.
> 
> We move the checks for these specifics into the architecture code for
> MIPS, S390 and PPC, and it has the added benefit of getting rid of the
> ifdef in the generic dispatcher.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c       | 51 +++++++++++++++++++++++----------------
>  arch/powerpc/kvm/powerpc.c | 15 +++++++-----
>  arch/s390/kvm/kvm-s390.c   | 21 +++++++++-------
>  arch/x86/kvm/x86.c         | 24 ++++++++++++++-----
>  virt/kvm/arm/arm.c         | 60 ++++++++++++++++++++++++++++++++--------------
>  virt/kvm/kvm_main.c        | 15 +-----------
>  6 files changed, 114 insertions(+), 72 deletions(-)
> 

[...]

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 66e5c2445a87..027a6259c3c4 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1621,16 +1621,18 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	void __user *argp = (void __user *)arg;
>  	long r;
>  
> -	switch (ioctl) {
> -	case KVM_INTERRUPT: {
> +	if (ioctl == KVM_INTERRUPT) {
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
> +	r = vcpu_load(vcpu);
> +	if (r)
> +		return r;
> +
> +	switch (ioctl) {
>  	case KVM_ENABLE_CAP:
>  	{
>  		struct kvm_enable_cap cap;
> @@ -1670,6 +1672,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	}
>  
>  out:
> +	vcpu_put(r);
>  	return r;

This should obviously be
	vcpu_put(vcpu);

Fixed for v2.

Thanks,
-Christoffer

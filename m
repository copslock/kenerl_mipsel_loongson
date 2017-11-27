Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 20:28:41 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:45468
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdK0T2XbQiPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 20:28:23 +0100
Received: by mail-wr0-x243.google.com with SMTP id a63so27519103wrc.12
        for <linux-mips@linux-mips.org>; Mon, 27 Nov 2017 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mJTM7LdzHEc4+0H8zUPyFjtjuM4ypVsxkeigELYD/w=;
        b=jSZJbWi9d8LUyFDwwqe6Nr0b/A3I1vCco2q3PHE55ixe/VMuplYHAxYPKjEQxIdIqi
         zRu7gyOrPk2co7GyXe8cFHEs7Is7EXxMUkZVYbVLgWZ6xejnwFIP164kFe/I97SIitWH
         s6P397Dw+X7KUOHXrRdcOuUwqoPOydeBUJc1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mJTM7LdzHEc4+0H8zUPyFjtjuM4ypVsxkeigELYD/w=;
        b=a51ON1Tk0FxyRp6wRE3lxaIUeQ8aeFw9u2lP75/BZK1oJZ2Hhe2bGQvXlqiGb1pTDT
         7I8G3Qg9fxFOl/GA5iMHL5ZOD9udyo0BBwriCkcqaxHX4LGnVLcQI7iE5q58rOSpH8vP
         WWGltiqlaW6/UF6+WU+Gd9YOCGFqw8rS8L1f6bVIOrPpMzfpbewQLlWGV9daTLm3YFy0
         YPXPPoHEPJHv3SwOv4NoB2KxZDRXB00Kwh0CDYGmWgiXglvhO5uVLJEE9j675Y78JePI
         VZyJcpf2XtrMDtOFURH5UWaODW+cvQHLVdl1kjcIp1nWF6YaMcp8HRKoa2v4TDYM46u6
         0SeQ==
X-Gm-Message-State: AJaThX4+GFBtjM+g9a+FlAmVs1gNru6aZHkrf9b3P2ukBow7EuJSKK5R
        J9XK5rWjN26yUwZAN7L+IcClCA==
X-Google-Smtp-Source: AGs4zMbBM4xjk6O9uwlu6sxiVqNK6JykaYx90gz80+PfTpEaQNfbOtbMVIOHzEE6diMQTkfMOA6mmA==
X-Received: by 10.223.157.41 with SMTP id k41mr32920125wre.281.1511810897989;
        Mon, 27 Nov 2017 11:28:17 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id t135sm11505201wmt.24.2017.11.27.11.28.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 11:28:17 -0800 (PST)
Date:   Mon, 27 Nov 2017 20:28:25 +0100
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
Subject: Re: [PATCH 11/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
Message-ID: <20171127192825.GA16941@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-12-christoffer.dall@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171125205718.7731-12-christoffer.dall@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61104
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

Replying to myself again...

On Sat, Nov 25, 2017 at 09:57:14PM +0100, Christoffer Dall wrote:
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_guest_debug().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/guest.c    | 17 ++++++++++++++---
>  arch/powerpc/kvm/book3s.c |  6 ++++++
>  arch/powerpc/kvm/booke.c  | 21 +++++++++++++++------
>  arch/s390/kvm/kvm-s390.c  | 14 +++++++++++---
>  arch/x86/kvm/x86.c        |  6 +++++-
>  virt/kvm/kvm_main.c       |  4 ----
>  6 files changed, 51 insertions(+), 17 deletions(-)
> 

[...]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index aa76d2988178..ac26d95444c9 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2819,15 +2819,20 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  					struct kvm_guest_debug *dbg)
>  {
> -	int rc = 0;
> +	int rc;
> +
> +	rc = vcpu_load(vcpu);
> +	if (rc)
> +		return rc;
>  
>  	vcpu->guest_debug = 0;
>  	kvm_s390_clear_bp_data(vcpu);
>  
> +	rc = -EINVAL;
>  	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
> -		return -EINVAL;
> +		goto out;
>  	if (!sclp.has_gpere)
> -		return -EINVAL;
> +		goto out;
>  
>  	if (dbg->control & KVM_GUESTDBG_ENABLE) {
>  		vcpu->guest_debug = dbg->control;
> @@ -2847,6 +2852,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
>  	}
>  
> +	rc = 0;

This is totally broken (although not clearly visible in the diff),
because it overrides a potential error code.

I'll fix it for v2.

> +out:
> +	vcpu_put(vcpu);
>  	return rc;
>  }
>  

Thanks,
-Christoffer

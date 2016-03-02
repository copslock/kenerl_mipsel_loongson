Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 10:35:33 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34555 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007226AbcCBJf3PeTJs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 10:35:29 +0100
Received: by mail-wm0-f68.google.com with SMTP id p65so8580392wmp.1;
        Wed, 02 Mar 2016 01:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SIf2+Ol4nDcevIjTN1vtgzZfKhrv6rrdEnz2LYaiI8I=;
        b=xh0RJe6kN7k5LnVT0DwheIi+DzYbWRgP22ruhjapj+x/SSzKrb2suelTEc4DxxKanu
         cLjwf5LGIURI58HEal0predDniNGGFQiZp8WqgSWw2O5LE1QegmSu6OjcHFQsTkzEKq6
         nYUA9fo3rhFB/E3PSyuwgclZw2f9g9+JMtAG1t/z7oTsSxgddsRQqBmt8tc4QcGja5n/
         EZu3o43MoA8zDfn2mZX3EIziwavdn6FsLz4z94pKwjMsCPYw7T+mESt4nIU/dlPyqhLy
         1CNewf977rOS2LG86WHIimgOQzBCMoeBlFx8FzxLmJ9f67l6Kkz7ZUeQxKtk9a85WcJ5
         HWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SIf2+Ol4nDcevIjTN1vtgzZfKhrv6rrdEnz2LYaiI8I=;
        b=Tve8Nj7G2XHRNbSj+mWhLsE4QmxSYnh2K0VAUgn8XPgpwFg/1zb8Hr+VTDz8XaY2Xq
         cCqwasKRr4bneZw3hnVLegY+1wESpDUEz86KeFNdNrZI/Iu59+XrmVgZR//a7ISTCUy8
         925VWv/+OLPfyATBq+ihDN45emFvJ1Z7wAv4DK6NMo1NGeqkwm0Wp8rX8hbKMXC/wFJ8
         EUWHeSbiCiJlssWEcV+y3TzmG034ydski0mDpTMDq3Dc5HprQHP2G8JyZvbb1buObEH+
         ySzgNZZjUbBM8d9kxMtPEVNARXaD587Hfx2G/SYg7YfWjzLc6od9T/d4tmRvnl28n37J
         MPZA==
X-Gm-Message-State: AD7BkJL7XsH4UwdCILN6qco4mSVeR2MHa7qLJha5I/bS6a3kacW11GhD4XX+80UwMfDXOg==
X-Received: by 10.28.225.8 with SMTP id y8mr3635745wmg.23.1456911323673;
        Wed, 02 Mar 2016 01:35:23 -0800 (PST)
Received: from [192.168.10.150] (94-39-138-146.adsl-ull.clienti.tiscali.it. [94.39.138.146])
        by smtp.googlemail.com with ESMTPSA id e19sm3270835wmd.1.2016.03.02.01.35.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 01:35:22 -0800 (PST)
Subject: Re: [PATCH for-4,5] mips/kvm: fix ioctl error handling
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <1456673711-24132-1-git-send-email-mst@redhat.com>
Cc:     stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56D6B3D8.1090000@redhat.com>
Date:   Wed, 2 Mar 2016 10:35:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456673711-24132-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 28/02/2016 16:35, Michael S. Tsirkin wrote:
> Calling return copy_to_user(...) or return copy_from_user in an ioctl
> will not do the right thing if there's a pagefault:
> copy_to_user/copy_from_user return the number of bytes not copied in
> this case.
> 
> Fix up kvm on mips to do
> 	return copy_to_user(...)) ?  -EFAULT : 0;
> and
> 	return copy_from_user(...)) ?  -EFAULT : 0;
> 
> everywhere.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Untested.
> 
>  arch/mips/kvm/mips.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 8bc3977..3110447 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -702,7 +702,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
>  	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
>  		void __user *uaddr = (void __user *)(long)reg->addr;
>  
> -		return copy_to_user(uaddr, vs, 16);
> +		return copy_to_user(uaddr, vs, 16) ? -EFAULT : 0;
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -732,7 +732,7 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
>  	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U128) {
>  		void __user *uaddr = (void __user *)(long)reg->addr;
>  
> -		return copy_from_user(vs, uaddr, 16);
> +		return copy_from_user(vs, uaddr, 16) ? -EFAULT : 0;
>  	} else {
>  		return -EINVAL;
>  	}
> 

Applied with the commit message tweak suggested by Sergei.

Paolo

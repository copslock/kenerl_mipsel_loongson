Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 07:53:48 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:53461
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeB1GxkMfbJi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 07:53:40 +0100
Received: by mail-wm0-x244.google.com with SMTP id t74so2858208wme.3
        for <linux-mips@linux-mips.org>; Tue, 27 Feb 2018 22:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zxq8biUl0aGGaa+HCTGp8R/4kMwR+TQh7rz7QfjAdSw=;
        b=SeCZLH1Ys5BENHbp56oScrG9b0NYYRDGKav43le0duW2vhzBspcaevNuXydUBLdHHR
         2LCq57Bj61/L/HVyXZue7PBixr2sObAXPbPkup8PU2Euw9G6BrvsSSl4G1nYNecMkxnv
         TUao0iqS5fFInhU341HG/Bl8PmEK2E7wI5zQI5Nrbx/zbfVaIo8l8QlSD7+fvQ2QbATt
         Jz8AIAP4N1BlP01MaRjYylfvCjI0uiBO7UeJt9kS194qTbPZbX8cLHyDLoV+by/dN+6c
         f4TS9guT7wuCqEaj/i8eL3Kgon8pG3w7fH3LT/1Hd6qbAMiwWjSCVCXOLvpnrgT7zBoL
         mksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zxq8biUl0aGGaa+HCTGp8R/4kMwR+TQh7rz7QfjAdSw=;
        b=KEXLBjUJh/iafE7/GIBx2yQ2HYFacC8X5kJvvpBua7Q6wsXtYNmOMp10Jp7EuuAtv1
         o4zXGn3DpmVGsXK+1lk2UPTwLWu96dCCuh7XUJhSZp0NYoxACcAGEJliRL20TtkZnS9P
         Dz+gGlHXRfmwkoPgkDEwYR15AnMY50w5eUhQ6iRRkE5U0GLfqXKenxR86OoFX9yspMxH
         /4V4vAbjRtPxdn7Krp0WTsQ0r4FVMcjP/MQ61PVMp7+T6INFfnOZhItFt+5MMvfy1mIk
         ahpgFjayTU1PUD8ACH81K2s6akLWvEDVbuFDlhkFVlzLrCiLnMUOcqEhti+4FZYuXSgu
         UtbA==
X-Gm-Message-State: APf1xPA3TW3eIWlHrQtkrLa0HgLnsTG6wBNG4u53X8dlJO0XqN3LIwoL
        N+nq14JcnzYshbTHh70aN/dDsc7/
X-Google-Smtp-Source: AH8x225MCTidDzxyqsZ9zMlkyatQ9wFJ+FHjqQEpLtrwFrhLNjjFTbwz07kYilJnJUiroQwDIH/qNw==
X-Received: by 10.80.214.75 with SMTP id c11mr22418364edj.80.1519800814357;
        Tue, 27 Feb 2018 22:53:34 -0800 (PST)
Received: from [192.168.10.150] (94-36-191-219.adsl-ull.clienti.tiscali.it. [94.36.191.219])
        by smtp.googlemail.com with ESMTPSA id f53sm1262114ede.49.2018.02.27.22.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 22:53:33 -0800 (PST)
Subject: Re: [PATCH] KVM: surround kvm_arch_vcpu_async_ioctl() with #ifdef
To:     wei.guo.simon@gmail.com, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org
References: <1519785099-13808-1-git-send-email-wei.guo.simon@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19e68ff8-552e-2e64-c2e4-3c718343bf57@redhat.com>
Date:   Wed, 28 Feb 2018 07:53:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519785099-13808-1-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62733
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

On 28/02/2018 03:31, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Although CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL is usually on, logically
> kvm_arch_vcpu_async_ioctl() definition should be wrapped with
> CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL #ifdef.

No, the symbol is defined by Kconfig.  It is a bug if it is not #defined.

Paolo

> This patch adds the #ifdef surround.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/mips/kvm/mips.c       | 2 ++
>  arch/powerpc/kvm/powerpc.c | 2 ++
>  arch/s390/kvm/kvm-s390.c   | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 2549fdd..4d593e5 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -903,6 +903,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
>  long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
>  			       unsigned long arg)
>  {
> @@ -922,6 +923,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
>  
>  	return -ENOIOCTLCMD;
>  }
> +#endif
>  
>  long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
>  			 unsigned long arg)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 403e642..2adca3c 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1757,6 +1757,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  	return -EINVAL;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
>  long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  			       unsigned int ioctl, unsigned long arg)
>  {
> @@ -1771,6 +1772,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  	}
>  	return -ENOIOCTLCMD;
>  }
> +#endif
>  
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>                           unsigned int ioctl, unsigned long arg)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 77d7818..c499396 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3784,6 +3784,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
>  long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  			       unsigned int ioctl, unsigned long arg)
>  {
> @@ -3811,6 +3812,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  	}
>  	return -ENOIOCTLCMD;
>  }
> +#endif
>  
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>  			 unsigned int ioctl, unsigned long arg)
> 

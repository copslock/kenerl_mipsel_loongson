Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 17:24:15 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:52614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990474AbdLHQYHwW2Cv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 17:24:07 +0100
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65906C005F6D;
        Fri,  8 Dec 2017 16:24:01 +0000 (UTC)
Received: from [10.36.116.132] (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE37E77C89;
        Fri,  8 Dec 2017 16:23:57 +0000 (UTC)
Subject: Re: [PATCH v3 06/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_sregs
To:     Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-7-cdall@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cd63ce04-6e7c-17ac-81bf-9f51763d5a66@redhat.com>
Date:   Fri, 8 Dec 2017 17:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171204203538.8370-7-cdall@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 08 Dec 2017 16:24:01 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@redhat.com
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

On 04.12.2017 21:35, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_get_sregs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/powerpc/kvm/book3s.c | 8 +++++++-
>  arch/powerpc/kvm/booke.c  | 9 ++++++++-
>  arch/s390/kvm/kvm-s390.c  | 4 ++++
>  arch/x86/kvm/x86.c        | 3 +++
>  virt/kvm/kvm_main.c       | 2 --
>  5 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 24bc7aabfc44..6cc2377549f7 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -484,7 +484,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  				  struct kvm_sregs *sregs)
>  {
> -	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +	int ret;
> +
> +	vcpu_load(vcpu);
> +	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +	vcpu_put(vcpu);
> +
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index bcbbeddc3430..f647e121070e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1613,11 +1613,18 @@ int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>                                    struct kvm_sregs *sregs)
>  {
> +	int ret;
> +
> +	vcpu_load(vcpu);
> +
>  	sregs->pvr = vcpu->arch.pvr;
>  
>  	get_sregs_base(vcpu, sregs);
>  	get_sregs_arch206(vcpu, sregs);
> -	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +	ret = vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
> +
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e3476430578a..18011fc4ac49 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2737,8 +2737,12 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  				  struct kvm_sregs *sregs)
>  {
> +	vcpu_load(vcpu);
> +
>  	memcpy(&sregs->acrs, &vcpu->run->s.regs.acrs, sizeof(sregs->acrs));
>  	memcpy(&sregs->crs, &vcpu->arch.sie_block->gcr, sizeof(sregs->crs));
> +
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 75eacce78f59..20a5f6776eea 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7400,6 +7400,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  {
>  	struct desc_ptr dt;
>  
> +	vcpu_load(vcpu);
> +
>  	kvm_get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
>  	kvm_get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
>  	kvm_get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
> @@ -7431,6 +7433,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  		set_bit(vcpu->arch.interrupt.nr,
>  			(unsigned long *)sregs->interrupt_bitmap);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 963e249d7b79..779c03e39fa4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2581,9 +2581,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!kvm_sregs)
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
> -		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

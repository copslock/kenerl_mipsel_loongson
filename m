Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 17:26:19 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:54546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990477AbdLHQ0NBZM4s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 17:26:13 +0100
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C908AC074555;
        Fri,  8 Dec 2017 16:26:06 +0000 (UTC)
Received: from [10.36.116.132] (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5696E70116;
        Fri,  8 Dec 2017 16:26:03 +0000 (UTC)
Subject: Re: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
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
 <20171204203538.8370-8-cdall@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com>
Date:   Fri, 8 Dec 2017 17:26:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171204203538.8370-8-cdall@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 08 Dec 2017 16:26:06 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61376
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


>  
>  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index f647e121070e..cdf0be02c95a 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1632,18 +1632,25 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  {
>  	int ret;
>  
> +	vcpu_load(vcpu);
> +
> +	ret = -EINVAL;

you can initialize this directly.

>  	if (vcpu->arch.pvr != sregs->pvr)
> -		return -EINVAL;
> +		goto out;
>  
>  	ret = set_sregs_base(vcpu, sregs);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	ret = set_sregs_arch206(vcpu, sregs);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
> +
> +	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
>  
> -	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 18011fc4ac49..d95b4f15e52b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2729,8 +2729,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  				  struct kvm_sregs *sregs)
>  {
> +	vcpu_load(vcpu);
> +
>  	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
>  	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
> +
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 20a5f6776eea..a31a80aee0b9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7500,15 +7500,19 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  	int mmu_reset_needed = 0;
>  	int pending_vec, max_bits, idx;
>  	struct desc_ptr dt;
> +	int ret;
> +
> +	vcpu_load(vcpu);
>  
> +	ret = -EINVAL;

dito


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

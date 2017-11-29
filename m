Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:46:52 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:59468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992128AbdK2RqoxSxIV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:46:44 +0100
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 791523E7FC;
        Wed, 29 Nov 2017 17:46:38 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D83254D742;
        Wed, 29 Nov 2017 17:46:33 +0000 (UTC)
Subject: Re: [PATCH v2 09/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_mpstate
To:     Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-10-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7332a8d3-2ff9-54db-0c05-a45303d184ad@redhat.com>
Date:   Wed, 29 Nov 2017 18:46:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-10-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 29 Nov 2017 17:46:38 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61221
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

On 29.11.2017 17:41, Christoffer Dall wrote:
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_mpstate().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c |  3 +++
>  arch/x86/kvm/x86.c       | 15 ++++++++++++---
>  virt/kvm/arm/arm.c       |  9 +++++++--
>  virt/kvm/kvm_main.c      |  2 --
>  4 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 396fc3d..8fade85 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2853,6 +2853,8 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  {
>  	int rc = 0;
>  
> +	vcpu_load(vcpu);
> +
>  	/* user space knows about this interface - let it control the state */
>  	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
>  
> @@ -2870,6 +2872,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  		rc = -ENXIO;
>  	}
>  
> +	vcpu_put(vcpu);
>  	return rc;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9bf62c3..ee357b6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7456,15 +7456,20 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	int ret;

initialize ret directly to -EINVAL ?

> +
> +	vcpu_load(vcpu);
> +
> +	ret = -EINVAL;
>  	if (!lapic_in_kernel(vcpu) &&
>  	    mp_state->mp_state != KVM_MP_STATE_RUNNABLE)
> -		return -EINVAL;
> +		goto out;
>  
>  	/* INITs are latched while in SMM */
>  	if ((is_smm(vcpu) || vcpu->arch.smi_pending) &&
>  	    (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED ||
>  	     mp_state->mp_state == KVM_MP_STATE_INIT_RECEIVED))
> -		return -EINVAL;
> +		goto out;
>  
>  	if (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
>  		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
> @@ -7472,7 +7477,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  	} else
>  		vcpu->arch.mp_state = mp_state->mp_state;
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
> -	return 0;
> +
> +	ret = 0;
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a717170..9a3acbc 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -395,6 +395,10 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	int ret = 0;
> +
> +	vcpu_load(vcpu);
> +
>  	switch (mp_state->mp_state) {
>  	case KVM_MP_STATE_RUNNABLE:
>  		vcpu->arch.power_off = false;
> @@ -403,10 +407,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  		vcpu_power_off(vcpu);
>  		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>  
> -	return 0;
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  /**
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index eac3c29..f360005 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2618,9 +2618,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
> -		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_TRANSLATE: {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

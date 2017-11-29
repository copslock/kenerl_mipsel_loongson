Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:48:03 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:35816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992176AbdK2Rr4V3uCV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:47:56 +0100
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6CA713A42;
        Wed, 29 Nov 2017 17:47:49 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1A460605;
        Wed, 29 Nov 2017 17:47:43 +0000 (UTC)
Subject: Re: [PATCH v2 08/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_mpstate
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
 <20171129164116.16167-9-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <70d9ce37-8c96-fcf9-b736-20455dfaf440@redhat.com>
Date:   Wed, 29 Nov 2017 18:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-9-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 29 Nov 2017 17:47:49 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61222
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
> implementations of kvm_arch_vcpu_ioctl_get_mpstate().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c | 11 +++++++++--
>  arch/x86/kvm/x86.c       |  3 +++
>  virt/kvm/arm/arm.c       |  3 +++
>  virt/kvm/kvm_main.c      |  2 --
>  4 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d95b4f1..396fc3d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2836,9 +2836,16 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	int ret;
> +
> +	vcpu_load(vcpu);
> +
>  	/* CHECK_STOP and LOAD are not supported yet */
> -	return is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
> -				       KVM_MP_STATE_OPERATING;
> +	ret = is_vcpu_stopped(vcpu) ? KVM_MP_STATE_STOPPED :
> +				      KVM_MP_STATE_OPERATING;
> +
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a31a80a..9bf62c3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7440,6 +7440,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	vcpu_load(vcpu);
> +
>  	kvm_apic_accept_events(vcpu);
>  	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
>  					vcpu->arch.pv.pv_unhalted)
> @@ -7447,6 +7449,7 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  	else
>  		mp_state->mp_state = vcpu->arch.mp_state;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 1f448b2..a717170 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -381,11 +381,14 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> +	vcpu_load(vcpu);
> +
>  	if (vcpu->arch.power_off)
>  		mp_state->mp_state = KVM_MP_STATE_STOPPED;
>  	else
>  		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 19cf2d1..eac3c29 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2603,9 +2603,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  	case KVM_GET_MP_STATE: {
>  		struct kvm_mp_state mp_state;
>  
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
> -		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

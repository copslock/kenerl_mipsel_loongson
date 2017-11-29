Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:44:03 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:36644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdK2Rnzd2eTV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:43:55 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CBDA85543;
        Wed, 29 Nov 2017 17:43:49 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA18A600C0;
        Wed, 29 Nov 2017 17:43:45 +0000 (UTC)
Subject: Re: [PATCH v2 11/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
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
 <20171129164116.16167-12-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9475a797-f412-688d-298c-7f6a11a672be@redhat.com>
Date:   Wed, 29 Nov 2017 18:43:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-12-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 29 Nov 2017 17:43:49 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61219
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
> implementations of kvm_arch_vcpu_ioctl_set_guest_debug().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/guest.c    | 15 ++++++++++++---
>  arch/powerpc/kvm/book3s.c |  2 ++
>  arch/powerpc/kvm/booke.c  | 19 +++++++++++++------
>  arch/s390/kvm/kvm-s390.c  | 16 ++++++++++++----
>  arch/x86/kvm/x86.c        |  4 +++-
>  virt/kvm/kvm_main.c       |  2 --
>  6 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5c7f657..d7e3299 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -361,10 +361,16 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  					struct kvm_guest_debug *dbg)
>  {
> +	int ret = 0;
> +
> +	vcpu_load(vcpu);
> +
>  	trace_kvm_set_guest_debug(vcpu, dbg->control);
>  
> -	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
> -		return -EINVAL;
> +	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	if (dbg->control & KVM_GUESTDBG_ENABLE) {
>  		vcpu->guest_debug = dbg->control;
> @@ -378,7 +384,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  		/* If not enabled clear all flags */
>  		vcpu->guest_debug = 0;
>  	}
> -	return 0;
> +
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 0476516..234531d 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -755,7 +755,9 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  					struct kvm_guest_debug *dbg)
>  {
> +	vcpu_load(vcpu);
>  	vcpu->guest_debug = dbg->control;
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1b491b8..7cb0e26 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -2018,12 +2018,15 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  {
>  	struct debug_reg *dbg_reg;
>  	int n, b = 0, w = 0;
> +	int ret = 0;
> +
> +	vcpu_load(vcpu);
>  
>  	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
>  		vcpu->arch.dbg_reg.dbcr0 = 0;
>  		vcpu->guest_debug = 0;
>  		kvm_guest_protect_msr(vcpu, MSR_DE, false);
> -		return 0;
> +		goto out;
>  	}
>  
>  	kvm_guest_protect_msr(vcpu, MSR_DE, true);
> @@ -2055,8 +2058,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  #endif
>  
>  	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
> -		return 0;
> +		goto out;
>  
> +	ret = -EINVAL;
>  	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
>  		uint64_t addr = dbg->arch.bp[n].addr;
>  		uint32_t type = dbg->arch.bp[n].type;
> @@ -2067,21 +2071,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
>  			     KVMPPC_DEBUG_WATCH_WRITE |
>  			     KVMPPC_DEBUG_BREAKPOINT))
> -			return -EINVAL;
> +			goto out;
>  
>  		if (type & KVMPPC_DEBUG_BREAKPOINT) {
>  			/* Setting H/W breakpoint */
>  			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
> -				return -EINVAL;
> +				goto out;
>  		} else {
>  			/* Setting H/W watchpoint */
>  			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
>  							type, w++))
> -				return -EINVAL;
> +				goto out;
>  		}
>  	}
>  
> -	return 0;
> +	ret = 0;
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8fade85..4bf80b5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2804,13 +2804,19 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  {
>  	int rc = 0;
>  
> +	vcpu_load(vcpu);
> +
>  	vcpu->guest_debug = 0;
>  	kvm_s390_clear_bp_data(vcpu);
>  
> -	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
> -		return -EINVAL;
> -	if (!sclp.has_gpere)
> -		return -EINVAL;
> +	if (dbg->control & ~VALID_GUESTDBG_FLAGS) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	if (!sclp.has_gpere) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
>  
>  	if (dbg->control & KVM_GUESTDBG_ENABLE) {
>  		vcpu->guest_debug = dbg->control;
> @@ -2830,6 +2836,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
>  	}
>  
> +out:
> +	vcpu_put(vcpu);
>  	return rc;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index eb70974..a074b0bd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7602,6 +7602,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  	unsigned long rflags;
>  	int i, r;
>  
> +	vcpu_load(vcpu);
> +
>  	if (dbg->control & (KVM_GUESTDBG_INJECT_DB | KVM_GUESTDBG_INJECT_BP)) {
>  		r = -EBUSY;
>  		if (vcpu->arch.exception.pending)
> @@ -7647,7 +7649,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  	r = 0;
>  
>  out:
> -
> +	vcpu_put(vcpu);
>  	return r;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0a8a490..c688eb7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2642,9 +2642,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&dbg, argp, sizeof(dbg)))
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
> -		vcpu_put(vcpu);
>  		break;
>  	}
>  	case KVM_SET_SIGNAL_MASK: {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:37:58 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:52604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdK2Rhv0WhgV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:37:51 +0100
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF8B181E09;
        Wed, 29 Nov 2017 17:37:44 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63D1460841;
        Wed, 29 Nov 2017 17:37:41 +0000 (UTC)
Subject: Re: [PATCH v2 13/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_fpu
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
 <20171129164116.16167-14-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f3e93346-7d6c-1f3f-1ec7-0823d46a83b7@redhat.com>
Date:   Wed, 29 Nov 2017 18:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-14-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 29 Nov 2017 17:37:45 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61217
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
> implementations of kvm_arch_vcpu_ioctl_set_fpu().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c | 15 ++++++++++++---
>  arch/x86/kvm/x86.c       |  8 ++++++--
>  virt/kvm/kvm_main.c      |  2 --
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 88dcb89..43278f3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2752,15 +2752,24 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>  
>  int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
> -	if (test_fp_ctl(fpu->fpc))
> -		return -EINVAL;
> +	int ret = 0;
> +
> +	vcpu_load(vcpu);
> +
> +	if (test_fp_ctl(fpu->fpc)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  	vcpu->run->s.regs.fpc = fpu->fpc;
>  	if (MACHINE_HAS_VX)
>  		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
>  				 (freg_t *) fpu->fprs);
>  	else
>  		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
> -	return 0;
> +
> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8b54567..fd8b92f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7699,8 +7699,11 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  
>  int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
> -	struct fxregs_state *fxsave =
> -			&vcpu->arch.guest_fpu.state.fxsave;
> +	struct fxregs_state *fxsave;
> +
> +	vcpu_load(vcpu);
> +
> +	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
>  
>  	memcpy(fxsave->st_space, fpu->fpr, 128);
>  	fxsave->cwd = fpu->fcw;
> @@ -7711,6 +7714,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  	fxsave->rdp = fpu->last_dp;
>  	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 73ad70a..06751bb 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2689,9 +2689,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			fpu = NULL;
>  			goto out;
>  		}
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
> -		vcpu_put(vcpu);
>  		break;
>  	}
>  	default:
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

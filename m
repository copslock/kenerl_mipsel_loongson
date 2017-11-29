Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:40:43 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:42114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdK2RkgCvuBV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:40:36 +0100
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96CDF6A7D6;
        Wed, 29 Nov 2017 17:40:29 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD9E760F80;
        Wed, 29 Nov 2017 17:40:25 +0000 (UTC)
Subject: Re: [PATCH v2 12/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_fpu
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
 <20171129164116.16167-13-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ae58005c-4b83-fac0-56aa-b77511249beb@redhat.com>
Date:   Wed, 29 Nov 2017 18:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-13-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 29 Nov 2017 17:40:29 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61218
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
> implementations of kvm_arch_vcpu_ioctl_get_fpu().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c | 4 ++++
>  arch/x86/kvm/x86.c       | 7 +++++--
>  virt/kvm/kvm_main.c      | 2 --
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4bf80b5..88dcb89 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2765,6 +2765,8 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
> +	vcpu_load(vcpu);
> +
>  	/* make sure we have the latest values */
>  	save_fpu_regs();
>  	if (MACHINE_HAS_VX)
> @@ -2773,6 +2775,8 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  	else
>  		memcpy(fpu->fprs, vcpu->run->s.regs.fprs, sizeof(fpu->fprs));
>  	fpu->fpc = vcpu->run->s.regs.fpc;
> +
> +	vcpu_put(vcpu);

This is one example where we need the vcpu_put/load.

>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a074b0bd..8b54567 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7679,9 +7679,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>  
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
> -	struct fxregs_state *fxsave =
> -			&vcpu->arch.guest_fpu.state.fxsave;
> +	struct fxregs_state *fxsave;
>  
> +	vcpu_load(vcpu);
> +
> +	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
>  	memcpy(fpu->fpr, fxsave->st_space, 128);
>  	fpu->fcw = fxsave->cwd;
>  	fpu->fsw = fxsave->swd;
> @@ -7691,6 +7693,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  	fpu->last_dp = fxsave->rdp;
>  	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c688eb7..73ad70a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2673,9 +2673,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!fpu)
>  			goto out;
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
> -		vcpu_put(vcpu);
>  		if (r)
>  			goto out;
>  		r = -EFAULT;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

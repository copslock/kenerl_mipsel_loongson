Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 12:00:39 +0200 (CEST)
Received: from mail-wm0-x22c.google.com ([IPv6:2a00:1450:400c:c09::22c]:36117
        "EHLO mail-wm0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994921AbdH2KAX3Bt5B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 12:00:23 +0200
Received: by mail-wm0-x22c.google.com with SMTP id b82so17347466wmd.1
        for <linux-mips@linux-mips.org>; Tue, 29 Aug 2017 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M1z83VgvwW8tiMdD0EXHnESX58gU0k50XC0P2K7aq9o=;
        b=H2dsTFaqtGNyM689reSAMuZJmxQl2H2Foe2F/BGujHmMdBhZLparTJlpN5+5f82GaD
         rCg0uhDIHZBdYyBXf5Jhh+OxVd8tnU1+sJCo3Yv40DE6z9YbnIMuoHuLKE4gZvbbYz2+
         mIsx/IfYsXm/G+p0Cpj4buFotV99Y6zUUsLvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M1z83VgvwW8tiMdD0EXHnESX58gU0k50XC0P2K7aq9o=;
        b=tplXg+17eKxMwQcp6gZLyFrXz93mO8v33j0vK96sZFC2deur62Ra1zZPmCaETCzg8b
         EoA6WnXCrcFI9e0S+GQrIybX4NPx37HLf2SnQBiNz5Vjd8fV6tqhSOT0dunvpkcmsXM3
         Sv1BZ3UUeuiXOxzXkjtFqaAV9telRb4VwuAxUGiEqCwzOXA5wxpOZ8PX6M7QY8yDDJ+d
         r4mvW68sENhax4mmFZiCH3AGEvz72Ax3T8yw/2uTgsxsf9qEyfX+JM+y/RQ6xheiRlTW
         fXza4iX1ordQV47OAmzrnfVc/yylevgf3XBLUvefSPUKhNI8tQxm0Gy4R+P7QP/CB3iH
         4f3g==
X-Gm-Message-State: AHYfb5i/xjNnF0IfM9qBkdpz31bA5HZap6xl1od5tKkmXhnY0o0FjBXG
        KMezMF0VYJtqAWMY
X-Received: by 10.80.173.245 with SMTP id b50mr3100929edd.143.1504000817873;
        Tue, 29 Aug 2017 03:00:17 -0700 (PDT)
Received: from localhost (xd93ddc2d.cust.hiper.dk. [217.61.220.45])
        by smtp.gmail.com with ESMTPSA id h64sm1284401edc.67.2017.08.29.03.00.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 03:00:17 -0700 (PDT)
Date:   Tue, 29 Aug 2017 12:00:16 +0200
From:   Christoffer Dall <cdall@linaro.org>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC v3 4/9] KVM: arm/arm64: use locking helpers in
 kvm_vgic_create()
Message-ID: <20170829100016.GU24649@cbox>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-5-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170821203530.9266-5-rkrcmar@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <cdall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59854
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

On Mon, Aug 21, 2017 at 10:35:25PM +0200, Radim Krčmář wrote:
> No new VCPUs can be created because we are holding the kvm->lock.
> This means that if we successfuly lock all VCPUs, we'll be unlocking the
> same set and there is no need to do extra bookkeeping.
> 
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  virt/kvm/arm/vgic/vgic-init.c       | 24 +++++++++---------------
>  virt/kvm/arm/vgic/vgic-kvm-device.c |  6 +++++-
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 5801261f3add..feb766f74c34 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -119,7 +119,7 @@ void kvm_vgic_vcpu_early_init(struct kvm_vcpu *vcpu)
>   */
>  int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
> -	int i, vcpu_lock_idx = -1, ret;
> +	int i, ret;
>  	struct kvm_vcpu *vcpu;
>  
>  	if (irqchip_in_kernel(kvm))
> @@ -140,18 +140,14 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  	 * vcpu->mutex.  By grabbing the vcpu->mutex of all VCPUs we ensure
>  	 * that no other VCPUs are run while we create the vgic.
>  	 */
> -	ret = -EBUSY;
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (!mutex_trylock(&vcpu->mutex))
> -			goto out_unlock;
> -		vcpu_lock_idx = i;
> -	}
> +	if (!lock_all_vcpus(kvm))
> +		return -EBUSY;
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (vcpu->arch.has_run_once)
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		if (vcpu->arch.has_run_once) {
> +			ret = -EBUSY;
>  			goto out_unlock;
> -	}
> -	ret = 0;
> +		}

I also prefer the additional brace here.

>  
>  	if (type == KVM_DEV_TYPE_ARM_VGIC_V2)
>  		kvm->arch.max_vcpus = VGIC_V2_MAX_CPUS;
> @@ -176,11 +172,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>  	kvm->arch.vgic.vgic_redist_base = VGIC_ADDR_UNDEF;
>  
> +	ret = 0;
>  out_unlock:
> -	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
> -		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
> -		mutex_unlock(&vcpu->mutex);
> -	}
> +	unlock_all_vcpus(kvm);
>  	return ret;
>  }
>  
> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
> index 10ae6f394b71..c5124737c7fc 100644
> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
> @@ -270,7 +270,11 @@ static void unlock_vcpus(struct kvm *kvm, int vcpu_lock_idx)
>  
>  void unlock_all_vcpus(struct kvm *kvm)
>  {
> -	unlock_vcpus(kvm, atomic_read(&kvm->online_vcpus) - 1);
> +	int i;
> +	struct kvm_vcpu *tmp_vcpu;
> +
> +	kvm_for_each_vcpu(i, tmp_vcpu, kvm)
> +		mutex_unlock(&tmp_vcpu->mutex);
>  }
>  
>  /* Returns true if all vcpus were locked, false otherwise */
> -- 
> 2.13.3
> 

As noted on the other patch, it looks a bit strange to modify
unlock_all_vcpus() here without also doing something about the error
path in lock_all_vcpus().

Otherwise this patch looks fine to me.

Thanks,
-Christoffer

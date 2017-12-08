Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 17:22:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:36572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbdLHQWnVLLJP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 17:22:43 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C71F22D26A3;
        Fri,  8 Dec 2017 16:22:36 +0000 (UTC)
Received: from [10.36.116.132] (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1729119E19;
        Fri,  8 Dec 2017 16:22:32 +0000 (UTC)
Subject: Re: [PATCH v3 05/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_regs
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
 <20171204203538.8370-6-cdall@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <42542ab3-9005-61f4-c446-09c33d2d8f52@redhat.com>
Date:   Fri, 8 Dec 2017 17:22:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171204203538.8370-6-cdall@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 08 Dec 2017 16:22:36 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61374
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
> implementations of kvm_arch_vcpu_ioctl_set_regs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c      | 3 +++
>  arch/powerpc/kvm/book3s.c | 3 +++
>  arch/powerpc/kvm/booke.c  | 3 +++
>  arch/s390/kvm/kvm-s390.c  | 2 ++
>  arch/x86/kvm/x86.c        | 3 +++
>  virt/kvm/kvm_main.c       | 2 --
>  6 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index adfca57420d1..3a898712d6cd 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1151,6 +1151,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
>  		vcpu->arch.gprs[i] = regs->gpr[i];
>  	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
> @@ -1158,6 +1160,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	vcpu->arch.lo = regs->lo;
>  	vcpu->arch.pc = regs->pc;
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index d85bfd733ccd..24bc7aabfc44 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -528,6 +528,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	kvmppc_set_pc(vcpu, regs->pc);
>  	kvmppc_set_cr(vcpu, regs->cr);
>  	kvmppc_set_ctr(vcpu, regs->ctr);
> @@ -548,6 +550,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
>  		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index e0e4f04c5535..bcbbeddc3430 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1462,6 +1462,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	int i;
>  
> +	vcpu_load(vcpu);
> +
>  	vcpu->arch.pc = regs->pc;
>  	kvmppc_set_cr(vcpu, regs->cr);
>  	vcpu->arch.ctr = regs->ctr;
> @@ -1483,6 +1485,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
>  		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 37b7caae2484..e3476430578a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2712,7 +2712,9 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>  
>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> +	vcpu_load(vcpu);
>  	memcpy(&vcpu->run->s.regs.gprs, &regs->gprs, sizeof(regs->gprs));
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 597e1f8fc8da..75eacce78f59 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7350,6 +7350,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  
>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
> +	vcpu_load(vcpu);
> +
>  	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
>  	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
>  
> @@ -7379,6 +7381,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  
> +	vcpu_put(vcpu);
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 843d481f58cb..963e249d7b79 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2572,9 +2572,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  			r = PTR_ERR(kvm_regs);
>  			goto out;
>  		}
> -		vcpu_load(vcpu);
>  		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
> -		vcpu_put(vcpu);
>  		kfree(kvm_regs);
>  		break;
>  	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

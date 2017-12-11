Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 13:40:09 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:56268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991526AbdLKMkCpWDb8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 13:40:02 +0100
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D4958046E;
        Mon, 11 Dec 2017 12:39:55 +0000 (UTC)
Received: from gondolin (ovpn-117-94.ams2.redhat.com [10.36.117.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C38205E9C9;
        Mon, 11 Dec 2017 12:39:46 +0000 (UTC)
Date:   Mon, 11 Dec 2017 13:39:43 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christoffer Dall <cdall@kernel.org>
Cc:     kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 11/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
Message-ID: <20171211133943.236f18be.cohuck@redhat.com>
In-Reply-To: <20171204203538.8370-12-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-12-cdall@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Dec 2017 12:39:55 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cohuck@redhat.com
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

On Mon,  4 Dec 2017 21:35:33 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_guest_debug().
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
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

> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1b491b89cd43..7cb0e2677e60 100644
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

I would probably set the -EINVAL in the individual branches (so it is
clear that something is wrong, and it is not just a benign exit as in
the cases above), but your code is correct as well. Let the powerpc
folks decide.

> +out:
> +	vcpu_put(vcpu);
> +	return ret;
>  }
>  
>  void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)

In any case,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

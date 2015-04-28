Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 13:37:32 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34409 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011991AbbD1LhajhE6n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 13:37:30 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SBbNjp024435
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Apr 2015 07:37:24 -0400
Received: from [10.36.112.20] (ovpn-112-20.ams2.redhat.com [10.36.112.20])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SBbFNi015350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Apr 2015 07:37:18 -0400
Message-ID: <553F70E9.50907@redhat.com>
Date:   Tue, 28 Apr 2015 13:37:13 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>
CC:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC 2/2] KVM: push down irq_save from kvm_guest_exit
References: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com> <1430217168-25504-3-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1430217168-25504-3-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 28/04/2015 12:32, Christian Borntraeger wrote:
> Some architectures already have irq disabled when calling
> kvm_guest_exit. Push down the disabling into the architectures
> to avoid double disabling. This also allows to replace
> irq_save with irq_disable which might be cheaper.
> arm and mips already have interrupts disabled. s390/power/x86
> need adoptions.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 2 ++
>  arch/powerpc/kvm/book3s_pr.c | 2 ++
>  arch/powerpc/kvm/booke.c     | 4 ++--
>  arch/s390/kvm/kvm-s390.c     | 2 ++
>  arch/x86/kvm/x86.c           | 2 ++
>  include/linux/kvm_host.h     | 4 ----
>  6 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index a5f392d..63b35b1 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1811,7 +1811,9 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>  
>  	/* make sure updates to secondary vcpu structs are visible now */
>  	smp_mb();
> +	local_irq_disable();
>  	kvm_guest_exit();
> +	local_irq_enable();
>  
>  	preempt_enable();
>  	cond_resched();
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index f573839..eafcb8c 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -891,7 +891,9 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  
>  	/* We get here with MSR.EE=1 */
>  
> +	local_irq_disable();
>  	trace_kvm_exit(exit_nr, vcpu);
> +	local_irq_enable();
>  	kvm_guest_exit();

This looks wrong.

>  
>  	switch (exit_nr) {
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 6c1316a..f1d6af3 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1004,11 +1004,11 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		break;
>  	}
>  
> -	local_irq_enable();
> -
>  	trace_kvm_exit(exit_nr, vcpu);
>  	kvm_guest_exit();
>  
> +	local_irq_enable();
> +
>  	run->exit_reason = KVM_EXIT_UNKNOWN;
>  	run->ready_for_interrupt_injection = 1;
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 9f4c954..0aa2534 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2015,7 +2015,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  		local_irq_enable();
>  		exit_reason = sie64a(vcpu->arch.sie_block,
>  				     vcpu->run->s.regs.gprs);
> +		local_irq_disable();
>  		kvm_guest_exit();
> +		local_irq_enable();
>  		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
>  
>  		rc = vcpu_post_run(vcpu, exit_reason);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32bf19e..a5fbd45 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6351,7 +6351,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 */
>  	barrier();
>  
> +	local_irq_disable();
>  	kvm_guest_exit();
> +	local_irq_enable();
>  
>  	preempt_enable();
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index a34bf6ed..fe699fb 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -773,11 +773,7 @@ static inline void kvm_guest_enter(void)
>  
>  static inline void kvm_guest_exit(void)
>  {
> -	unsigned long flags;
> -
> -	local_irq_save(flags);

Why no WARN_ON here?

I think the patches are sensible, especially since you can add warnings.
 This kind of code definitely knows if it has interrupts disabled or enabled

Alternatively, the irq-disabled versions could be called
__kvm_guest_{enter,exit}.  Then you can use those directly when it makes
sense.

Paolo

>  	guest_exit();
> -	local_irq_restore(flags);
>  }
>  
>  /*
> 

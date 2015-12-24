Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2015 12:15:19 +0100 (CET)
Received: from mx2.parallels.com ([199.115.105.18]:37249 "EHLO
        mx2.parallels.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006604AbbLXLPRqRMvY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2015 12:15:17 +0100
Received: from [199.115.105.250] (helo=mail.odin.com)
        by mx2.parallels.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.86)
        (envelope-from <rkagan@virtuozzo.com>)
        id 1aC3rU-0003BU-5H; Thu, 24 Dec 2015 03:15:12 -0800
Received: from rkaganb.sw.ru (10.30.3.95) by US-EXCH2.sw.swsoft.com
 (10.255.249.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 24 Dec
 2015 03:14:56 -0800
Date:   Thu, 24 Dec 2015 14:14:51 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Andrey Smetanin <asmetanin@virtuozzo.com>
CC:     <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexander Graf <agraf@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Cornelia Huck" <cornelia.huck@de.ibm.com>,
        <linux-mips@linux-mips.org>, <kvm-ppc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, "Denis V. Lunev" <den@openvz.org>,
        <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] kvm: Make vcpu->requests as 64 bit bitmap
Message-ID: <20151224111450.GA19296@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, Alexander Graf <agraf@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cornelia.huck@de.ibm.com>, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org,
        "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
References: <1450949426-25545-1-git-send-email-asmetanin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1450949426-25545-1-git-send-email-asmetanin@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: US-EXCH.sw.swsoft.com (10.255.249.47) To
 US-EXCH2.sw.swsoft.com (10.255.249.46)
Return-Path: <rkagan@virtuozzo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkagan@virtuozzo.com
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

On Thu, Dec 24, 2015 at 12:30:26PM +0300, Andrey Smetanin wrote:
> Currently on x86 arch we has already 32 requests defined
> so the newer request bits can't be placed inside
> vcpu->requests(unsigned long) inside x86 32 bit system.
> But we are going to add a new request in x86 arch
> for Hyper-V tsc page support.
> 
> To solve the problem the patch replaces vcpu->requests by
> bitmap with 64 bit length and uses bitmap API.
> 
> The patch consists of:
> * announce kvm_vcpu_has_requests() to check whether vcpu has
> requests
> * announce kvm_vcpu_requests() to get vcpu requests pointer

I think that if abstracting out the implementation of the request
container is what you're after, you'd better not define this function;
accesses to the request map should be through your accessor functions.

> * announce kvm_clear_request() to clear particular vcpu request
> * replace if (vcpu->requests) by if (kvm_vcpu_has_requests(vcpu))
> * replace clear_bit(req, vcpu->requests) by
>  kvm_clear_request(req, vcpu)

Apparently one accessor is missing: test the presence of a request
without clearing it from the bitmap (because kvm_check_request() clears
it).

> diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
> index 2e0e67e..4015b88 100644
> --- a/arch/powerpc/kvm/trace.h
> +++ b/arch/powerpc/kvm/trace.h
> @@ -109,7 +109,7 @@ TRACE_EVENT(kvm_check_requests,
>  
>  	TP_fast_assign(
>  		__entry->cpu_nr		= vcpu->vcpu_id;
> -		__entry->requests	= vcpu->requests;
> +		__entry->requests	= (__u32)kvm_vcpu_requests(vcpu)[0];
>  	),

This doesn't make sense, to expose only subset of the requests.  BTW I
don't see this event in Linus tree, nor in linux-next, so I'm not quite
sure why it's formed this way; I guess the interesting part is the
request number and the return value (i.e. whether it's set), not the
whole bitmap.

> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -5957,7 +5957,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
>  		if (intr_window_requested && vmx_interrupt_allowed(vcpu))
>  			return handle_interrupt_window(&vmx->vcpu);
>  
> -		if (test_bit(KVM_REQ_EVENT, &vcpu->requests))
> +		if (test_bit(KVM_REQ_EVENT, kvm_vcpu_requests(vcpu)))

Here you'd rather want that function to test for the request without
clearing it.

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2117,7 +2117,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  			if (ka->boot_vcpu_runs_old_kvmclock != tmp)
>  				set_bit(KVM_REQ_MASTERCLOCK_UPDATE,
> -					&vcpu->requests);
> +					kvm_vcpu_requests(vcpu));

This should have been kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);

> @@ -8048,7 +8048,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
>  	if (atomic_read(&vcpu->arch.nmi_queued))
>  		return true;
>  
> -	if (test_bit(KVM_REQ_SMI, &vcpu->requests))
> +	if (test_bit(KVM_REQ_SMI, kvm_vcpu_requests(vcpu)))

Again the test-only accessor is due here.

> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -146,6 +146,8 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQ_HV_EXIT           30
>  #define KVM_REQ_HV_STIMER         31
>  
> +#define KVM_REQ_MAX               64
> +
>  #define KVM_USERSPACE_IRQ_SOURCE_ID		0
>  #define KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
>  
> @@ -233,7 +235,7 @@ struct kvm_vcpu {
>  	int vcpu_id;
>  	int srcu_idx;
>  	int mode;
> -	unsigned long requests;
> +	DECLARE_BITMAP(requests, KVM_REQ_MAX);
>  	unsigned long guest_debug;
>  
>  	int pre_pcpu;
> @@ -286,6 +288,16 @@ struct kvm_vcpu {
>  	struct kvm_vcpu_arch arch;
>  };
>  
> +static inline bool kvm_vcpu_has_requests(struct kvm_vcpu *vcpu)
> +{
> +	return !bitmap_empty(vcpu->requests, KVM_REQ_MAX);
> +}
> +
> +static inline ulong *kvm_vcpu_requests(struct kvm_vcpu *vcpu)
> +{
> +	return (ulong *)vcpu->requests;
> +}

As I wrote above, I believe this function doesn't belong in the API.

> +
>  static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
>  {
>  	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
> @@ -1002,7 +1014,7 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
>  
>  static inline void kvm_migrate_timers(struct kvm_vcpu *vcpu)
>  {
> -	set_bit(KVM_REQ_MIGRATE_TIMER, &vcpu->requests);
> +	set_bit(KVM_REQ_MIGRATE_TIMER, kvm_vcpu_requests(vcpu));

kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);

> @@ -1118,19 +1130,24 @@ static inline bool kvm_vcpu_compatible(struct kvm_vcpu *vcpu) { return true; }
>  
>  static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
>  {
> -	set_bit(req, &vcpu->requests);
> +	set_bit(req, kvm_vcpu_requests(vcpu));
>  }
>  
>  static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
>  {
> -	if (test_bit(req, &vcpu->requests)) {
> -		clear_bit(req, &vcpu->requests);
> +	if (test_bit(req, kvm_vcpu_requests(vcpu))) {
> +		clear_bit(req, kvm_vcpu_requests(vcpu));
>  		return true;
>  	} else {
>  		return false;
>  	}

I wonder why this doesn't use test_and_clear_bit instead.

Roman.

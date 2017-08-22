Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2017 16:07:18 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:46654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992456AbdHVOHKT6TvR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Aug 2017 16:07:10 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88D2661490;
        Tue, 22 Aug 2017 14:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 88D2661490
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.117.255] (unknown [10.36.117.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30C4B83DBA;
        Tue, 22 Aug 2017 14:06:58 +0000 (UTC)
Subject: Re: [PATCH RFC v3 6/9] KVM: rework kvm_vcpu_on_spin loop
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-7-rkrcmar@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <debc181e-6517-a8da-7a19-909fda5e4505@redhat.com>
Date:   Tue, 22 Aug 2017 16:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170821203530.9266-7-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 22 Aug 2017 14:07:04 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59758
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

On 21.08.2017 22:35, Radim Krčmář wrote:
> The original code managed to obfuscate a straightforward idea:
> start iterating from the selected index and reset the index to 0 when
> reaching the end of online vcpus, then iterate until reaching the index
> that we started at.
> 
> The resulting code is a bit better, IMO.  (Still horrible, though.)

I think I prefer dropping this patch and maybe _after_ we have the list
implementation in place, simply start walking the list from
last_boosted_vcpu? (store a pointer instead of an index then, of course)

If I understand correctly, this would then be simply, one walk from
last_boosted_vcpu until we hit last_boosted_vcpu again.


> 
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  include/linux/kvm_host.h | 13 +++++++++++++
>  virt/kvm/kvm_main.c      | 47 ++++++++++++++++++-----------------------------
>  2 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index abd5cb1feb9e..cfb3c0efdd51 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -498,6 +498,19 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
>  	     (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
>  	     idx++)
>  
> +#define kvm_for_each_vcpu_from(idx, vcpup, from, kvm) \
> +	for (idx = from, vcpup = kvm_get_vcpu(kvm, idx); \
> +	     vcpup; \
> +	     ({ \
> +		idx++; \
> +		if (idx >= atomic_read(&kvm->online_vcpus)) \
> +			idx = 0; \
> +		if (idx == from) \
> +			vcpup = NULL; \
> +		else \
> +			vcpup = kvm_get_vcpu(kvm, idx); \
> +	      }))
> +
>  static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
>  {
>  	struct kvm_vcpu *vcpu = NULL;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d89261d0d8c6..33a15e176927 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2333,8 +2333,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
>  	struct kvm_vcpu *vcpu;
>  	int last_boosted_vcpu = me->kvm->last_boosted_vcpu;
>  	int yielded = 0;
> -	int try = 3;
> -	int pass;
> +	int try = 2;
>  	int i;
>  
>  	kvm_vcpu_set_in_spin_loop(me, true);
> @@ -2345,34 +2344,24 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
>  	 * VCPU is holding the lock that we need and will release it.
>  	 * We approximate round-robin by starting at the last boosted VCPU.
>  	 */
> -	for (pass = 0; pass < 2 && !yielded && try; pass++) {
> -		kvm_for_each_vcpu(i, vcpu, kvm) {
> -			if (!pass && i <= last_boosted_vcpu) {
> -				i = last_boosted_vcpu;
> -				continue;
> -			} else if (pass && i > last_boosted_vcpu)
> -				break;
> -			if (!ACCESS_ONCE(vcpu->preempted))
> -				continue;
> -			if (vcpu == me)
> -				continue;
> -			if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
> -				continue;
> -			if (yield_to_kernel_mode && !kvm_arch_vcpu_in_kernel(vcpu))
> -				continue;
> -			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
> -				continue;
> +	kvm_for_each_vcpu_from(i, vcpu, last_boosted_vcpu, kvm) {
> +		if (!ACCESS_ONCE(vcpu->preempted))
> +			continue;
> +		if (vcpu == me)
> +			continue;
> +		if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
> +			continue;
> +		if (yield_to_kernel_mode && !kvm_arch_vcpu_in_kernel(vcpu))
> +			continue;
> +		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
> +			continue;
>  
> -			yielded = kvm_vcpu_yield_to(vcpu);
> -			if (yielded > 0) {
> -				kvm->last_boosted_vcpu = i;
> -				break;
> -			} else if (yielded < 0) {
> -				try--;
> -				if (!try)
> -					break;
> -			}
> -		}
> +		yielded = kvm_vcpu_yield_to(vcpu);
> +		if (yielded > 0) {
> +			kvm->last_boosted_vcpu = i;
> +			break;
> +		} else if (yielded < 0 && !try--)
> +			break;
>  	}
>  	kvm_vcpu_set_in_spin_loop(me, false);
>  
> 


-- 

Thanks,

David

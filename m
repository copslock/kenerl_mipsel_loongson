Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:25:04 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:43790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994963AbdH2PYyBNGqN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 17:24:54 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D57B7356DB;
        Tue, 29 Aug 2017 15:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com D57B7356DB
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=cohuck@redhat.com
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E87CC692A4;
        Tue, 29 Aug 2017 15:24:41 +0000 (UTC)
Date:   Tue, 29 Aug 2017 17:24:39 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC v3 6/9] KVM: rework kvm_vcpu_on_spin loop
Message-ID: <20170829172439.23fcd6eb.cohuck@redhat.com>
In-Reply-To: <debc181e-6517-a8da-7a19-909fda5e4505@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
        <20170821203530.9266-7-rkrcmar@redhat.com>
        <debc181e-6517-a8da-7a19-909fda5e4505@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 29 Aug 2017 15:24:47 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59867
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

On Tue, 22 Aug 2017 16:06:57 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.08.2017 22:35, Radim Krčmář wrote:
> > The original code managed to obfuscate a straightforward idea:
> > start iterating from the selected index and reset the index to 0 when
> > reaching the end of online vcpus, then iterate until reaching the index
> > that we started at.
> > 
> > The resulting code is a bit better, IMO.  (Still horrible, though.)  
> 
> I think I prefer dropping this patch and maybe _after_ we have the list
> implementation in place, simply start walking the list from
> last_boosted_vcpu? (store a pointer instead of an index then, of course)
> 
> If I understand correctly, this would then be simply, one walk from
> last_boosted_vcpu until we hit last_boosted_vcpu again.

Yes, doing this change at this point in the series trades an ugly piece
of code for a slightly less ugly one.

> > 
> > Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> > ---
> >  include/linux/kvm_host.h | 13 +++++++++++++
> >  virt/kvm/kvm_main.c      | 47 ++++++++++++++++++-----------------------------
> >  2 files changed, 31 insertions(+), 29 deletions(-)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index abd5cb1feb9e..cfb3c0efdd51 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -498,6 +498,19 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
> >  	     (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
> >  	     idx++)
> >  
> > +#define kvm_for_each_vcpu_from(idx, vcpup, from, kvm) \
> > +	for (idx = from, vcpup = kvm_get_vcpu(kvm, idx); \
> > +	     vcpup; \
> > +	     ({ \
> > +		idx++; \
> > +		if (idx >= atomic_read(&kvm->online_vcpus)) \
> > +			idx = 0; \
> > +		if (idx == from) \
> > +			vcpup = NULL; \
> > +		else \
> > +			vcpup = kvm_get_vcpu(kvm, idx); \
> > +	      }))

The loop below is better after the change, but this macro... it gets at
least a bit better if you push this behind patch 8.

> > +
> >  static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
> >  {
> >  	struct kvm_vcpu *vcpu = NULL;
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index d89261d0d8c6..33a15e176927 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2333,8 +2333,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
> >  	struct kvm_vcpu *vcpu;
> >  	int last_boosted_vcpu = me->kvm->last_boosted_vcpu;
> >  	int yielded = 0;
> > -	int try = 3;
> > -	int pass;
> > +	int try = 2;
> >  	int i;
> >  
> >  	kvm_vcpu_set_in_spin_loop(me, true);
> > @@ -2345,34 +2344,24 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
> >  	 * VCPU is holding the lock that we need and will release it.
> >  	 * We approximate round-robin by starting at the last boosted VCPU.
> >  	 */
> > -	for (pass = 0; pass < 2 && !yielded && try; pass++) {
> > -		kvm_for_each_vcpu(i, vcpu, kvm) {
> > -			if (!pass && i <= last_boosted_vcpu) {
> > -				i = last_boosted_vcpu;
> > -				continue;
> > -			} else if (pass && i > last_boosted_vcpu)
> > -				break;
> > -			if (!ACCESS_ONCE(vcpu->preempted))
> > -				continue;
> > -			if (vcpu == me)
> > -				continue;
> > -			if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
> > -				continue;
> > -			if (yield_to_kernel_mode && !kvm_arch_vcpu_in_kernel(vcpu))
> > -				continue;
> > -			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
> > -				continue;
> > +	kvm_for_each_vcpu_from(i, vcpu, last_boosted_vcpu, kvm) {
> > +		if (!ACCESS_ONCE(vcpu->preempted))
> > +			continue;
> > +		if (vcpu == me)
> > +			continue;
> > +		if (swait_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
> > +			continue;
> > +		if (yield_to_kernel_mode && !kvm_arch_vcpu_in_kernel(vcpu))
> > +			continue;
> > +		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
> > +			continue;
> >  
> > -			yielded = kvm_vcpu_yield_to(vcpu);
> > -			if (yielded > 0) {
> > -				kvm->last_boosted_vcpu = i;
> > -				break;
> > -			} else if (yielded < 0) {
> > -				try--;
> > -				if (!try)
> > -					break;
> > -			}
> > -		}
> > +		yielded = kvm_vcpu_yield_to(vcpu);
> > +		if (yielded > 0) {
> > +			kvm->last_boosted_vcpu = i;
> > +			break;
> > +		} else if (yielded < 0 && !try--)
> > +			break;
> >  	}
> >  	kvm_vcpu_set_in_spin_loop(me, false);
> >  
> >   
> 
> 

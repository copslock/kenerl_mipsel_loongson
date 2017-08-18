Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 16:11:06 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:53854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994921AbdHROKqogXUK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 16:10:46 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD281356F9;
        Fri, 18 Aug 2017 14:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com DD281356F9
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F4916A30A;
        Fri, 18 Aug 2017 14:10:32 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 18 Aug 2017 16:10:31 +0200
Date:   Fri, 18 Aug 2017 16:10:31 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Alexander Graf <agraf@suse.de>
Cc:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Christoffer Dall <cdall@linaro.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Message-ID: <20170818141028.GG2566@flask>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
 <20170817145411.GE2566@flask>
 <edb9403f-3a94-605d-5f06-9bc81ca4d2c3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb9403f-3a94-605d-5f06-9bc81ca4d2c3@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 18 Aug 2017 14:10:40 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2017-08-17 21:17+0200, Alexander Graf:
> On 17.08.17 16:54, Radim Krčmář wrote:
> > 2017-08-17 09:04+0200, Alexander Graf:
> > > What if we just sent a "vcpu move" request to all vcpus with the new pointer
> > > after it moved? That way the vcpu thread itself would be responsible for the
> > > migration to the new memory region. Only if all vcpus successfully moved,
> > > keep rolling (and allow foreign get_vcpu again).
> > 
> > I'm not sure if I understood this.  You propose to cache kvm->vcpus in
> > vcpu->vcpus and do an extensions of this,
> > 
> >    int vcpu_create(...) {
> >      if (resize_needed(kvm->vcpus)) {
> >        old_vcpus = kvm->vcpus
> >        kvm->vcpus = make_bigger(kvm->vcpus)
> 
> if (kvm->vcpus != old_vcpus) :)
> 
> >        kvm_make_all_cpus_request(kvm, KVM_REQ_UPDATE_VCPUS)
> 
> IIRC you'd need some manual bookkeeping to ensure that all users have
> switched to the new array. Or set the KVM_REQUEST_WAIT flag :).

Absolutely.  I was thinking about synchronous execution, which might
need extra work to expedite halted VCPUs.  Letting the last user free it
is plausible and would need more protection against races.

> >        free(old_vcpus)
> >      }
> >      vcpu->vcpus = kvm->vcpus
> >    }
> > 
> > with added extra locking, (S)RCU, on accesses that do not come from
> > VCPUs (irqfd and VM ioctl)?
> 
> Well, in an ideal world we wouldn't have any users to vcpu structs outside
> of the vcpus obviously. Every time we do, we should either reconsider
> whether the design is smart and if we think it is, protect them accordingly.

And there would be no linear access to all VCPUs. :)

The main user of kvm->vcpus is kvm_for_each_vcpu(), which is well suited
for a list, so we can change the design of kvm_for_each_vcpu() to use a
list head in struct kvm_vcpu with head/tail in struct kvm.
(The list is trivial to make lockless as we only append.)

This would allow more flexibility with the remaining uses.

> Maybe even hard code separate request mechanisms for the few cases where
> it's reasonable?

All non-kvm_for_each_vcpu() seem to need accesss outside of VCPU scope.

We have few awkward accesses that can be handled keeping track of kvm
state and all remaining uses need some kind of "int -> struct kvm_vcpu"
mapping, where the integer is arbitrary.

All users of kvm_get_vcpu_by_id() need a vcpu_id mapping, but hijack
kvm->vcpus for O(1) access if lucky, with fallback to
kvm_for_each_vcpu().  Adding a vcpu_id mapping seems reasonable.

s390 __floating_irq_kick() and x86 kvm_irq_delivery_to_apic() are
keeping a bitmap for kvm->vcpus indices.  They want compact indices,
which cannot be provided by vcpu_id mapping.

I think that MIPS and ARM use the index in kvm->vcpus for userspace
communication, which looks dangerous as userspace shouldn't know the
position.  Not much we can do because of that.

> > > That way we should be basically lock-less and scale well. For additional
> > > icing, feel free to increase the vcpu array x2 every time it grows to not
> > > run into the slow path too often.
> > 
> > Yeah, I skipped the growing as it was not necessary for the
> > illustration.
> 
> Sure.
> 
> I'm also not fully advocating my solution here, but wanted to make sure we
> have it on the radar. I *think* this option has the least runtime overhead
> and best readability score, as it sticks to the same frameworks we already
> have and use throughout the code base ;).
> 
> That said, I'd love to get proven wrong.

Unless I missed some uses, the linked list for kvm_for_each_vcpu() and a
use-case specific protection for the rest looks better ... kvm->vcpus is
terribly overloaded.

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 18:51:11 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:35392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994886AbdHQQu7stnTi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 18:50:59 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E041C047B6A;
        Thu, 17 Aug 2017 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 2E041C047B6A
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0155B187AF;
        Thu, 17 Aug 2017 16:50:45 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 17 Aug 2017 18:50:44 +0200
Date:   Thu, 17 Aug 2017 18:50:44 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC 2/2] KVM: RCU protected dynamic vcpus array
Message-ID: <20170817165044.GF2566@flask>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <20170816194037.9460-3-rkrcmar@redhat.com>
 <7cb42373-355c-7cb3-2979-9529aef0641c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb42373-355c-7cb3-2979-9529aef0641c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 17 Aug 2017 16:50:52 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59626
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

2017-08-17 13:14+0200, David Hildenbrand:
> >  	atomic_set(&kvm->online_vcpus, 0);
> >  	mutex_unlock(&kvm->lock);
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index c8df733eed41..eb9fb5b493ac 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -386,12 +386,17 @@ struct kvm_memslots {
> >  	int used_slots;
> >  };
> >  
> > +struct kvm_vcpus {
> > +	u32 online;
> > +	struct kvm_vcpu *array[];
> 
> On option could be to simply chunk it:
> 
> +struct kvm_vcpus {
> +       struct kvm_vcpu vcpus[32];

I'm thinking of 128/256.

> +};
> +
>  /*
>   * Note:
>   * memslots are not sorted by id anymore, please use id_to_memslot()
> @@ -391,7 +395,7 @@ struct kvm {
>         struct mutex slots_lock;
>         struct mm_struct *mm; /* userspace tied to this vm */
>         struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
> -       struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> +       struct kvm_vcpus vcpus[(KVM_MAX_VCPUS + 31) / 32];
>         /*
>          * created_vcpus is protected by kvm->lock, and is incremented
> @@ -483,12 +487,14 @@ static inline struct kvm_io_bus
> *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
> 
> 
> 1. make nobody access kvm->vcpus directly (factor out)
> 2. allocate next chunk if necessary when creating a VCPU and store
> pointer using WRITE_ONCE
> 3. use READ_ONCE to test for availability of the current chunk

We can also use kvm->online_vcpus exactly like we did now.

> kvm_for_each_vcpu just has to use READ_ONCE to access/test for the right
> chunk. Pointers never get invalid. No RCU needed. Sleeping in the loop
> is possible.

I like this better than SRCU because it keeps the internal code mostly
intact, even though it is compromise solution with a tunable.
(SRCU gives us more protection than we need.)

It is very similar to (3).  Chunks will usually take memory and have
slower access to the first chunk than an extendable list would, but is
faster from the third chunk, which is a reasonable deal.

We are just postponing the problem until a higher number of VCPUs, but
then we can extend it into more levels using the same principle and I
think it will still get a better trade-offs than SRCU.

I'd do this for v2,

thanks.

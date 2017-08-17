Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 18:54:56 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:41296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994885AbdHQQyqd-k1i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 18:54:46 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 641405F739;
        Thu, 17 Aug 2017 16:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 641405F739
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.100] (ovpn-117-100.ams2.redhat.com [10.36.117.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C9235D97E;
        Thu, 17 Aug 2017 16:54:33 +0000 (UTC)
Subject: Re: [PATCH RFC 2/2] KVM: RCU protected dynamic vcpus array
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <20170816194037.9460-3-rkrcmar@redhat.com>
 <7cb42373-355c-7cb3-2979-9529aef0641c@redhat.com>
 <20170817165044.GF2566@flask>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1dea37fa-d51e-1381-c3f1-e067065560b7@redhat.com>
Date:   Thu, 17 Aug 2017 18:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170817165044.GF2566@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 17 Aug 2017 16:54:39 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59627
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

On 17/08/2017 18:50, Radim Krčmář wrote:
> 2017-08-17 13:14+0200, David Hildenbrand:
>>>  	atomic_set(&kvm->online_vcpus, 0);
>>>  	mutex_unlock(&kvm->lock);
>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>> index c8df733eed41..eb9fb5b493ac 100644
>>> --- a/include/linux/kvm_host.h
>>> +++ b/include/linux/kvm_host.h
>>> @@ -386,12 +386,17 @@ struct kvm_memslots {
>>>  	int used_slots;
>>>  };
>>>  
>>> +struct kvm_vcpus {
>>> +	u32 online;
>>> +	struct kvm_vcpu *array[];
>>
>> On option could be to simply chunk it:
>>
>> +struct kvm_vcpus {
>> +       struct kvm_vcpu vcpus[32];
> 
> I'm thinking of 128/256.
> 
>> +};
>> +
>>  /*
>>   * Note:
>>   * memslots are not sorted by id anymore, please use id_to_memslot()
>> @@ -391,7 +395,7 @@ struct kvm {
>>         struct mutex slots_lock;
>>         struct mm_struct *mm; /* userspace tied to this vm */
>>         struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
>> -       struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>> +       struct kvm_vcpus vcpus[(KVM_MAX_VCPUS + 31) / 32];
>>         /*
>>          * created_vcpus is protected by kvm->lock, and is incremented
>> @@ -483,12 +487,14 @@ static inline struct kvm_io_bus
>> *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
>>
>>
>> 1. make nobody access kvm->vcpus directly (factor out)
>> 2. allocate next chunk if necessary when creating a VCPU and store
>> pointer using WRITE_ONCE
>> 3. use READ_ONCE to test for availability of the current chunk
> 
> We can also use kvm->online_vcpus exactly like we did now.
> 
>> kvm_for_each_vcpu just has to use READ_ONCE to access/test for the right
>> chunk. Pointers never get invalid. No RCU needed. Sleeping in the loop
>> is possible.
> 
> I like this better than SRCU because it keeps the internal code mostly
> intact, even though it is compromise solution with a tunable.
> (SRCU gives us more protection than we need.)
>
> I'd do this for v2,

Sounds good!

Paolo

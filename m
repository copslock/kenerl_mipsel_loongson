Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 11:55:34 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:55392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992864AbdHQJzXZrkng (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 11:55:23 +0200
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3FD515E914;
        Thu, 17 Aug 2017 09:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com E3FD515E914
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.117.43] (ovpn-117-43.ams2.redhat.com [10.36.117.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 355FE619CA;
        Thu, 17 Aug 2017 09:55:13 +0000 (UTC)
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Alexander Graf <agraf@suse.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Christoffer Dall <cdall@linaro.org>,
        Paul Mackerras <paulus@ozlabs.org>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
 <20170817093612.024cc4bc.cohuck@redhat.com>
 <b69bc1e0-9d7b-5412-ba56-a5261d539a5b@redhat.com>
 <20170817112829.7795820a.cohuck@redhat.com>
 <69d47131-2405-b2be-60d7-e40fbd17592a@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6609138c-6a29-5106-39a8-3219ce47f01a@redhat.com>
Date:   Thu, 17 Aug 2017 11:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <69d47131-2405-b2be-60d7-e40fbd17592a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 17 Aug 2017 09:55:17 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59614
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

On 17.08.2017 11:44, Paolo Bonzini wrote:
> On 17/08/2017 11:28, Cornelia Huck wrote:
>> On Thu, 17 Aug 2017 11:16:59 +0200
>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>> On 17/08/2017 09:36, Cornelia Huck wrote:
>>>>> What if we just sent a "vcpu move" request to all vcpus with the new 
>>>>> pointer after it moved? That way the vcpu thread itself would be 
>>>>> responsible for the migration to the new memory region. Only if all 
>>>>> vcpus successfully moved, keep rolling (and allow foreign get_vcpu again).
>>>>>
>>>>> That way we should be basically lock-less and scale well. For additional 
>>>>> icing, feel free to increase the vcpu array x2 every time it grows to 
>>>>> not run into the slow path too often.  
>>>>
>>>> I'd prefer the rcu approach: This is a mechanism already understood
>>>> well, no need to come up with a new one that will likely have its own
>>>> share of problems.  
>>>
>>> What Alex is proposing _is_ RCU, except with a homegrown
>>> synchronize_rcu.  Using kvm->srcu seems to be the best of both worlds.
>>
>> I'm worried a bit about the 'homegrown' part, though.
> 
> I agree, that's why I'm suggesting SRCU instead.  But it's a trick that
> has its uses.  For example, if you were only doing reads from a work
> queue, flush_work_queue could be used as the "homegrown
> synchronize_rcu".  In KVM you might use kvm_make_all_cpus_request, I guess.
> 
>> I also may be misunderstanding what Alex means with "vcpu move"...
> 
> My interpretation was "resizing the array" (so it moves in memory).
> 
> Paolo
> 

Unpopular opinion: Let's keep it simple first (straight rcu) and
optimize later on.

-- 

Thanks,

David

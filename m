Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:22:47 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:42482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991743AbdK2RWkIfqea (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:22:40 +0100
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB1B9C058ED4;
        Wed, 29 Nov 2017 17:22:33 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A50B5D6A8;
        Wed, 29 Nov 2017 17:22:30 +0000 (UTC)
Subject: Re: [PATCH v2 01/16] KVM: Take vcpu->mutex outside vcpu_load
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-2-christoffer.dall@linaro.org>
 <25c1daca-1d8b-48e7-af2d-5cf47d0d278b@redhat.com>
 <1cf0f391-960c-a457-29e5-f31ee410a9d1@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <51b1bb38-7fa8-d785-3281-5a239639989e@redhat.com>
Date:   Wed, 29 Nov 2017 18:22:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1cf0f391-960c-a457-29e5-f31ee410a9d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 29 Nov 2017 17:22:33 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61212
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

On 29.11.2017 18:20, Paolo Bonzini wrote:
> On 29/11/2017 18:17, David Hildenbrand wrote:
>> On 29.11.2017 17:41, Christoffer Dall wrote:
>>> As we're about to call vcpu_load() from architecture-specific
>>> implementations of the KVM vcpu ioctls, but yet we access data
>>> structures protected by the vcpu->mutex in the generic code, factor
>>> this logic out from vcpu_load().
>>>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>>  arch/x86/kvm/vmx.c       |  4 +---
>>>  arch/x86/kvm/x86.c       | 20 +++++++-------------
>>>  include/linux/kvm_host.h |  2 +-
>>>  virt/kvm/kvm_main.c      | 17 ++++++-----------
>>>  4 files changed, 15 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>>> index 714a067..e7c46d2 100644
>>> --- a/arch/x86/kvm/vmx.c
>>> +++ b/arch/x86/kvm/vmx.c
>>> @@ -9559,10 +9559,8 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
>>>  static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
>>>  {
>>>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>>> -       int r;
>>>  
>>> -       r = vcpu_load(vcpu);
>>> -       BUG_ON(r);
>>> +       vcpu_load(vcpu);
>> I am most likely missing something, why don't we have to take the lock
>> in these cases?
> 
> See earlier discussion, at these points there can be no concurrent
> access; the file descriptor is not accessible yet, or is already gone.
> 
> Paolo

Thanks, this belongs into the patch description then.

-- 

Thanks,

David / dhildenb

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 14:06:10 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:51934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994931AbdH2MFxd05VV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 14:05:53 +0200
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F32685376;
        Tue, 29 Aug 2017 12:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 0F32685376
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=david@redhat.com
Received: from [10.36.118.19] (unknown [10.36.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 765A27FB55;
        Tue, 29 Aug 2017 12:05:41 +0000 (UTC)
Subject: Re: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
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
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-2-rkrcmar@redhat.com>
 <67a8b09c-3e7a-943d-8684-f9ad6e70514b@redhat.com>
 <20170829132342.1ef25500.cohuck@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d63ceb80-bdf7-0a24-a4ac-3265b7528a60@redhat.com>
Date:   Tue, 29 Aug 2017 14:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170829132342.1ef25500.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Aug 2017 12:05:45 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59860
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

On 29.08.2017 13:23, Cornelia Huck wrote:
> On Tue, 22 Aug 2017 13:31:27 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 21.08.2017 22:35, Radim Krčmář wrote:
>>> We can add a variable instead of scanning all online VCPUs to know how
>>> many are started.  We can't trivially tell which VCPU is the last one,
>>> though.  
>>
>> You could keep the started vcpus in a list. Then you might drop unsigned
>> started_vcpus;
>>
>> No started vcpus: Start pointer NULL
>> Single started vcpu: Only one element in the list (easy to check)
>>> 1 started vcpus: More than one element int he list (easy to check)  
> 
> I'm not sure the added complication of keeping a list buys us much
> here: We only have the "look for the last vcpu not stopped" operation
> for the 2->1 transition.
> 

That is wrong, we also have to know the last remaining (started) VCPU.
For that, right now we have to iterate over all VCPUs.

There shouldn't be much complexity. We already perform changes under a
lock, so it is as simple as adding/removing from the list.

Detecting the transitions boils down to looking at two pointers.

-- 

Thanks,

David

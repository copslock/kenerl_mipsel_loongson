Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 18:13:00 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991033AbdKWRMxHd2Sr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Nov 2017 18:12:53 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F9DC7E427;
        Thu, 23 Nov 2017 17:12:46 +0000 (UTC)
Received: from [10.36.117.224] (ovpn-117-224.ams2.redhat.com [10.36.117.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 559F9620A2;
        Thu, 23 Nov 2017 17:12:43 +0000 (UTC)
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
To:     Christoffer Dall <cdall@linaro.org>
Cc:     Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
Date:   Thu, 23 Nov 2017 18:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171123170642.GA28855@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 23 Nov 2017 17:12:46 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61063
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

On 23/11/2017 18:06, Christoffer Dall wrote:
> On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
>> On 23/11/2017 17:05, Christoffer Dall wrote:
>>> For example,
>>> arm64 is about to do significant work in vcpu load/put when running a
>>> vcpu, but not when doing things like KVM_SET_ONE_REG or
>>> KVM_SET_MP_STATE.
>>
>> Out of curiosity, in what circumstances are these ioctls a hot path?
>> Especially KVM_SET_MP_STATE.
> 
> Perhaps my commit message was misleading; we only want to do that for
> KVM_RUN, and not for anything else.  We're already doing things like
> potentially jumping to hyp mode and flushing VMIDs which really
> shouldn't be done unless we actually plan on running a VCPU, and we're
> going to do things like setting up the timer to handle timer interrupts
> in an ISR, which doesn't make sense unless the VCPU is running.
> 
> Add to that, that loading an entire VM's state onto hardware, only to
> read back a single register from hardware and returning it to user
> space, doesn't really fall within optimization vs. non-optimization in
> the critical path, but is just wrong, IMHO.

For GET/SET_ONE_REG it certainly makes sense.  For everything else, I'm
wondering which ioctls (and how many calls to each of them) exactly you
are seeing, and also on which userspace paths.

> That doesn't solve my need as I want to *only* do the arch vcpu_load for
> KVM_RUN, I should have been more clear in the commit message.

That's what you want to do, but it might not be what you need to do.

Paolo

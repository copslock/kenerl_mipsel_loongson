Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 19:16:51 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:38334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990593AbdKWSQokOHPE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Nov 2017 19:16:44 +0100
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59156C04D28B;
        Thu, 23 Nov 2017 18:16:37 +0000 (UTC)
Received: from [10.36.117.224] (ovpn-117-224.ams2.redhat.com [10.36.117.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF58060F9C;
        Thu, 23 Nov 2017 18:16:33 +0000 (UTC)
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
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
 <20171123174804.GB28855@cbox>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
Date:   Thu, 23 Nov 2017 19:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171123174804.GB28855@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 23 Nov 2017 18:16:37 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61066
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

On 23/11/2017 18:48, Christoffer Dall wrote:
>>> That doesn't solve my need as I want to *only* do the arch vcpu_load for
>>> KVM_RUN, I should have been more clear in the commit message.
>>
>> That's what you want to do, but it might not be what you need to do.
> 
> Well, why would we want to do a lot of work when there's absolutely no
> need to?
> 
> I see that this patch is invasive, and that's why I originally proposed
> the other approach of recording the ioctl number.

Because we need to balance performance and maintainability.  The
following observation is the important one:

> While it may be possible to call kvm_arch_vcpu_load() for a number of
> non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult to reason
> about, especially after my optimization series, because a lot of things
> can now happen, where we have to consider if we're really in the process
> of running a vcpu or not.

... because outside ARM I couldn't see any maintainability drawback.
Now I understand (or at least, I understand enough to believe you!).

The idea of this patch then is okay, but:

* x86 can use __vcpu_load/__vcpu_put, because the calls outside the lock
are all in the destruction path where no one can concurrently take the
lock.  So the lock+load and put+unlock variants are not necessary.

* Just make a huge series that, one ioctl at a time, pushes down the
load/put to the arch-specific functions.  No need to figure out where
it's actually needed, or at least you can leave it to the architecture
maintainers.

Thanks,

Paolo

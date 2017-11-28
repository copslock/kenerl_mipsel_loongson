Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 22:29:24 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:34890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990486AbdK1V3SRVFRR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Nov 2017 22:29:18 +0100
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E42F84E334;
        Tue, 28 Nov 2017 21:29:10 +0000 (UTC)
Received: from [10.36.117.153] (ovpn-117-153.ams2.redhat.com [10.36.117.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D62CB5D962;
        Tue, 28 Nov 2017 21:29:06 +0000 (UTC)
Subject: Re: [PATCH 00/15] Move vcpu_load and vcpu_put calls to arch code
To:     David Hildenbrand <david@redhat.com>,
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
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <dd738b4f-3d99-ec3b-fa5e-d166230f9d2b@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abcdc95d-0f78-3e42-1784-56393f502c68@redhat.com>
Date:   Tue, 28 Nov 2017 22:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <dd738b4f-3d99-ec3b-fa5e-d166230f9d2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 28 Nov 2017 21:29:11 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61168
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

On 28/11/2017 21:55, David Hildenbrand wrote:
> On 25.11.2017 21:57, Christoffer Dall wrote:
>> Some architectures may decide to do different things during
>> kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
>> arm64 is about to do significant work in vcpu load/put when running a
>> vcpu, but it's problematic to do this for any other vcpu ioctl than
>> KVM_RUN.
>>
>> Further, while it may be possible to call kvm_arch_vcpu_load() for a
>> number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
>> to reason about, especially after my optimization series, because a lot
>> of things can now happen, where we have to consider if we're really in
>> the process of running a vcpu or not.
>>
>> This series will first move the vcpu_load() and vcpu_put() calls in the
>> arch generic dispatch function into each case of the switch statement
>> and then, one-by-one, pushed the calls down into the architecture
>> specific code making the changes for each ioctl as required.
>>
>> Thanks,
>> -Christoffer
>>
>> Christoffer Dall (15):
>>   KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
>>   KVM: Factor out vcpu->pid adjustment for KVM_RUN
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
>>   KVM: Move vcpu_load to arch-specific
>>     kvm_arch_vcpu_ioctl_set_guest_debug
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
>>   KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
>>   KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
>>
>>  arch/arm64/kvm/guest.c     |  17 +++++--
>>  arch/mips/kvm/mips.c       |  72 +++++++++++++++++++--------
>>  arch/powerpc/kvm/book3s.c  |  38 +++++++++++++-
>>  arch/powerpc/kvm/booke.c   |  65 +++++++++++++++++++-----
>>  arch/powerpc/kvm/powerpc.c |  24 ++++++---
>>  arch/s390/kvm/kvm-s390.c   | 119 +++++++++++++++++++++++++++++++++++++-------
>>  arch/x86/kvm/x86.c         | 121 ++++++++++++++++++++++++++++++++++++++-------
>>  include/linux/kvm_host.h   |   2 +
>>  virt/kvm/arm/arm.c         |  91 +++++++++++++++++++++++++---------
>>  virt/kvm/kvm_main.c        |  43 +++++++---------
>>  10 files changed, 463 insertions(+), 129 deletions(-)
>>
> 
> Looking at the amount of code we duplicate, I wonder if simple ifdefery
> (if possible) would be easier for the single known "special" case.
> 
> (most probably an unpopular opinion :) )

No, also because the duplicate code will go down sensibly in the next
version.

Paolo

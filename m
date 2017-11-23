Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 17:17:19 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990483AbdKWQRMPkkUX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Nov 2017 17:17:12 +0100
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 363ACC058EDD;
        Thu, 23 Nov 2017 16:17:05 +0000 (UTC)
Received: from [10.36.117.224] (ovpn-117-224.ams2.redhat.com [10.36.117.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED6DF6BF8D;
        Thu, 23 Nov 2017 16:17:01 +0000 (UTC)
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
To:     Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72357599-798d-14d0-336a-69a083f17863@redhat.com>
Date:   Thu, 23 Nov 2017 17:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171123160521.27260-1-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 23 Nov 2017 16:17:05 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61061
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

On 23/11/2017 17:05, Christoffer Dall wrote:
> For example,
> arm64 is about to do significant work in vcpu load/put when running a
> vcpu, but not when doing things like KVM_SET_ONE_REG or
> KVM_SET_MP_STATE.

Out of curiosity, in what circumstances are these ioctls a hot path?
Especially KVM_SET_MP_STATE.

> Hi all,
> 
> Drew suggested this as an alternative approach to recording the ioctl
> number on the vcpu struct [1] as it may benefit other architectures in
> general.
> 
> I had a look at some of the specific ioctls across architectures, but
> must admit that I can't easily tell which architecture specific logic
> relies on having registered preempt notifiers and having called the
> architecture specific load function.
> 
> It would be great if you would let me know if you think this is
> generally useful or if you prefer the less invasive approach, and in
> case this is useful, if you could have a look at all the vcpu ioctls for
> your architecture and let me know if I am being too loose or too
> careful in calling __vcpu_load() in this patch.

I can suggest a third approach:

        if (ioctl == KVM_GET_ONE_REG || ioctl == KVM_SET_ONE_REG)
                return kvm_arch_vcpu_ioctl(filp, ioctl, arg);

in kvm_vcpu_ioctl before "r = vcpu_load(vcpu);", or even better:

        if (ioctl == KVM_GET_ONE_REG)
		// call kvm_arch_vcpu_get_one_reg_ioctl(vcpu, &reg);
		// and do copy_to_user
		return kvm_vcpu_get_one_reg_ioctl(vcpu, arg);
        if (ioctl == KVM_SET_ONE_REG)
		// do copy_from_user then call
		// kvm_arch_vcpu_set_one_reg_ioctl(vcpu, &reg);
		return kvm_vcpu_set_one_reg_ioctl(vcpu, arg);

so that the kvm_arch_vcpu_get/set_one_reg_ioctl functions are called
without the lock.

Then all architectures except ARM can be switched to do
vcpu_load/vcpu_put in kvm_arch_vcpu_get/set_one_reg_ioctl

Paolo

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:30:54 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:3432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991957AbdK2RaqYBwFV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 18:30:46 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2409F61461;
        Wed, 29 Nov 2017 17:30:40 +0000 (UTC)
Received: from [10.36.117.80] (ovpn-117-80.ams2.redhat.com [10.36.117.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4A1F6031B;
        Wed, 29 Nov 2017 17:30:33 +0000 (UTC)
Subject: Re: [PATCH v2 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
To:     Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-16-christoffer.dall@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <12137903-6f11-6350-6344-30e3bc6542e3@redhat.com>
Date:   Wed, 29 Nov 2017 18:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129164116.16167-16-christoffer.dall@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 29 Nov 2017 17:30:40 +0000 (UTC)
Return-Path: <david@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61214
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


> +++ b/virt/kvm/arm/arm.c
> @@ -381,14 +381,11 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> -	vcpu_load(vcpu);
> -
>  	if (vcpu->arch.power_off)
>  		mp_state->mp_state = KVM_MP_STATE_STOPPED;
>  	else
>  		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
>  
> -	vcpu_put(vcpu);
>  	return 0;
>  }

Okay, this also makes sense on other architectures. The important thing
is only that we hold the vcpu mutex.


-- 

Thanks,

David / dhildenb

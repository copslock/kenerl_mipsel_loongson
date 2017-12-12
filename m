Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 17:34:12 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:44753
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdLLQeBvXBgN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 17:34:01 +0100
Received: by mail-wr0-x242.google.com with SMTP id l22so21764598wrc.11
        for <linux-mips@linux-mips.org>; Tue, 12 Dec 2017 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yIW3ChdLjiatK6Sxf6blTiEb9AWnSVhpixbbDE7fGn0=;
        b=oHnrUGlX16WRRhNJX13gMjpJWUtkQJ7vo5Bd23j8DCr8kHdKGwUrJWsT9eWcH+A7zU
         AbMoLjT6Y0ns+t5m8eSCb8nCA/d2Tr9YFmfRKJp6IKZEdPigNS375QvBZYTidzfh06pX
         8un5/EeW6L0ScSW41qUq9jmFb29GKHsU9oktzyQze9PiUvD0RfWr5dzuJJbtPtIPatqt
         EmtLaiB0mmizaZTnAgYhUE/DUUVUACTCZLPuUepZs2GFH9bgdU6xhVDN06fyUTjIgeX/
         U2DOydq/MV5o31B48RMZMxHKbwGvEFSeOdIB9biahTDEvy+ExsXp2v+RsIF2K+Bb/LZy
         GKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIW3ChdLjiatK6Sxf6blTiEb9AWnSVhpixbbDE7fGn0=;
        b=BnusvhEI3kYN9Ln4OLR9oarr38KHtDy1IymmhoZrENhrfvqpx/rl2zvwTbp9mNqqDy
         RtCr0ef8IhmrzXM4LGo4AYKQ/a4yVx3pnSNL5WqR33OydDU1+m/PPrNeFqMfSZuapB5e
         k3Ag+ThM/t1OLEJVvcZMwWiJbfmn+KgJPTqHGIjo7YNOjixJ9qLyx21CM7+7O0MDsrvx
         NYohbWrnN1ssS27ompHvDTJJIFMEKyZpnXmfuYJinUTg+eFGCZuybhaYHk1EuwP8JTQa
         LncOaisoLvvIHzqF6v2x50gLw2Ib5/CZy+KYjOG5yiipk5NuQIKZQsVLU3OUh82gtWD4
         wBHg==
X-Gm-Message-State: AKGB3mKw7cvDlarS3wXbn0kvTnTtih5oqB9yURDijdY0zC3cC8q6QRll
        2ikpKEHM88gHfg3fnn6DZ4E=
X-Google-Smtp-Source: ACJfBot7hUUJrRAYxXozwzNDuLnDUSCFuy2pieleZkMA4WN7ibFpwDPrjFDruVOymWqVxP5k/NlpkQ==
X-Received: by 10.223.184.47 with SMTP id h44mr4146237wrf.11.1513096436278;
        Tue, 12 Dec 2017 08:33:56 -0800 (PST)
Received: from [192.168.10.165] (dynamic-adsl-78-12-251-125.clienti.tiscali.it. [78.12.251.125])
        by smtp.googlemail.com with ESMTPSA id 59sm18686823wrs.41.2017.12.12.08.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 08:33:55 -0800 (PST)
Subject: Re: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
To:     Christoffer Dall <christoffer.dall@linaro.org>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mips@linux-mips.org, Christoffer Dall <cdall@kernel.org>,
        kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-8-cdall@kernel.org>
 <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com> <20171211091921.GE910@cbox>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c05dc6c-5028-9b45-3478-b09c4563bbcd@redhat.com>
Date:   Tue, 12 Dec 2017 17:33:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211091921.GE910@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61447
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

On 11/12/2017 10:19, Christoffer Dall wrote:
> On Fri, Dec 08, 2017 at 05:26:02PM +0100, David Hildenbrand wrote:
>>
>>>  
>>>  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>> index f647e121070e..cdf0be02c95a 100644
>>> --- a/arch/powerpc/kvm/booke.c
>>> +++ b/arch/powerpc/kvm/booke.c
>>> @@ -1632,18 +1632,25 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>>>  {
>>>  	int ret;
>>>  
>>> +	vcpu_load(vcpu);
>>> +
>>> +	ret = -EINVAL;
>>
>> you can initialize this directly.
>>
>>>  	if (vcpu->arch.pvr != sregs->pvr)
>>> -		return -EINVAL;
>>> +		goto out;
>>>  
>>>  	ret = set_sregs_base(vcpu, sregs);
>>>  	if (ret < 0)
>>> -		return ret;
>>> +		goto out;
>>>  
>>>  	ret = set_sregs_arch206(vcpu, sregs);
>>>  	if (ret < 0)
>>> -		return ret;
>>> +		goto out;
>>> +
>>> +	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
>>>  
>>> -	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
>>> +out:
>>> +	vcpu_put(vcpu);
>>> +	return ret;
>>>  }
>>>  
>>>  int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 18011fc4ac49..d95b4f15e52b 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2729,8 +2729,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>>>  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>>>  				  struct kvm_sregs *sregs)
>>>  {
>>> +	vcpu_load(vcpu);
>>> +
>>>  	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
>>>  	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
>>> +
>>> +	vcpu_put(vcpu);
>>>  	return 0;
>>>  }
>>>  
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 20a5f6776eea..a31a80aee0b9 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -7500,15 +7500,19 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>>>  	int mmu_reset_needed = 0;
>>>  	int pending_vec, max_bits, idx;
>>>  	struct desc_ptr dt;
>>> +	int ret;
>>> +
>>> +	vcpu_load(vcpu);
>>>  
>>> +	ret = -EINVAL;
>>
>> dito
> 
> Sure.

I'm doing it when applying.

Paolo

>> Reviewed-by: David Hildenbrand <david@redhat.com>

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 17:36:49 +0100 (CET)
Received: from mail-wr0-x233.google.com ([IPv6:2a00:1450:400c:c0c::233]:45691
        "EHLO mail-wr0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbdLLQgmyCn5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 17:36:42 +0100
Received: by mail-wr0-x233.google.com with SMTP id h1so21737269wre.12
        for <linux-mips@linux-mips.org>; Tue, 12 Dec 2017 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b6PD1hcAA+b82mAK6NrApmGxfXkyMCpPsYOA2ZA4k50=;
        b=V5AG90GPRlWL03zh61C3p/T9rkRKKIv6XtUeb4ktIViF2Dd9zEf7VMO0HWf4w+wce9
         nrcV0fYaLGQLYrsYG+fkl4ZhMNcxL60NTHErmp4NxQwYcBq9U9fKAMsr5LtrAgmWJvft
         BADIQS7ZjB1ErgquYPjfSZHIT1APK+lJFsDAd3tEBlhAQWPm5WQeu4myZqvG4L5K2tOB
         BJdsu8DDCt/0MIX9L2mPhbIMJZ7ydWWm46GIxb7FYos5ADAksGjdMdiMzB6vlHKEU9/S
         le8UTzHMpBRv6PVR3qFqVGeK7fPKup4owoRzRSH9CWmJNm0sysSZGwYAjQLGdyL3f8D/
         Zo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b6PD1hcAA+b82mAK6NrApmGxfXkyMCpPsYOA2ZA4k50=;
        b=qvyE6NZdc6nhYrOiT7AD95MxVTFHy3hGDFCBc/IohThhQxSE8o/+UN23TDOhBoOO2p
         wVoblHaj7Mlomm9M1lkA0hpoEoLh8mFG2pQtuV2f7xCZ9Ql78UDAJVizOrsb6Kd1A1g7
         94tROc+Hf0YIM3Q3IptpKUp39cf6g1+wKa38tcM+Zj0Xj2pI+Y/qiphT70Ko97BfqJGV
         X8UDPh9TaJWAgU/w+1IWFcucWnKIJpsufskiY4zXRezIhUSn5Rbe4SGv6wUV5k79xkn2
         Ji6DAaMoh2K51hOFgFPCwEgvaS8tuaMehB6zGFiBqvMqhP8DdLwYLsrGuTrKONLkfvl+
         ir6A==
X-Gm-Message-State: AKGB3mJptS0qTYwH6oVqbbbWxsGSIn43W9i8ABttivIGnKrqth7MwIlU
        LfHeWJ4kPXEOrXOcJDwQwzU=
X-Google-Smtp-Source: ACJfBoutzw/dboR8Tis+Y+KW17BNqlrR4RK8OWysEU2pzCxzXQui695qkS00qDNitfuIJV+hRcsfMw==
X-Received: by 10.223.199.203 with SMTP id y11mr4644716wrg.37.1513096597586;
        Tue, 12 Dec 2017 08:36:37 -0800 (PST)
Received: from [192.168.10.165] (dynamic-adsl-78-12-251-125.clienti.tiscali.it. [78.12.251.125])
        by smtp.googlemail.com with ESMTPSA id r14sm18655718wra.71.2017.12.12.08.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 08:36:36 -0800 (PST)
Subject: Re: [PATCH v3 11/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
To:     Cornelia Huck <cohuck@redhat.com>,
        Christoffer Dall <cdall@kernel.org>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Hogan <jhogan@kernel.org>, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-12-cdall@kernel.org>
 <20171211133943.236f18be.cohuck@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9380125-a226-0df1-2724-d957b9c05b42@redhat.com>
Date:   Tue, 12 Dec 2017 17:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211133943.236f18be.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61448
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

On 11/12/2017 13:39, Cornelia Huck wrote:
>> +	ret = -EINVAL;
>>  	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
>>  		uint64_t addr = dbg->arch.bp[n].addr;
>>  		uint32_t type = dbg->arch.bp[n].type;
>> @@ -2067,21 +2071,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>  		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
>>  			     KVMPPC_DEBUG_WATCH_WRITE |
>>  			     KVMPPC_DEBUG_BREAKPOINT))
>> -			return -EINVAL;
>> +			goto out;
>>  
>>  		if (type & KVMPPC_DEBUG_BREAKPOINT) {
>>  			/* Setting H/W breakpoint */
>>  			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
>> -				return -EINVAL;
>> +				goto out;
>>  		} else {
>>  			/* Setting H/W watchpoint */
>>  			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
>>  							type, w++))
>> -				return -EINVAL;
>> +				goto out;
>>  		}
>>  	}
>>  
>> -	return 0;
>> +	ret = 0;
> 
> I would probably set the -EINVAL in the individual branches (so it is
> clear that something is wrong, and it is not just a benign exit as in
> the cases above), but your code is correct as well. Let the powerpc
> folks decide.

The idiom that Christoffer used is found elsewhere in KVM, so I'm
accepting his version.  Thanks for the review!

Paolo

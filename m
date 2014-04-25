Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 23:45:17 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:44090 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816002AbaDYVpPhypY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 23:45:15 +0200
Received: by mail-ie0-f172.google.com with SMTP id at1so992735iec.31
        for <multiple recipients>; Fri, 25 Apr 2014 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=s9BkhIOe2w3q+savat0dm+TZvfrveL3V5Pptu41GXeo=;
        b=XRMPjQl866sqqm7dXKhL/78lbzO21Tzszw3Ykk/HAH3nLmYmOuqBC4Wlq1pHdK7rql
         kzsh1tl/dgTer1avVJhuke2hTpVt7XUfxUuwSY0aZNziN8AnQYp2NIuW5I0IDiu9ofGv
         snNGvjHM4Zzcp6SandRMUkBvU4P3gY8Nfs0wbgbxxYEzfpUrxUbujhh362Kb69J1UyiE
         y6rUN/94o1bbj1sQKP7z9Vx1dFYkvT1Qtbkok3X5KixR+t0r18+zrFKWMnx4Q0CzN9Z+
         zWKbd0SzhCn/lz7Lg5rkT6u2S5/Y1x06PRHRSvhLQ77D22x3QXyOV8ZxVoDBTwvOnPx2
         OwYA==
X-Received: by 10.50.66.3 with SMTP id b3mr8142670igt.22.1398462308896;
        Fri, 25 Apr 2014 14:45:08 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id sc2sm12057707igb.5.2014.04.25.14.45.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 14:45:08 -0700 (PDT)
Message-ID: <535AD763.1040604@gmail.com>
Date:   Fri, 25 Apr 2014 14:45:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 05/21] MIPS: KVM: Add CP0_EPC KVM register access
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-6-git-send-email-james.hogan@imgtec.com> <535A90E1.2030705@gmail.com> <10468933.5AvfRZXSN7@radagast>
In-Reply-To: <10468933.5AvfRZXSN7@radagast>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 04/25/2014 01:29 PM, James Hogan wrote:
> Hi David,
>
> On Friday 25 April 2014 09:44:17 David Daney wrote:
>> On 04/25/2014 08:19 AM, James Hogan wrote:
>>> Contrary to the comment, the guest CP0_EPC register cannot be set via
>>> kvm_regs, since it is distinct from the guest PC. Add the EPC register
>>> to the KVM_{GET,SET}_ONE_REG ioctl interface.
>>>
>>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Gleb Natapov <gleb@kernel.org>
>>> Cc: kvm@vger.kernel.org
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: linux-mips@linux-mips.org
>>> Cc: David Daney <david.daney@cavium.com>
>>> Cc: Sanjay Lal <sanjayl@kymasys.com>
>>
>> NACK...
>>
>>> ---
>>>
>>>    arch/mips/kvm/kvm_mips.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
>>> index 46cea0bad518..db41876cbac5 100644
>>> --- a/arch/mips/kvm/kvm_mips.c
>>> +++ b/arch/mips/kvm/kvm_mips.c
>>> @@ -512,6 +512,7 @@ kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>>>
>>>    #define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
>>>    #define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
>>>    #define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
>>>
>>> +#define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
>>
>> This is already called KVM_REG_MIPS_PC, you cannot change that.
>
> KVM_REG_MIPS_PC gets you vcpu->arch.pc, i.e. the next address of guest
> execution.
>
> KVM_REG_MIPS_CP0_EPC gets you the guest's CP0 EPC register which is the PC of
> the last guest exception.
>
> They are quite distinct state, even though vcpu->arch.pc is read from the
> *root context*'s CP0 EPC register after an exception or interrupt.
>

Sorry, my mistake.  I was confusing Root/Host and Guest state.

I remove my objection.

David Daney


> Cheers
> James
>
>>
>>>    #define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_32(15, 1)
>>>    #define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
>>>    #define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
>>>
>>> @@ -567,7 +568,7 @@ static u64 kvm_mips_get_one_regs[] = {
>>>
>>>    	KVM_REG_MIPS_CP0_ENTRYHI,
>>>    	KVM_REG_MIPS_CP0_STATUS,
>>>    	KVM_REG_MIPS_CP0_CAUSE,
>>>
>>> -	/* EPC set via kvm_regs, et al. */
>>> +	KVM_REG_MIPS_CP0_EPC,
>>>
>>>    	KVM_REG_MIPS_CP0_CONFIG,
>>>    	KVM_REG_MIPS_CP0_CONFIG1,
>>>    	KVM_REG_MIPS_CP0_CONFIG2,
>>>
>>> @@ -620,6 +621,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
>>>
>>>    	case KVM_REG_MIPS_CP0_CAUSE:
>>>    		v = (long)kvm_read_c0_guest_cause(cop0);
>>>    		break;
>>>
>>> +	case KVM_REG_MIPS_CP0_EPC:
>>> +		v = (long)kvm_read_c0_guest_epc(cop0);
>>> +		break;
>>>
>>>    	case KVM_REG_MIPS_CP0_ERROREPC:
>>>    		v = (long)kvm_read_c0_guest_errorepc(cop0);
>>>    		break;
>>>
>>> @@ -716,6 +720,9 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
>>>
>>>    	case KVM_REG_MIPS_CP0_CAUSE:
>>>    		kvm_write_c0_guest_cause(cop0, v);
>>>    		break;
>>>
>>> +	case KVM_REG_MIPS_CP0_EPC:
>>> +		kvm_write_c0_guest_epc(cop0, v);
>>> +		break;
>>>
>>>    	case KVM_REG_MIPS_CP0_ERROREPC:
>>>    		kvm_write_c0_guest_errorepc(cop0, v);
>>>    		break;

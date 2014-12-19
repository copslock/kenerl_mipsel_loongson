Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 17:38:15 +0100 (CET)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:41522 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008725AbaLSQiNL268V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 17:38:13 +0100
Received: by mail-ie0-f175.google.com with SMTP id x19so1026849ier.20
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yO1Ic1YGlzIC/ovg8O+2FIjHLS723VUV8FlueeVx5bg=;
        b=k7Tmc5Ajl/G+7LqRlVo3pfsTqZkU8i6WM5vGQqbtSrO3kOUL0B6frTfhb7hjhdCzSz
         Nz2CtOhC6er7HcVMdeh7BKGgEv+rakIblhDEUEuWOh2gTwDwRr/J/YdZ8BxHExb5rbws
         nMbWmzOEVcFjG5gl11As+vLEDpjk075DDSYFllkeow758C2is9tcp52a4cMtXo4Kvj/e
         eQlXesZhC9HyjV3gPWmxPREZ/Dwd3MfolNF24c62zD+xl6QM+avWmOUrR+4lY14faHlg
         NMqrn2Kp2uxlxLSbcZvYQrb4zjznjDHmfk/wpv1WQHhoLm7UTUpuxhsFSLYBTepUEMDY
         lpkg==
X-Received: by 10.107.169.15 with SMTP id s15mr8109153ioe.34.1419007087136;
        Fri, 19 Dec 2014 08:38:07 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id qj6sm1098857igc.1.2014.12.19.08.38.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 08:38:06 -0800 (PST)
Message-ID: <5494546D.5080802@gmail.com>
Date:   Fri, 19 Dec 2014 08:38:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains
 for MIPS R6 support
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com> <549321F3.1090704@gmail.com> <5493F794.9040200@imgtec.com>
In-Reply-To: <5493F794.9040200@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44848
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

On 12/19/2014 02:01 AM, Markos Chandras wrote:
> On 12/18/2014 06:50 PM, David Daney wrote:
>> On 12/18/2014 07:09 AM, Markos Chandras wrote:
>>> MIPS R6 changed the opcodes for LL/SC instructions and reduced the
>>> offset field to 9-bits. This has some undesired effects with the "m"
>>> constrain since it implies a 16-bit immediate. As a result of which,
>>> add a register ("r") constrain as well to make sure the entire address
>>> is loaded to a register before the LL/SC operations. Also use macro
>>> to set the appropriate ISA for the asm blocks
>>>
>>
>> Has support for MIPS R6 been added to GCC?
>>
>> If so, that should include a proper constraint to be used with the new
>> offset restrictions.  We should probably use that, instead of forcing to
>> a "r" constraint.
>>
>>
>>> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>    arch/mips/include/asm/atomic.h | 50
>>> +++++++++++++++++++++---------------------
>>>    1 file changed, 25 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/atomic.h
>>> b/arch/mips/include/asm/atomic.h
>>> index 6dd6bfc607e9..8669e0ec97e3 100644
>>> --- a/arch/mips/include/asm/atomic.h
>>> +++ b/arch/mips/include/asm/atomic.h
>>> @@ -60,13 +60,13 @@ static __inline__ void atomic_##op(int i, atomic_t
>>> * v)                \
>>>                                            \
>>>            do {                                \
>>>                __asm__ __volatile__(                    \
>>> -            "    .set    arch=r4000            \n"    \
>>> -            "    ll    %0, %1        # atomic_" #op "\n"    \
>>> +            "    .set    "MIPS_ISA_ARCH_LEVEL"        \n"    \
>>> +            "    ll    %0, 0(%3)    # atomic_" #op "\n"    \
>>>                "    " #asm_op " %0, %2            \n"    \
>>> -            "    sc    %0, %1                \n"    \
>>> +            "    sc    %0, 0(%3)            \n"    \
>>>                "    .set    mips0                \n"    \
>>>                : "=&r" (temp), "+m" (v->counter)            \
>>> -            : "Ir" (i));                        \
>>> +            : "Ir" (i), "r" (&v->counter));                \
>>
>> You lost the "m" constraint, but are still modifying memory.  There is
>> no "memory" clobber here, so we are no longer correctly describing what
>> is happening.
>>
>>
>
> Sorry I don't understand what you mean by  "you lost the "m"
> constraint". +m (v->counter) is still there to denote that v->counter
> memory is being modified no?
>

It looks like I misread the patch.  On closer inspection, it seems that 
the "m" constraint remains, so let's disregard my comment.

David Daney

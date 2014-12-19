Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 11:02:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43467 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008667AbaLSKCEpp2Wx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 11:02:04 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0D87BA61E29D5;
        Fri, 19 Dec 2014 10:01:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 19 Dec 2014 10:01:58 +0000
Received: from [192.168.154.125] (192.168.154.125) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 19 Dec
 2014 10:01:56 +0000
Message-ID: <5493F794.9040200@imgtec.com>
Date:   Fri, 19 Dec 2014 10:01:56 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains
 for MIPS R6 support
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com> <549321F3.1090704@gmail.com>
In-Reply-To: <549321F3.1090704@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 12/18/2014 06:50 PM, David Daney wrote:
> On 12/18/2014 07:09 AM, Markos Chandras wrote:
>> MIPS R6 changed the opcodes for LL/SC instructions and reduced the
>> offset field to 9-bits. This has some undesired effects with the "m"
>> constrain since it implies a 16-bit immediate. As a result of which,
>> add a register ("r") constrain as well to make sure the entire address
>> is loaded to a register before the LL/SC operations. Also use macro
>> to set the appropriate ISA for the asm blocks
>>
> 
> Has support for MIPS R6 been added to GCC?
> 
> If so, that should include a proper constraint to be used with the new
> offset restrictions.  We should probably use that, instead of forcing to
> a "r" constraint.
> 
> 
>> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>   arch/mips/include/asm/atomic.h | 50
>> +++++++++++++++++++++---------------------
>>   1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/atomic.h
>> b/arch/mips/include/asm/atomic.h
>> index 6dd6bfc607e9..8669e0ec97e3 100644
>> --- a/arch/mips/include/asm/atomic.h
>> +++ b/arch/mips/include/asm/atomic.h
>> @@ -60,13 +60,13 @@ static __inline__ void atomic_##op(int i, atomic_t
>> * v)                \
>>                                           \
>>           do {                                \
>>               __asm__ __volatile__(                    \
>> -            "    .set    arch=r4000            \n"    \
>> -            "    ll    %0, %1        # atomic_" #op "\n"    \
>> +            "    .set    "MIPS_ISA_ARCH_LEVEL"        \n"    \
>> +            "    ll    %0, 0(%3)    # atomic_" #op "\n"    \
>>               "    " #asm_op " %0, %2            \n"    \
>> -            "    sc    %0, %1                \n"    \
>> +            "    sc    %0, 0(%3)            \n"    \
>>               "    .set    mips0                \n"    \
>>               : "=&r" (temp), "+m" (v->counter)            \
>> -            : "Ir" (i));                        \
>> +            : "Ir" (i), "r" (&v->counter));                \
> 
> You lost the "m" constraint, but are still modifying memory.  There is
> no "memory" clobber here, so we are no longer correctly describing what
> is happening.
> 
> 

Sorry I don't understand what you mean by  "you lost the "m"
constraint". +m (v->counter) is still there to denote that v->counter
memory is being modified no?

-- 
markos

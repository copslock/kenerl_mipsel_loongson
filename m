Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 10:42:07 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52263 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6852087Ab3KLJl5naUd0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Nov 2013 10:41:57 +0100
Message-ID: <5281F7E3.6070802@imgtec.com>
Date:   Tue, 12 Nov 2013 09:41:55 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 3/6] MIPS: Add support for the proAptiv cores
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com> <1383844120-29601-4-git-send-email-markos.chandras@imgtec.com> <5281370C.8040707@gmail.com>
In-Reply-To: <5281370C.8040707@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_12_09_41_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38504
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

On 11/11/2013 07:59 PM, David Daney wrote:
>
> This patch is a big collection of small unrelated changes.
>
> Can you break it up so that there is one patch per change?
>
> o Add new identifiers
> o Probe for them.
> o Add new cpu-features.
> o tlb.h change.
> o All the places you add 'case CPU_PROAPTIV'
>

Hi David,

Ok thanks I will split this patch into smaller patches.

> [...]
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index c814287..8168e29 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -286,6 +286,13 @@ static inline unsigned int decode_config4(struct
>> cpuinfo_mips *c)
>>           && cpu_has_tlb)
>>           c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
>>
>> +    if (cpu_has_tlb) {
>> +        if (((config4 & MIPS_CONF4_IE) >> 29) == 2) {
>> +            c->options |= MIPS_CPU_TLBINV;
>> +            pr_info("TLBINV/F supported, config4=0x%0x\n", config4);
>
> ... The probing functions don't print messages, so don't add this
> pr_info().

Ok will do

Thanks for the review

-- 
markos

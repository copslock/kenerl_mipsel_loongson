Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 16:23:56 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:41528 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990430AbdLUPXpFvJ5n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 16:23:45 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 21 Dec 2017 15:20:16 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Dec
 2017 07:19:37 -0800
Subject: Re: [PATCH 1/3] MIPS: c-r4k: instruction_hazard should immediately
 follow cache op
To:     James Hogan <james.hogan@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "stable # v4 . 9+" <stable@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>
References: <1513854965-3880-1-git-send-email-matt.redfearn@mips.com>
 <20171221151443.GG5027@jhogan-linux.mipstec.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <a6bfa1da-806f-a852-f33f-309cd153c596@mips.com>
Date:   Thu, 21 Dec 2017 15:19:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171221151443.GG5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513869613-637137-31546-67400-14
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi James,

On 21/12/17 15:14, James Hogan wrote:
> On Thu, Dec 21, 2017 at 11:16:02AM +0000, Matt Redfearn wrote:
>> During ftrace initialisation, placeholder instructions in the prologue
>> of every kernel function not marked "notrace" are replaced with nops.
>> After the instructions are written (to the dcache), flush_icache_range()
>> is used to ensure that the icache will be updated with these replaced
>> instructions. Currently there is an instruction_hazard guard at the end
>> of __r4k_flush_icache_range, since a hazard can be created if the CPU
>> has already begun fetching the instructions that have have been
>> replaced. The placement, however, ignores the calls to preempt_enable(),
>> both in __r4k_flush_icache_range and r4k_on_each_cpu. When
>> CONFIG_PREEMPT is enabled, these expand out to at least calls to
>> preempt_count_sub(). The lack of an instruction hazard between icache
>> invalidate and the execution of preempt_count_sub, in rare
>> circumstances, was observed to cause weird crashes on Ci40, where the
>> CPU would end up taking a kernel unaligned access exception from the
>> middle of do_ade(), which it somehow reached from preempt_count_sub
>> without executing the start of do_ade.
>>
>> Since the instruction hazard exists immediately after the dcache is
>> written back and icache invalidated, place the instruction_hazard()
>> within __local_r4k_flush_icache_range. The one at the end of
>> __r4k_flush_icache_range is too late, since all of the functions in the
>> call path of preempt_enable have already been executed, so remove it.
>>
>> This fixes the crashes during ftrace initialisation on Ci40.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> Cc: stable <stable@vger.kernel.org> # v4.9+
>>
>> ---
>>
>>   arch/mips/mm/c-r4k.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index 6f534b209971..ce7a54223504 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>> @@ -760,6 +760,8 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
>>   			break;
>>   		}
>>   	}
>> +	/* Hazard to force new i-fetch */
>> +	instruction_hazard();
> 
> By the sounds of it that is a hardware bug, that it didn't try and
> execute either the old instruction or the new instruction.

Yeah, possibly.

  Maybe an
> expanded comment would be worthwhile here. If it wasn't for that issue
> it would I suppose be safe for it to be directly before the
> preempt_enable() in __r4k_flush_icache_range().

No - there's another preempt_enable() in r4k_on_each_cpu (noted in the 
commit message) so by the time the local CPU gets to the 
preempt_enable() in __r4k_flush_icache_range, it has potentially already 
executed the preempt_enable path and died. That's why I put it here.

Thanks,
Matt

> 
> Cheers
> James
> 
>>   }
>>   
>>   static inline void local_r4k_flush_icache_range(unsigned long start,
>> @@ -817,7 +819,6 @@ static void __r4k_flush_icache_range(unsigned long start, unsigned long end,
>>   	}
>>   	r4k_on_each_cpu(args.type, local_r4k_flush_icache_range_ipi, &args);
>>   	preempt_enable();
>> -	instruction_hazard();
>>   }
>>   
>>   static void r4k_flush_icache_range(unsigned long start, unsigned long end)
>> -- 
>> 2.7.4
>>

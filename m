Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Nov 2013 21:56:33 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52884 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832660Ab3KKU4bNojpg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Nov 2013 21:56:31 +0100
Message-ID: <5281445D.9090001@imgtec.com>
Date:   Mon, 11 Nov 2013 12:55:57 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/6] MIPS: mm: Use the TLBINVF instruction to flush the
 VTLB
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com> <1383844120-29601-5-git-send-email-markos.chandras@imgtec.com> <528139B1.9010909@gmail.com>
In-Reply-To: <528139B1.9010909@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
X-SEF-Processed: 7_3_0_01192__2013_11_11_20_56_00
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 11/11/2013 12:10 PM, David Daney wrote:
> On 11/07/2013 09:08 AM, Markos Chandras wrote:
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> The TLBINVF instruction can be used to flush the entire VTLB.
>> This eliminates the need for the TLBWI loop and improves performance.
>>
>> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
>
> This should be split into two patches.  One for each file.
>
> Also...
>
>> ---
>>   arch/mips/include/asm/mipsregs.h | 13 +++++++++++++
>>   arch/mips/mm/tlb-r4k.c           | 18 ++++++++++++------
>>   2 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/mipsregs.h 
>> b/arch/mips/include/asm/mipsregs.h
>> index 412fe99..9cd0e13 100644
>> --- a/arch/mips/include/asm/mipsregs.h
>> +++ b/arch/mips/include/asm/mipsregs.h
>> @@ -685,6 +685,19 @@ static inline int mm_insn_16bit(u16 insn)
>>   }
>>
>>   /*
>> + * TLB Invalidate Flush
>> + */
>> +static inline void tlbinvf(void)
>> +{
>> +    __asm__ __volatile__(
>> +        ".set push\n\t"
>> +        ".set noreorder\n\t"
>
> ... Why do you need noreorder here?

Historically. Just copied a worked stuff right before this function and 
doesn't bother "why it is needed in other functions".

>
>> +        ".word 0x42000004\n\t" /* tlbinvf */
>> +        ".set pop");
>> +}
>> +
>> +
>> +/*
>>    * Functions to access the R10000 performance counters. These are 
>> basically
>>    * mfc0 and mtc0 instructions from and to coprocessor register with 
>> a 5-bit
>>    * performance counter number encoded into bits 1 ... 5 of the 
>> instruction.
>> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
>> index 363aa03..427dcac 100644
>> --- a/arch/mips/mm/tlb-r4k.c
>> +++ b/arch/mips/mm/tlb-r4k.c
>> @@ -83,13 +83,19 @@ void local_flush_tlb_all(void)
>>       entry = read_c0_wired();
>>
>>       /* Blast 'em all away. */
>> -    while (entry < current_cpu_data.tlbsize) {
>> -        /* Make sure all entries differ. */
>> -        write_c0_entryhi(UNIQUE_ENTRYHI(entry));
>> -        write_c0_index(entry);
>> +    if (cpu_has_tlbinv && current_cpu_data.tlbsize) {
>> +        write_c0_index(0);
>>           mtc0_tlbw_hazard();
>> -        tlb_write_indexed();
>> -        entry++;
>> +        tlbinvf();  /* invalidate VTLB */
>> +    } else {
>> +        while (entry < current_cpu_data.tlbsize) {
>> +            /* Make sure all entries differ. */
>> +            write_c0_entryhi(UNIQUE_ENTRYHI(entry));
>> +            write_c0_index(entry);
>> +            mtc0_tlbw_hazard();
>> +            tlb_write_indexed();
>> +            entry++;
>> +        }
>>       }
>>       tlbw_use_hazard();
>>       write_c0_entryhi(old_ctx);
>>
>

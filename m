Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:51:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58484 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994787AbdFHNfFPGhkT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:35:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 34A02CB171951;
        Thu,  8 Jun 2017 14:34:56 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 8 Jun
 2017 14:34:58 +0100
Subject: Re: [PATCH] irqchip/mips-gic: mark count and compare accessors
 notrace
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
References: <1496927183-31987-1-git-send-email-marcin.nowakowski@imgtec.com>
 <87k24mipa1.fsf@arm.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <5928d606-d903-b096-a2cd-44df5f6cec4c@imgtec.com>
Date:   Thu, 8 Jun 2017 15:34:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <87k24mipa1.fsf@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Marc,

On 08.06.2017 15:26, Marc Zyngier wrote:
> On Thu, Jun 08 2017 at  3:06:23 pm BST, Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
>> gic_read_count(), gic_write_compare() and gic_write_cpu_compare() are
>> often used in a sequence to update the compare register with a count
>> value increased by a small offset.
>> With small delta values used to update the compare register, the time to
>> update function trace for these operations may be longer than the update
>> timeout leading to update failure.
>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>> ---
>>   drivers/irqchip/irq-mips-gic.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
>> index eb7fbe1..ecee073 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c
>> @@ -140,7 +140,7 @@ static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
>>   }
>>   
>>   #ifdef CONFIG_CLKSRC_MIPS_GIC
>> -u64 gic_read_count(void)
>> +notrace u64 gic_read_count(void)
> 
> The attributes are usually placed between the return type and the
> function name.

OK, I'll change this.

>>   {
>>   	unsigned int hi, hi2, lo;
>>   
>> @@ -167,7 +167,7 @@ unsigned int gic_get_count_width(void)
>>   	return bits;
>>   }
>>   
>> -void gic_write_compare(u64 cnt)
>> +notrace void gic_write_compare(u64 cnt)
>>   {
>>   	if (mips_cm_is64) {
>>   		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE), cnt);
>> @@ -179,7 +179,7 @@ void gic_write_compare(u64 cnt)
>>   	}
>>   }
>>   
>> -void gic_write_cpu_compare(u64 cnt, int cpu)
>> +notrace void gic_write_cpu_compare(u64 cnt, int cpu)
>>   {
>>   	unsigned long flags;
> 
> What guarantees do you have that some event (interrupt? frequency
> scaling?) won't delay these anyway, generating the same missed deadline?
> Shouldn't the code deal with these case and acknowledge that the
> deadline has already expired?

Well - there is no guarantee for that at the moment. One solution that 
kernel provides (and that works in this scenario) is to enable 
GENERIC_CLOCKEVENTS_MIN_ADJUST. This ensures that any failures are 
always retried with an increasing minimum adjustment step.
That, however, suffers from a different issue as described and discussed 
here: https://patchwork.kernel.org/patch/8909491/

Various events can delay these operations and even with notrace they 
might still fail, but as it stands now, even if the code using them does 
a retry, the latency I've observed with tracing enabled is often too 
long to ever succeed.

Marcin

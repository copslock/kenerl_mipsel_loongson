Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 12:35:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51921 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992639AbcHKKfOUWva8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 12:35:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AE513F10B4BC5;
        Thu, 11 Aug 2016 11:34:54 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 11 Aug
 2016 11:34:57 +0100
Subject: Re: [PATCH] MIPS: Delete unused file smp-gic.c
To:     Paul Burton <paul.burton@imgtec.com>, <ralf@linux-mips.org>
References: <1470845463-25269-1-git-send-email-matt.redfearn@imgtec.com>
 <a284afa7-caf7-b4fa-e936-03486ef14a7d@imgtec.com>
CC:     <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <57AC54D1.5020900@imgtec.com>
Date:   Thu, 11 Aug 2016 11:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <a284afa7-caf7-b4fa-e936-03486ef14a7d@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Paul,

On 11/08/16 09:42, Paul Burton wrote:
> On 10/08/16 17:11, Matt Redfearn wrote:
>> Commit 7eb8c99db26c ("MIPS: Delete smp-gic.c") removed the file from the
>> Makefile and the option to build it from KConfig, but left the file
>> itself floating in the tree.
>>
>> Remove the unused source file.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> ---
>>   arch/mips/kernel/smp-gic.c | 66 ----------------------------------------------
>>   1 file changed, 66 deletions(-)
>>   delete mode 100644 arch/mips/kernel/smp-gic.c
>>
>> diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
>> deleted file mode 100644
>> index 9b63829cf929..000000000000
>> --- a/arch/mips/kernel/smp-gic.c
>> +++ /dev/null
>> @@ -1,66 +0,0 @@
>> -/*
>> - * Copyright (C) 2013 Imagination Technologies
>> - * Author: Paul Burton <paul.burton@imgtec.com>
>> - *
>> - * Based on smp-cmp.c:
>> - *  Copyright (C) 2007 MIPS Technologies, Inc.
>> - *  Author: Chris Dearman (chris@mips.com)
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of the GNU General Public License as published by the
>> - * Free Software Foundation;  either version 2 of the  License, or (at your
>> - * option) any later version.
>> - */
>> -
>> -#include <linux/irqchip/mips-gic.h>
>> -#include <linux/printk.h>
>> -
>> -#include <asm/mips-cpc.h>
>> -#include <asm/smp-ops.h>
>> -
>> -void gic_send_ipi_single(int cpu, unsigned int action)
>> -{
>> -	unsigned long flags;
>> -	unsigned int intr;
>> -	unsigned int core = cpu_data[cpu].core;
>> -
>> -	pr_debug("CPU%d: %s cpu %d action %u status %08x\n",
>> -		 smp_processor_id(), __func__, cpu, action, read_c0_status());
>> -
>> -	local_irq_save(flags);
>> -
>> -	switch (action) {
>> -	case SMP_CALL_FUNCTION:
>> -		intr = plat_ipi_call_int_xlate(cpu);
>> -		break;
>> -
>> -	case SMP_RESCHEDULE_YOURSELF:
>> -		intr = plat_ipi_resched_int_xlate(cpu);
>> -		break;
>> -
>> -	default:
>> -		BUG();
>> -	}
>> -
>> -	gic_send_ipi(intr);
>> -
>> -	if (mips_cpc_present() && (core != current_cpu_data.core)) {
>> -		while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
>> -			mips_cm_lock_other(core, 0);
>> -			mips_cpc_lock_other(core);
>> -			write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
>> -			mips_cpc_unlock_other();
>> -			mips_cm_unlock_other();
>> -		}
>> -	}
> Hi Matt,
>
> This patch itself makes sense, but it does bring to light that the IPI
> IRQ domain stuff will have broken cpuidle. When a core goes into one of
> the deeper power saving states (becoming clock gated or power gated) it
> won't automatically wake back up upon interrupts, which is why the bit
> of code above exists to bring it back out of the power saving state via
> the CPC.

There is equivalent code to that removed by the IPI IRQ domain here:
http://lxr.free-electrons.com/source/arch/mips/kernel/smp.c#L185.

With a 2c2t Interaptiv, core 1 does seem to be getting clock & power gated:
# cat /sys/devices/system/cpu/cpu2/cpuidle/state2/desc
core clock gated
# cat /sys/devices/system/cpu/cpu2/cpuidle/state3/desc
core power gated
# cat /sys/devices/system/cpu/cpu2/cpuidle/state2/time
7007
# cat /sys/devices/system/cpu/cpu2/cpuidle/state3/time
300549307
# cat /sys/devices/system/cpu/cpu3/cpuidle/state2/time
8556
# cat /sys/devices/system/cpu/cpu3/cpuidle/state3/time
301527771

So I think it's all good.

Thanks,
Matt

>
> Thanks,
>      Paul
>
>> -
>> -	local_irq_restore(flags);
>> -}
>> -
>> -void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>> -{
>> -	unsigned int i;
>> -
>> -	for_each_cpu(i, mask)
>> -		gic_send_ipi_single(i, action);
>> -}
>>

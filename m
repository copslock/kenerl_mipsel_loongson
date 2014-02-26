Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2014 15:37:45 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63656 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867079AbaBZOhnKdrdh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Feb 2014 15:37:43 +0100
Received: by mail-wi0-f177.google.com with SMTP id e4so2203186wiv.4
        for <linux-mips@linux-mips.org>; Wed, 26 Feb 2014 06:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FAT17P2x+xiOfdL3/czjyCFv2v3i47iYRTiRTRSXKQE=;
        b=J8w1vNlBBQ5a7lqq25cbuacQP7dWqz3R795YwrhQfs61JIKCjpVWmg92XsMDr9BHUG
         ziBfuiQ6npRCygEuRQpntySdxlcy6ZMb6/Z3Uf0nbvbobN3T03WfKMQLgKpkYQUgfC/0
         y6cYxodP71+gFmNV6w+gorW10htCy/7fD0Mk5lzg+3BNoJMaCstYfs9u/eqGS/qrwIO4
         Dt72eNGJEFKh9f5bEYFWbf6v2GMGWXl9W50038L9E4mwcPZpdeZzECLSLPiy641QqeE1
         V77Zv6dKDou/kCzlJV+llCrWLo+5z5uSzIv6SpmzgG12IAzJXBUJaWVpThBErO9jKAVh
         q3Nw==
X-Gm-Message-State: ALoCoQkP38NG/fPpCUnAhazR/8Uc+kGZl6GSw3OxDQ0kRvdk5szKLcr60pedI6Zeq+4yATnBIKES
X-Received: by 10.194.62.206 with SMTP id a14mr2885288wjs.26.1393425457623;
        Wed, 26 Feb 2014 06:37:37 -0800 (PST)
Received: from [192.168.1.150] (AToulouse-654-1-393-198.w90-55.abo.wanadoo.fr. [90.55.192.198])
        by mx.google.com with ESMTPSA id u6sm10711097wif.6.2014.02.26.06.37.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 06:37:36 -0800 (PST)
Message-ID: <530DFC33.1090609@linaro.org>
Date:   Wed, 26 Feb 2014 15:37:39 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/10] cpuidle: cpuidle driver for MIPS CPS
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-11-git-send-email-paul.burton@imgtec.com> <530CB7DA.7060305@linaro.org> <20140225221200.GP25765@pburton-linux.le.imgtec.org>
In-Reply-To: <20140225221200.GP25765@pburton-linux.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 02/25/2014 11:12 PM, Paul Burton wrote:
> On Tue, Feb 25, 2014 at 04:33:46PM +0100, Daniel Lezcano wrote:
>> On 01/15/2014 02:55 PM, Paul Burton wrote:
>>> This patch introduces a cpuidle driver implementation for the MIPS
>>> Coherent Processing System (ie. Coherence Manager, Cluster Power
>>> Controller). It allows for use of the following idle states:
>>>
>>>   - Coherent wait. This is the usual MIPS wait instruction.
>>>
>>>   - Non-coherent wait. In this state a core will disable coherency with
>>>     the rest of the system before running the wait instruction. This
>>>     eliminates coherence interventions which would typically be used to
>>>     keep cores coherent.
>>>
>>> These two states lay the groundwork for deeper states to be implemented
>>> later, since all deeper states require the core to become non-coherent.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> ---
>>>   drivers/cpuidle/Kconfig            |   5 +
>>>   drivers/cpuidle/Kconfig.mips       |  14 +
>>>   drivers/cpuidle/Makefile           |   3 +
>>>   drivers/cpuidle/cpuidle-mips-cps.c | 545 +++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 567 insertions(+)
>>>   create mode 100644 drivers/cpuidle/Kconfig.mips
>>>   create mode 100644 drivers/cpuidle/cpuidle-mips-cps.c
>>>
>>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>>> index b3fb81d..11ff281 100644
>>> --- a/drivers/cpuidle/Kconfig
>>> +++ b/drivers/cpuidle/Kconfig
>>> @@ -35,6 +35,11 @@ depends on ARM
>>>   source "drivers/cpuidle/Kconfig.arm"
>>>   endmenu
>>>
>>> +menu "MIPS CPU Idle Drivers"
>>> +depends on MIPS
>>> +source "drivers/cpuidle/Kconfig.mips"
>>> +endmenu
>>> +
>>>   endif
>>>
>>>   config ARCH_NEEDS_CPU_IDLE_COUPLED
>>> diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
>>> new file mode 100644
>>> index 0000000..dc96691
>>> --- /dev/null
>>> +++ b/drivers/cpuidle/Kconfig.mips
>>> @@ -0,0 +1,14 @@
>>> +#
>>> +# MIPS CPU Idle drivers
>>> +#
>>> +
>>> +config MIPS_CPS_CPUIDLE
>>> +	bool "Support for MIPS Coherent Processing Systems"
>>> +	depends on SYS_SUPPORTS_MIPS_CPS && CPU_MIPSR2 && !MIPS_MT_SMTC
>>> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
>>> +	select MIPS_CM
>>> +	help
>>> +	  Select this option to enable CPU idle driver for systems based
>>> +	  around the MIPS Coherent Processing System architecture - that
>>> +	  is, those with a Coherence Manager & optionally a Cluster
>>> +	  Power Controller.
>>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>>> index 527be28..693cd95 100644
>>> --- a/drivers/cpuidle/Makefile
>>> +++ b/drivers/cpuidle/Makefile
>>> @@ -13,3 +13,6 @@ obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
>>>   obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>>>   obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>>>   obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>>> +
>>> +# MIPS SoC drivers
>>> +obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-mips-cps.o
>>> diff --git a/drivers/cpuidle/cpuidle-mips-cps.c b/drivers/cpuidle/cpuidle-mips-cps.c
>>> new file mode 100644
>>> index 0000000..a78bfb4
>>> --- /dev/null
>>> +++ b/drivers/cpuidle/cpuidle-mips-cps.c
>>> @@ -0,0 +1,545 @@
>>> +/*
>>> + * Copyright (C) 2013 Imagination Technologies
>>> + * Author: Paul Burton <paul.burton@imgtec.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License as published by the
>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>> + * option) any later version.
>>> + */
>>> +
>>> +#include <linux/cpuidle.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kconfig.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <asm/cacheflush.h>
>>> +#include <asm/cacheops.h>
>>> +#include <asm/idle.h>
>>> +#include <asm/mips-cm.h>
>>> +#include <asm/mipsmtregs.h>
>>> +#include <asm/uasm.h>
>>
>> The convention is to not include headers from arch. These headers shouldn't
>> appear in this driver.
>>
>
> Without accessing those headers I can't really implement anything useful
> - entering these idle states by their nature involves architecture
> specifics. Would you rather the bulk of the driver is implemented under
> arch/mips & the code in drivers/cpuidle simply calls elsewhere to do the
> real work?

Usually, this is how it is done. If you can move the 'asm' code inside 
eg. pm.c somewhere in arch/mips and invoke from pm functions from 
cpuidle through a simple header that would be great.

>>> +/*
>>> + * The CM & CPC can only handle coherence & power control on a per-core basis,
>>> + * thus in an MT system the VPEs within each core are coupled and can only
>>> + * enter or exit states requiring CM or CPC assistance in unison.
>>> + */
>>> +#ifdef CONFIG_MIPS_MT
>>> +# define coupled_coherence cpu_has_mipsmt
>>> +#else
>>> +# define coupled_coherence 0
>>> +#endif
>>> +
>>> +/*
>>> + * cps_nc_entry_fn - type of a generated non-coherent state entry function
>>> + * @vpe_mask: a bitmap of online coupled VPEs, excluding this one
>>> + * @online: the count of online coupled VPEs (weight of vpe_mask + 1)
>>> + *
>>> + * The code entering & exiting non-coherent states is generated at runtime
>>> + * using uasm, in order to ensure that the compiler cannot insert a stray
>>> + * memory access at an unfortunate time and to allow the generation of optimal
>>> + * core-specific code particularly for cache routines. If coupled_coherence
>>> + * is non-zero, returns the number of VPEs that were in the wait state at the
>>> + * point this VPE left it. Returns garbage if coupled_coherence is zero.
>>> + */
>>> +typedef unsigned (*cps_nc_entry_fn)(unsigned vpe_mask, unsigned online);
>>> +
>>> +/*
>>> + * The entry point of the generated non-coherent wait entry/exit function.
>>> + * Actually per-core rather than per-CPU.
>>> + */
>>> +static DEFINE_PER_CPU_READ_MOSTLY(cps_nc_entry_fn, ncwait_asm_enter);
>>> +
>>> +/*
>>> + * Indicates the number of coupled VPEs ready to operate in a non-coherent
>>> + * state. Actually per-core rather than per-CPU.
>>> + */
>>> +static DEFINE_PER_CPU_ALIGNED(u32, nc_ready_count);
>>> +
>>> +/* A somewhat arbitrary number of labels & relocs for uasm */
>>> +static struct uasm_label labels[32] __initdata;
>>> +static struct uasm_reloc relocs[32] __initdata;
>>> +
>>> +/* CPU dependant sync types */
>>> +static unsigned stype_intervention;
>>> +static unsigned stype_memory;
>>> +static unsigned stype_ordering;
>>> +
>>> +enum mips_reg {
>>> +	zero, at, v0, v1, a0, a1, a2, a3,
>>> +	t0, t1, t2, t3, t4, t5, t6, t7,
>>> +	s0, s1, s2, s3, s4, s5, s6, s7,
>>> +	t8, t9, k0, k1, gp, sp, fp, ra,
>>> +};
>>> +
>>> +static int cps_ncwait_enter(struct cpuidle_device *dev,
>>> +			    struct cpuidle_driver *drv, int index)
>>> +{
>>> +	unsigned core = cpu_data[dev->cpu].core;
>>> +	unsigned online, first_cpu, num_left;
>>> +	cpumask_var_t coupled_mask, vpe_mask;
>>> +
>>> +	if (!alloc_cpumask_var(&coupled_mask, GFP_KERNEL))
>>> +		return -ENOMEM;
>>> +
>>> +	if (!alloc_cpumask_var(&vpe_mask, GFP_KERNEL)) {
>>> +		free_cpumask_var(coupled_mask);
>>> +		return -ENOMEM;
>>> +	}
>>
>> You can't do that in this function where the local irqs are disabled. IMO,
>> if you set CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_ATOMIC_SLEEP, you should
>> see a kernel warning.
>
> Right you are, it should either use GFP_ATOMIC or just not handle the
> off-stack case (which isn't currently used).

Why don't you just allocate these cpumasks at init time instead of 
allocating / freeing them in the fast path ?

>>> +	/* Calculate which coupled CPUs (VPEs) are online */
>>> +#ifdef CONFIG_MIPS_MT
>>> +	cpumask_and(coupled_mask, cpu_online_mask, &dev->coupled_cpus);
>>> +	first_cpu = cpumask_first(coupled_mask);
>>> +	online = cpumask_weight(coupled_mask);
>>> +	cpumask_clear_cpu(dev->cpu, coupled_mask);
>>> +	cpumask_shift_right(vpe_mask, coupled_mask,
>>> +			    cpumask_first(&dev->coupled_cpus));
>>
>> What is the purpose of this computation ?
>
> If you read through the code generated in cps_gen_entry_code, the
> vpe_mask is used to indicate the VPEs within the current core which are
> both online & not the VPE currently running the code.

Ok, thanks for the clarification.

Shouldn't 'online = cpumask_weight(coupled_mask)' be after clearing the 
current cpu ? Otherwise, online has also the current cpu which, IIUC, 
shouldn't be included, no ?

>>> +#else
>>> +	cpumask_clear(coupled_mask);
>>> +	cpumask_clear(vpe_mask);
>>> +	first_cpu = dev->cpu;
>>> +	online = 1;
>>> +#endif
>>
>> first_cpu is not used.
>
> Right you are. It's used in further work-in-progress patches but I'll
> remove it from this one.
>
>>
>>> +	/*
>>> +	 * Run the generated entry code. Note that we assume the number of VPEs
>>> +	 * within this core does not exceed the width in bits of a long. Since
>>> +	 * MVPConf0.PVPE is 4 bits wide this seems like a safe assumption.
>>> +	 */
>>> +	num_left = per_cpu(ncwait_asm_enter, core)(vpe_mask->bits[0], online);
>>> +
>>> +	/*
>>> +	 * If this VPE is the first to leave the non-coherent wait state then
>>> +	 * it needs to wake up any coupled VPEs still running their wait
>>> +	 * instruction so that they return to cpuidle,
>>
>> Why is it needed ? Can't the other cpus stay idle ?
>
> Not with the current cpuidle code. Please see the end of
> cpuidle_enter_state_coupled in drivers/cpuidle/coupled.c. The code waits
> for all coupled CPUs to exit the idle state before any of them proceed.
> Whilst I suppose it would be possible to modify cpuidle to not require
> that, it would leave you with inaccurate residence statistics mentioned
> below.
>
>>
>>>        * which can then complete
>>> +	 * coordination between the coupled VPEs & provide the governor with
>>> +	 * a chance to reflect on the length of time the VPEs were in the
>>> +	 * idle state.
>>> +	 */
>>> +	if (coupled_coherence && (num_left == online))
>>> +		arch_send_call_function_ipi_mask(coupled_mask);
>>
>> Except there is no choice due to hardware limitations, I don't think this is
>> valid.
>
> By nature when one CPU (VPE) within a core leaves a non-coherent state
> the rest do too, because as I mentioned coherence is a property of the
> core not of individual VPEs. It would be possible to leave the other
> VPEs idle if we didn't differentiate between the coherent & non-coherent
> wait states, but again not with cpuidle as it is today (due to the
> waiting for all CPUs at the end of cpuidle_enter_state_coupled).

[ ... ]

>>> +
>>> +	/*
>>> +	 * Set the coupled flag on the appropriate states if this system
>>> +	 * requires it.
>>> +	 */
>>> +	if (coupled_coherence)
>>> +		for (i = 1; i < cps_driver.state_count; i++)
>>> +			cps_driver.states[i].flags |= CPUIDLE_FLAG_COUPLED;
>>
>> I am not sure CPUIDLE_FLAG_COUPLED is the solution for this driver. IIUC,
>> with the IPI above and the wakeup sync with the couple states, this driver
>> is waking up everybody instead of sleeping as much as possible.
>>
>> I would recommend to have a look at a different approach, like the one used
>> for cpuidle-ux500.c.
>
> Ok it looks like that just counts & performs work only on the last
> online CPU to run the code.

Yes, the last-man-standing approach. Usually, the couple idle states are 
used when the processors need to do some extra work or only the cpu0 can 
invoke PM routine for security reason.

In your case, IIUC, we don't care who will call the PM routine and if a 
cpu wakes up, the other ones (read the VPEs belonging to the same core), 
can stay idle until an interrupt occurs.

> As before that could work but only by
> disregarding any differentiation between coherent & non-coherent wait
> states at levels above the driver.

May be you can use the arch private flags for the idle states to 
differentiate coherent or non-coherent wait states ? Or alternatively 
create two drivers and register the right one.

>> --
>>   <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

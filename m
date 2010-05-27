Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:33:30 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:51500 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492392Ab0E0Wd0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:33:26 +0200
Received: by pxi1 with SMTP id 1so268632pxi.36
        for <multiple recipients>; Thu, 27 May 2010 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2DjhAcI3nnR5IKarVc3IPV9KMwvv9wUc6F+6pU+oYO4=;
        b=WBpjtn+DQcOEb110kvb67qodItHJYthpWCjs3GtdGpHh/TBAv0wLihBtEDK486Fde0
         9nHbc3X53rPX23p+4Y2Ky9GkF6dJr+An4zLNVOgd7jqGgS8eC7oV+g4QDMbXgQn0hg5G
         gDsMsQWM07HvRkVSuG1Dz45RnOn9VLXd0H15g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=b0izcHww0G2kUyPpuvtwmCAl7dTsWRWkbjwPZuaM4vyTBduSYe7GjAUefFC33dFifL
         MM1sYmowkTgv8gP4RmHhv2XpA83WoPhDMHMctLb7LKEtBVd+1vAjhKfz1WeVqtMxGDYk
         +/fgrSd4T909YDwwekt5WR7bPsnBxINcvMado=
Received: by 10.142.210.15 with SMTP id i15mr424482wfg.256.1274999598347;
        Thu, 27 May 2010 15:33:18 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id y27sm949704wfi.17.2010.05.27.15.33.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 15:33:17 -0700 (PDT)
Message-ID: <4BFEF327.2020701@gmail.com>
Date:   Thu, 27 May 2010 15:33:11 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 04/12] MIPS: add support for hardware performance events
 (skeleton)
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-5-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-5-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> This patch provides the skeleton of the HW perf event support. To enable
> this feature, we can not choose the SMTC kernel; Oprofile should be
> disabled; kernel performance events be selected. Then we can enable it in
> Kernel type menu.
>
> Oprofile for MIPS platforms initializes irq at arch init time. Currently
> we do not change this logic to allow PMU reservation.
>
> If a platform has EIC, we can use the irq base and perf counter irq
> offset defines for the interrupt controller in mipspmu_get_irq().
>
> Based on this skeleton patch, the 3 different kinds of MIPS PMU, namely,
> mipsxx/loongson2/rm9000, can be supported by adding corresponding lower
> level C files at the bottom. The suggested names of these files are
> perf_event_mipsxx.c/perf_event_loongson2.c/perf_event_rm9000.c. So, for
> example, we can do this by adding "#include perf_event_mipsxx.c" at the
> bottom of perf_event.c.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/Kconfig                  |    8 +
>   arch/mips/include/asm/perf_event.h |   28 ++
>   arch/mips/kernel/Makefile          |    2 +
>   arch/mips/kernel/perf_event.c      |  503 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 541 insertions(+), 0 deletions(-)
>   create mode 100644 arch/mips/include/asm/perf_event.h
>   create mode 100644 arch/mips/kernel/perf_event.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 1bccfe5..27577b4 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1888,6 +1888,14 @@ config NODES_SHIFT
>   	default "6"
>   	depends on NEED_MULTIPLE_NODES
>
> +config HW_PERF_EVENTS
> +	bool "Enable hardware performance counter support for perf events"
> +	depends on PERF_EVENTS&&  !MIPS_MT_SMTC&&  OPROFILE=n&&  CPU_MIPS32


This depends on not consistent with the #if conditions in [01/12] for 
pmu.h.  They should be I think.

Probably removing the tests from pmu.h and encoding them here is better.


> +	default y
> +	help
> +	  Enable hardware performance counter support for perf events. If
> +	  disabled, perf events will use software events only.
> +
>   source "mm/Kconfig"
>
>   config SMP
> diff --git a/arch/mips/include/asm/perf_event.h b/arch/mips/include/asm/perf_event.h
> new file mode 100644
> index 0000000..bcf54bc
> --- /dev/null
> +++ b/arch/mips/include/asm/perf_event.h
> @@ -0,0 +1,28 @@
> +/*
> + * linux/arch/mips/include/asm/perf_event.h
> + *
> + * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu

IANAL, but who holds the copyright?  You or MTI ?



> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __MIPS_PERF_EVENT_H__
> +#define __MIPS_PERF_EVENT_H__
> +
> +extern int (*perf_irq)(void);
> +

This shadows the declaration in asm/time.h.  Declare it in exactly one 
place please.


[...]
> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> new file mode 100644
> index 0000000..788815f
> --- /dev/null
> +++ b/arch/mips/kernel/perf_event.c
> @@ -0,0 +1,503 @@
> +/*
> + * Linux performance counter support for MIPS.
> + *
> + * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
> + *

Same thing about the copyright.


> + * This code is based on the implementation for ARM, which is in turn
> + * based on the sparc64 perf event code and the x86 code. Performance
> + * counter access is based on the MIPS Oprofile code.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include<linux/cpumask.h>
> +#include<linux/interrupt.h>
> +#include<linux/smp.h>
> +#include<linux/kernel.h>
> +#include<linux/perf_event.h>
> +#include<linux/uaccess.h>
> +
> +#include<asm/irq.h>
> +#include<asm/irq_regs.h>
> +#include<asm/stacktrace.h>
> +#include<asm/pmu.h>
> +
> +
> +#define MAX_PERIOD ((1ULL<<  32) - 1)
> +
> +struct cpu_hw_events {
> +	/* Array of events on this cpu. */
> +	struct perf_event	*events[MIPS_MAX_HWEVENTS];
> +
> +	/*
> +	 * Set the bit (indexed by the counter number) when the counter
> +	 * is used for an event.
> +	 */
> +	unsigned long		used_mask[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
> +
> +	/*
> +	 * The borrowed MSB for the performance counter. A MIPS performance
> +	 * counter uses its bit 31 as a factor of determining whether a counter

Not quite true.  They use the high bit, that can be either 31 or 63 
depending on the width of the counters.


[...]
> +
> +struct mips_pmu {
> +	const char	*name;
> +	irqreturn_t	(*handle_irq)(int irq, void *dev);
> +	int		(*handle_shared_irq)(void);
> +	void		(*start)(void);
> +	void		(*stop)(void);
> +	int		(*alloc_counter)(struct cpu_hw_events *cpuc,
> +					struct hw_perf_event *hwc);
> +	unsigned int	(*read_counter)(unsigned int idx);
> +	void		(*write_counter)(unsigned int idx, unsigned int val);

Counters can be 64-bits wide, unsigned int is only 32-bits wide.


[...]

David Daney

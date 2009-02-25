Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2009 17:00:20 +0000 (GMT)
Received: from wa4ehsobe001.messaging.microsoft.com ([216.32.181.11]:49356
	"EHLO WA4EHSOBE001.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20808545AbZBYRAQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Feb 2009 17:00:16 +0000
Received: from mail187-wa4-R.bigfish.com (10.8.14.249) by
 WA4EHSOBE001.bigfish.com (10.8.40.21) with Microsoft SMTP Server id
 8.1.340.0; Wed, 25 Feb 2009 17:00:07 +0000
Received: from mail187-wa4 (localhost.localdomain [127.0.0.1])	by
 mail187-wa4-R.bigfish.com (Postfix) with ESMTP id 63239108382;	Wed, 25 Feb
 2009 17:00:08 +0000 (UTC)
X-BigFish: VPS-72(zz709fM1432R62a3L98dR936eQ1805M936fK8d0R655O13ddRzzzzz32i6bh62h)
X-FB-SS: 5,
Received: by mail187-wa4 (MessageSwitch) id 1235581205889666_9387; Wed, 25 Feb
 2009 17:00:05 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail187-wa4.bigfish.com (Postfix) with
 ESMTP id A31251310058;	Wed, 25 Feb 2009 17:00:05 +0000 (UTC)
Received: from ausb3twp01.amd.com (ausb3twp01.amd.com [163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 n1PGxwN1020942;	Wed, 25 Feb 2009 11:00:03 -0600
X-WSS-ID: 0KFMSJP-01-2R8-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2BCD41944F7;
	Wed, 25 Feb 2009 10:59:48 -0600 (CST)
Received: from sausexmb5.amd.com ([163.181.49.129]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 25 Feb 2009 10:59:56 -0600
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by sausexmb5.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 25 Feb 2009 10:59:56 -0600
Received: from seurexmb1.amd.com ([165.204.82.130]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 25 Feb 2009 17:59:54 +0100
Received: from erda.amd.com ([165.204.85.17]) by seurexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 25 Feb 2009 17:59:53 +0100
Received: by erda.amd.com (Postfix, from userid 35569)	id 909B17FF9; Wed, 25
 Feb 2009 17:59:53 +0100 (CET)
Date:	Wed, 25 Feb 2009 17:59:53 +0100
From:	Robert Richter <robert.richter@amd.com>
To:	Mark Asselstine <mark.asselstine@windriver.com>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH] oprofile: VR5500 performance counter driver
Message-ID: <20090225165953.GF25042@erda.amd.com>
References: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 25 Feb 2009 16:59:53.0683 (UTC) FILETIME=[7AA68230:01C9976A]
Return-Path: <robert.richter@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips

On 23.02.09 11:26:34, Mark Asselstine wrote:
> This is inspired by op_model_mipsxx.c with some modification
> in regards to register layout and overflow handling. This has
> been tested on a NEC VR5500 board and shown to produce sane
> results.

Mark,

I have looked at the differences between the VR5500 code and the
generic in op_model_mipsxx.c. If I am not wrong, only the interrupt
handling is different. This affects only vr5500_reg_setup() and
vr5500_perfcount_handler(). I think it would be better to implement
cpu checks in the generic functions or remap to cpu specific functions
during mipsxx_init(). This extension of the generic code is much more
maintainable. Also, there is less code in the end. See also my
comments below.

-Robert

> 
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> 
> diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
> index cfd4b60..977a828 100644
> --- a/arch/mips/oprofile/Makefile
> +++ b/arch/mips/oprofile/Makefile
> @@ -14,4 +14,5 @@ oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
>  oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
>  oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
>  oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
> +oprofile-$(CONFIG_CPU_VR5500)		+= op_model_vr5500.o

I could not find a Kconfig option for this.

>  oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
> diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
> index e1bffab..68aad99 100644
> --- a/arch/mips/oprofile/common.c
> +++ b/arch/mips/oprofile/common.c
> @@ -17,6 +17,7 @@
>  
>  extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
>  extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
> +extern struct op_mips_model op_model_vr5500_ops __attribute__((weak));
>  
>  static struct op_mips_model *model;
>  
> @@ -94,6 +95,10 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
>  	case CPU_RM9000:
>  		lmodel = &op_model_rm9000_ops;
>  		break;
> +
> +	case CPU_R5500:
> +		lmodel = &op_model_vr5500_ops;
> +		break;

Is there a reason for using _vr5500_ instead of _r5500_ for the
function and the filename?

>  	};
>  
>  
> diff --git a/arch/mips/oprofile/op_model_vr5500.c b/arch/mips/oprofile/op_model_vr5500.c
> new file mode 100644
> index 0000000..75fae6a
> --- /dev/null
> +++ b/arch/mips/oprofile/op_model_vr5500.c
> @@ -0,0 +1,179 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *

Copyright statements from op_model_mipsxx.c should be added here.

> + * Copyright (c) 2009 Wind River Systems, Inc.
> + */
> +#include <linux/cpumask.h>
> +#include <linux/oprofile.h>
> +#include <linux/interrupt.h>
> +#include <linux/smp.h>
> +#include <asm/irq_regs.h>
> +
> +#include "op_impl.h"
> +
> +#define M_PERFCTL_EXL			(1UL      <<  0)
> +#define M_PERFCTL_KERNEL		(1UL      <<  1)
> +#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
> +#define M_PERFCTL_USER			(1UL      <<  3)
> +#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
> +#define M_PERFCTL_INTERRUPT		(1UL      <<  5)
> +#define M_PERFCTL_EVENT(event)		(((event) & 0xf)  << 6)
> +#define M_PERFCTL_COUNT_ENABLE		(1UL      <<  10)
> +
> +#define NUM_COUNTERS                    2
> +
> +static int (*save_perf_irq) (void);
> +
> +#define __define_perf_accessors(r, n)    				\
> +									\
> +	static inline unsigned int r_c0_ ## r ## n(void)		\
> +	{								\
> +		return read_c0_ ## r ## n();				\
> +	}								\
> +									\
> +	static inline void w_c0_ ## r ## n(unsigned int value)		\
> +	{								\
> +		write_c0_ ## r ## n(value);				\
> +	}								\
> +
> +__define_perf_accessors(perfcntr, 0)
> +__define_perf_accessors(perfcntr, 1)
> +
> +__define_perf_accessors(perfctrl, 0)
> +__define_perf_accessors(perfctrl, 1)

I know this code is borrowed, but why not use write/read_c0_perfXXXX()
directly?

> +
> +struct op_mips_model op_model_vr5500_ops;
> +
> +static struct vr5500_register_config {
> +	unsigned int control[NUM_COUNTERS];
> +	unsigned int counter[NUM_COUNTERS];
> +} reg;
> +
> +/* Compute all of the registers in preparation for enabling profiling.  */
> +static void vr5500_reg_setup(struct op_counter_config *ctr)
> +{
> +	int i;
> +	unsigned int counters = NUM_COUNTERS;
> +
> +	/* Compute the performance counter control word.  */
> +	for (i = 0; i < counters; i++) {
> +		reg.control[i] = 0;
> +		reg.counter[i] = 0;
> +
> +		if (!ctr[i].enabled)
> +			continue;
> +
> +		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
> +		    M_PERFCTL_INTERRUPT_ENABLE | M_PERFCTL_COUNT_ENABLE;
> +		if (ctr[i].kernel)
> +			reg.control[i] |= M_PERFCTL_KERNEL;
> +		if (ctr[i].user)
> +			reg.control[i] |= M_PERFCTL_USER;
> +		if (ctr[i].exl)
> +			reg.control[i] |= M_PERFCTL_EXL;
> +
> +		reg.counter[i] = 0xffffffff - ctr[i].count + 1;
> +	}
> +}
> +
> +/* Program all of the registers in preparation for enabling profiling.  */
> +static void vr5500_cpu_setup(void *args)
> +{
> +	w_c0_perfctrl1(0);
> +	w_c0_perfcntr1(reg.counter[1]);
> +
> +	w_c0_perfctrl0(0);
> +	w_c0_perfcntr0(reg.counter[0]);
> +}
> +
> +/* Start all counters on current CPU */
> +static void vr5500_cpu_start(void *args)
> +{
> +	w_c0_perfctrl1(reg.control[1]);
> +	w_c0_perfctrl0(reg.control[0]);
> +}
> +
> +/* Stop all counters on current CPU */
> +static void vr5500_cpu_stop(void *args)
> +{
> +	w_c0_perfctrl1(0);
> +	w_c0_perfctrl0(0);
> +}
> +
> +static int vr5500_perfcount_handler(void)
> +{
> +	unsigned int control;
> +	unsigned int counter;
> +	int handled = IRQ_NONE;
> +	unsigned int counters = NUM_COUNTERS;
> +
> +	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))

Do not use magic numbers.

> +		return handled;
> +
> +	switch (counters) {

Since counters is a fix value the switch/case could be removed.

> +	#define HANDLE_COUNTER(n) 					\
> +	case n + 1:							\
> +		control = r_c0_perfctrl ## n();				\
> +		counter = r_c0_perfcntr ## n();				\
> +		if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&		\
> +			(control & M_PERFCTL_INTERRUPT)) {		\
> +			oprofile_add_sample(get_irq_regs(), n);		\
> +			w_c0_perfcntr ## n(reg.counter[n]);		\
> +			w_c0_perfctrl ## n(control & ~M_PERFCTL_INTERRUPT); \
> +			handled = IRQ_HANDLED;				\
> +		}
> +	HANDLE_COUNTER(1)
> +	HANDLE_COUNTER(0)
> +	}

It is hard to see a loop here. I would like to prefer programming c
instead of macros unless there is a good reason to do so. Also, this
causes a checkpatch error.

> +
> +	return handled;
> +}
> +
> +static void reset_counters(void *arg)
> +{
> +	w_c0_perfctrl1(0);
> +	w_c0_perfcntr1(0);
> +
> +	w_c0_perfctrl0(0);
> +	w_c0_perfcntr0(0);
> +}
> +
> +static int __init vr5500_init(void)
> +{
> +	on_each_cpu(reset_counters, NULL, 1);
> +
> +	switch (current_cpu_type()) {
> +	case CPU_R5500:
> +		op_model_vr5500_ops.cpu_type = "mips/vr5500";
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "Profiling unsupported for this CPU\n");
> +
> +		return -ENODEV;
> +	}
> +
> +	save_perf_irq = perf_irq;
> +	perf_irq = vr5500_perfcount_handler;
> +
> +	return 0;
> +}
> +
> +static void vr5500_exit(void)
> +{
> +	on_each_cpu(reset_counters, NULL, 1);
> +
> +	perf_irq = save_perf_irq;
> +}
> +
> +struct op_mips_model op_model_vr5500_ops = {
> +	.reg_setup = vr5500_reg_setup,
> +	.cpu_setup = vr5500_cpu_setup,
> +	.init = vr5500_init,
> +	.exit = vr5500_exit,
> +	.cpu_start = vr5500_cpu_start,
> +	.cpu_stop = vr5500_cpu_stop,
> +	.num_counters = NUM_COUNTERS,

Please align this vertically.

> +};
> 
> ------------------------------------------------------------------------------
> Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
> -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
> -Strategies to boost innovation and cut costs with open source participation
> -Receive a $600 discount off the registration fee with the source code: SFAD
> http://p.sf.net/sfu/XcvMzF8H
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
> 

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com

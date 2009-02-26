Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 16:31:01 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:47773 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20808060AbZBZQa6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2009 16:30:58 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n1QGUp7q015116;
	Thu, 26 Feb 2009 08:30:51 -0800 (PST)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 26 Feb 2009 08:30:50 -0800
Received: from yow-masselst-d1.localnet ([128.224.146.23]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 26 Feb 2009 08:30:49 -0800
From:	"M. Asselstine" <Mark.Asselstine@windriver.com>
Organization: Wind River Systems Inc.
To:	Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH] oprofile: VR5500 performance counter driver
Date:	Thu, 26 Feb 2009 11:30:48 -0500
User-Agent: KMail/1.11.0 (Linux/2.6.27-9-generic; KDE/4.2.0; x86_64; ; )
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	oprofile-list@lists.sf.net
References: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com> <20090225165953.GF25042@erda.amd.com>
In-Reply-To: <20090225165953.GF25042@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902261130.48307.Mark.Asselstine@windriver.com>
X-OriginalArrivalTime: 26 Feb 2009 16:30:49.0571 (UTC) FILETIME=[957DE330:01C9982F]
Return-Path: <Mark.Asselstine@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mark.Asselstine@windriver.com
Precedence: bulk
X-list: linux-mips

On Wednesday 25 February 2009, Robert Richter wrote:
> On 23.02.09 11:26:34, Mark Asselstine wrote:
> > This is inspired by op_model_mipsxx.c with some modification
> > in regards to register layout and overflow handling. This has
> > been tested on a NEC VR5500 board and shown to produce sane
> > results.
>
> Mark,
>
> I have looked at the differences between the VR5500 code and the
> generic in op_model_mipsxx.c. If I am not wrong, only the interrupt
> handling is different. This affects only vr5500_reg_setup() and
> vr5500_perfcount_handler(). I think it would be better to implement
> cpu checks in the generic functions or remap to cpu specific functions
> during mipsxx_init(). This extension of the generic code is much more
> maintainable. Also, there is less code in the end. See also my
> comments below.
>

I had original thought the same thing but found there was enough deviation 
leaving me to create the new file. In addition to what you point out the 
register layout is also different so I was ending up having to make use of 
some CPU specific ifdefs which made for ugly code. As well the CPU does not 
implement MIPS32 nor MIPS64 so didn't necessarily fall under mipsxx (weak 
yes). It might make sense to name the file to be more generic and cover other 
NEC MIPS CPUs. Anyways I will have another look and see if it can be done 
nicely.

> -Robert
>
> > Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> >
> > diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
> > index cfd4b60..977a828 100644
> > --- a/arch/mips/oprofile/Makefile
> > +++ b/arch/mips/oprofile/Makefile
> > @@ -14,4 +14,5 @@ oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
> >  oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
> >  oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
> >  oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
> > +oprofile-$(CONFIG_CPU_VR5500)		+= op_model_vr5500.o
>
> I could not find a Kconfig option for this.
>

Sorry, was working from another tree that had a patch pulling this config in, 
it is in fact CONFIG_CPU_R5500 as seen in mainline. I will correct this.

> >  oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
> > diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
> > index e1bffab..68aad99 100644
> > --- a/arch/mips/oprofile/common.c
> > +++ b/arch/mips/oprofile/common.c
> > @@ -17,6 +17,7 @@
> >
> >  extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
> >  extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
> > +extern struct op_mips_model op_model_vr5500_ops __attribute__((weak));
> >
> >  static struct op_mips_model *model;
> >
> > @@ -94,6 +95,10 @@ int __init oprofile_arch_init(struct
> > oprofile_operations *ops) case CPU_RM9000:
> >  		lmodel = &op_model_rm9000_ops;
> >  		break;
> > +
> > +	case CPU_R5500:
> > +		lmodel = &op_model_vr5500_ops;
> > +		break;
>
> Is there a reason for using _vr5500_ instead of _r5500_ for the
> function and the filename?
>

If I keep this as a new file I will change to _r5500_ as suggested.

> >  	};
> >
> >
> > diff --git a/arch/mips/oprofile/op_model_vr5500.c
> > b/arch/mips/oprofile/op_model_vr5500.c new file mode 100644
> > index 0000000..75fae6a
> > --- /dev/null
> > +++ b/arch/mips/oprofile/op_model_vr5500.c
> > @@ -0,0 +1,179 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General
> > Public + * License.  See the file "COPYING" in the main directory of this
> > archive + * for more details.
> > + *
>
> Copyright statements from op_model_mipsxx.c should be added here.
>

I will ask Ralf if he want to have his carried over, but will carry the MIPS 
copyright if it makes legal sense.

> > + * Copyright (c) 2009 Wind River Systems, Inc.
> > + */
> > +#include <linux/cpumask.h>
> > +#include <linux/oprofile.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/smp.h>
> > +#include <asm/irq_regs.h>
> > +
> > +#include "op_impl.h"
> > +
> > +#define M_PERFCTL_EXL			(1UL      <<  0)
> > +#define M_PERFCTL_KERNEL		(1UL      <<  1)
> > +#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
> > +#define M_PERFCTL_USER			(1UL      <<  3)
> > +#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
> > +#define M_PERFCTL_INTERRUPT		(1UL      <<  5)
> > +#define M_PERFCTL_EVENT(event)		(((event) & 0xf)  << 6)
> > +#define M_PERFCTL_COUNT_ENABLE		(1UL      <<  10)
> > +
> > +#define NUM_COUNTERS                    2
> > +
> > +static int (*save_perf_irq) (void);
> > +
> > +#define __define_perf_accessors(r, n)    				\
> > +									\
> > +	static inline unsigned int r_c0_ ## r ## n(void)		\
> > +	{								\
> > +		return read_c0_ ## r ## n();				\
> > +	}								\
> > +									\
> > +	static inline void w_c0_ ## r ## n(unsigned int value)		\
> > +	{								\
> > +		write_c0_ ## r ## n(value);				\
> > +	}								\
> > +
> > +__define_perf_accessors(perfcntr, 0)
> > +__define_perf_accessors(perfcntr, 1)
> > +
> > +__define_perf_accessors(perfctrl, 0)
> > +__define_perf_accessors(perfctrl, 1)
>
> I know this code is borrowed, but why not use write/read_c0_perfXXXX()
> directly?
>

Sure, will change.

> > +
> > +struct op_mips_model op_model_vr5500_ops;
> > +
> > +static struct vr5500_register_config {
> > +	unsigned int control[NUM_COUNTERS];
> > +	unsigned int counter[NUM_COUNTERS];
> > +} reg;
> > +
> > +/* Compute all of the registers in preparation for enabling profiling. 
> > */ +static void vr5500_reg_setup(struct op_counter_config *ctr)
> > +{
> > +	int i;
> > +	unsigned int counters = NUM_COUNTERS;
> > +
> > +	/* Compute the performance counter control word.  */
> > +	for (i = 0; i < counters; i++) {
> > +		reg.control[i] = 0;
> > +		reg.counter[i] = 0;
> > +
> > +		if (!ctr[i].enabled)
> > +			continue;
> > +
> > +		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
> > +		    M_PERFCTL_INTERRUPT_ENABLE | M_PERFCTL_COUNT_ENABLE;
> > +		if (ctr[i].kernel)
> > +			reg.control[i] |= M_PERFCTL_KERNEL;
> > +		if (ctr[i].user)
> > +			reg.control[i] |= M_PERFCTL_USER;
> > +		if (ctr[i].exl)
> > +			reg.control[i] |= M_PERFCTL_EXL;
> > +
> > +		reg.counter[i] = 0xffffffff - ctr[i].count + 1;
> > +	}
> > +}
> > +
> > +/* Program all of the registers in preparation for enabling profiling. 
> > */ +static void vr5500_cpu_setup(void *args)
> > +{
> > +	w_c0_perfctrl1(0);
> > +	w_c0_perfcntr1(reg.counter[1]);
> > +
> > +	w_c0_perfctrl0(0);
> > +	w_c0_perfcntr0(reg.counter[0]);
> > +}
> > +
> > +/* Start all counters on current CPU */
> > +static void vr5500_cpu_start(void *args)
> > +{
> > +	w_c0_perfctrl1(reg.control[1]);
> > +	w_c0_perfctrl0(reg.control[0]);
> > +}
> > +
> > +/* Stop all counters on current CPU */
> > +static void vr5500_cpu_stop(void *args)
> > +{
> > +	w_c0_perfctrl1(0);
> > +	w_c0_perfctrl0(0);
> > +}
> > +
> > +static int vr5500_perfcount_handler(void)
> > +{
> > +	unsigned int control;
> > +	unsigned int counter;
> > +	int handled = IRQ_NONE;
> > +	unsigned int counters = NUM_COUNTERS;
> > +
> > +	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
>
> Do not use magic numbers.
>

A comment will be added or a well named define.

> > +		return handled;
> > +
> > +	switch (counters) {
>
> Since counters is a fix value the switch/case could be removed.
>
> > +	#define HANDLE_COUNTER(n) 					\
> > +	case n + 1:							\
> > +		control = r_c0_perfctrl ## n();				\
> > +		counter = r_c0_perfcntr ## n();				\
> > +		if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&		\
> > +			(control & M_PERFCTL_INTERRUPT)) {		\
> > +			oprofile_add_sample(get_irq_regs(), n);		\
> > +			w_c0_perfcntr ## n(reg.counter[n]);		\
> > +			w_c0_perfctrl ## n(control & ~M_PERFCTL_INTERRUPT); \
> > +			handled = IRQ_HANDLED;				\
> > +		}
> > +	HANDLE_COUNTER(1)
> > +	HANDLE_COUNTER(0)
> > +	}
>
> It is hard to see a loop here. I would like to prefer programming c
> instead of macros unless there is a good reason to do so. Also, this
> causes a checkpatch error.
>

I will look to get rid of the macros, you don't have to ask me twice.

> > +
> > +	return handled;
> > +}
> > +
> > +static void reset_counters(void *arg)
> > +{
> > +	w_c0_perfctrl1(0);
> > +	w_c0_perfcntr1(0);
> > +
> > +	w_c0_perfctrl0(0);
> > +	w_c0_perfcntr0(0);
> > +}
> > +
> > +static int __init vr5500_init(void)
> > +{
> > +	on_each_cpu(reset_counters, NULL, 1);
> > +
> > +	switch (current_cpu_type()) {
> > +	case CPU_R5500:
> > +		op_model_vr5500_ops.cpu_type = "mips/vr5500";
> > +		break;
> > +
> > +	default:
> > +		printk(KERN_ERR "Profiling unsupported for this CPU\n");
> > +
> > +		return -ENODEV;
> > +	}
> > +
> > +	save_perf_irq = perf_irq;
> > +	perf_irq = vr5500_perfcount_handler;
> > +
> > +	return 0;
> > +}
> > +
> > +static void vr5500_exit(void)
> > +{
> > +	on_each_cpu(reset_counters, NULL, 1);
> > +
> > +	perf_irq = save_perf_irq;
> > +}
> > +
> > +struct op_mips_model op_model_vr5500_ops = {
> > +	.reg_setup = vr5500_reg_setup,
> > +	.cpu_setup = vr5500_cpu_setup,
> > +	.init = vr5500_init,
> > +	.exit = vr5500_exit,
> > +	.cpu_start = vr5500_cpu_start,
> > +	.cpu_stop = vr5500_cpu_stop,
> > +	.num_counters = NUM_COUNTERS,
>
> Please align this vertically.
>

Sure.

Expect a resend soon.

Regards,
Mark

> > +};
> >
> > -------------------------------------------------------------------------
> >----- Open Source Business Conference (OSBC), March 24-25, 2009, San
> > Francisco, CA -OSBC tackles the biggest issue in open source: Open
> > Sourcing the Enterprise -Strategies to boost innovation and cut costs
> > with open source participation -Receive a $600 discount off the
> > registration fee with the source code: SFAD http://p.sf.net/sfu/XcvMzF8H
> > _______________________________________________
> > oprofile-list mailing list
> > oprofile-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/oprofile-list

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 17:53:19 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:51653 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S21365662AbZCDRxQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2009 17:53:16 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n24Hr5IP023894;
	Wed, 4 Mar 2009 09:53:06 -0800 (PST)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 4 Mar 2009 09:53:04 -0800
Received: from yow-masselst-d1.localnet ([128.224.146.23]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 4 Mar 2009 09:53:04 -0800
From:	"M. Asselstine" <Mark.Asselstine@windriver.com>
Organization: Wind River Systems Inc.
To:	Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH V2] oprofile: VR5500 performance counter driver
Date:	Wed, 4 Mar 2009 12:53:03 -0500
User-Agent: KMail/1.11.0 (Linux/2.6.27-9-generic; KDE/4.2.0; x86_64; ; )
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	oprofile-list@lists.sf.net
References: <20090225165953.GF25042@erda.amd.com> <1235681374-19952-1-git-send-email-mark.asselstine@windriver.com> <20090303110755.GD10085@erda.amd.com>
In-Reply-To: <20090303110755.GD10085@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903041253.03682.Mark.Asselstine@windriver.com>
X-OriginalArrivalTime: 04 Mar 2009 17:53:04.0648 (UTC) FILETIME=[11816080:01C99CF2]
Return-Path: <Mark.Asselstine@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mark.Asselstine@windriver.com
Precedence: bulk
X-list: linux-mips

On Tuesday 03 March 2009, Robert Richter wrote:
> On 26.02.09 15:49:34, Mark Asselstine wrote:
> > This is inspired by op_model_mipsxx.c with some modification
> > in regards to register layout and overflow handling. This has
> > been tested on a NEC VR5500 board and shown to produce sane
> > results.
> >
> > Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> > ---
> >
> > I have left this as a new file as there is enough differences
> > to make combining it combersome. If pushed I would possibly
> > change my mind but I am not convinced yet. The userspace
> > events are seen as mips/vr5500 so if there is a desire to
> > have everything be r5500 some userspace changes would need
> > to be made.
> >
> >  arch/mips/oprofile/Makefile         |    1 +
> >  arch/mips/oprofile/common.c         |    5 +
> >  arch/mips/oprofile/op_model_r5500.c |  161
> > +++++++++++++++++++++++++++++++++++
>
> Mark,
>
> the Kconfig option for CONFIG_CPU_R5500 is still missing otherwise the
> patch itself looks fine.
>

Hmmm, what tree are you looking at? I see it in Linus' tree as well as Ralf's 
.29 RCs and master.

Mark

> Ralf,
>
> do you agree on introducing a separate file for this cpu model?
> Please ack.
>
> Thanks,
>
> -Robert
>
> >  3 files changed, 167 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/oprofile/op_model_r5500.c
> >
> > diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
> > index bf3be6f..586e64e 100644
> > --- a/arch/mips/oprofile/Makefile
> > +++ b/arch/mips/oprofile/Makefile
> > @@ -14,4 +14,5 @@ oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
> >  oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
> >  oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
> >  oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
> > +oprofile-$(CONFIG_CPU_R5500)		+= op_model_r5500.o
> >  oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
> > diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
> > index 3bf3354..26780c7 100644
> > --- a/arch/mips/oprofile/common.c
> > +++ b/arch/mips/oprofile/common.c
> > @@ -16,6 +16,7 @@
> >
> >  extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
> >  extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
> > +extern struct op_mips_model op_model_r5500_ops __attribute__((weak));
> >
> >  static struct op_mips_model *model;
> >
> > @@ -93,6 +94,10 @@ int __init oprofile_arch_init(struct
> > oprofile_operations *ops) case CPU_RM9000:
> >  		lmodel = &op_model_rm9000_ops;
> >  		break;
> > +
> > +	case CPU_R5500:
> > +		lmodel = &op_model_r5500_ops;
> > +		break;
> >  	};
> >
> >  	if (!lmodel)
> > diff --git a/arch/mips/oprofile/op_model_r5500.c
> > b/arch/mips/oprofile/op_model_r5500.c new file mode 100644
> > index 0000000..9b0d20f
> > --- /dev/null
> > +++ b/arch/mips/oprofile/op_model_r5500.c
> > @@ -0,0 +1,161 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General
> > Public + * License.  See the file "COPYING" in the main directory of this
> > archive + * for more details.
> > + *
> > + * Copyright (c) 2009 Wind River Systems, Inc.
> > + *
> > + * Derived from op_model_mipsxx.c Copyright Ralf Baechle, MIPS
> > Technologies Inc + */
> > +#include <linux/oprofile.h>
> > +#include <linux/interrupt.h>
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
> > +struct op_mips_model op_model_r5500_ops;
> > +
> > +static struct r5500_register_config {
> > +	unsigned int control[NUM_COUNTERS];
> > +	unsigned int counter[NUM_COUNTERS];
> > +} reg;
> > +
> > +/* Compute all of the registers in preparation for enabling profiling. 
> > */ +static void r5500_reg_setup(struct op_counter_config *ctr)
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
> > */ +static void r5500_cpu_setup(void *args)
> > +{
> > +	write_c0_perfctrl1(0);
> > +	write_c0_perfcntr1(reg.counter[1]);
> > +
> > +	write_c0_perfctrl0(0);
> > +	write_c0_perfcntr0(reg.counter[0]);
> > +}
> > +
> > +/* Start all counters on current CPU */
> > +static void r5500_cpu_start(void *args)
> > +{
> > +	write_c0_perfctrl1(reg.control[1]);
> > +	write_c0_perfctrl0(reg.control[0]);
> > +}
> > +
> > +/* Stop all counters on current CPU */
> > +static void r5500_cpu_stop(void *args)
> > +{
> > +	write_c0_perfctrl1(0);
> > +	write_c0_perfctrl0(0);
> > +}
> > +
> > +static int r5500_perfcount_handler(void)
> > +{
> > +	unsigned int control;
> > +	unsigned int counter;
> > +	int handled = IRQ_NONE;
> > +
> > +	control = read_c0_perfctrl0();
> > +	counter = read_c0_perfcntr0();
> > +	if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&
> > +			(control & M_PERFCTL_INTERRUPT)) {
> > +		oprofile_add_sample(get_irq_regs(), 0);
> > +		write_c0_perfcntr0(reg.counter[0]);
> > +		write_c0_perfctrl0(control & ~M_PERFCTL_INTERRUPT);
> > +		handled = IRQ_HANDLED;
> > +	}
> > +
> > +	control = read_c0_perfctrl1();
> > +	counter = read_c0_perfcntr1();
> > +	if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&
> > +			(control & M_PERFCTL_INTERRUPT)) {
> > +		oprofile_add_sample(get_irq_regs(), 1);
> > +		write_c0_perfcntr1(reg.counter[1]);
> > +		write_c0_perfctrl1(control & ~M_PERFCTL_INTERRUPT);
> > +		handled = IRQ_HANDLED;
> > +	}
> > +
> > +	return handled;
> > +}
> > +
> > +static void reset_counters(void *arg)
> > +{
> > +	write_c0_perfctrl1(0);
> > +	write_c0_perfcntr1(0);
> > +
> > +	write_c0_perfctrl0(0);
> > +	write_c0_perfcntr0(0);
> > +}
> > +
> > +static int __init r5500_init(void)
> > +{
> > +	on_each_cpu(reset_counters, NULL, 1);
> > +
> > +	switch (current_cpu_type()) {
> > +	case CPU_R5500:
> > +		op_model_r5500_ops.cpu_type = "mips/vr5500";
> > +		break;
> > +
> > +	default:
> > +		printk(KERN_ERR "Profiling unsupported for this CPU\n");
> > +
> > +		return -ENODEV;
> > +	}
> > +
> > +	save_perf_irq = perf_irq;
> > +	perf_irq = r5500_perfcount_handler;
> > +
> > +	return 0;
> > +}
> > +
> > +static void r5500_exit(void)
> > +{
> > +	on_each_cpu(reset_counters, NULL, 1);
> > +
> > +	perf_irq = save_perf_irq;
> > +}
> > +
> > +struct op_mips_model op_model_r5500_ops = {
> > +	.reg_setup     = r5500_reg_setup,
> > +	.cpu_setup     = r5500_cpu_setup,
> > +	.init          = r5500_init,
> > +	.exit          = r5500_exit,
> > +	.cpu_start     = r5500_cpu_start,
> > +	.cpu_stop      = r5500_cpu_stop,
> > +	.num_counters  = NUM_COUNTERS,
> > +};
> > --
> > 1.6.0.3
> >
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

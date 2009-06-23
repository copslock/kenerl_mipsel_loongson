Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2009 11:32:33 +0200 (CEST)
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:61508 "EHLO
	IE1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492222AbZFWJc1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jun 2009 11:32:27 +0200
Received: from mail141-dub-R.bigfish.com (10.5.252.3) by
 IE1EHSOBE005.bigfish.com (10.5.252.25) with Microsoft SMTP Server id
 8.1.340.0; Tue, 23 Jun 2009 09:29:17 +0000
Received: from mail141-dub (localhost.localdomain [127.0.0.1])	by
 mail141-dub-R.bigfish.com (Postfix) with ESMTP id 1A14145018D;	Tue, 23 Jun
 2009 09:29:17 +0000 (UTC)
X-SpamScore: -60
X-BigFish: VPS-60(zz709fM1432R98dR936eN4015L1805M62a3L8d0K655N13ddRzz1202hzzz32i6bh17ch43j61h)
Received: by mail141-dub (MessageSwitch) id 1245749355188395_23879; Tue, 23
 Jun 2009 09:29:15 +0000 (UCT)
Received: from svlb1extmailp02.amd.com (unknown [139.95.251.11])	(using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate
 requested)	by mail141-dub.bigfish.com (Postfix) with ESMTP id 4027C1B7804F;
	Tue, 23 Jun 2009 09:29:13 +0000 (UTC)
Received: from svlb1twp01.amd.com ([139.95.250.34])	by svlb1extmailp02.amd.com
 (Switch-3.2.7/Switch-3.2.7) with ESMTP id n5N9T3sV005396;	Tue, 23 Jun 2009
 02:29:07 -0700
X-WSS-ID: 0KLOQCG-03-9A2-01
Received: from SSVLEXBH1.amd.com (ssvlexbh1.amd.com [139.95.53.182])	by
 svlb1twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 273E2884944;
	Tue, 23 Jun 2009 02:29:04 -0700 (PDT)
Received: from ssvlexmb2.amd.com ([139.95.53.7]) by SSVLEXBH1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 23 Jun 2009 02:29:07 -0700
Received: from SF36EXMB1.amd.com ([172.19.4.24]) by ssvlexmb2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 23 Jun 2009 02:29:06 -0700
Received: from seurexmb1.amd.com ([165.204.9.130]) by SF36EXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 23 Jun 2009 11:29:03 +0200
Received: from erda.amd.com ([165.204.15.17]) by seurexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 23 Jun 2009 11:29:03 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id 695C5800D; Tue, 23
 Jun 2009 11:29:02 +0200 (CEST)
Date:	Tue, 23 Jun 2009 11:29:01 +0200
From:	Robert Richter <robert.richter@amd.com>
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Mark Asselstine <mark.asselstine@windriver.com>,
	linux-mips@linux-mips.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH V2] oprofile: VR5500 performance counter driver
Message-ID: <20090623092901.GC18016@erda.amd.com>
References: <20090225165953.GF25042@erda.amd.com> <1235681374-19952-1-git-send-email-mark.asselstine@windriver.com> <20090303110755.GD10085@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20090303110755.GD10085@erda.amd.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 23 Jun 2009 09:29:03.0213 (UTC) FILETIME=[0C0ED9D0:01C9F3E5]
Return-Path: <robert.richter@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@amd.com
Precedence: bulk
X-list: linux-mips

On 03.03.09 12:07:55, Robert Richter wrote:
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
> >  arch/mips/oprofile/op_model_r5500.c |  161 +++++++++++++++++++++++++++++++++++
> 
> 
> Mark,
> 
> the Kconfig option for CONFIG_CPU_R5500 is still missing otherwise the
> patch itself looks fine.
> 
> Ralf,
> 
> do you agree on introducing a separate file for this cpu model?
> Please ack.

Ralf,

I still have this patch in my queue. Do you have any opinions here?
op_model_r5500.c is very similar to op_model_mipsxx.c, it partly
introduces duplicate code.

Thanks,

-Robert

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
> > @@ -93,6 +94,10 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
> >  	case CPU_RM9000:
> >  		lmodel = &op_model_rm9000_ops;
> >  		break;
> > +
> > +	case CPU_R5500:
> > +		lmodel = &op_model_r5500_ops;
> > +		break;
> >  	};
> >  
> >  	if (!lmodel)
> > diff --git a/arch/mips/oprofile/op_model_r5500.c b/arch/mips/oprofile/op_model_r5500.c
> > new file mode 100644
> > index 0000000..9b0d20f
> > --- /dev/null
> > +++ b/arch/mips/oprofile/op_model_r5500.c
> > @@ -0,0 +1,161 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (c) 2009 Wind River Systems, Inc.
> > + *
> > + * Derived from op_model_mipsxx.c Copyright Ralf Baechle, MIPS Technologies Inc
> > + */
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
> > +/* Compute all of the registers in preparation for enabling profiling.  */
> > +static void r5500_reg_setup(struct op_counter_config *ctr)
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
> > +/* Program all of the registers in preparation for enabling profiling.  */
> > +static void r5500_cpu_setup(void *args)
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
> > ------------------------------------------------------------------------------
> > Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
> > -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
> > -Strategies to boost innovation and cut costs with open source participation
> > -Receive a $600 discount off the registration fee with the source code: SFAD
> > http://p.sf.net/sfu/XcvMzF8H
> > _______________________________________________
> > oprofile-list mailing list
> > oprofile-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/oprofile-list
> > 
> 
> -- 
> Advanced Micro Devices, Inc.
> Operating System Research Center
> email: robert.richter@amd.com

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com

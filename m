Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 09:44:47 +0100 (CET)
Received: from mx2.mail.elte.hu ([157.181.151.9]:53063 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492444AbZKWIok (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 09:44:40 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1NCUX4-0008HR-5P
	from <mingo@elte.hu>; Mon, 23 Nov 2009 09:44:29 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E23E03E22E1; Mon, 23 Nov 2009 09:44:22 +0100 (CET)
Date:	Mon, 23 Nov 2009 09:44:23 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
Message-ID: <20091123084423.GB23635@elte.hu>
References: <b08d39e76685878bc91d9de906d155f1daa1c985.1258894783.git.wuzhangjin@gmail.com>
 <4B098AE4.6090804@ru.mvista.com>
 <1258938035.2411.6.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258938035.2411.6.camel@falcon.domain.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-2.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> On Sun, 2009-11-22 at 22:03 +0300, Sergei Shtylyov wrote:
> > Hello.
> > 
> > Wu Zhangjin wrote:
> > 
> > > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > >
> > > (This v3 revision incorporates with the feedbacks from Ingo, Ralf and Sergei.)
> > >
> > > This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> > > which provides high resolution. and also, one new kernel option
> > > (HR_SCHED_CLOCK) is added to enable/disable this sched_clock().
> > >
> > > Without it, the Ftrace for MIPS will give useless timestamp information.
> > >
> > > Because cnt32_to_63() needs to be called at least once per half period
> > > to work properly, Differ from the old version, this v2 revision set up a
> > > kernel timer to ensure the requirement of some MIPSs which have short c0
> > > count period.
> > >
> > > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > > ---
> > >  arch/mips/Kconfig           |   18 ++++++++++++++
> > >  arch/mips/kernel/csrc-r4k.c |   55 +++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 73 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index b342197..5ea55f5 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -1952,6 +1952,24 @@ config NR_CPUS
> > >  source "kernel/time/Kconfig"
> > >  
> > >  #
> > > +# High Resolution sched_clock() Configuration
> > > +#
> > > +
> > > +config HR_SCHED_CLOCK
> > > +	bool "High Resolution sched_clock()"
> > > +	depends on CSRC_R4K
> > > +	default n
> > > +	help
> > > +	  This option enables the MIPS c0 count based high resolution
> > > +	  sched_clock().
> > > +
> > > +	  If you need a ns precision timestamp, you are recommended to enable
> > > +	  this option. For example, If you are using the Ftrace subsystem to do
> > > +	  real time tracing, this option is needed.
> > > +
> > > +	  If unsure, disable it.
> > > +
> > > +#
> > >  # Timer Interrupt Frequency Configuration
> > >  #
> > >  
> > > diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> > > index e95a3cd..e287f0d 100644
> > > --- a/arch/mips/kernel/csrc-r4k.c
> > > +++ b/arch/mips/kernel/csrc-r4k.c
> > > @@ -10,6 +10,57 @@
> > >  
> > >  #include <asm/time.h>
> > >  
> > > +#ifdef CONFIG_HR_SCHED_CLOCK
> > > +#include <linux/cnt32_to_63.h>
> > > +#include <linux/timer.h>
> > > +
> > > +/*
> > > + * MIPS sched_clock implementation.
> > > + *
> > > + * because cnt32_to_63() needs to be called at least once per half period to
> > > + * work properly, and some of the MIPS frequency is high, perhaps a kernel
> > > + * timer is needed to be set up to ensure this requirement is always met.
> > > + * Please refer to arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
> > > + */
> > > +static unsigned long __read_mostly tclk2ns_scale;
> > > +static unsigned long __read_mostly tclk2ns_scale_factor;
> > > +
> > > +unsigned long long notrace sched_clock(void)
> > > +{
> > > +	unsigned long long v = cnt32_to_63(read_c0_count());
> > > +	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
> > > +}
> > > +
> > > +static struct timer_list cnt32_to_63_keepwarm_timer;
> > > +
> > > +static void cnt32_to_63_keepwarm(unsigned long data)
> > > +{
> > > +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> > > +	(void) sched_clock();
> > > +}
> > > +
> > > +static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)
> > > +{
> > > +	unsigned long long v;
> > > +	unsigned long data;
> > > +
> > > +	v = cs->mult;
> > > +	/*
> > > +	 * We want an even value to automatically clear the top bit
> > > +	 * returned by cnt32_to_63() without an additional run time
> > > +	 * instruction. So if the LSB is 1 then round it up.
> > > +	 */
> > > +	if (v & 1)
> > > +		v++;
> > > +	tclk2ns_scale = v;
> > > +	tclk2ns_scale_factor = cs->shift;
> > > +
> > > +	data = 0x80000000 / tclk * HZ;
> > > +	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
> > > +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> > > +}
> > > +#endif	/* !CONFIG_HR_SCHED_CLOCK */
> > > +
> > >  static cycle_t c0_hpt_read(struct clocksource *cs)
> > >  {
> > >  	return read_c0_count();
> > > @@ -32,6 +83,10 @@ int __init init_r4k_clocksource(void)
> > >  
> > >  	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
> > >  
> > > +#ifdef CONFIG_HR_SCHED_CLOCK
> > > +	setup_sched_clock(&clocksource_mips, mips_hpt_frequency);
> > > +#endif
> > > +
> > >   
> > 
> >    According to CodingStyle #ifdef's in the code are frowned upon. I 
> > suggest that you add an empty setup_sched_clock() definition under #else 
> > above and have the call here without #ifdef. That's the preferred way of 
> > doing such things...
> > 
> 
> Done, thanks!
> 
> Wil resend it later.

The proper solution would be what i suggested in my previous mail: to 
put it into a separate .c file. It's easy as the code has its own 
Kconfig value already. The only #ifdef is out of sight in a .h file.

	Ingo

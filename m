Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 09:14:40 +0100 (CET)
Received: from mx2.mail.elte.hu ([157.181.151.9]:40644 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492378AbZKWIOe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 09:14:34 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1NCU44-00042P-Hx
	from <mingo@elte.hu>; Mon, 23 Nov 2009 09:14:30 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 181F73E22E1; Mon, 23 Nov 2009 09:14:23 +0100 (CET)
Date:	Mon, 23 Nov 2009 09:14:23 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org
Subject: Re: [PATCH v4] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
Message-ID: <20091123081423.GA13186@elte.hu>
References: <34211a03cdfc6f0bcadd94c939ae0237c99ef6e5.1258939222.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34211a03cdfc6f0bcadd94c939ae0237c99ef6e5.1258939222.git.wuzhangjin@gmail.com>
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
X-archive-position: 25047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> (This v4 revision incorporates with the feedbacks from Sergei.)
> 
> This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> which provides high resolution. and also, one new kernel option
> (HR_SCHED_CLOCK) is added to enable/disable this sched_clock().
> 
> Without it, the Ftrace for MIPS will give useless timestamp information.
> 
> Because cnt32_to_63() needs to be called at least once per half period
> to work properly, Differ from the old version, this v2 revision set up a
> kernel timer to ensure the requirement of some MIPSs which have short c0
> count period.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Kconfig           |   18 +++++++++++++
>  arch/mips/kernel/csrc-r4k.c |   57 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 0 deletions(-)

Looks good in general, just a few small nits:

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b342197..5ea55f5 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1952,6 +1952,24 @@ config NR_CPUS
>  source "kernel/time/Kconfig"
>  
>  #
> +# High Resolution sched_clock() Configuration
> +#
> +
> +config HR_SCHED_CLOCK
> +	bool "High Resolution sched_clock()"
> +	depends on CSRC_R4K
> +	default n
> +	help
> +	  This option enables the MIPS c0 count based high resolution
> +	  sched_clock().
> +
> +	  If you need a ns precision timestamp, you are recommended to enable
> +	  this option. For example, If you are using the Ftrace subsystem to do

s/If/if

> +	  real time tracing, this option is needed.
> +
> +	  If unsure, disable it.
> +
> +#
>  # Timer Interrupt Frequency Configuration
>  #
>  
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index e95a3cd..7762c95 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -10,6 +10,61 @@
>  
>  #include <asm/time.h>
>  
> +#ifdef CONFIG_HR_SCHED_CLOCK
> +#include <linux/cnt32_to_63.h>
> +#include <linux/timer.h>
> +
> +/*
> + * MIPS sched_clock implementation.
> + *
> + * because cnt32_to_63() needs to be called at least once per half period to
> + * work properly, and some of the MIPS frequency is high, perhaps a kernel
> + * timer is needed to be set up to ensure this requirement is always met.
> + * Please refer to arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
> + */
> +static unsigned long __read_mostly tclk2ns_scale;
> +static unsigned long __read_mostly tclk2ns_scale_factor;
> +
> +unsigned long long notrace sched_clock(void)
> +{
> +	unsigned long long v = cnt32_to_63(read_c0_count());
> +	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
> +}
> +
> +static struct timer_list cnt32_to_63_keepwarm_timer;
> +
> +static void cnt32_to_63_keepwarm(unsigned long data)
> +{
> +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> +	(void) sched_clock();

sched_clock() isnt __must_check so the cast of the return value seems 
unnecessary.

> +}
> +
> +static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)
> +{
> +	unsigned long long v;
> +	unsigned long data;
> +
> +	v = cs->mult;
> +	/*
> +	 * We want an even value to automatically clear the top bit
> +	 * returned by cnt32_to_63() without an additional run time
> +	 * instruction. So if the LSB is 1 then round it up.
> +	 */
> +	if (v & 1)
> +		v++;
> +	tclk2ns_scale = v;
> +	tclk2ns_scale_factor = cs->shift;
> +
> +	data = 0x80000000 / tclk * HZ;
> +	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
> +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> +}
> +#else	/* !CONFIG_HR_SCHED_CLOCK */
> +static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)
> +{
> +}
> +#endif

Could this be put into a new, separate file, 
arch/mips/kernel/csrc-r4k-hres.c, to avoid the ugly #ifdef block?

> +
>  static cycle_t c0_hpt_read(struct clocksource *cs)
>  {
>  	return read_c0_count();
> @@ -32,6 +87,8 @@ int __init init_r4k_clocksource(void)
>  
>  	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
>  
> +	setup_sched_clock(&clocksource_mips, mips_hpt_frequency);

And i'd suggest to rename it to setup_hres_sched_clock() - as i presume 
this system has a sched_clock() even if CONFIG_HR_SCHED_CLOCK is 
disabled.

Thanks,

	Ingo

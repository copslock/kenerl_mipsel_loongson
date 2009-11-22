Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 20:03:37 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:26848 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1492870AbZKVTDa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 20:03:30 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id B3DCF3EC9; Sun, 22 Nov 2009 11:03:13 -0800 (PST)
Message-ID: <4B098AE4.6090804@ru.mvista.com>
Date:	Sun, 22 Nov 2009 22:03:00 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
References: <b08d39e76685878bc91d9de906d155f1daa1c985.1258894783.git.wuzhangjin@gmail.com>
In-Reply-To: <b08d39e76685878bc91d9de906d155f1daa1c985.1258894783.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
>
> (This v3 revision incorporates with the feedbacks from Ingo, Ralf and Sergei.)
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
>  arch/mips/Kconfig           |   18 ++++++++++++++
>  arch/mips/kernel/csrc-r4k.c |   55 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 0 deletions(-)
>
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
> +	  real time tracing, this option is needed.
> +
> +	  If unsure, disable it.
> +
> +#
>  # Timer Interrupt Frequency Configuration
>  #
>  
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index e95a3cd..e287f0d 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -10,6 +10,57 @@
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
> +#endif	/* !CONFIG_HR_SCHED_CLOCK */
> +
>  static cycle_t c0_hpt_read(struct clocksource *cs)
>  {
>  	return read_c0_count();
> @@ -32,6 +83,10 @@ int __init init_r4k_clocksource(void)
>  
>  	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
>  
> +#ifdef CONFIG_HR_SCHED_CLOCK
> +	setup_sched_clock(&clocksource_mips, mips_hpt_frequency);
> +#endif
> +
>   

   According to CodingStyle #ifdef's in the code are frowned upon. I 
suggest that you add an empty setup_sched_clock() definition under #else 
above and have the call here without #ifdef. That's the preferred way of 
doing such things...

WBR, Sergei

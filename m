Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 17:39:49 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:4136 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20023343AbYG2Qjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 17:39:42 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 29 Jul 2008 16:39:33 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 29 Jul 2008 11:39:37 -0500
Subject: Re: [PATCH 7/8] Alchemy: split core PM code from sysctl parts.
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080723175549.GH5986@roarinelk.homelinux.net>
References: <20080723174557.GA5986@roarinelk.homelinux.net>
	 <20080723175549.GH5986@roarinelk.homelinux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 29 Jul 2008 11:39:23 -0500
Message-Id: <1217349563.20884.0.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Manuel,

I'm trying to test/evaluate these patches on my DB1200 system, but this
one no longer applies.  power.c was updated about 90 minutes after you
sent these out.  Can you resend #7 relative to the current HEAD?

Thanks,
Kevin

On Wed, 2008-07-23 at 19:55 +0200, Manuel Lauss wrote:
> The Alchemy power.c file contains both core suspend/resume code, which
> is processor specific, and leftovers of the 2.4 PM userspace interface
> (sysctls).
> 
> This patch moves the userspace interface to the platform.c file and
> leaves the core board-independent suspend/resume parts which should be
> usable for all Alchemy-based systems intact.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  arch/mips/au1000/common/platform.c |  305 ++++++++++++++++++++++++++++++++++-
>  arch/mips/au1000/common/power.c    |  318 +-----------------------------------
>  2 files changed, 306 insertions(+), 317 deletions(-)
> 
> diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
> index 66d6770..0874593 100644
> --- a/arch/mips/au1000/common/platform.c
> +++ b/arch/mips/au1000/common/platform.c
> @@ -6,6 +6,9 @@
>   * (C) Copyright Embedded Alley Solutions, Inc 2005
>   * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
>   *
> + *  Some of the routines are right out of init/main.c, whose
> + *  copyrights apply here.
> + *
>   * This file is licensed under the terms of the GNU General Public
>   * License version 2.  This program is licensed "as is" without any
>   * warranty of any kind, whether express or implied.
> @@ -19,7 +22,12 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_8250.h>
> -#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm.h>
> +#include <linux/pm_legacy.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysctl.h>
> +#include <linux/uaccess.h>
>  
>  #include <asm/mach-au1x00/au1xxx.h>
>  
> @@ -322,3 +330,298 @@ static int __init au1xxx_platform_init(void)
>  }
>  
>  arch_initcall(au1xxx_platform_init);
> +
> +
> +/*********************************************************************/
> +
> +
> +#ifdef CONFIG_PM
> +
> +static DEFINE_SPINLOCK(pm_lock);
> +
> +extern unsigned long save_local_and_disable(int controller);
> +extern void restore_local_and_enable(int controller, unsigned long mask);
> +extern void local_enable_irq(unsigned int irq_nr);
> +extern void au_sleep(void);
> +
> +/*
> + * Define this to cause the value you write to /proc/sys/pm/sleep to
> + * set the TOY timer for the amount of time you want to sleep.
> + * This is done mainly for testing, but may be useful in other cases.
> + * The value is number of 32KHz ticks to sleep.
> + */
> +#define SLEEP_TEST_TIMEOUT 1
> +#ifdef	SLEEP_TEST_TIMEOUT
> +static int sleep_ticks;
> +static void wakeup_counter0_set(int ticks)
> +{
> +	au_writel(au_readl(SYS_TOYREAD) + ticks, SYS_TOYMATCH2);
> +	au_sync();
> +}
> +#endif
> +
> +static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
> +		       void __user *buffer, size_t *len, loff_t *ppos)
> +{
> +	unsigned long wakeup, flags;
> +#ifdef SLEEP_TEST_TIMEOUT
> +#define TMPBUFLEN2 16
> +	char buf[TMPBUFLEN2], *p;
> +#endif
> +
> +	spin_lock_irqsave(&pm_lock, flags);
> +
> +	if (!write) {
> +		*len = 0;
> +		spin_unlock_irqrestore(&pm_lock, flags);
> +		return 0;
> +	}
> +
> +#ifdef SLEEP_TEST_TIMEOUT
> +	if (*len > TMPBUFLEN2 - 1)
> +		return -EFAULT;
> +	if (copy_from_user(buf, buffer, *len))
> +		return -EFAULT;
> +	buf[*len] = 0;
> +	p = buf;
> +	sleep_ticks = simple_strtoul(p, &p, 0);
> +#endif
> +
> +	/**
> +	 ** The code below is all system dependent and we should probably
> +	 ** have a function call out of here to set this up.  You need
> +	 ** to configure the GPIO or timer interrupts that will bring
> +	 ** you out of sleep.
> +	 ** For testing, the TOY counter wakeup is useful.
> +	 **/
> +#if 0
> +	au_writel(au_readl(SYS_PINSTATERD) & ~(1 << 11), SYS_PINSTATERD);
> +
> +	/* GPIO 6 can cause a wake up event */
> +	wakeup = au_readl(SYS_WAKEMSK);
> +	wakeup &= ~(1 << 8);	/* turn off match20 wakeup */
> +	wakeup |= 1 << 6;	/* turn on  GPIO  6 wakeup */
> +#else
> +	/* For testing, allow match20 to wake us up. */
> +#ifdef SLEEP_TEST_TIMEOUT
> +	wakeup_counter0_set(sleep_ticks);
> +#endif
> +	wakeup = 1 << 8;	/* turn on match20 wakeup   */
> +#endif
> +	au_writel(1, SYS_WAKESRC);	/* clear cause */
> +	au_sync();
> +	au_writel(wakeup, SYS_WAKEMSK);
> +	au_sync();
> +
> +	au_sleep();
> +
> +	spin_unlock_irqrestore(&pm_lock, flags);
> +
> +	return 0;
> +}
> +
> +/*
> + * This is the number of bits of precision for the loops_per_jiffy.
> + * Each bit takes on average 1.5/HZ seconds.  This (like the original)
> + * is a little better than 1%.
> + */
> +#define LPS_PREC 8
> +
> +static void au1000_calibrate_delay(void)
> +{
> +	unsigned long ticks, loopbit;
> +	int lps_precision = LPS_PREC;
> +
> +	loops_per_jiffy = 1 << 12;
> +
> +	while (loops_per_jiffy <<= 1) {
> +		/* Wait for "start of" clock tick */
> +		ticks = jiffies;
> +		while (ticks == jiffies)
> +			/* nothing */ ;
> +		/* Go ... */
> +		ticks = jiffies;
> +		__delay(loops_per_jiffy);
> +		ticks = jiffies - ticks;
> +		if (ticks)
> +			break;
> +	}
> +
> +	/*
> +	 * Do a binary approximation to get loops_per_jiffy set to be equal
> +	 * one clock (up to lps_precision bits)
> +	 */
> +	loops_per_jiffy >>= 1;
> +	loopbit = loops_per_jiffy;
> +	while (lps_precision-- && (loopbit >>= 1)) {
> +		loops_per_jiffy |= loopbit;
> +		ticks = jiffies;
> +		while (ticks == jiffies);
> +		ticks = jiffies;
> +		__delay(loops_per_jiffy);
> +		if (jiffies != ticks)	/* longer than 1 tick */
> +			loops_per_jiffy &= ~loopbit;
> +	}
> +}
> +
> +static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
> +		      void __user *buffer, size_t *len, loff_t *ppos)
> +{
> +	int retval = 0, i;
> +	unsigned long val, pll;
> +#define TMPBUFLEN 64
> +#define MAX_CPU_FREQ 396
> +	char buf[TMPBUFLEN], *p;
> +	unsigned long flags, intc0_mask, intc1_mask;
> +	unsigned long old_baud_base, old_cpu_freq, old_clk, old_refresh;
> +	unsigned long new_baud_base, new_cpu_freq, new_clk, new_refresh;
> +	unsigned long baud_rate;
> +
> +	spin_lock_irqsave(&pm_lock, flags);
> +	if (!write)
> +		*len = 0;
> +	else {
> +		/* Parse the new frequency */
> +		if (*len > TMPBUFLEN - 1) {
> +			spin_unlock_irqrestore(&pm_lock, flags);
> +			return -EFAULT;
> +		}
> +		if (copy_from_user(buf, buffer, *len)) {
> +			spin_unlock_irqrestore(&pm_lock, flags);
> +			return -EFAULT;
> +		}
> +		buf[*len] = 0;
> +		p = buf;
> +		val = simple_strtoul(p, &p, 0);
> +		if (val > MAX_CPU_FREQ) {
> +			spin_unlock_irqrestore(&pm_lock, flags);
> +			return -EFAULT;
> +		}
> +
> +		pll = val / 12;
> +		if ((pll > 33) || (pll < 7)) {	/* 396 MHz max, 84 MHz min */
> +			/* Revisit this for higher speed CPUs */
> +			spin_unlock_irqrestore(&pm_lock, flags);
> +			return -EFAULT;
> +		}
> +
> +		old_baud_base = get_au1x00_uart_baud_base();
> +		old_cpu_freq = get_au1x00_speed();
> +
> +		new_cpu_freq = pll * 12 * 1000000;
> +	        new_baud_base = (new_cpu_freq / (2 * ((int)(au_readl(SYS_POWERCTRL)
> +							    & 0x03) + 2) * 16));
> +		set_au1x00_speed(new_cpu_freq);
> +		set_au1x00_uart_baud_base(new_baud_base);
> +
> +		old_refresh = au_readl(MEM_SDREFCFG) & 0x1ffffff;
> +		new_refresh = ((old_refresh * new_cpu_freq) / old_cpu_freq) |
> +			      (au_readl(MEM_SDREFCFG) & ~0x1ffffff);
> +
> +		au_writel(pll, SYS_CPUPLL);
> +		au_sync_delay(1);
> +		au_writel(new_refresh, MEM_SDREFCFG);
> +		au_sync_delay(1);
> +
> +		for (i = 0; i < 4; i++)
> +			if (au_readl(UART_BASE + UART_MOD_CNTRL +
> +				     i * 0x00100000) == 3) {
> +				old_clk = au_readl(UART_BASE + UART_CLK +
> +						   i * 0x00100000);
> +				baud_rate = old_baud_base / old_clk;
> +				/*
> +				 * We won't get an exact baud rate and the error
> +				 * could be significant enough that our new
> +				 * calculation will result in a clock that will
> +				 * give us a baud rate that's too far off from
> +				 * what we really want.
> +				 */
> +				if (baud_rate > 100000)
> +					baud_rate = 115200;
> +				else if (baud_rate > 50000)
> +					baud_rate = 57600;
> +				else if (baud_rate > 30000)
> +					baud_rate = 38400;
> +				else if (baud_rate > 17000)
> +					baud_rate = 19200;
> +				else
> +					baud_rate = 9600;
> +				new_clk = new_baud_base / baud_rate;
> +				au_writel(new_clk, UART_BASE + UART_CLK +
> +					  i * 0x00100000);
> +				au_sync_delay(10);
> +			}
> +	}
> +
> +	/*
> +	 * We don't want _any_ interrupts other than match20. Otherwise our
> +	 * au1000_calibrate_delay() calculation will be off, potentially a lot.
> +	 */
> +	intc0_mask = save_local_and_disable(0);
> +	intc1_mask = save_local_and_disable(1);
> +	local_enable_irq(AU1000_TOY_MATCH2_INT);
> +	spin_unlock_irqrestore(&pm_lock, flags);
> +	au1000_calibrate_delay();
> +	restore_local_and_enable(0, intc0_mask);
> +	restore_local_and_enable(1, intc1_mask);
> +
> +	return retval;
> +}
> +
> +
> +static struct ctl_table pm_table[] = {
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "sleep",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_sleep
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "freq",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_freq
> +	},
> +	{}
> +};
> +
> +static struct ctl_table pm_dir_table[] = {
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "pm",
> +		.mode		= 0555,
> +		.child		= pm_table
> +	},
> +	{}
> +};
> +
> +/*
> + * Initialize power interface
> + */
> +static int __init pm_init(void)
> +{
> +	/* init TOY to tick at 1Hz. No need to wait for access bits
> +	 * since there's plenty of time between here and the first
> +	 * suspend cycle.
> +	 */
> +	au_writel(32767, SYS_TOYTRIM);
> +	au_writel(0, SYS_TOYWRITE);
> +	au_sync();
> +
> +	au_writel(0, SYS_WAKESRC);
> +	au_sync();
> +	au_writel(0, SYS_WAKEMSK);
> +	au_sync();
> +
> +	register_sysctl_table(pm_dir_table);
> +
> +	return 0;
> +}
> +
> +__initcall(pm_init);
> +
> +#endif	/* CONFIG_PM */
> diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
> index 0aa9522..4b0f6a1 100644
> --- a/arch/mips/au1000/common/power.c
> +++ b/arch/mips/au1000/common/power.c
> @@ -5,9 +5,6 @@
>   * Copyright 2001, 2008 MontaVista Software Inc.
>   * Author: MontaVista Software, Inc. <source@mvista.com>
>   *
> - *  Some of the routines are right out of init/main.c, whose
> - *  copyrights apply here.
> - *
>   *  This program is free software; you can redistribute	 it and/or modify it
>   *  under  the terms of	 the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the	License, or (at your
> @@ -30,31 +27,12 @@
>   */
>  
>  #include <linux/init.h>
> -#include <linux/pm.h>
> -#include <linux/pm_legacy.h>
> -#include <linux/sysctl.h>
> -#include <linux/jiffies.h>
> -
> -#include <asm/uaccess.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mach-au1x00/au1000.h>
>  
>  #ifdef CONFIG_PM
>  
> -#define DEBUG 1
> -#ifdef	DEBUG
> -#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: " fmt, __func__, ## args)
> -#else
> -#define DPRINTK(fmt, args...)
> -#endif
> -
> -static void au1000_calibrate_delay(void);
> -
> -extern unsigned long save_local_and_disable(int controller);
> -extern void restore_local_and_enable(int controller, unsigned long mask);
> -extern void local_enable_irq(unsigned int irq_nr);
> -
> -static DEFINE_SPINLOCK(pm_lock);
> +extern void save_and_sleep(void);
>  
>  /*
>   * We need to save/restore a bunch of core registers that are
> @@ -78,22 +56,6 @@ static unsigned int	sleep_usbhost_enable;
>  static unsigned int	sleep_usbdev_enable;
>  static unsigned int	sleep_static_memctlr[4][3];
>  
> -/*
> - * Define this to cause the value you write to /proc/sys/pm/sleep to
> - * set the TOY timer for the amount of time you want to sleep.
> - * This is done mainly for testing, but may be useful in other cases.
> - * The value is number of 32KHz ticks to sleep.
> - */
> -#define SLEEP_TEST_TIMEOUT 1
> -#ifdef	SLEEP_TEST_TIMEOUT
> -static int sleep_ticks;
> -static void wakeup_counter0_set(int ticks)
> -{
> -	au_writel(au_readl(SYS_TOYREAD) + ticks, SYS_TOYMATCH2);
> -	au_sync();
> -}
> -#endif
> -
>  static void save_core_regs(void)
>  {
>  	extern void save_au1xxx_intctl(void);
> @@ -191,287 +153,11 @@ static void restore_core_regs(void)
>  	restore_au1xxx_intctl();
>  }
>  
> -unsigned long suspend_mode;
> -
> -void wakeup_from_suspend(void)
> -{
> -	suspend_mode = 0;
> -}
> -
> -int au_sleep(void)
> +void au_sleep(void)
>  {
> -	unsigned long wakeup, flags;
> -	extern void save_and_sleep(void);
> -
> -	spin_lock_irqsave(&pm_lock, flags);
> -
>  	save_core_regs();
> -
>  	flush_cache_all();
> -
> -	/**
> -	 ** The code below is all system dependent and we should probably
> -	 ** have a function call out of here to set this up.  You need
> -	 ** to configure the GPIO or timer interrupts that will bring
> -	 ** you out of sleep.
> -	 ** For testing, the TOY counter wakeup is useful.
> -	 **/
> -#if 0
> -	au_writel(au_readl(SYS_PINSTATERD) & ~(1 << 11), SYS_PINSTATERD);
> -
> -	/* GPIO 6 can cause a wake up event */
> -	wakeup = au_readl(SYS_WAKEMSK);
> -	wakeup &= ~(1 << 8);	/* turn off match20 wakeup */
> -	wakeup |= 1 << 6;	/* turn on  GPIO  6 wakeup */
> -#else
> -	/* For testing, allow match20 to wake us up. */
> -#ifdef SLEEP_TEST_TIMEOUT
> -	wakeup_counter0_set(sleep_ticks);
> -#endif
> -	wakeup = 1 << 8;	/* turn on match20 wakeup   */
> -	wakeup = 0;
> -#endif
> -	au_writel(1, SYS_WAKESRC);	/* clear cause */
> -	au_sync();
> -	au_writel(wakeup, SYS_WAKEMSK);
> -	au_sync();
> -
>  	save_and_sleep();
> -
> -	/*
> -	 * After a wakeup, the cpu vectors back to 0x1fc00000, so
> -	 * it's up to the boot code to get us back here.
> -	 */
>  	restore_core_regs();
> -	spin_unlock_irqrestore(&pm_lock, flags);
> -	return 0;
> -}
> -
> -static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
> -		       void __user *buffer, size_t *len, loff_t *ppos)
> -{
> -#ifdef SLEEP_TEST_TIMEOUT
> -#define TMPBUFLEN2 16
> -	char buf[TMPBUFLEN2], *p;
> -#endif
> -
> -	if (!write)
> -		*len = 0;
> -	else {
> -#ifdef SLEEP_TEST_TIMEOUT
> -		if (*len > TMPBUFLEN2 - 1)
> -			return -EFAULT;
> -		if (copy_from_user(buf, buffer, *len))
> -			return -EFAULT;
> -		buf[*len] = 0;
> -		p = buf;
> -		sleep_ticks = simple_strtoul(p, &p, 0);
> -#endif
> -
> -		au_sleep();
> -	}
> -	return 0;
> -}
> -
> -static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
> -		      void __user *buffer, size_t *len, loff_t *ppos)
> -{
> -	int retval = 0, i;
> -	unsigned long val, pll;
> -#define TMPBUFLEN 64
> -#define MAX_CPU_FREQ 396
> -	char buf[TMPBUFLEN], *p;
> -	unsigned long flags, intc0_mask, intc1_mask;
> -	unsigned long old_baud_base, old_cpu_freq, old_clk, old_refresh;
> -	unsigned long new_baud_base, new_cpu_freq, new_clk, new_refresh;
> -	unsigned long baud_rate;
> -
> -	spin_lock_irqsave(&pm_lock, flags);
> -	if (!write)
> -		*len = 0;
> -	else {
> -		/* Parse the new frequency */
> -		if (*len > TMPBUFLEN - 1) {
> -			spin_unlock_irqrestore(&pm_lock, flags);
> -			return -EFAULT;
> -		}
> -		if (copy_from_user(buf, buffer, *len)) {
> -			spin_unlock_irqrestore(&pm_lock, flags);
> -			return -EFAULT;
> -		}
> -		buf[*len] = 0;
> -		p = buf;
> -		val = simple_strtoul(p, &p, 0);
> -		if (val > MAX_CPU_FREQ) {
> -			spin_unlock_irqrestore(&pm_lock, flags);
> -			return -EFAULT;
> -		}
> -
> -		pll = val / 12;
> -		if ((pll > 33) || (pll < 7)) {	/* 396 MHz max, 84 MHz min */
> -			/* Revisit this for higher speed CPUs */
> -			spin_unlock_irqrestore(&pm_lock, flags);
> -			return -EFAULT;
> -		}
> -
> -		old_baud_base = get_au1x00_uart_baud_base();
> -		old_cpu_freq = get_au1x00_speed();
> -
> -		new_cpu_freq = pll * 12 * 1000000;
> -	        new_baud_base = (new_cpu_freq / (2 * ((int)(au_readl(SYS_POWERCTRL)
> -							    & 0x03) + 2) * 16));
> -		set_au1x00_speed(new_cpu_freq);
> -		set_au1x00_uart_baud_base(new_baud_base);
> -
> -		old_refresh = au_readl(MEM_SDREFCFG) & 0x1ffffff;
> -		new_refresh = ((old_refresh * new_cpu_freq) / old_cpu_freq) |
> -			      (au_readl(MEM_SDREFCFG) & ~0x1ffffff);
> -
> -		au_writel(pll, SYS_CPUPLL);
> -		au_sync_delay(1);
> -		au_writel(new_refresh, MEM_SDREFCFG);
> -		au_sync_delay(1);
> -
> -		for (i = 0; i < 4; i++)
> -			if (au_readl(UART_BASE + UART_MOD_CNTRL +
> -				     i * 0x00100000) == 3) {
> -				old_clk = au_readl(UART_BASE + UART_CLK +
> -						   i * 0x00100000);
> -				baud_rate = old_baud_base / old_clk;
> -				/*
> -				 * We won't get an exact baud rate and the error
> -				 * could be significant enough that our new
> -				 * calculation will result in a clock that will
> -				 * give us a baud rate that's too far off from
> -				 * what we really want.
> -				 */
> -				if (baud_rate > 100000)
> -					baud_rate = 115200;
> -				else if (baud_rate > 50000)
> -					baud_rate = 57600;
> -				else if (baud_rate > 30000)
> -					baud_rate = 38400;
> -				else if (baud_rate > 17000)
> -					baud_rate = 19200;
> -				else
> -					baud_rate = 9600;
> -				new_clk = new_baud_base / baud_rate;
> -				au_writel(new_clk, UART_BASE + UART_CLK +
> -					  i * 0x00100000);
> -				au_sync_delay(10);
> -			}
> -	}
> -
> -	/*
> -	 * We don't want _any_ interrupts other than match20. Otherwise our
> -	 * au1000_calibrate_delay() calculation will be off, potentially a lot.
> -	 */
> -	intc0_mask = save_local_and_disable(0);
> -	intc1_mask = save_local_and_disable(1);
> -	local_enable_irq(AU1000_TOY_MATCH2_INT);
> -	spin_unlock_irqrestore(&pm_lock, flags);
> -	au1000_calibrate_delay();
> -	restore_local_and_enable(0, intc0_mask);
> -	restore_local_and_enable(1, intc1_mask);
> -
> -	return retval;
> -}
> -
> -
> -static struct ctl_table pm_table[] = {
> -	{
> -		.ctl_name	= CTL_UNNUMBERED,
> -		.procname	= "sleep",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0600,
> -		.proc_handler	= &pm_do_sleep
> -	},
> -	{
> -		.ctl_name	= CTL_UNNUMBERED,
> -		.procname	= "freq",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0600,
> -		.proc_handler	= &pm_do_freq
> -	},
> -	{}
> -};
> -
> -static struct ctl_table pm_dir_table[] = {
> -	{
> -		.ctl_name	= CTL_UNNUMBERED,
> -		.procname	= "pm",
> -		.mode		= 0555,
> -		.child		= pm_table
> -	},
> -	{}
> -};
> -
> -/*
> - * Initialize power interface
> - */
> -static int __init pm_init(void)
> -{
> -	/* init TOY to tick at 1Hz. No need to wait for access bits
> -	 * since there's plenty of time between here and the first
> -	 * suspend cycle.
> -	 */
> -	au_writel(32767, SYS_TOYTRIM);
> -	au_writel(0, SYS_TOYWRITE);
> -	au_sync();
> -
> -	register_sysctl_table(pm_dir_table);
> -	return 0;
> -}
> -
> -__initcall(pm_init);
> -
> -/*
> - * This is right out of init/main.c
> - */
> -
> -/*
> - * This is the number of bits of precision for the loops_per_jiffy.
> - * Each bit takes on average 1.5/HZ seconds.  This (like the original)
> - * is a little better than 1%.
> - */
> -#define LPS_PREC 8
> -
> -static void au1000_calibrate_delay(void)
> -{
> -	unsigned long ticks, loopbit;
> -	int lps_precision = LPS_PREC;
> -
> -	loops_per_jiffy = 1 << 12;
> -
> -	while (loops_per_jiffy <<= 1) {
> -		/* Wait for "start of" clock tick */
> -		ticks = jiffies;
> -		while (ticks == jiffies)
> -			/* nothing */ ;
> -		/* Go ... */
> -		ticks = jiffies;
> -		__delay(loops_per_jiffy);
> -		ticks = jiffies - ticks;
> -		if (ticks)
> -			break;
> -	}
> -
> -	/*
> -	 * Do a binary approximation to get loops_per_jiffy set to be equal
> -	 * one clock (up to lps_precision bits)
> -	 */
> -	loops_per_jiffy >>= 1;
> -	loopbit = loops_per_jiffy;
> -	while (lps_precision-- && (loopbit >>= 1)) {
> -		loops_per_jiffy |= loopbit;
> -		ticks = jiffies;
> -		while (ticks == jiffies);
> -		ticks = jiffies;
> -		__delay(loops_per_jiffy);
> -		if (jiffies != ticks)	/* longer than 1 tick */
> -			loops_per_jiffy &= ~loopbit;
> -	}
>  }
>  #endif	/* CONFIG_PM */
-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044

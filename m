Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Nov 2006 19:22:29 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:29170 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038477AbWKLTWY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Nov 2006 19:22:24 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 67DF63EBE; Sun, 12 Nov 2006 11:22:02 -0800 (PST)
Message-ID: <455774BD.6010706@ru.mvista.com>
Date:	Sun, 12 Nov 2006 22:23:41 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] mips hpt cleanup: make clocksource_mips public
References: <20061112.001028.41198601.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061112.001028.41198601.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
> Note: This patch can be applied after the patch titled:
> "[PATCH] mips hpt cleanup: get rid of mips_hpt_init"
> in lmo linux-queue tree (or 2.6.19-rc5-mm1).

> Make clocksource_mips public and get rid of mips_hpt_read,
> mips_hpt_mask.

    Good to see it. :-)
    I have a suggestion though...

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

>  arch/mips/dec/time.c                |    4 +--
>  arch/mips/jmr3927/rbhma3100/setup.c |    4 +--
>  arch/mips/kernel/time.c             |   42 +++++++++++++-----------------------
>  arch/mips/sgi-ip27/ip27-timer.c     |    4 +--
>  arch/mips/sibyte/bcm1480/time.c     |    4 +--
>  arch/mips/sibyte/sb1250/time.c      |    8 +++---
>  include/asm-mips/time.h             |    8 +++---
>  7 files changed, 32 insertions(+), 42 deletions(-)

> diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
> index 69e424e..8b7e0c1 100644
> --- a/arch/mips/dec/time.c
> +++ b/arch/mips/dec/time.c
> @@ -151,7 +151,7 @@ static void dec_timer_ack(void)
>  	CMOS_READ(RTC_REG_C);			/* Ack the RTC interrupt.  */
>  }
>  
> -static unsigned int dec_ioasic_hpt_read(void)
> +static cycle_t dec_ioasic_hpt_read(void)
>  {
>  	/*
>  	 * The free-running counter is 32-bit which is good for about
> @@ -171,7 +171,7 @@ void __init dec_time_init(void)
>  
>  	if (!cpu_has_counter && IOASIC)
>  		/* For pre-R4k systems we use the I/O ASIC's counter.  */
> -		mips_hpt_read = dec_ioasic_hpt_read;
> +		clocksource_mips.read = dec_ioasic_hpt_read;

    I'd like to see clocksource_mips.name overriden there as well.

>  	/* Set up the rate of periodic DS1287 interrupts.  */
>  	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - __ffs(HZ)), RTC_REG_A);
> diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
> index 16e5dfe..138f25e 100644
> --- a/arch/mips/jmr3927/rbhma3100/setup.c
> +++ b/arch/mips/jmr3927/rbhma3100/setup.c
> @@ -170,7 +170,7 @@ static void jmr3927_machine_power_off(vo
>  	while (1);
>  }
>  
> -static unsigned int jmr3927_hpt_read(void)
> +static cycle_t jmr3927_hpt_read(void)
>  {
>  	/* We assume this function is called xtime_lock held. */
>  	return jiffies * (JMR3927_TIMER_CLK / HZ) + jmr3927_tmrptr->trr;
> @@ -182,7 +182,7 @@ extern void rtc_ds1742_init(unsigned lon
>  #endif
>  static void __init jmr3927_time_init(void)
>  {
> -	mips_hpt_read = jmr3927_hpt_read;
> +	clocksource_mips.read = jmr3927_hpt_read;

    And the same here as well as this is TX3927-specific timer.

>  	mips_hpt_frequency = JMR3927_TIMER_CLK;
>  #ifdef USE_RTC_DS1742
>  	if (jmr3927_have_nvram()) {
[...]
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 5e82a26..7106d54 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -239,14 +239,14 @@ void __init plat_timer_setup(struct irqa
>  	setup_irq(irqno, &rt_irqaction);
>  }
>  
> -static unsigned int ip27_hpt_read(void)
> +static cycle_t ip27_hpt_read(void)
>  {
>  	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
>  }
>  
>  void __init ip27_time_init(void)
>  {
> -	mips_hpt_read = ip27_hpt_read;
> +	clocksource_mips.read = ip27_hpt_read;

    Again, would be good to override clocksource_mips.name here...

>  	mips_hpt_frequency = CYCLES_PER_SEC;
>  	xtime.tv_sec = get_m48t35_time();
>  	xtime.tv_nsec = 0;
> diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
> index e136bde..26b5c29 100644
> --- a/arch/mips/sibyte/bcm1480/time.c
> +++ b/arch/mips/sibyte/bcm1480/time.c
> @@ -119,7 +119,7 @@ void bcm1480_timer_interrupt(void)
>  	}
>  }
>  
> -static unsigned int bcm1480_hpt_read(void)
> +static cycle_t bcm1480_hpt_read(void)
>  {
>  	/* We assume this function is called xtime_lock held. */
>  	unsigned long count =
> @@ -129,6 +129,6 @@ static unsigned int bcm1480_hpt_read(voi
>  
>  void __init bcm1480_hpt_setup(void)
>  {
> -	mips_hpt_read = bcm1480_hpt_read;
> +	clocksource_mips.read = bcm1480_hpt_read;

    Here...

>  	mips_hpt_frequency = BCM1480_HPT_VALUE;
>  }
> diff --git a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
> index bcb74f2..2efffe1 100644
> --- a/arch/mips/sibyte/sb1250/time.c
> +++ b/arch/mips/sibyte/sb1250/time.c
> @@ -51,7 +51,7 @@ #define SB1250_HPT_VALUE	M_SCD_TIMER_CNT
>  
>  extern int sb1250_steal_irq(int irq);
>  
> -static unsigned int sb1250_hpt_read(void);
> +static cycle_t sb1250_hpt_read(void);
>  
>  void __init sb1250_hpt_setup(void)
>  {
> @@ -66,8 +66,8 @@ void __init sb1250_hpt_setup(void)
>  			     IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CFG)));
>  
>  		mips_hpt_frequency = V_SCD_TIMER_FREQ;
> -		mips_hpt_read = sb1250_hpt_read;
> -		mips_hpt_mask = M_SCD_TIMER_INIT;
> +		clocksource_mips.read = sb1250_hpt_read;
> +		clocksource_mips.mask = M_SCD_TIMER_INIT;

    And here as well...

>  	}
>  }
>  

WBR, Sergei

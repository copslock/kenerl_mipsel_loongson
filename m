Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 18:07:04 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16894 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTF3RHC>;
	Mon, 30 Jun 2003 18:07:02 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5UH6vY08795;
	Mon, 30 Jun 2003 10:06:57 -0700
Date: Mon, 30 Jun 2003 10:06:57 -0700
From: Jun Sun <jsun@mvista.com>
To: ilya@theIlya.com
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: ip32 timer setup fix
Message-ID: <20030630100657.E8542@mvista.com>
References: <20030630031338.GK13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030630031338.GK13617@gateway.total-knowledge.com>; from ilya@theIlya.com on Sun, Jun 29, 2003 at 08:13:38PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


It appears that if you set mips_counter_frequency to 
cc_interval, then you are all set and timer should work just fine.
In other words, 
	a) you don't  have to use your timer interrupt routine
	b) you don't have to clear count register
	c) you don't have to set the first compare register

What a deal! :)

Jun


On Sun, Jun 29, 2003 at 08:13:38PM -0700, ilya@theIlya.com wrote:
> Attached is patch to fix timer setup on IP32.
> 

> Index: arch/mips/sgi-ip32/ip32-timer.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-timer.c,v
> retrieving revision 1.12
> diff -u -r1.12 ip32-timer.c
> --- arch/mips/sgi-ip32/ip32-timer.c	29 Jun 2003 21:59:13 -0000	1.12
> +++ arch/mips/sgi-ip32/ip32-timer.c	30 Jun 2003 03:07:47 -0000
> @@ -45,11 +45,17 @@
>  #define USECS_PER_JIFFY (1000000/HZ)
>  
>  
> +static irqreturn_t cc_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs);
> +
>  void __init ip32_timer_setup (struct irqaction *irq)
>  {
>  	u64 crime_time;
>  	u32 cc_tick;
>  
> +
> +	write_c0_count(0);
> +	irq->handler = cc_timer_interrupt;
> +
>  	printk("Calibrating system timer... ");
>  
>  	crime_time = crime_read_64(CRIME_TIME) & CRIME_TIME_MASK;
> @@ -70,12 +76,14 @@
>  	printk("%d MHz CPU detected\n", (int) (cc_interval / PER_MHZ));
>  
>  	setup_irq (CLOCK_IRQ, irq);
> +#define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
> +	/* Set ourselves up for future interrupts */
> +	write_c0_compare(read_c0_count() + cc_interval);
> +        change_c0_status(ST0_IM, ALLINTS);
> +	local_irq_enable();
>  }
>  
> -struct irqaction irq0  = { NULL, SA_INTERRUPT, 0,
> -			   "timer", NULL, NULL};
> -
> -irqreturn_t cc_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
> +static irqreturn_t cc_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
>  {
>  	u32 count;
>  
> @@ -150,15 +158,4 @@
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
>  	xtime.tv_nsec = 0;
>  	write_sequnlock_irq(&xtime_lock);
> -
> -	write_c0_count(0);
> -	irq0.handler = cc_timer_interrupt;
> -
> -	ip32_timer_setup (&irq0);
> -
> -#define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
> -	/* Set ourselves up for future interrupts */
> -	write_c0_compare(read_c0_count() + cc_interval);
> -        change_c0_status(ST0_IM, ALLINTS);
> -	local_irq_enable();
>  }
> Index: arch/mips/sgi-ip32/ip32-setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
> retrieving revision 1.4
> diff -u -r1.4 ip32-setup.c
> --- arch/mips/sgi-ip32/ip32-setup.c	14 Apr 2003 16:33:24 -0000	1.4
> +++ arch/mips/sgi-ip32/ip32-setup.c	30 Jun 2003 03:11:05 -0000
> @@ -94,6 +94,7 @@
>  	rtc_ops = &ip32_rtc_ops;
>  	board_be_init = ip32_be_init;
>  	board_time_init = ip32_time_init;
> +	board_timer_setup = ip32_timer_setup();
>  
>  	crime_init ();
>  }

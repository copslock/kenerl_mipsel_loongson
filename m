Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2005 15:57:29 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:50403 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225196AbVADP5X>; Tue, 4 Jan 2005 15:57:23 +0000
Received: from gw.junsun.net (c-24-6-106-170.client.comcast.net[24.6.106.170])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005010415565901300c83qne>; Tue, 4 Jan 2005 15:57:03 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id j04FuqNq012195;
	Tue, 4 Jan 2005 07:56:54 -0800
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id j04FupPV012194;
	Tue, 4 Jan 2005 07:56:51 -0800
Date: Tue, 4 Jan 2005 07:56:51 -0800
From: Jun Sun <jsun@junsun.net>
To: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc: linux-mips@linux-mips.org
Subject: Re: SMP on Yosemite
Message-ID: <20050104155651.GB12031@gw.junsun.net>
References: <41DA6A13.7090703@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DA6A13.7090703@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips


In earlier version time.c file, I introduced something like 
"smp_emulate_local_timer" variable.  When it is set, cpu 0 sends
"EMULATE_LOCAL_TIMER" IPI to other CPUs.  Sending IPI is done
inside timer_interrupt().

I think that is a better approach, where implementation can be shared
by other SMP machines.

I would just rename RESCHEDULE_YOURSELF to EMULATE_LOCAL_TIMER.

Jun

On Tue, Jan 04, 2005 at 11:04:03AM +0100, Rojhalat Ibrahim wrote:
> Hi!
> 
> I noticed that on the Yosemite board in SMP mode
> local_timer_interrupt is never called on the CPU
> which does not handle the timer IRQ in the first
> place. Therefore process accounting does not work
> for at least one CPU. I have attached a patch that
> sends an inter-processor interrupt to the other
> CPU every time a timer interrupt occurs. I have
> used SMP_RESCHEDULE_YOURSELF since it is obviously
> unused. If this is not the way it's supposed to
> be done, please let me know.
> 
> Thanks
> Rojhalat Ibrahim
> 

> Index: setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/pmc-sierra/yosemite/setup.c,v
> retrieving revision 1.12
> diff -u -r1.12 setup.c
> --- setup.c	19 Dec 2004 02:38:44 -0000	1.12
> +++ setup.c	4 Jan 2005 09:46:17 -0000
> @@ -127,8 +127,22 @@
>  	return 0;
>  }
>  
> +irqreturn_t yosemite_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +#ifdef CONFIG_SMP
> +	int cpu = smp_processor_id();
> +	
> +	if (ocd_base) {
> +	   if (cpu == 0) core_send_ipi(1,SMP_RESCHEDULE_YOURSELF);
> +	   else core_send_ipi(0,SMP_RESCHEDULE_YOURSELF);
> +	}
> +#endif
> +	return timer_interrupt(irq,dev_id,regs);
> +}
> +
>  void yosemite_timer_setup(struct irqaction *irq)
>  {
> +	irq->handler = yosemite_timer_interrupt;
>  	setup_irq(7, irq);
>  }
>  
> @@ -136,13 +150,13 @@
>  {
>  	board_timer_setup = yosemite_timer_setup;
>  	mips_hpt_frequency = cpu_clock / 2;
> -mips_hpt_frequency = 33000000 * 3 * 5;
> +	mips_hpt_frequency = 100000000 * 5;
>  }
>  
>  /* No other usable initialization hook than this ...  */
>  extern void (*late_time_init)(void);
>  
> -unsigned long ocd_base;
> +unsigned long ocd_base = 0;
>  
>  EXPORT_SYMBOL(ocd_base);
>  
> Index: smp.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/pmc-sierra/yosemite/smp.c,v
> retrieving revision 1.11
> diff -u -r1.11 smp.c
> --- smp.c	15 Dec 2004 20:04:59 -0000	1.11
> +++ smp.c	4 Jan 2005 09:46:17 -0000
> @@ -1,5 +1,6 @@
>  #include <linux/linkage.h>
>  #include <linux/sched.h>
> +#include <linux/interrupt.h>
>  
>  #include <asm/pmon.h>
>  #include <asm/titan_dep.h>
> @@ -7,6 +8,8 @@
>  extern unsigned int (*mips_hpt_read)(void);
>  extern void (*mips_hpt_init)(unsigned int);
>  
> +extern void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
> +
>  #define LAUNCHSTACK_SIZE 256
>  
>  static spinlock_t launch_lock __initdata;
> @@ -122,10 +125,10 @@
>  {
>  }
>  
> -asmlinkage void titan_mailbox_irq(struct pt_regs *regs)
> +asmlinkage void titan_mailbox_irq(int irq, struct pt_regs *regs)
>  {
>  	int cpu = smp_processor_id();
> -	unsigned long status;
> +	unsigned long status = 0;
>  
>  	if (cpu == 0) {
>  		status = OCD_READ(RM9000x2_OCD_INTP0STATUS3);
> @@ -139,6 +142,13 @@
>  
>  	if (status & 0x2)
>  		smp_call_function_interrupt();
> +	
> +	if (status & 0x4)
> +	{
> +		irq_enter();
> +		local_timer_interrupt(irq, NULL, regs);
> +		irq_exit();
> +	}
>  }
>  
>  /*

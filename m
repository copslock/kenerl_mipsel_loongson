Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4L1gLnC032520
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 18:42:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4L1gLaZ032519
	for linux-mips-outgoing; Mon, 20 May 2002 18:42:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4L1g9nC032513
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 18:42:09 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4L1fp626655
	for linux-mips@oss.sgi.com; Mon, 20 May 2002 18:41:51 -0700
Date: Mon, 20 May 2002 18:41:51 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Subject: [PATCH] arch/mips/kernel/irq_cpu.c interrupt safety?
Message-ID: <20020520184151.C26598@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The mips_cpu_irq_*() routines in arch/mips/kernel/irq_cpu.c seem to not be
safe; {clear,set}_cp0_*() don't provide interrupt safety while changing the cp0
register. Is this not wrong? Is there a case where an interrupt handler may
change CP0 status? If so, the patch below (against linux_2_4) simply disables
interrupts during these operations.

Thanks,
Will

---
Index: arch/mips/kernel/irq_cpu.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/irq_cpu.c,v
retrieving revision 1.2.2.2
diff -c -r1.2.2.2 irq_cpu.c
*** arch/mips/kernel/irq_cpu.c	2002/04/09 02:27:12	1.2.2.2
--- arch/mips/kernel/irq_cpu.c	2002/05/21 01:16:30
***************
*** 31,45 ****
  
  static void mips_cpu_irq_enable(unsigned int irq)
  {
  	clear_cp0_cause( 1 << (irq - mips_cpu_irq_base + 8));
  	set_cp0_status(1 << (irq - mips_cpu_irq_base + 8));
  }
  
! static void mips_cpu_irq_disable(unsigned int irq)
  {
  	clear_cp0_status(1 << (irq - mips_cpu_irq_base + 8));
  }
  
  static unsigned int mips_cpu_irq_startup(unsigned int irq)
  {
  	mips_cpu_irq_enable(irq);
--- 31,56 ----
  
  static void mips_cpu_irq_enable(unsigned int irq)
  {
+ 	unsigned long flags;
+ 	save_and_cli(flags);
  	clear_cp0_cause( 1 << (irq - mips_cpu_irq_base + 8));
  	set_cp0_status(1 << (irq - mips_cpu_irq_base + 8));
+ 	restore_flags(flags);
  }
  
! static void __mips_cpu_irq_disable(unsigned int irq)
  {
  	clear_cp0_status(1 << (irq - mips_cpu_irq_base + 8));
  }
  
+ static void mips_cpu_irq_disable(unsigned int irq)
+ {
+ 	unsigned long flags;
+ 	save_and_cli(flags);
+ 	__mips_cpu_irq_disable(irq);
+ 	restore_flags(flags);
+ }
+ 
  static unsigned int mips_cpu_irq_startup(unsigned int irq)
  {
  	mips_cpu_irq_enable(irq);
***************
*** 51,63 ****
  
  static void mips_cpu_irq_ack(unsigned int irq)
  {
! 	/* although we attemp to clear the IP bit in cause reigster, I think
  	 * usually it is cleared by device (irq source)
  	 */
  	clear_cp0_cause(1 << (irq - mips_cpu_irq_base + 8));
  
  	/* disable this interrupt - so that we safe proceed to the handler */
! 	mips_cpu_irq_disable(irq);
  }
  
  static void mips_cpu_irq_end(unsigned int irq)
--- 62,78 ----
  
  static void mips_cpu_irq_ack(unsigned int irq)
  {
! 	unsigned long flags;
! 	save_and_cli(flags);
! 
! 	/* although we attempt to clear the IP bit in cause register, I think
  	 * usually it is cleared by device (irq source)
  	 */
  	clear_cp0_cause(1 << (irq - mips_cpu_irq_base + 8));
  
  	/* disable this interrupt - so that we safe proceed to the handler */
! 	__mips_cpu_irq_disable(irq);
! 	restore_flags(flags);
  }
  
  static void mips_cpu_irq_end(unsigned int irq)

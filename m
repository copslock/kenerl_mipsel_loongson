Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PJpJR27664
	for linux-mips-outgoing; Mon, 25 Feb 2002 11:51:19 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PJp1927661
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 11:51:01 -0800
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16fQD8-0001fM-00
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 12:50:54 -0600
Message-ID: <3C7A9579.BE02A838@cotw.com>
Date: Mon, 25 Feb 2002 13:50:17 -0600
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: MIPS, i8259 and spurious interrupts.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have been trying to track down and resolve a spurious interrupt
problem. I have attached some output and the code used to generate it in
i8259.c.

enable_8259A_irq is called but  disable_8259A_irq is never called.

My i8259 is mapped to MIPS IRQ 6. As you will see below all my spurious
interrupts happen to be on 8259 irq 6. (Which is my ethernet card)

It appears that a new interrput is occuring before the last one is
finished. What should be done with MIPS irq 6? Should I clear the
status?
	clear_cp0_status(STATUSF_IP6);


Instead of implementing i8259_do_irq is it ok to use do_irq in
arch/mips/kernel/irq.c?


Can anyone explain the following behavior:

Sometimes this code get caught in an endless loop.
Sometimes I see the:
	printk("spurious 8259A interrupt: IRQ%d.\n", irq);

Sometimes I see:

*** SP 1 irq: 6***
*** SP 1.1 ***
*** SP 1.2 ***
*** SP 1 irq: 6***
*** SP 1.1 ***
*** SP 1.2 ***
*** SP 1 irq: 6***
*** SP 1.1 ***
*** SP 1.2 ***
*** SP 1 irq: 6***
*** SP 1.1 ***
*** SP 1.2 ***
*** SP 1 irq: 6***
*** SP 1.1 ***
*** SP 1.2 ***
*** SP 1 irq: 6***
*** SP 1.1 ***                
*** SP 1.2 ***                            
*** SP 1 irq: 6***                                    
*** SP 1.1 ***
*** SP 1.2 ***

---- Modified code ----
static inline int i8259A_irq_real(unsigned int irq)
{
	int value;
	int irqmask = 1 << irq;

	if (irq < 8) {
	     printk("*** SP 1.1 ***\n");
		outb(0x0B,0x20);		/* ISR register */
		value = inb(0x20) & irqmask;
		outb(0x0A,0x20);		/* back to the IRR register */
	     printk("*** SP 1.2 ***\n");
		return value;
	}
     if (irq<14)
	     printk("*** SP 1.3 ***\n");
	outb(0x0B,0xA0);		/* ISR register */
	value = inb(0xA0) & (irqmask >> 8);
	outb(0x0A,0xA0);		/* back to the IRR register */
	return value;
}

/*
 * Careful! The 8259A is a fragile beast, it pretty
 * much _has_ to be done exactly like this (mask it
 * first, _then_ send the EOI, and the order of EOI
 * to the two 8259s is important!
 */
void mask_and_ack_8259A(unsigned int irq)
{
	unsigned int irqmask = 1 << irq;
	unsigned long flags;

	spin_lock_irqsave(&i8259A_lock, flags);
	/*
	 * Lightweight spurious IRQ detection. We do not want to overdo
	 * spurious IRQ handling - it's usually a sign of hardware problems, so
	 * we only do the checks we can do without slowing down good hardware
	 * nnecesserily.
	 *
	 * Note that IRQ7 and IRQ15 (the two spurious IRQs usually resulting
	 * rom the 8259A-1|2 PICs) occur even if the IRQ is masked in the
8259A.
	 * Thus we can check spurious 8259A IRQs without doing the quite slow
	 * i8259A_irq_real() call for every IRQ.  This does not cover 100% of
	 * spurious interrupts, but should be enough to warn the user that
	 * there is something bad going on ...
	 */
	if (cached_irq_mask & irqmask)
		goto spurious_8259A_irq;
	cached_irq_mask |= irqmask;

handle_real_irq:
	if (irq & 8) {
		inb(0xA1);		/* DUMMY - (do we need this?) */
		outb(cached_A1,0xA1);
		outb(0x60+(irq&7),0xA0);/* 'Specific EOI' to slave */
		outb(0x62,0x20);	/* 'Specific EOI' to master-IRQ2 */
	} else {
		inb(0x21);		/* DUMMY - (do we need this?) */
		outb(cached_21,0x21);
		outb(0x60+irq,0x20);	/* 'Specific EOI' to master */
	}
	spin_unlock_irqrestore(&i8259A_lock, flags);

	return;

spurious_8259A_irq:
	/*
	 * this is the slow path - should happen rarely.
	 */

/************************************************************************************/
/* Why am I not returning from the following
call?                                  */
/************************************************************************************/

	printk("*** SP 1 irq: %d***\n", irq);
	if (i8259A_irq_real(irq))
		/*
		 * oops, the IRQ _is_ in service according to the
		 * 8259A - not spurious, go handle it.
		 */
	printk("*** SP 2 ***\n");
		goto handle_real_irq;

	{
		static int spurious_irq_mask = 0;

	printk("*** SP 3 ***\n");

		/*
		 * At this point we can be sure the IRQ is spurious,
		 * lets ACK and report it. [once per IRQ]
		 */
	printk("*** SP 4 ***\n");

		if (!(spurious_irq_mask & irqmask)) {
			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
			spurious_irq_mask |= irqmask;
		}
	printk("*** SP 5 ***\n");

		irq_err_count++;
		/*
		 * Theoretically we do not have to handle this IRQ,
		 * but in Linux this does not cause problems and is
		 * simpler for us.
		 */
	printk("*** SP 6 ***\n");

		goto handle_real_irq;
	}
}


Thanks in advance for any advice...

-- 
Scott A. McConnell

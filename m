Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q7qYf04673
	for linux-mips-outgoing; Mon, 25 Feb 2002 23:52:34 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q7qP904669
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 23:52:26 -0800
Message-Id: <200202260752.g1Q7qP904669@oss.sgi.com>
Received: (qmail 24010 invoked from network); 26 Feb 2002 06:56:18 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 26 Feb 2002 06:56:19 -0000
Date: Tue, 26 Feb 2002 14:50:9 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Scott A McConnell <samcconn@cotw.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS, i8259 and spurious interrupts.
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,


>/************************************************************************************/
>/* Why am I not returning from the following
>call?                                  */
>/************************************************************************************/
>
>	printk("*** SP 1 irq: %d***\n", irq);
>	if (i8259A_irq_real(irq))
>		/*
>		 * oops, the IRQ _is_ in service according to the
>		 * 8259A - not spurious, go handle it.
>		 */
>	printk("*** SP 2 ***\n");
>		goto handle_real_irq;
do you really mean it? the goto is unconditional now?
but your output susgest that i8259A_irq_real never return true
>
>	{
>		static int spurious_irq_mask = 0;
>
>	printk("*** SP 3 ***\n");
>
>		/*
>		 * At this point we can be sure the IRQ is spurious,
>		 * lets ACK and report it. [once per IRQ]
>		 */
>	printk("*** SP 4 ***\n");
>
>		if (!(spurious_irq_mask & irqmask)) {
>			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
>			spurious_irq_mask |= irqmask;
>		}
>	printk("*** SP 5 ***\n");
>
>		irq_err_count++;
>		/*
>		 * Theoretically we do not have to handle this IRQ,
>		 * but in Linux this does not cause problems and is
>		 * simpler for us.
>		 */
>	printk("*** SP 6 ***\n");
>
>		goto handle_real_irq;
>	}
>}
>
>
>Thanks in advance for any advice...
>
>-- 
>Scott A. McConnell

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

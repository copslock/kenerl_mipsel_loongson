Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8JJl5l03282
	for linux-mips-outgoing; Wed, 19 Sep 2001 12:47:05 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8JJl2e03279
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 12:47:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8JJoNA03779;
	Wed, 19 Sep 2001 12:50:23 -0700
Message-ID: <3BA8F45D.21347CD@mvista.com>
Date: Wed, 19 Sep 2001 12:39:09 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
References: <200109190838.f8J8cIe21408@oss.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:
> 
>  My irq dispatching code is very simple,it just read the IRR,count the first
> irq number and call do_IRQ.
>   /*
>  * the first level int-handler will jump here if it is a 8259A irq
>  */
> asmlinkage void i8259A_irqdispatch(struct pt_regs *regs)
> {
>         int isr, irq;
> 
>         isr = inb(0x20);
> 
>         irq = ffz (~isr);
> 
>         if (irq == 2) {
>                 isr = inb(0xa0);
>                 irq = 8 + ffz(~isr);
>         }
> 
>         do_IRQ(irq,regs);
> }
> 

OK, so the problem is not what I was thinking.

I don't have much clue here.  I remember old i8259As have some timing issues
on fast cpus.  Hopefully all the bridge chips are set up correctly ...

> >It is typically much easier to modify PCI device BARS so that they do coincide
> >with the same physical address.   You can control that by using the correct
> >starting address for PCI MEM space in pci_auto.c resource assignment.
> It seems a good way to solve the ioremap problem and X problem.But virt_to_bus
> & bus_to_virt problem remains?
> 

What is the virt_to_bus() problem?  Is the address beyond 512MB (phy addr)? 
If PCI mem (BUS) address is identical to phy addr, you should not have problem
unless the address is beyond 512MB.

BTW, virt_to_bus()/bus_to_virt() are deprecicated.  See
Documentation/DMA-mapping.txt.

Jun

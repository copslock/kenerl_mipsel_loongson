Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Dec 2002 00:55:43 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:33930 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225290AbSLNAzn>; Sat, 14 Dec 2002 00:55:43 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id BAA03578;
	Sat, 14 Dec 2002 01:55:54 +0100 (MET)
Date: Sat, 14 Dec 2002 01:55:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021213150853.F22731@mvista.com>
Message-ID: <Pine.GSO.3.96.1021214004003.841D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Dec 2002, Jun Sun wrote:

> This patch adds support for those sorry boards which only have
> option 2) available.
> 
> While I am here, I also promoted do_IRQ() declaration to a 
> header file, as it is needed by all C-level interrupt dispatching
> code.
> 
> Any feedbacks? 

 Yep -- a few random thoughts.

> +asmlinkage void dispatch_i8259_irq(struct pt_regs *regs)
> +{
> +	int isr, irq=-1;
> +
> +	isr = ~(int)inb(0x20) | cached_21;

 OCW3 defaults to IRR in our setup (as it does for the chip itself after
writing ICWs) -- you need to select ISR explicitly before reading and
reset it afterwards to avoid surprises.  Unless we change the default for
MIPS, which seems feasible -- we don't have to handle i386 oddities like
I/O APICs and weird chipset bugs.  And we avoid the need to grab a
spinlock here.  Alpha went this path. 

> +	if (isr != -1) 
> +		irq = ffz (isr);
> +	if (irq == 2) {
> +		isr = ~(int)inb(0xa0) | cached_A1;
> +		if (isr != -1) 
> +			irq = 8 + ffz(isr);
> +	}
> +	if (irq == -1) {
> +		printk("We got a spurious i8259 interrupt\n");

 The wording is odd -- how about following the one from
arch/i386/kernel/i8259.c? 

> +		atomic_inc(&irq_err_count);
> +	} else {
> +		do_IRQ(irq,regs);

 And how about using an offset passed from a user?  We're not on a PC --
i8259 IRQs do not have to start from 0.  E.g. I find cleaner allocating
CPU IRQs first if handled.

> --- ./include/asm-mips64/irq.h.orig	Fri Dec 13 10:51:25 2002
> +++ ./include/asm-mips64/irq.h	Fri Dec 13 14:50:46 2002
[...]
> +extern asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);

 Hmm, <asm/hw_irq.h> might be a better alternative.  I have no strong
preference, though.  Both get included by <linux/irq.h> so there's no
difference for a user.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

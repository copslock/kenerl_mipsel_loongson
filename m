Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 18:14:23 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:58062 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225344AbSLRSOW>; Wed, 18 Dec 2002 18:14:22 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA11500;
	Wed, 18 Dec 2002 19:14:21 +0100 (MET)
Date: Wed, 18 Dec 2002 19:14:20 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021218094828.A6061@mvista.com>
Message-ID: <Pine.GSO.3.96.1021218185016.5977F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 18 Dec 2002, Jun Sun wrote:

> > do_IRQ(poll_8259A_irq(), regs);
> 
> I actually don't like the new semantic.  The main drawback is that we can't
> dispatch a 8259A interrupt from assemably code, which is often needed.

 You can't do that with your original code either, unless you arrange a
call to your dispatch_i8259_irq() C function.  This can still be done with
a trivial wrapper like:

asmlinkage void foo_dispatch_i8259_irq(struct pt_regs *regs)
{
	do_IRQ(poll_8259A_irq(), regs);
}

which results in code like you proposed.

> What is wrong with original way of dispatching?  The general interrupt 
> dispatching flow is that you chase the routing path until you find the final
> source and do a do_IRQ().  That seems fine with i8259A case here.

 It does too much and is therefore useful for a single specific case only. 
I focused on handling the chip only and the resulting function may be used
however desired, including your specific case.  Not all platforms need to
want to call do_IRQ() immediately after getting an IRQ number, including
code already in existence. 

> While there is certain urge to create asm/i8259a.h file, if in the end all there
> is two function declarations (i8259_init() and dispatch_i8259_irq()), it is not
> really worth it.

 The header issue is orthogonal -- for lone init_i8259_irqs() it should
exist.  Otherwise you'll be doomed upon the next interface change.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 18:51:56 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3055 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225346AbSLRSv4>;
	Wed, 18 Dec 2002 18:51:56 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBIIpnc07231;
	Wed, 18 Dec 2002 10:51:49 -0800
Date: Wed, 18 Dec 2002 10:51:48 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021218105148.E6061@mvista.com>
References: <20021218094828.A6061@mvista.com> <Pine.GSO.3.96.1021218185016.5977F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1021218185016.5977F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 18, 2002 at 07:14:20PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 07:14:20PM +0100, Maciej W. Rozycki wrote:
> On Wed, 18 Dec 2002, Jun Sun wrote:
> 
> > > do_IRQ(poll_8259A_irq(), regs);
> > 
> > I actually don't like the new semantic.  The main drawback is that we can't
> > dispatch a 8259A interrupt from assemably code, which is often needed.
> 
>  You can't do that with your original code either, 

What do you mean?  I could do a standard assembly intr dispatching code like
this;

	move	a0, sp
	jal	dispatch_i8259_irq
	j	ret_from_irq

Please cross-check all current assembly-level irq dispatching calls.  They
are all like this.

> unless you arrange a
> call to your dispatch_i8259_irq() C function.  This can still be done with
> a trivial wrapper like:
> 
> asmlinkage void foo_dispatch_i8259_irq(struct pt_regs *regs)
> {
> 	do_IRQ(poll_8259A_irq(), regs);
> }
>

This is essentially the same as adding dispatch_i8259_irq() to i8259.c file,
which in turn calls an inline function as its function body. 

Unless there is obvious another usage of poll_8259A_irq(), the inline function
might as well be not inlined.
 
> which results in code like you proposed.
>

Yes, that is why I liked my original function call. :-)
 
> > What is wrong with original way of dispatching?  The general interrupt 
> > dispatching flow is that you chase the routing path until you find the final
> > source and do a do_IRQ().  That seems fine with i8259A case here.
> 
>  It does too much and is therefore useful for a single specific case only. 
> I focused on handling the chip only and the resulting function may be used
> however desired, including your specific case.  Not all platforms need to
> want to call do_IRQ() immediately after getting an IRQ number, including
> code already in existence. 

Note those platforms don't read i8259 registers to get irq number either.

There is also a style issue.  Dispatching an interrupt is really part of
hw_interrupt_type structure.  You should implement it in the same file as the
rest functions.  However, if anybody feels it is not optimized enough they are
always free to lump all IRQ dispatching code together in one place, probably even
in assembly code.

I also disagree to have a header file with only one function declaration, but I 
agree there is orthognal issue, mostly a maintenance issue.  So if Ralf is ok with that,
I won't bitching about it.

Jun

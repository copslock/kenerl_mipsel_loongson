Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 19:26:06 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14801 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225349AbSLRT0F>; Wed, 18 Dec 2002 19:26:05 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA13022;
	Wed, 18 Dec 2002 20:26:03 +0100 (MET)
Date: Wed, 18 Dec 2002 20:26:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021218105148.E6061@mvista.com>
Message-ID: <Pine.GSO.3.96.1021218195418.5977H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 18 Dec 2002, Jun Sun wrote:

> > call to your dispatch_i8259_irq() C function.  This can still be done with
> > a trivial wrapper like:
> > 
> > asmlinkage void foo_dispatch_i8259_irq(struct pt_regs *regs)
> > {
> > 	do_IRQ(poll_8259A_irq(), regs);
> > }
> >
> 
> This is essentially the same as adding dispatch_i8259_irq() to i8259.c file,
> which in turn calls an inline function as its function body. 

 It's not the same (assuming you'd use a separate file as not all
platforms need dispatch_i8259_irq()) as for other uses you may need
slightly different duplicates.

> Unless there is obvious another usage of poll_8259A_irq(), the inline function
> might as well be not inlined.

 You lose several cycles for stack frame handling and the extraneous call
itself then. 

> There is also a style issue.  Dispatching an interrupt is really part of
> hw_interrupt_type structure.  You should implement it in the same file as the

 Not at all.  The hw_interrupt_type structure is about handling (or
receiving) interrupts.  The code we are talking about is about dispatching
(or sending) interrupts, which is sometimes done by hardware (e.g. 
probably always for ia32).  These activities are opposite to each other. 

> rest functions.  However, if anybody feels it is not optimized enough they are
> always free to lump all IRQ dispatching code together in one place, probably even
> in assembly code.

 Within sane code we keep dispatchers separate from handlers and that
makes a lot of sense.  Not only they are logically separated, but often
there are multiple unrelated handlers, e.g. three for most of DECstations,
and there is always a single dispatcher, i.e. the interrupt exception
handler.  Also dispatchers are platform-specific, depending on the wiring,
desired priorities, etc., while handlers are generic, depending on an
interrupt controller chip only. 

> I also disagree to have a header file with only one function declaration, but I 
> agree there is orthognal issue, mostly a maintenance issue.  So if Ralf is ok with that,
> I won't bitching about it.

 It's better to have a self-contained header for a single declaration than
a single header collecting various weakly related junk -- see
<linux/sched.h> (and keep a barf bag handy -- you have been warned).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 17:48:37 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:40179 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225338AbSLRRsg>;
	Wed, 18 Dec 2002 17:48:36 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBIHmTi06905;
	Wed, 18 Dec 2002 09:48:29 -0800
Date: Wed, 18 Dec 2002 09:48:28 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021218094828.A6061@mvista.com>
References: <20021217134011.M11575@mvista.com> <Pine.GSO.3.96.1021217224740.7289I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1021217224740.7289I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 18, 2002 at 05:14:19PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 05:14:19PM +0100, Maciej W. Rozycki wrote:
> On Tue, 17 Dec 2002, Jun Sun wrote:
> 
> > > > No MIPS boards are using do_slow_gettimeoffset().  We really should get
> > > > rid of it.
> > > 
> > >  I know none does at the moment.  But are you sure there is no system that
> > > would need it and might be supported one day?
> > 
> > I serisouly don't think so.  Moving forward every CPU will have a CPU counter,
> > which can be used for timeoffset purpose.  Even if it does not have one,
> > it will surely have some onboard high resolution timer, which can be used
> > to intra-jiffy offset purpose.
> 
>  Well, I do hope so, too, but you'll never know until you find out. ;-)
> 
> > >  Here is an example (untested) code that I would recommend.  It sends
> > > explicit ACKs to the i8259As, which has the following advantages:
> > > 
> > <snip>
> > 
> > Cool.  This code works for me.
> 
>  Excellent.  I worked on the code a bit more and removed the spurious IRQ
> stuff.  It's not really necessary -- mask_and_ack_8259A() will deal with
> it anyway (a bit less precisely, but we don't care -- they are very rare
> and drivers absolutely have to be able to deal with spurious interrupts)
> and we want the low-level IRQ handling to be fast as it's performance
> critical.  At this point the function became so compact it would be
> unreasonable not to make it inline -- the generated code is 24
> instructions on my system.  The positive side effect is the code won't be
> compiled for systems that don't use it.
> 
>  Following is a patch that I consider a candidate for submission.  I
> changed the interface a bit to permit greater flexibility.  I renamed the
> function to reflect the new semantic.  Unless special handling is needed
> you may simply call: 
> 
> do_IRQ(poll_8259A_irq(), regs);
>

I actually don't like the new semantic.  The main drawback is that we can't
dispatch a 8259A interrupt from assemably code, which is often needed.

What is wrong with original way of dispatching?  The general interrupt 
dispatching flow is that you chase the routing path until you find the final
source and do a do_IRQ().  That seems fine with i8259A case here.

While there is certain urge to create asm/i8259a.h file, if in the end all there
is two function declarations (i8259_init() and dispatch_i8259_irq()), it is not
really worth it.

Jun

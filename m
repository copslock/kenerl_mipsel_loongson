Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA31075
	for <pstadt@stud.fh-heilbronn.de>; Mon, 2 Aug 1999 23:53:37 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA06865; Mon, 2 Aug 1999 14:49:28 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA52327
	for linux-list;
	Mon, 2 Aug 1999 14:45:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA16983;
	Mon, 2 Aug 1999 14:45:22 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05773; Mon, 2 Aug 1999 14:45:20 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id QAA30474;
	Mon, 2 Aug 1999 16:45:19 -0500
Date: Tue, 3 Aug 1999 00:41:46 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: "William J. Earl" <wje@fir.engr.sgi.com>
cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
In-Reply-To: <14246.1339.269402.396117@fir.engr.sgi.com>
Message-ID: <Pine.LNX.3.96.990803003314.15805B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Mon, 2 Aug 1999, William J. Earl wrote:

> Andrew R. Baker writes:
>  > 
>  > While working in EISA support for the Indigo2 I have run across some
>  > interesting design decisions and I would like to get some feedback.
>  > 
>  > First is interupt handling.  On the Indigo2 all the EISA interupts and
>  > mapped down to a single INT2 interrupt.  In other words, an [E]ISA card
>  > generates an interrupt, which in turn, generates an INT2 interrupt, which
>  > generates a CPU interrupt.  This causes a problem because current device
>  > drivers do a "request_irq" call to allocate an interrupt, on the Indy and
>  > Indigo2, this procedure allocates an INT2/3 irq.  ASFAIK, this means that
>  > to be supported on the Indigo2, the device driver needs to call something
>  > else like "request_isa_irq", so that it can be allocated properly.  I see
>  > two ways of implementing this.  The first is easier to implement, but
>  > looks slightly grotesque and would involve lines like:
>  > 
>  > #ifndef CONFIG_SGI_EISA
>  > request_irq(....);
>  > #else
>  > request_isa_irq(....);
>  > #endif
>  > 
>  > the other would be to create a "request_isa_irq" procedure that defaults
>  > to "request_irq" in most architectures.
>  > 
>  > Does anyone have any comments or suggestions on this?
> 
>       Suppose you define a range of request_irq() index values which
> correspond to EISA interrupts.  The generic EISA interrupt would always
> be enabled, and the selective masking would apply to various bits in the
> EISA interrupt controller, in much the way that the cascading interrupts
> in INT2 and INT3 are handled.

I hadn't even thought about doing it that way, but after looking at the
existing interupt code, it shouldn't be much of a problem. My biggest
concern is maintaining compatability with the existing drivers. From what
I can tell, they all grab IRQs in the range of 1-15 (the available range
for EISA on x86 machines).  So the best course of action is to shift the
virtual IRQ numbers up to start at 16, and put the EISA irqs on the 0-15
range.  Are there any major things I should consider before doing this?
Are there any arguments against this? 

-Andrew

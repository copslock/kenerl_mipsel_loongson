Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA32525
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 00:14:46 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08701; Mon, 2 Aug 1999 15:11:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA10174
	for linux-list;
	Mon, 2 Aug 1999 15:08:26 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA12586
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 2 Aug 1999 15:08:23 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01425
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Aug 1999 15:08:19 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA23351
	for <linux@cthulhu.engr.sgi.com>; Tue, 3 Aug 1999 00:08:16 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA29683;
	Tue, 3 Aug 1999 00:06:16 +0200
Date: Tue, 3 Aug 1999 00:06:15 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
Message-ID: <19990803000615.A29290@uni-koblenz.de>
References: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu>; from Andrew R. Baker on Mon, Aug 02, 1999 at 08:51:06PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 02, 1999 at 08:51:06PM -0500, Andrew R. Baker wrote:

> While working in EISA support for the Indigo2 I have run across some
> interesting design decisions and I would like to get some feedback.
> 
> First is interupt handling.  On the Indigo2 all the EISA interupts and
> mapped down to a single INT2 interrupt.  In other words, an [E]ISA card
> generates an interrupt, which in turn, generates an INT2 interrupt, which
> generates a CPU interrupt.  This causes a problem because current device
> drivers do a "request_irq" call to allocate an interrupt, on the Indy and
> Indigo2, this procedure allocates an INT2/3 irq.  ASFAIK, this means that
> to be supported on the Indigo2, the device driver needs to call something
> else like "request_isa_irq", so that it can be allocated properly.  I see
> two ways of implementing this.  The first is easier to implement, but
> looks slightly grotesque and would involve lines like:
> 
> #ifndef CONFIG_SGI_EISA
> request_irq(....);
> #else
> request_isa_irq(....);
> #endif
> 
> the other would be to create a "request_isa_irq" procedure that defaults
> to "request_irq" in most architectures.
> 
> Does anyone have any comments or suggestions on this?

The solution which we're using for other systems is to number the
interrupts such that 0 ... 15 are the (E)ISA interrupts; all other
system specific interrupts use higher numbers.  In such a scenario
request_irq() will essentially just be a demultiplexer which for
(E)ISA interrupt numbers calls request_isa_irq() etc.  You really
should try to leave the interrupt numbers unchanged as they are;
basically every (E)ISA interrupt driver has it's numbers hardwired.

  Ralf

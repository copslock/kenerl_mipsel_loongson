Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id UAA23062
	for <pstadt@stud.fh-heilbronn.de>; Mon, 2 Aug 1999 20:05:15 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA19944; Mon, 2 Aug 1999 11:00:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA92377
	for linux-list;
	Mon, 2 Aug 1999 10:54:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA18536
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 2 Aug 1999 10:54:45 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06547
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Aug 1999 10:54:41 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id MAA21375
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Aug 1999 12:54:40 -0500
Date: Mon, 2 Aug 1999 20:51:06 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: EISA support
Message-ID: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


While working in EISA support for the Indigo2 I have run across some
interesting design decisions and I would like to get some feedback.

First is interupt handling.  On the Indigo2 all the EISA interupts and
mapped down to a single INT2 interrupt.  In other words, an [E]ISA card
generates an interrupt, which in turn, generates an INT2 interrupt, which
generates a CPU interrupt.  This causes a problem because current device
drivers do a "request_irq" call to allocate an interrupt, on the Indy and
Indigo2, this procedure allocates an INT2/3 irq.  ASFAIK, this means that
to be supported on the Indigo2, the device driver needs to call something
else like "request_isa_irq", so that it can be allocated properly.  I see
two ways of implementing this.  The first is easier to implement, but
looks slightly grotesque and would involve lines like:

#ifndef CONFIG_SGI_EISA
request_irq(....);
#else
request_isa_irq(....);
#endif

the other would be to create a "request_isa_irq" procedure that defaults
to "request_irq" in most architectures.

Does anyone have any comments or suggestions on this?



The second is a request for comments on the advantages/disadvantages of
implementing EISA support as a loadable module?  There is nothing in the
running system that actually requires it to be available, and I think it
would be neat to have bus support as a module.

-Andrew

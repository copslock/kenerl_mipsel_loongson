Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA21315
	for <pstadt@stud.fh-heilbronn.de>; Mon, 2 Aug 1999 23:03:51 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08835; Mon, 2 Aug 1999 13:57:58 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA60217
	for linux-list;
	Mon, 2 Aug 1999 13:53:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA18127;
	Mon, 2 Aug 1999 13:53:21 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA14295; Mon, 2 Aug 1999 13:53:15 -0700
From: "William J. Earl" <wje@fir.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14246.1339.269402.396117@fir.engr.sgi.com>
Date: Mon, 2 Aug 1999 13:53:15 -0700 (PDT)
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
In-Reply-To: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu>
References: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu>
X-Mailer: VM 6.72 under Emacs 19.34.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Andrew R. Baker writes:
 > 
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

      Suppose you define a range of request_irq() index values which
correspond to EISA interrupts.  The generic EISA interrupt would always
be enabled, and the selective masking would apply to various bits in the
EISA interrupt controller, in much the way that the cascading interrupts
in INT2 and INT3 are handled.

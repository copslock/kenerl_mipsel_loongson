Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAJ01U11762
	for linux-mips-outgoing; Mon, 10 Dec 2001 11:00:01 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAIxro11741
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 10:59:53 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id fBAHxim07081;
	Mon, 10 Dec 2001 17:59:44 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id fBAHxew09191;
	Mon, 10 Dec 2001 17:59:40 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15380.63500.561133.890301@gladsmuir.algor.co.uk>
Date: Mon, 10 Dec 2001 17:59:40 +0000 (GMT)
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: Chris Dearman <chris@algor.co.uk>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: the cause of spurious interrupt problem 
In-Reply-To: <200112091416.fB9EGwo06733@oss.sgi.com>
References: <200112091416.fB9EGwo06733@oss.sgi.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Zhang Fuxin (fxzhang@ict.ac.cn) writes:

>   Then all at a suddenly i find the REAL reason...

I don't know whether you read the section "Tips on Programming
South Bridge Interrupt Controllers" in our P-6032 user manual.  It
goes like this:

		*           *           *           *

The interrupt controllers inside the south bridge chip have to be
software-compatible with the dual Intel 8259 controllers fitted to
very old PCs.  There are two 8-bit controllers inside the south
bridge, a slave whose interrupt output becomes one of the eight inputs
of the master controller.

The 8259 is a very old device, dating from around 1980.  Under the
influence of contemporary minicomputer designs, the 8259 made a brave
attempt to build an interrupt priority system in hardware for Intel
8-bit and 8086 CPUs.  With the benefit of 20 years hindsight, we can
see this was pretty silly (but that's a lot of hindsight, and the
people who did it were much younger then).

When separated from its Intel CPU, the 8259 is unable to do exciting
things like automatically causing the CPU to vector to an appropriate
interrupt vector location.  Experience shows that allowing it to do
anything complicated is likely to lead to trouble, so we suggest:

1. Don't use the 8259's priority logic.  Instead, place both the
   master and slave controller into what the Intel manuals call
   Special Mask Mode.  This disables all interrupt prioritisation; now
   any active and unmasked interrupt input will activate the interrupt
   output, which is enough.

2. Do not ever read the ISR (``in-service'') registers.  They don't
   make sense outside of the priority scheme.  If you want to know
   what individual interrupt lines are doing, look in the IRR
   (``interrupt request'') registers instead.  (You'll have to use
   soft copies of the current mask values to tell which of these
   bits to attend to).

3. Conclude each interrupt service routine with a ``Specific end-of-
   interrupt (EOI)'' command to the 8259.  In special mask mode this
   doesn't do anything to the priority, but it does serve to clear a
   latched interrupt, if there is one.  (There are other ways of doing
   this).

		*           *           *           *

One or two of the PC interrupts must, I think, be edge-triggered: but
most of them should not be.

I know, it's a pain, you want to maximise compatibility with x86
drivers.  But I suspect you're just burying problems which will surely
rise again.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk

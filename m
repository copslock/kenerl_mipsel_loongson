Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 14:35:43 +0000 (GMT)
Received: from alg133.algor.co.uk ([IPv6:::ffff:62.254.210.133]:61433 "EHLO
	oalggw.algor.co.uk") by linux-mips.org with ESMTP
	id <S8225272AbSLQOfm>; Tue, 17 Dec 2002 14:35:42 +0000
Received: from arsenal.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gBHEZSW27119;
	Tue, 17 Dec 2002 14:35:28 GMT
Received: from dom by arsenal.algor.co.uk with local (Exim 3.35 #1 (Debian))
	id 18OIoc-0008Br-00; Tue, 17 Dec 2002 14:35:22 +0000
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15871.13866.515311.16388@arsenal.algor.co.uk>
Date: Tue, 17 Dec 2002 14:35:22 +0000
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl>
References: <20021216124009.D10178@mvista.com>
	<Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


>  The i8259A doesn't work this way.  With your proposed code the IRR
> is never cleared (which is a problem for edge-triggered interrupts
> -- such an interrupt gets signalled again once it's unmasked, until
> deasserted by a device).  The i8259A only clears a bit in the IRR
> when it receives an ACK (it then copies the bit to the corresponding
> bit of the ISR) or when an interrupt goes away (a device deasserts
> it).

Just a few comments on the hardware:

As I recall, you can clear a stored edge-triggered interrupt using a
"specific EOI".  In the 8080 microprocessor for which the 8259 was
designed, this command was magically communicated to the 8259 when the
CPU ran its "return from interrupt" instruction.  I think even in the
8086 this had to be replaced with an explicit I/O cycle.

People not using x86 CPUs should consider putting the i8259 into
"special mask mode".  Then it behaves simply and predictably,
providing an interrupt on any active unmasked input.  You lose the
i8259 interrupt priority stuff, but this is only one of the
advantages.  You'd need to be reasonably knowledgeable about the Linux
interrupt system to make this clean and compatible with the x86
versions, but then these troubles would be over for ever and you'd be
a Hero, First Class.

Alternatively, many MIPS systems have a hardware feature which enables
them to generate imitation-x86 interrupt acknowledge cycles, so you
can keep the 8259s in complete ignorance that they're not being
controlled by an x86.  

--
Dominic Sweetman
MIPS Technologies
dom@mips.com

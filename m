Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 13:19:19 +0000 (GMT)
Received: from p508B6BAF.dip.t-dialin.net ([IPv6:::ffff:80.139.107.175]:23495
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225383AbTKQNTH>; Mon, 17 Nov 2003 13:19:07 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAHDJ5A0006432;
	Mon, 17 Nov 2003 14:19:05 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAHDJ4kp006423;
	Mon, 17 Nov 2003 14:19:04 +0100
Date: Mon, 17 Nov 2003 14:19:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ashish anand <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: is cp0 interrupt infrastructure sufficient..?
Message-ID: <20031117131904.GC5221@linux-mips.org>
References: <20031117114011.22352.qmail@webmail27.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117114011.22352.qmail@webmail27.rediffmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 17, 2003 at 11:40:11AM -0000, ashish  anand wrote:

> I have a generic question regarding interrupt controler functionality 
> integrated in CP0 on mips architecture.
> I don't see any interface to configure the edge/level triggering settings.

MIPS only supports level triggered interrupts in coprocessor 0.

> though in our BSP we take care of handling spurious interrupts , but is
> this designed to be like that..?

There is no handling needed.  If the processor takes an interrupt but none
of the interrupt bits in c0_status is set, just return.  That's a legal
condition.

> I mean to ask , suppose I want to add a edge triggering peripheral.
> to the extent of my understanding this will certainly generate the
> spurious interrupts when coupled with a level triggering configuration 
> in CP0 (by default..?).

You can directly sample the level of the edge irq in the interrupt bits in
the cause register.  But that seems a fragile approach.

> if i am handling through CP0_CAUSE or any other register inspection
> that can work but I am loosing so many valid interupts which would have
> been really valid with edge trigger pin of interrupt controller  .
> further this type of handling is valid for actual spurious interrupts 
> not for those who are certain to be fired because of edge/level mismatching.

If you really need to use an edge triggered interrupt on a MIPS then you
probably want to use some circuit interrupt controller that converts the
edge to a level triggered interrupt.  

  Ralf

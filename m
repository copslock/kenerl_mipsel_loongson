Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 12:30:48 +0000 (GMT)
Received: from p508B62C3.dip.t-dialin.net ([IPv6:::ffff:80.139.98.195]:45955
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225316AbTKDMah>; Tue, 4 Nov 2003 12:30:37 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id hA4CUZsY004802;
	Tue, 4 Nov 2003 13:30:35 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hA4CUYrH004801;
	Tue, 4 Nov 2003 13:30:34 +0100
Date: Tue, 4 Nov 2003 13:30:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adeel Malik <AdeelM@quartics.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How to request an IRQ for NMI on MIPS Processor
Message-ID: <20031104123034.GA4048@linux-mips.org>
References: <10C6C1971DA00C4BB87AC0206E3CA38264F542@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38264F542@1aurora.enabtech>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 04, 2003 at 04:56:08PM +0500, Adeel Malik wrote:

>           In my embedded design, I intend to use NMI of MIPS 4Kc processor
> (rather than IRQ0 or IRQ1 .....) for an external Interrupt Source. The
> external Interrupt source is a video capture device which interrupts the
> MIPS 4Kc CPU via its NMI (Non-Maskable Interrupt) line, whenever it has one
> complete frame. I need to write the driver for that device in Linux-2.4.20.
> The request_irq function provided by Linux takes a digit value from 0 to 5
> to map external interrupt sources to any one of CPUs Interrupt pins. How can
> I request and implement my interrupt handler routine for the NMI of MIPS
> processor ?.

Is there any particular reason for using the NMI?

NMI on MIPS is pretty much miss-designed for use in application code; it's
use should be limited to debugging and recovery from catastrophical
failure.  The reason for this is the way this exception is handled:

  - the BEV, TS, SR, NMI and ERL bits in c0_status are overwritten - that is
    their old state is lost.
  - c0_errorepc is overwritten - again that means the old value is lost so
    in case the NMI interrupts an exception handler that uses this register
    such as the cache error handler you can not resume execution.
  - the program counter is set to 0xbfc00000.  Most likely a slow flash
    memory is mapped at this address but in any case it's an uncached
    segment of the address space so execution will be even slower.
  - execution will pass through the firmware.  That means you can only
    use the NMI at all if firmware provides some kind of hook.

It seems pretty clear to me that the MIPS designers never intended the
NMI for anything else than catastrophic events.

  Ralf

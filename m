Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 12:58:54 +0000 (GMT)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:28377
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225316AbTKDM6m>; Tue, 4 Nov 2003 12:58:42 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <WHAQ22BV>; Tue, 4 Nov 2003 17:58:32 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264F543@1aurora.enabtech>
From: Adeel Malik <AdeelM@quartics.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: RE: How to request an IRQ for NMI on MIPS Processor
Date: Tue, 4 Nov 2003 17:58:32 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Return-Path: <AdeelM@quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@quartics.com
Precedence: bulk
X-list: linux-mips

Hi Ralph,
	   Thanks for the reply. Yes you are right that NMI isn't meant to
be used as a regular IRQ of MIPS Processor. But somehow the board designer
connected the External Interrupt from video capture device to the NMI and
now I am thinking as how to how implement the Interrupt handler routine for
the NMI of MIPS processor. Do you think that we need to re-route the Board
or there may be some patch available describing the implementation of
Interrupt handler for NMI of MIPS 4Kc.

Regards, 	

ADEEL MALIK,


-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ralf Baechle
Sent: Tuesday, November 04, 2003 5:31 PM
To: Adeel Malik
Cc: linux-mips@linux-mips.org
Subject: Re: How to request an IRQ for NMI on MIPS Processor


On Tue, Nov 04, 2003 at 04:56:08PM +0500, Adeel Malik wrote:

>           In my embedded design, I intend to use NMI of MIPS 4Kc processor
> (rather than IRQ0 or IRQ1 .....) for an external Interrupt Source. The
> external Interrupt source is a video capture device which interrupts the
> MIPS 4Kc CPU via its NMI (Non-Maskable Interrupt) line, whenever it has
one
> complete frame. I need to write the driver for that device in
Linux-2.4.20.
> The request_irq function provided by Linux takes a digit value from 0 to 5
> to map external interrupt sources to any one of CPUs Interrupt pins. How
can
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

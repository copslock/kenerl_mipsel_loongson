Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 12:24:59 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:23829 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133489AbWAWMXq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 12:23:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NCRK0l005416;
	Mon, 23 Jan 2006 12:28:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0LBKnFj003531;
	Sat, 21 Jan 2006 11:20:49 GMT
Date:	Sat, 21 Jan 2006 11:20:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Time slowing down while doing IDE PIO transfer
Message-ID: <20060121112048.GA3456@linux-mips.org>
References: <1137777997.16631.147.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137777997.16631.147.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 20, 2006 at 06:26:37PM +0100, Maxime Bizon wrote:

> I have a R4Kec board with an IDE controller, and run linux-mips 2.6.14
> on it. When running a transfer on a cdrom drive, with dma disabled and
> at lowest pio mode, time is slowing down (about 10 times too slow).
> 
> HZ is 1000, I'm using generic mips timer code (arch/mips/kernel/time.c),
> HPT and timer interrupts are R4K.
> 
> This is I guess related to the interrupts being disabled during pio
> transfer (I can't use unmaskirq btw).

This by itself sounds like a bug.

> Looking at timer_interrupt() code, I see that do_timer() will be only
> called once, whether we have lost timer interrupts or not, I guess this
> is the reason of this time problem. Is it a wanted behaviour ?

"Yes" - because properly designed systems shouldn't loose interrupts.
Your problem isn't new but so for everybody was able to solve it by
unmasking interrupts.

> If this is the case, I guess my only hope is running with lower HZ or
> using an RTC ?

Dependig on your processor's clock a lower HZ may indeed be a good idea
just to keep the interrupt overhead down.  You should test yourself what
the optimal balance between latency and overhead it.

If lowering HZ doesn't solve the clock problem you may want to add a
loop to call the timer interrupt repeatedly.

  Ralf

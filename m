Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 16:21:48 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:3024 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027192AbXFGPVq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 16:21:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57FEmPu024225;
	Thu, 7 Jun 2007 16:14:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57FElXJ024224;
	Thu, 7 Jun 2007 16:14:47 +0100
Date:	Thu, 7 Jun 2007 16:14:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070607151447.GF26047@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com> <20070607113032.GA26047@linux-mips.org> <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 03:11:48PM +0200, Franck Bui-Huu wrote:

> Actually I'm wondering if we shouldn't create a new file
> "arch/mips/kernel/time2.c" which will be a complete rewrite of the
> old one (interrupt handler, function pointers, clocksource,
> clockevent). This file would be the future replacement of the old
> time.c. This new file would be used only if the board have been
> updated accordingly. That may help to migrate...

And we'll still be stuck with the compat crap for years - no thank you.
One of the strength of Linux has always been that if necessary we've been
able to turn the code base upside down as needed - even if sometimes it
takes a snow plough to move old stuff out of the way ;-)

> >You can mask the count/compare interrupt in the status register like any
> >other interrupt.  Keep in mind that on many CPUs this interrupt is
> >shared with the performance counter interrupt so cannot always be
> >disabled.
> 
> Well this interrupt could be shared with other devices too, couldn't it ?
> If so only the board code can disable it.

No, the boot mode bit controls a multiplexer so there is either count/compare
or the external interrupt.

> >There is no other disable bit for this interrupt than the IE bit in the
> >status register.  So it may just have to be ignored.
> >
> 
> That would mean we can't have a tickless system in these cases, wouldn't
> it ?

It would simply mean we will receive a useless every 2^32 cycles - nothing
terrible.  The tickless kernel isn't really tickless.  It's more accurately
called dyntick.  One thing that keeps us from completly getting rid of
regular timer interrupts under all circumstances is the current scheduler.
Only if a CPU is idle Linux can stop the regular timer interrupts for it.
With all the software interrupts that happen to be running on a usual
system we expect just a hand full of interrupts per second.  And the good
news is that mingo's current scheduler work is going to remove the concept
of time slices from the scheduler and once that is done we _finally_ will
be able to go even on non-idle CPUs.

  Ralf

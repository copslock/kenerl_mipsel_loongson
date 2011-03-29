Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 15:20:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35036 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2100747Ab1C2NUQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2011 15:20:16 +0200
Date:   Tue, 29 Mar 2011 14:20:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:     tglx@linutronix.de, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch 06/38] mips: dec: Convert to new irq_chip functions
In-Reply-To: <20110329.215637.193684107.anemo@mba.ocn.ne.jp>
Message-ID: <alpine.LFD.2.00.1103291359400.32219@eddie.linux-mips.org>
References: <alpine.LFD.2.00.1103241808300.18858@eddie.linux-mips.org>        <alpine.LFD.2.00.1103242024470.31464@localhost6.localdomain6>        <alpine.LFD.2.00.1103250005470.18858@eddie.linux-mips.org> <20110329.215637.193684107.anemo@mba.ocn.ne.jp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 29 Mar 2011, Atsushi Nemoto wrote:

> > > Then that code was broken before. Since MIPS was converted to the flow
> > > handlers nothing ever called .end(). I seem to miss something.
> ...
> >  I'll see what I can do about it, but I need a pointer to the offending 
> > change -- Ralf or anyone, can you provide me with one?
> 
> JFYI from my old memory...
> 
> On 2006, I once converted ioasic_irq and ioasic_dma_irq to the flow
> handlers, and then revert ioasic_dma_irq to old style.
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20061202.000803.05599975.anemo%40mba.ocn.ne.jp
> 
> Then, Franck Bui-Huu added GENERIC_HARDIRQS_NO__DO_IRQ to some
> platforms but not DECstation.
> 
> And then, on 2009, Ralf enabled GENERIC_HARDIRQS_NO__DO_IRQ for all
> platforms.
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20090311112806.GA24541%40linux-mips.org
> 
> I suppose something was lost at this conversion, but not sure.

 OK, thanks.

 I've had a look into the issue and my understanding at the moment is the 
IOASIC DMA interrupts will need a dedicated handler along the lines of the 
old approach, i.e. mask at the beginning (because the output is 
level-triggered) to let other interrupts through, call the high-level 
handler, and issue an EOI and unmask at the end (some of these interrupts 
are informational only so the EOI could well be issued at the beginning, 
but there's no gain from doing so that would justify the extra 
diversification).  I've noticed some other (non-MIPS) platforms use their 
own handlers too, so it's not the only one the new generic handlers do not 
fit, sigh...  I'll see what I can do about this problem.

 OTOH, the remaining ordinary IOASIC interrupts are just plain old 
level-triggered pass-through signals with no actions beyond mask/unmask 
required/available at the interrupt controller level, so the 
handle_level_irq() is exactly what they need.

 As I say, except from our driver for the onboard SCSI adapter (that is 
pending a revive), we only use these DMA interrupts for exceptional 
conditions, such as a memory error during a DMA transaction, so they 
hardly ever happen and any run-time breakage could have survived for long.

  Maciej

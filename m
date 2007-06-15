Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 15:25:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:48071 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022458AbXFOOZc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 15:25:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5FELNLS010811;
	Fri, 15 Jun 2007 15:21:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5FELMAp010810;
	Fri, 15 Jun 2007 15:21:22 +0100
Date:	Fri, 15 Jun 2007 15:21:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
	code.
Message-ID: <20070615142122.GC16133@linux-mips.org>
References: <11818164023940-git-send-email-fbuihuu@gmail.com> <20070614111748.GA8223@alpha.franken.de> <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl> <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com> <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl> <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com> <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl> <20070615132613.GA16133@linux-mips.org> <Pine.LNX.4.64N.0706151446020.3754@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64N.0706151446020.3754@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 15, 2007 at 03:08:14PM +0100, Maciej W. Rozycki wrote:

> > The tickless kernel needs something that can be used as oneshoot timer.
> 
>  A periodic timer typically works here just fine -- just "forget" about 
> the future shots. ;-)

That's pretty much how for example on an R1 core the compare interrupt
has to be used - IE7 is shared with the performance counter so can't be
disabled and as the result if the cp0 clockevent device is unused we will
get one useless but also harmless interrupt every 2^32 cycles.

>  Even the miserable 8254/8259 combination is fine as 
> the former in the mode #2 only deasserts its output for its one input 
> clock, so the latter will only miss an interrupt if it has been on hold 
> for much too long anyway.  With an interrupt controller that implements 
> real edge-triggered inputs even this single clock is not an issue.
> 
> > >  Note that the 8254 can be reprogrammed into a one-shot mode, but somehow 
> > > nobody does it. ;-)  Similarly for the local APIC timer that is used for 
> > > scheduling on i386 systems (if available).
> > 
> > Actually modern i386 kernels use it in both modes.  But this can't help
> 
>  Oh really?  How many clone chipset bugs has it triggered? ;-)

I'm sure you couldn't miss the screaming on linux-kernel ;-)

> > over the fact that the i8253/i8254 is a horrible chip with extremly slow
> > access times so it's only used as the fallback when everything else fails.
> 
>  The chip is typically in the south bridge these days, so the access time 
> is not as bad itself as it used to be when it was a discrete one somewhere 
> on the x-bus, but the actual problem is the typical Intel baroque way of 
> accessing the counter: ask it to latch the current value, then issue two 
> reads to retrieve the two halves of the counter, plus check the lower half 
> has not overflown into the upper one meanwhile in case the latch command 
> did not work because of a chipset bug. ;-)

Actually these days it seems to be living inside the southbridge behind
an extremly slow interface which is optimized for minimum connections to
the rest of the southbridge.  So I'm told the access time is still around
2µs which is basically as crappy as it always has been.

  Ralf

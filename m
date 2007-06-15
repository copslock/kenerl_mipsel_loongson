Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 15:08:22 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:44810 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022450AbXFOOIT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 15:08:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8D3FEE1D13;
	Fri, 15 Jun 2007 16:08:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJHA0IZG1+uj; Fri, 15 Jun 2007 16:08:07 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 44DD4E1C6B;
	Fri, 15 Jun 2007 16:08:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5FE8Io4006479;
	Fri, 15 Jun 2007 16:08:18 +0200
Date:	Fri, 15 Jun 2007 15:08:14 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
In-Reply-To: <20070615132613.GA16133@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0706151446020.3754@blysk.ds.pg.gda.pl>
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
 <11818164023940-git-send-email-fbuihuu@gmail.com> <20070614111748.GA8223@alpha.franken.de>
 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
 <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
 <20070615132613.GA16133@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3427/Fri Jun 15 15:01:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 15 Jun 2007, Ralf Baechle wrote:

> The cp0 timer may have disadvantages but it certainly is the timer with
> the lowest overhead to program, usually the timer with the highest
> resolution.  Unless in the rare cases where cp0 cannot be used because
> it cannot trigger interrupts or the CPU clock is variable I think it will
> always be the clockevent device of choice.

 No argument about the overhead or the resolution, but these are the kinds 
of properties that make it more appropriate for other purposes like 
profiling or other short interval measurements, not necessarily for 
timekeeping.

> The tickless kernel needs something that can be used as oneshoot timer.

 A periodic timer typically works here just fine -- just "forget" about 
the future shots. ;-)  Even the miserable 8254/8259 combination is fine as 
the former in the mode #2 only deasserts its output for its one input 
clock, so the latter will only miss an interrupt if it has been on hold 
for much too long anyway.  With an interrupt controller that implements 
real edge-triggered inputs even this single clock is not an issue.

> >  Note that the 8254 can be reprogrammed into a one-shot mode, but somehow 
> > nobody does it. ;-)  Similarly for the local APIC timer that is used for 
> > scheduling on i386 systems (if available).
> 
> Actually modern i386 kernels use it in both modes.  But this can't help

 Oh really?  How many clone chipset bugs has it triggered? ;-)

> over the fact that the i8253/i8254 is a horrible chip with extremly slow
> access times so it's only used as the fallback when everything else fails.

 The chip is typically in the south bridge these days, so the access time 
is not as bad itself as it used to be when it was a discrete one somewhere 
on the x-bus, but the actual problem is the typical Intel baroque way of 
accessing the counter: ask it to latch the current value, then issue two 
reads to retrieve the two halves of the counter, plus check the lower half 
has not overflown into the upper one meanwhile in case the latch command 
did not work because of a chipset bug. ;-)

  Maciej

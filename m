Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 17:46:22 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5129 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021781AbXFNQqT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 17:46:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C0698E1D18;
	Thu, 14 Jun 2007 18:45:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVXbnaWXWt6l; Thu, 14 Jun 2007 18:45:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 34D65E1C6B;
	Thu, 14 Jun 2007 18:45:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5EGjmiF012303;
	Thu, 14 Jun 2007 18:45:48 +0200
Date:	Thu, 14 Jun 2007 17:45:43 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
In-Reply-To: <cda58cb80706140852k12dafadbjbffbe470608f540c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0706141733210.25868@blysk.ds.pg.gda.pl>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> 
 <11818164023940-git-send-email-fbuihuu@gmail.com>  <20070614111748.GA8223@alpha.franken.de>
  <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> 
 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
 <cda58cb80706140852k12dafadbjbffbe470608f540c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3419/Thu Jun 14 15:49:39 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Jun 2007, Franck Bui-Huu wrote:

> > I'll have a look at your patches, but I hope you have got about the most
> > interesting configuration right, which is the DEC platform
> 
> hmm, I looked at arch/mips/dec/time.c, and I'm not sure to understand it.
> Could you give me more info ?

 Whatever you like!

> To be sure we're taking about the same thing, I'm calling "hpt" the timer
> in CP0 _only_. If you have others timers let's call them "timer".

 We can agree on it for the purpose of this consideration, but otherwise 
HPT is meant to mean a High-Precision Counter, that is a counter that 
improves the resolution (precision) of that given by the timer interrupt 
itself.  This is how current code interpretes the name too.

> > where you can have one of these:
> >
> > 1. No HPT at all.
> >
> 
> What's generating the tick interrupt in this case ?

 For DEC an external DS1287 is always the timer interrupt source.  In this 
case this is the resolution you can get from gettimeofday() -- not 
terribly impressive.

> > 2. HPT in the chipset.
> >
> 
> What do you mean by chipset ? the DS1287 ?

 This is one of the motherboard components, called IOASIC.  Starting from 
a certain revision this chip includes a 32-bit free-running counter 
(timer) that is clocked from the TURBOchannel (the peripheral bus used in 
these systems) clock, which varies across systems, but is somewhere 
between 12.5MHz and 25MHz.

 Obviously the DS1287 does not include any kind of readable timer that 
could improve the resolution of the timer interrupt -- otherwise this 
whole complication would be a non-issue.

> > 3. HPT in CP0.
> >
> 
> Reading the dec code, it seems that whatever the case, you don't use
> the hpt cp0 as tick interrupt source. It's only use as a clock source.
> If so, why ?

 That is correct and there is no reason to use the CP0 timer interrupt as 
it has its issues (as mentioned in the other mail) and all the DEC systems 
that we support have a DS1287 chip that can generate a timer interrupt 
just fine.  The CP0 counter register is only used as a 32-bit free-running 
counter (timer) to improve the resolution of time recorded by timer 
interrupts.

  Maciej

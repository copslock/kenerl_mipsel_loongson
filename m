Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 17:33:40 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37384 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023656AbXFNQdi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 17:33:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3DB91E1D18;
	Thu, 14 Jun 2007 18:32:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Jd9k3jKxNce; Thu, 14 Jun 2007 18:32:54 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DA31CE1C6B;
	Thu, 14 Jun 2007 18:32:53 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5EGX7IN010124;
	Thu, 14 Jun 2007 18:33:07 +0200
Date:	Thu, 14 Jun 2007 17:33:02 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
In-Reply-To: <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> 
 <11818164023940-git-send-email-fbuihuu@gmail.com>  <20070614111748.GA8223@alpha.franken.de>
  <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> 
 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3419/Thu Jun 14 15:49:39 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Jun 2007, Franck Bui-Huu wrote:

> > Which should normally be the case unless there is no way to do
> > calibration, when a platform can provide a hardcoded value.  There is
> > nothing to guess here.
> >
> 
> Are you sure it's the normal case? I would say that only DEC needs
> that calibration:
> 
> Doing the following on the _current_ tree:
> 
> $ git grep -l mips_timer_state arch/mips
> arch/mips/dec/time.c
> arch/mips/kernel/time.c

 Well, many platforms have some sort of external timer interrupt sources 
(like an 8254 or an DS1287 or even a more sophisticated timer; sometimes 
integrated in the south bridge and collecting dust there), but people tend 
to follow the path of least resistance and use the CP0 timer, even though 
it is is a valuable resource that may be used for some other purposes.  I 
think the issue has been raised here many times already.  The CP0 timer 
has its problems too as it is one-shot only and needs complicated recovery 
if an interrupt is missed -- see c0_timer_ack().

 Please note that this generic calibration code may be used for 
calibrating the CP0 timer too -- all that you need is defining 
mips_timer_state appropriately, i.e. to flip at the HZ rate (it may be 
based on one of the south bridge choices mentioned above or some 
free-running counter for example), but people seem to prefer to write 
their own code for some reason. ;-)

> > 1. No HPT at all.
> >
> > 2. HPT in the chipset.
> >
> > 3. HPT in CP0.
> >
> > depending on the configuration as determined at the run time, with no
> > predefined frequency in the cases #2 and #3.
> >
> 
> Good to know.

 And FYI for DEC CP0 is meant to be the last resort (current code does not 
get it exactly right, I know -- I forgot to look at it at some point) as 
there is exactly one platform that has no HPT in the chipset and uses an 
R4k processor at the same time (the 5000/150 for those that care -- the 
free-running counter was added in a later revision of the IOASIC).  All 
the others either have a HPT in the chipset or only support R3k-class 
processors with no CP0 timer.

  Maciej

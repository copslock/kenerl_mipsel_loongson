Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 15:51:20 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:37134 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224903AbVITOu7>; Tue, 20 Sep 2005 15:50:59 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3310EF5978; Tue, 20 Sep 2005 16:50:52 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15158-02; Tue, 20 Sep 2005 16:50:52 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B4997F5977; Tue, 20 Sep 2005 16:50:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j8KEoqh1011229;
	Tue, 20 Sep 2005 16:50:52 +0200
Date:	Tue, 20 Sep 2005 15:51:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
In-Reply-To: <17200.3119.436273.291080@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.61L.0509201451520.23494@blysk.ds.pg.gda.pl>
References: <20050919154056.GG3386@hattusa.textio>
 <Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl> <17199.53696.27856.801284@mips.com>
 <Pine.LNX.4.61L.0509201017220.23494@blysk.ds.pg.gda.pl>
 <17200.3119.436273.291080@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1091/Tue Sep 20 15:59:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 20 Sep 2005, Dominic Sweetman wrote:

> > Besides new CPUs more often than not 
> > require changes to kernel-level software anyway.
> 
> Making sure that isn't so is the reason why there's a MIPS32/64 spec
> (with all the privileged operations defined).  Which also avoids the
> undesirable development step of new hardware combined with new kernel
> software... 

 Except that clairvoyance does not work reliably in the long run, so while 
you may be able to run old software with no changes on a new chip using a 
subset of its capabilities, you probably still want to update your kernel 
to better exploit the new design.

> >  I just disabled invalidations. ;-)
> 
> Ouch.  So the effect could have come from a variety of sources.

 Yes, I should have probably really done a better arrangement -- but I had 
limited time for testing, so I did just a rough estimate.  I should get 
back to it eventually as that piece of code requires further tuning.

> > Ironically this is where the write-back cache of the R4k gives loss
> > rather than gain as compared to the write-through cache of the R3k
> > (the system supports daughtercards with either CPU, so useful
> > comparison is possible)...
> 
> Maybe.  But remember, on the R3K every write was a write through, and
> they all had a cost in bus congestion, which may have delayed a
> following read and held up the CPU (or the write buffer may have
> filled and stalled the CPU). 

 Effective bandwidth of DRAM memory for the system is documented to be 
100MB/s and the R3k used (the PACEMIPS R3400) is clocked @40MHz (the R4400 
on the other daughterboard is clocked @60MHz).  Therefore while I believe 
congestion is indeed possible, it's not really that common with PIO, 
especially as the CPU has a priority over DMA traffic.  Except from 
partial word writes which require RMW cycles at the memory controller 
level due to ECC (but they are not used for bulk transfers anyway).

> I think up to about 33MHz write-through remained a tolerable policy
> for 1988-era memory systems; any faster than that and you just sank
> under a flood of writes.  2005-era memory systems are much faster when
> bursting, but the time they take to process a single write cycle has
> improved by less than 2x.  So write-through is still a really bad idea
> for 100MHz CPUs using off-chip memory.

 Certainly.  It's just systems with a lot of DMA traffic do really beg for 
hardware-maintained coherence.

> Even when your device requires you to push out all the data it can be
> more efficient to write data to the cache and then force writeback to
> memory: at least that way the data goes to the memory in efficient
> burst cycles.

 That's assuming cache does write-allocation, which is not always the 
case.

  Maciej

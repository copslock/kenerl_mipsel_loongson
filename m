Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 21:55:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:17672 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225990AbVF0UzV>; Mon, 27 Jun 2005 21:55:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B2F38E1C95; Mon, 27 Jun 2005 22:54:36 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11719-03; Mon, 27 Jun 2005 22:54:36 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 037B2E1C8A; Mon, 27 Jun 2005 22:54:36 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5RKsfdv008529;
	Mon, 27 Jun 2005 22:54:41 +0200
Date:	Mon, 27 Jun 2005 21:54:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
In-Reply-To: <20050627141842.GA28236@gaspode.automagically.de>
Message-ID: <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
References: <20050627100757.GA27679@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
 <20050627141842.GA28236@gaspode.automagically.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/958/Mon Jun 27 00:22:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Jun 2005, Markus Dahms wrote:

> >  Hmm, it might be a problem with TLB handlers that have been changed to be 
> > built at the run time.  Perhaps the R4600 isn't handled right as a result.  
> > What's the CPU revision ID? -- it's printed right at the beginning.
> 
> | CPU revision is: 00002020
> | FPU revision is: 00002020

 That's what I'm interested in -- the R4600 is fancy enough they've 
implemented different quirks with different revisions. ;-)

> | Synthesized TLB refill handler (30 instructions).
> | Synthesized TLB load handler fastpath (43 instructions).
> | Synthesized TLB store handler fastpath (43 instructions).
> | Synthesized TLB modify handler fastpath (42 instructions).
> 
> the TLB stuff, if it's of interest...

 I might ask about more detailed dumps of these, but for now I'll just 
check the sources for obvious problems.

> | ...
> | Calibrating system timer... warning: timer counts differ, retrying...\
> | disagreement, using average... 44500 [89.0000 MHz CPU]
> | Using 44.500 MHz high precision timer.
> 
> this is strange, too. It's a 133MHz CPU as kernel 2.4.x correctly
> recognizes.
> 
> For the R4000 there are two other things I could try: console on newport
> instead of serial port and a 32-bit kernel, which I only tried on the
> R4600.

 Well, I don't know what newport is, but if it's capable of providing 
output that early, it'll do.

> I'll also try the said patch (you're referring to "blast_scache nop ...", do
> you?).

 Precisely.

  Maciej

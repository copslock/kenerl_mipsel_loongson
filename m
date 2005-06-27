Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 20:44:19 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:1035 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225987AbVF0ToC>; Mon, 27 Jun 2005 20:44:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 752A8E1C95; Mon, 27 Jun 2005 21:43:24 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26825-10; Mon, 27 Jun 2005 21:43:24 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 06214E1C79; Mon, 27 Jun 2005 21:43:24 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5RJhS1H005189;
	Mon, 27 Jun 2005 21:43:29 +0200
Date:	Mon, 27 Jun 2005 20:43:40 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
In-Reply-To: <20050627190910.GA13292@alpha.franken.de>
Message-ID: <Pine.LNX.4.61L.0506272035290.23903@blysk.ds.pg.gda.pl>
References: <20050625131938.GA7669@paradigm.rfc822.org> <20050625160316.GP6953@linux-mips.org>
 <20050625175048.GA25276@alpha.franken.de> <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
 <20050627190910.GA13292@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/958/Mon Jun 27 00:22:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Jun 2005, Thomas Bogendoerfer wrote:

> >  Are you sure CONF_SC isn't set?
> 
> I've checked that after we saw a crash in __flush_cache_all().

 I see -- that's OK.

> > That would be weird, it's one of the boot-mode settings so it would be
> > hard to get it wrong.  What's printed upon bootstrap about caches?
> 
> I don't have the console working yet, we just put enough prom_printf()s
> to work out, what was going wron.

 How about using these prom_printf()s to implement a real early printk()?  
You'd save yourself and perhaps others a lot of hassle.

> I'm also not sure, whether adding the blast_scache_nop() stuff is
> the way to go. I'd probably throw out the switch case over CPU types
> and use a single test before calling r4k_blast_scache(). Hmm, the
> probably cheapest version would be:
> 
> 	if (r4k_blast_scache)
> 		r4k_blast_scache();
> 
> Problem solved.

 Probably, but there are actually other conditions already used, which may 
happen to fit, or otherwise you are rather after creating "cpu_has_scache" 
which would expand to a bit test for cpu_data[0].options or 0 or 1 as 
appropriate, depending on platform settings.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 20:26:23 +0100 (BST)
Received: from elvis.franken.de ([IPv6:::ffff:193.175.24.41]:9147 "EHLO
	elvis.franken.de") by linux-mips.org with ESMTP id <S8225987AbVF0T0E>;
	Mon, 27 Jun 2005 20:26:04 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1DmzEa-0007tF-03; Mon, 27 Jun 2005 21:25:32 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id B10C827C45; Mon, 27 Jun 2005 21:09:10 +0200 (CEST)
Date:	Mon, 27 Jun 2005 21:09:10 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
Message-ID: <20050627190910.GA13292@alpha.franken.de>
References: <20050625131938.GA7669@paradigm.rfc822.org> <20050625160316.GP6953@linux-mips.org> <20050625175048.GA25276@alpha.franken.de> <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Jun 27, 2005 at 01:45:39PM +0100, Maciej W. Rozycki wrote:
>  Are you sure CONF_SC isn't set?

I've checked that after we saw a crash in __flush_cache_all().

> That would be weird, it's one of the boot-mode settings so it would be
> hard to get it wrong.  What's printed upon bootstrap about caches?

I don't have the console working yet, we just put enough prom_printf()s
to work out, what was going wron.

> (but it may break elsewhere).  Have I heard: "serious brain damage" from 
> you?  Well, I couldn't agree more...

well, I haven't digged deep enough, to have a good opion on the whole
issue.

I'm also not sure, whether adding the blast_scache_nop() stuff is
the way to go. I'd probably throw out the switch case over CPU types
and use a single test before calling r4k_blast_scache(). Hmm, the
probably cheapest version would be:

	if (r4k_blast_scache)
		r4k_blast_scache();

Problem solved.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

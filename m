Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 19:25:50 +0100 (BST)
Received: from elvis.franken.de ([IPv6:::ffff:193.175.24.41]:51080 "EHLO
	elvis.franken.de") by linux-mips.org with ESMTP id <S8225735AbVFYSZe>;
	Sat, 25 Jun 2005 19:25:34 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1DmEqO-0000iR-04; Sat, 25 Jun 2005 19:53:28 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id D453D27C7D; Sat, 25 Jun 2005 19:50:48 +0200 (CEST)
Date:	Sat, 25 Jun 2005 19:50:48 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
Message-ID: <20050625175048.GA25276@alpha.franken.de>
References: <20050625131938.GA7669@paradigm.rfc822.org> <20050625160316.GP6953@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625160316.GP6953@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Jun 25, 2005 at 06:03:16PM +0200, Ralf Baechle wrote:
> On Sat, Jun 25, 2005 at 03:19:38PM +0200, Florian Lohoff wrote:
> 
> > Subject: [patch] blast_scache nop for sc cpus without scache
> 
> Interesting.  Which system needs this patch?

RM400; looks like the secondary cache on the cpu module isn't normally
attached, but like the board caches on den Indy. CONF_SC isn't set
in cp0 config, but the cpu is an R4400SC -> crash in r4k_scache_blast*.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 13:46:23 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:6160 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225399AbVF0MqH>; Mon, 27 Jun 2005 13:46:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 44027E1CAC; Mon, 27 Jun 2005 14:45:30 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26842-01; Mon, 27 Jun 2005 14:45:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A52BCE1C95; Mon, 27 Jun 2005 14:45:29 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5RCjWua016775;
	Mon, 27 Jun 2005 14:45:32 +0200
Date:	Mon, 27 Jun 2005 13:45:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
In-Reply-To: <20050625175048.GA25276@alpha.franken.de>
Message-ID: <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
References: <20050625131938.GA7669@paradigm.rfc822.org> <20050625160316.GP6953@linux-mips.org>
 <20050625175048.GA25276@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/958/Mon Jun 27 00:22:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 25 Jun 2005, Thomas Bogendoerfer wrote:

> > > Subject: [patch] blast_scache nop for sc cpus without scache
> > 
> > Interesting.  Which system needs this patch?
> 
> RM400; looks like the secondary cache on the cpu module isn't normally
> attached, but like the board caches on den Indy. CONF_SC isn't set
> in cp0 config, but the cpu is an R4400SC -> crash in r4k_scache_blast*.

 Are you sure CONF_SC isn't set?  That would be weird, it's one of the 
boot-mode settings so it would be hard to get it wrong.  What's printed 
upon bootstrap about caches?

 Anyway these days we apparently ignore the result of the S-cache probe 
and the sc_present variable.  The only values that determine whether an 
S-cache is present or not are: cpu_has_dc_aliases, cpu_has_ic_fills_f_dc 
and cpu_has_subset_pcaches which you need to get right for your 
configuration -- I guess cpu_has_dc_aliases == 0, cpu_has_ic_fills_f_dc == 
1 and cpu_has_subset_pcaches == 0 should be right to fulfil your needs 
(but it may break elsewhere).  Have I heard: "serious brain damage" from 
you?  Well, I couldn't agree more...

  Maciej

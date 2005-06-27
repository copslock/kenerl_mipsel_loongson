Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 16:31:46 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:35858 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225976AbVF0PbZ>; Mon, 27 Jun 2005 16:31:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BB84CE1C8D; Mon, 27 Jun 2005 17:30:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27347-10; Mon, 27 Jun 2005 17:30:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 66B70E1C8A; Mon, 27 Jun 2005 17:30:47 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5RFUpIv025119;
	Mon, 27 Jun 2005 17:30:51 +0200
Date:	Mon, 27 Jun 2005 16:31:00 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
In-Reply-To: <20050627143633.GD28082@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0506271616240.23903@blysk.ds.pg.gda.pl>
References: <20050625131938.GA7669@paradigm.rfc822.org> <20050625160316.GP6953@linux-mips.org>
 <20050625175048.GA25276@alpha.franken.de> <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
 <20050627143633.GD28082@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/958/Mon Jun 27 00:22:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Jun 2005, Ralf Baechle wrote:

> What matters isn't the presence of a second level cache but the actual
> properties.  The old code was relying almost exclusively on the precense
> of an S-cache, so had to be very liberal in it's assumption about that
> cache's properties.  Performancewise that sucked, badly.

 Well, I do think the defaults for these "features to be overridden" 
should be liberal about accepting what's available.  That is they should 
never take anything for granted.  Performance doesn't matter.  Code has to 
be correct.  It's up to a platform maintainer to tune it if desired and 
possible.

 And if we go back in time for c-r4k.c far enough, then we'll see these 
setup_scache_funcs() and setup_noscache_funcs() functions we used to have 
for proper handling of set-ups both with and without secondary caches.  
There could have been bugs, certainly, but at least the framework was in 
place.

  Maciej

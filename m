Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2005 18:01:34 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:27397 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225388AbVISRBQ>; Mon, 19 Sep 2005 18:01:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D6534F59C2; Mon, 19 Sep 2005 19:01:05 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32695-02; Mon, 19 Sep 2005 19:01:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 57E78F59C0; Mon, 19 Sep 2005 19:01:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j8JH16gQ000534;
	Mon, 19 Sep 2005 19:01:06 +0200
Date:	Mon, 19 Sep 2005 18:01:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
In-Reply-To: <20050919154056.GG3386@hattusa.textio>
Message-ID: <Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl>
References: <20050919154056.GG3386@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1084/Sat Sep 17 05:32:40 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Sep 2005, Thiemo Seufer wrote:

> I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
> Hit_Writeback_Inv instead of Hit_Invalidate is done. Ralf mentioned
> this is probably due to broken Hit_Invalidate cache ops on some
> CPUs, does anybody have more information about this? The appended
> patch works apparently fine on R4400, R4600v2.0, R5000.

 It's actually been on my to-do list for research for quite a while.  
These functions are called through pointers, so even if there are errata 
in some processors, I'd be more than happy to use pure invalidations for 
these that work whenever possible.

 FYI, for R4k DECstations the need to flush the cache for newly allocated 
skbs reduces throughput of FDDI reception by about a half (!), down from 
about 90Mbps (that's for the /260); hopefully with no writebacks the 
performance hit will be at least a bit smaller.

  Maciej

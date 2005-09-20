Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 10:10:17 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:54285 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225283AbVITJKB>;
	Tue, 20 Sep 2005 10:10:01 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EHe6l-00081J-00; Tue, 20 Sep 2005 10:08:11 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EHe7r-0001Xd-00; Tue, 20 Sep 2005 10:09:19 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17199.53696.27856.801284@mips.com>
Date:	Tue, 20 Sep 2005 10:09:20 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
In-Reply-To: <Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl>
References: <20050919154056.GG3386@hattusa.textio>
	<Pine.LNX.4.61L.0509191733180.5551@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.826,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> > I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
> > Hit_Writeback_Inv instead of Hit_Invalidate is done.

The MIPS64 spec (which is really all there is to set standards in this
area) regards Hit_Invalidate as optional.  So it would be nice not to
use it.  CPUs have no standard "configuration" register you can read
to establish which cacheops work, so to identify capable CPUs you must
use a table of CPU attributes indexed by the CPU ID, which encourages
the crime of building software which can't possibly run on a new CPU...

So long as the buffer is in fact clean, then in most implementations a
Hit_Writeback_Invalidate will be just as efficient.

Moreover, CPUs always "post" writes to some extent, so a small
percentage of dirty lines can be handled without any great overhead.
So a significant advantage can only occur when the buffer you want to
invalidate (prior to DMA-in) was fairly recently densely written by
the CPU; and this is only safe when all that data can be guaranteed to
now be of no importance to anyone.

Randomly and retrospectively discarding writes could generate some
very interesting bugs, or (indeed) usually hide some very interesting
bugs.  It's the kind of thing one would lik to avoid!

I suppose where DMA data subsequently gets decorated by the CPU then
handed on to some other layer, then the buffer is freed...?

> FYI, for R4k DECstations the need to flush the cache for newly allocated 
> skbs reduces throughput of FDDI reception by about a half (!), down from 
> about 90Mbps (that's for the /260)...

How did you measure the high throughput?  Have you got a
machine with DMA-coherency you can turn on and off?

--
Dominic

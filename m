Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jun 2010 19:47:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40770 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492080Ab0F0RrO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Jun 2010 19:47:14 +0200
Date:   Sun, 27 Jun 2010 18:47:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     loody <miloody@gmail.com>
cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about wmb in mips
In-Reply-To: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006271745480.14683@eddie.linux-mips.org>
References: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18231

On Mon, 28 Jun 2010, loody wrote:

> AFAIK, wmb in mips is implemented by calling sync,

 For platforms that support this instructions, yes.

> wmb->fast_wmb->__sync, which makes sure Loads and stores executed
> before the SYNC are completed before loads
> and stores after the SYNC can start

 You shouldn't be relying on implementation details -- WMB is defined as a 
write ordering barrier only, so all the interface guarantees is any 
outstanding stores will be seen on the processor's bus interface before 
any future store starts.  This is AFAIR the case with (at least some) 
platforms that do not have the SYNC instruction -- where any outstanding 
stores can still be delayed until after a future load.

 Actually with the recent introduction of the SYNC_WMB instruction it's 
likely it'll get used as the implementation of the WMB interface as soon 
as the distribution of the instruction is wide enough across platforms.  
As the name implies, this instruction only guarantees an ordering barrier 
for stores and not for loads.

> But will this instruction write the cache back too?

 No, SYNC is only meaningful for uncached (and cached coherent) accesses.  
I think that's clear from how the instruction has been specified.

> take usb example, it will call this maco before it let host processing
> the commands on dram, so I wondering whether sync will write the cache
> back to memory.

 You need to call the appropriate helper -- see the DMA API document for 
details.  Or use a coherent (in the Linux sense) mapping, which in turn 
will make CPU-side memory accesses to this area uncached on non-coherent 
(in the MIPS sense) systems.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2010 04:56:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44230 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491093Ab0F1C4C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jun 2010 04:56:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5RKq7K0004909;
        Sun, 27 Jun 2010 21:52:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5RKq6Oq004907;
        Sun, 27 Jun 2010 21:52:06 +0100
Date:   Sun, 27 Jun 2010 21:52:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     loody <miloody@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about wmb in mips
Message-ID: <20100627205206.GB4554@linux-mips.org>
References: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
 <alpine.LFD.2.00.1006271745480.14683@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006271745480.14683@eddie.linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18365

On Sun, Jun 27, 2010 at 06:47:14PM +0100, Maciej W. Rozycki wrote:

> > AFAIK, wmb in mips is implemented by calling sync,
> 
>  For platforms that support this instructions, yes.

For platforms that support this instruction _AND_ are not strongly ordered.
Iow we try to avoid it, if possible.  Details are complicated.

> > wmb->fast_wmb->__sync, which makes sure Loads and stores executed
> > before the SYNC are completed before loads
> > and stores after the SYNC can start
> 
>  You shouldn't be relying on implementation details -- WMB is defined as a 
> write ordering barrier only, so all the interface guarantees is any 
> outstanding stores will be seen on the processor's bus interface before 
> any future store starts.  This is AFAIR the case with (at least some) 
> platforms that do not have the SYNC instruction -- where any outstanding 
> stores can still be delayed until after a future load.
> 
>  Actually with the recent introduction of the SYNC_WMB instruction it's 
> likely it'll get used as the implementation of the WMB interface as soon 
> as the distribution of the instruction is wide enough across platforms.  
> As the name implies, this instruction only guarantees an ordering barrier 
> for stores and not for loads.
> 
> > But will this instruction write the cache back too?
> 
>  No, SYNC is only meaningful for uncached (and cached coherent) accesses.  
> I think that's clear from how the instruction has been specified.
> 
> > take usb example, it will call this maco before it let host processing
> > the commands on dram, so I wondering whether sync will write the cache
> > back to memory.
> 
>  You need to call the appropriate helper -- see the DMA API document for 
> details.  Or use a coherent (in the Linux sense) mapping, which in turn 
> will make CPU-side memory accesses to this area uncached on non-coherent 
> (in the MIPS sense) systems.

  Ralf

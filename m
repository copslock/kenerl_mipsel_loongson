Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 20:25:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46120 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493382Ab0HESZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 20:25:51 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o75IPnF0007967;
        Thu, 5 Aug 2010 19:25:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o75IPlGN007965;
        Thu, 5 Aug 2010 19:25:47 +0100
Date:   Thu, 5 Aug 2010 19:25:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: file corruption with highmem kernel
Message-ID: <20100805182547.GB1382@linux-mips.org>
References: <A7DEA48C84FD0B48AAAE33F328C020140526FCF5@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <A7DEA48C84FD0B48AAAE33F328C02014052700A1@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C02014052700A1@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 05, 2010 at 06:43:50AM -0700, Anoop P.A. wrote:

> With a slightly modified patched (copied below) I have reached a point
> where I am no more seeing errors like segmentation fault, bus error
> (which was due to memory corruption I believe).
> How ever I am still seeing some kind of file corruption. 
> 
> I believe this file corruption happening because cache is not getting
> invalidated before a highmem dma. I am not sure which routine to call to
> invalidate cache for a highmem address. 

Since you're running on an RM9000 class CPU, why don't just use a 64-bit
kernel?  Highmem is just so f*cking insane that you want to avoid it like
French kisses from a zombie suffering ebola.  If you have DMA restrictions
then you may consider reusing ZONE_DMA.

That said, a word on the history of the MIPS highmem code.  It was written
for a company who in the early stages of the 64-bit kernel didn't want to
be the first through the minefield in 2001.  That CPU had full coherency
and no cache aliases so arch/mips/mm/dma-*.c did not need any code to
support it at all and for many years after that everybody either had a
small 32-bit system that didn't need highmem or went 64-bit right away so
the gaps in the code while well known were never fixed up ...

I'm a bit surprised that the patch posted actually made things work better
for you since it entirely avoids flushing of highmem pages.  The code as it
was originally written using page_address() will perform cacheflushes
for highmem pages as well - but only for highmem pages are actually are
mapped.  That is your code will flush less pages than the existing code.

  Ralf

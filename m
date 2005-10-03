Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 13:50:56 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:3344 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465646AbVJCMuj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 13:50:39 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93CoGma018656;
	Mon, 3 Oct 2005 13:50:16 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j93CoG44018655;
	Mon, 3 Oct 2005 13:50:16 +0100
Date:	Mon, 3 Oct 2005 13:50:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
Message-ID: <20051003125016.GE2624@linux-mips.org>
References: <20050622230042.GA17919@broadcom.com> <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl> <20051001092807.GD14463@linux-mips.org> <Pine.LNX.4.61L.0510031239260.8056@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0510031239260.8056@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 03, 2005 at 12:56:20PM +0100, Maciej W. Rozycki wrote:

> > >  Of course if your TLB is indeed different from that of the R4k, then you 
> > > shouldn't be setting cp0.config.mt to 1 in the first place...
> > 
> > The reason was primarily the tiny bit of extra performance because the
> > SB1 doesn't need the hazard handling overhead.  Also tlb-sb1 has a few
> 
>  That's hardly a justification for duplicating all the code; I've thought 
> the reason was actually historical -- hadn't it been simply written 
> separately initially and never got merged properly afterwards?

Historically even the R10000 had it's own copy of the TLB code - with
the sole reason of existence being it having neither hazards nor suffering
from potencial duplicate TLB entries.  Well, maybe also the very first
stages of MIPS SMP support.

Anyway, as you said that's little reason for an extra copy to exist and
so I both got axed.

> > changes that are needed to initialize a TLB in undefined state after
> > powerup.  That was needed to run Linux on firmware-less SB1 cores.
> 
>  But that's true about the power-up state of the TLB on any MIPS CPU, 
> isn't it?

Some come out of powerup with a cleared TLB but anyway, since normally
some piece of firmware takes care of these issues it's not something
Linux normally should need to worry about.

  Ralf

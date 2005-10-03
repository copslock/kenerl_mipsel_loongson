Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 14:24:57 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:20997 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465651AbVJCNYl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 14:24:41 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93DOAcg019890;
	Mon, 3 Oct 2005 14:24:10 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j93DO889019889;
	Mon, 3 Oct 2005 14:24:08 +0100
Date:	Mon, 3 Oct 2005 14:24:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
Message-ID: <20051003132408.GG2624@linux-mips.org>
References: <20050622230042.GA17919@broadcom.com> <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl> <20051001092807.GD14463@linux-mips.org> <20051003131551.GA19075@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003131551.GA19075@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 03, 2005 at 09:15:52AM -0400, Daniel Jacobowitz wrote:

> > >  Well, the flag is not really to specify whether the common code is to be 
> > > used or not.  It's about whether the TLB is like that of the R4k.  
> > > Actually it's always been a mystery for me why the common code cannot be 
> > > used for the SB1, but perhaps there is something specific that I could 
> > > only discover in that "SB-1 Core User Manual" that I yet have to see, 
> > > sigh...
> > > 
> > >  Of course if your TLB is indeed different from that of the R4k, then you 
> > > shouldn't be setting cp0.config.mt to 1 in the first place...
> > 
> > The reason was primarily the tiny bit of extra performance because the
> > SB1 doesn't need the hazard handling overhead.  Also tlb-sb1 has a few
> > changes that are needed to initialize a TLB in undefined state after
> > powerup.  That was needed to run Linux on firmware-less SB1 cores.
> 
> FYI, all I have is a piece of hard evidence: this patch was the
> difference between not booting and booting for a Sentosa with CFE. 
> Which isn't firmwareless and isn't a tiny bit of extra performance
> issue.
> 
> I'll try to give CVS HEAD a shot this week sometime.

Just as reminder for everybody - CVS is dead and frozen, the action is
playing on git now ...

  Ralf

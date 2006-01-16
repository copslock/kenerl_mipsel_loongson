Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 15:45:56 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:42513 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133474AbWAPPpi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 15:45:38 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9867F64D54; Mon, 16 Jan 2006 15:49:08 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 306E48517; Mon, 16 Jan 2006 15:48:57 +0000 (GMT)
Date:	Mon, 16 Jan 2006 15:48:57 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
Message-ID: <20060116154856.GB26771@deprecation.cyrius.com>
References: <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl> <20051001092807.GD14463@linux-mips.org> <20051003131551.GA19075@nevyn.them.org> <Pine.LNX.4.61L.0510031432410.8056@blysk.ds.pg.gda.pl> <20050622230042.GA17919@broadcom.com> <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl> <20051001092807.GD14463@linux-mips.org> <20051003131551.GA19075@nevyn.them.org> <20050622230003.GA17725@broadcom.com> <20050622230042.GA17919@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0510031432410.8056@blysk.ds.pg.gda.pl> <20051003131551.GA19075@nevyn.them.org> <20050622230042.GA17919@broadcom.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Andrew Isaacson <adi@broadcom.com> [2005-06-22 16:00]:
> SB1 does not use the R4K TLB code.
> 
>  		c->cputype = CPU_SB1;
> +		c->options &= ~MIPS_CPU_4KTLB;
> +		c->options |= MIPS_CPU_TLB;
>  #ifdef CONFIG_SB1_PASS_1_WORKAROUNDS

* Daniel Jacobowitz <dan@debian.org> [2005-10-03 09:15]:
> > >  Well, the flag is not really to specify whether the common code is to be 
> > > used or not.  It's about whether the TLB is like that of the R4k.  
> > > Actually it's always been a mystery for me why the common code cannot be 
> > > used for the SB1, but perhaps there is something specific that I could 
> > > only discover in that "SB-1 Core User Manual" that I yet have to see, 
> > > sigh...
> > >  Of course if your TLB is indeed different from that of the R4k, then you 
> > > shouldn't be setting cp0.config.mt to 1 in the first place...
> > The reason was primarily the tiny bit of extra performance because the
> > SB1 doesn't need the hazard handling overhead.  Also tlb-sb1 has a few
> > changes that are needed to initialize a TLB in undefined state after
> > powerup.  That was needed to run Linux on firmware-less SB1 cores.
> FYI, all I have is a piece of hard evidence: this patch was the
> difference between not booting and booting for a Sentosa with CFE. 
> Which isn't firmwareless and isn't a tiny bit of extra performance
> issue.
> 
> I'll try to give CVS HEAD a shot this week sometime.

* Maciej W. Rozycki <macro@linux-mips.org> [2005-10-03 14:35]:
> > FYI, all I have is a piece of hard evidence: this patch was the
> > difference between not booting and booting for a Sentosa with CFE. 
> > Which isn't firmwareless and isn't a tiny bit of extra performance
> > issue.
>  Actually workarounds have been floating around for some time. ;-)  But 
> I'm glad this has now been fixed properly.

There was some discussion regarding this patch but no real conclusion.
Is it working without this patch now, or should it be applied (or
modified? - how?).
-- 
Martin Michlmayr
http://www.cyrius.com/

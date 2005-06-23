Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 00:27:47 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:59162 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225560AbVFWX1c>; Fri, 24 Jun 2005 00:27:32 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 651AC2AE; Thu, 23 Jun 2005 16:26:33 -0700 (PDT)
Date:	Thu, 23 Jun 2005 16:26:33 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
Message-ID: <20050623232633.GD26427@hexapodia.org>
References: <20050622230042.GA17919@broadcom.com> <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 23, 2005 at 12:01:57PM +0100, Maciej W. Rozycki wrote:
> On Wed, 22 Jun 2005, Andrew Isaacson wrote:
> > SB1 does not use the R4K TLB code.
> 
>  Well, the flag is not really to specify whether the common code is to be 
> used or not.  It's about whether the TLB is like that of the R4k.  
> Actually it's always been a mystery for me why the common code cannot be 
> used for the SB1, but perhaps there is something specific that I could 
> only discover in that "SB-1 Core User Manual" that I yet have to see, 
> sigh...
> 
>  Of course if your TLB is indeed different from that of the R4k, then you 
> shouldn't be setting cp0.config.mt to 1 in the first place...

So I don't know everything that went on during the SB1 MIPS port, but
what I see at this point makes at least some sense to me.  The SB1 has
some fancy features that are used in c-sb1.c and thereabouts (the DMA
pageops, and avoiding work by using the coherency guarantees, among
others).

While it is worthwhile to abstract that code out some more (and I
consider it a long-term goal to share as much code as possible with the
generic r4k/mips32/mips64 code), it works as is and it's not obvious
what small simplifications should be taken at this point.  (Or at least,
I'm not smart enough to see what obvious small simplifications should be
done.)  So for the time being I'm in favor of doing what's needed to
keep the support from bit-rotting.  I'll keep an eye on whatever
cleanups you end up doing and keep them up to date with our internal
tree...

That said, I'm open to suggestions as to what I should do in the short
term to get the right results.

-andy

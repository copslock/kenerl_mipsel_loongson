Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 23:28:23 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:58174 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225558AbVFWW2H>; Thu, 23 Jun 2005 23:28:07 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 63B242AE; Thu, 23 Jun 2005 15:27:09 -0700 (PDT)
Date:	Thu, 23 Jun 2005 15:27:09 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 4/5] SiByte fixes for 2.6.12
Message-ID: <20050623222709.GC26427@hexapodia.org>
References: <20050622230151.GA17970@broadcom.com> <Pine.LNX.4.61L.0506231208120.17155@blysk.ds.pg.gda.pl> <20050623144926.GA10216@hexapodia.org> <Pine.LNX.4.61L.0506231601270.17155@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506231601270.17155@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 23, 2005 at 04:11:51PM +0100, Maciej W. Rozycki wrote:
> On Thu, 23 Jun 2005, Andy Isaacson wrote:
> > The code looks like it's structured to be able to be compiled with
> > support for multiple CPUs, say, r4k and SB1; using #error would seem to
> > prevent that.
> > 
> > With the code as currently structured, you don't know it's going to be a
> > noop until runtime comes along and cpu_has_4ktlb is true...
> 
>  Well, I've had a look at the code and it's such a mess.  Obviously 
> calling ld_mmu_r4xx0() (or any of the other variants) should not be 
> compiled conditionally and more specific cases, i.e. based on PRId values 
> should take precedence.  I'll see if I can make it better.

I certainly won't argue with a cleanup of arch/mips/mm/cache.c, that
code has annoyed me from first laying eyes on it...

-andy

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 20:49:42 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:21124 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225542AbVFWTt0>; Thu, 23 Jun 2005 20:49:26 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 202932AE; Thu, 23 Jun 2005 12:48:27 -0700 (PDT)
Date:	Thu, 23 Jun 2005 12:48:26 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 3/5] SiByte fixes for 2.6.12
Message-ID: <20050623194826.GA23653@hexapodia.org>
References: <20050622230137.GA17954@broadcom.com> <Pine.LNX.4.61L.0506231202130.17155@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506231202130.17155@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 23, 2005 at 12:07:48PM +0100, Maciej W. Rozycki wrote:
> On Wed, 22 Jun 2005, Andrew Isaacson wrote:
> > Toolchain compat fix: gas 2.12.1 doesn't understand two-argument jalr,
> > and the $ra is redundant anyways.
> 
>  Is it really the case?  Perhaps it doesn't know the symbolic name of the 
> register which has only been added recently.  Replacing it with $31 should 
> fix the problem, but your patch is obviously correct regardless.

Yeah, you're right, my old gas just doesn't know $ra.  s/ra/31/g works
as well.

-andy

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 15:50:51 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:22430 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225534AbVFWOu2>; Thu, 23 Jun 2005 15:50:28 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 3B107297; Thu, 23 Jun 2005 07:49:27 -0700 (PDT)
Date:	Thu, 23 Jun 2005 07:49:27 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 4/5] SiByte fixes for 2.6.12
Message-ID: <20050623144926.GA10216@hexapodia.org>
References: <20050622230151.GA17970@broadcom.com> <Pine.LNX.4.61L.0506231208120.17155@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506231208120.17155@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 23, 2005 at 12:08:39PM +0100, Maciej W. Rozycki wrote:
> On Wed, 22 Jun 2005, Andrew Isaacson wrote:
> > If the CPU Options get out of sync with the CONFIG_CPU_ options,
> > cpu_cache_init() can end up being a noop.  Stop with a useful message
> > in that case rather than running on without cache functions.
> 
>  Wouldn't a build-time error be a better option?

The code looks like it's structured to be able to be compiled with
support for multiple CPUs, say, r4k and SB1; using #error would seem to
prevent that.

With the code as currently structured, you don't know it's going to be a
noop until runtime comes along and cpu_has_4ktlb is true...

-andy

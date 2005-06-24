Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 23:40:32 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:50563 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225526AbVFXWkQ>; Fri, 24 Jun 2005 23:40:16 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 06684290; Fri, 24 Jun 2005 15:39:16 -0700 (PDT)
Date:	Fri, 24 Jun 2005 15:39:15 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	Prashant Viswanathan <vprashant@echelon.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: glibc based toolchain for mips
Message-ID: <20050624223915.GB4295@hexapodia.org>
References: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4350@miles.echelon.echcorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4350@miles.echelon.echcorp.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 24, 2005 at 03:14:49PM -0700, Prashant Viswanathan wrote:
> Is it possible to get a free/open glibc based toolchain for MIPS? Buildroot
> and ucLibc based toolchain seems to work well, but I really need a glibc
> based toolchain. Though I can use the SDE from MIPS technologies to build
> the kernel, I can't seem to use it as a toolchain to compile my own
> applications.

Debian provides a complete native toolchain with glibc, which I've used
with great success.  (You will need to do a nfsroot or nbd-root if you
don't have local storage.)

-andy

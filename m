Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 17:24:28 +0100 (BST)
Received: from p508B5290.dip.t-dialin.net ([IPv6:::ffff:80.139.82.144]:64905
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225401AbTJAQY0>; Wed, 1 Oct 2003 17:24:26 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h91GOMNK008563;
	Wed, 1 Oct 2003 18:24:22 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h91GOK0X008562;
	Wed, 1 Oct 2003 18:24:20 +0200
Date: Wed, 1 Oct 2003 18:24:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Michael Uhler <uhler@mips.com>,
	"Finney, Steve" <Steve.Finney@spirentcom.com>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
Message-ID: <20031001162420.GA28892@linux-mips.org>
References: <1064950055.12992.99.camel@uhler-linux.mips.com> <Pine.GSO.3.96.1031001055849.20371C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1031001055849.20371C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 01, 2003 at 06:26:02AM +0200, Maciej W. Rozycki wrote:

> > was never intended to run real 32-bit programs with 64-bit ops enabled,
> > and I would strongly urge you not to do this now.
> 
>  After a bit of thinking, I consider this not to be a real problem.  Apart
> from the kernel interface, which sanitizes values passed, the rest is pure
> userland, where allowing undefined operation with 64-bit opcodes cannot
> really hurt.  Of course running a buggy or malicious program may lead to
> bad results or loss of data, but it'll be limited to the user responsible
> for running such software and the root user by definition has to know what
> he is doing and specifically he is responsible for not running untrusted
> software on critical systems.
> 
>  That said, I don't really have a strong preference either way -- it just
> doesn't seem to be worth the hassle for me to explicitly defend against
> such a marginal case.  Although it may be good to try validating this
> assumption with `crashme'. 

It's a while since this last has been done and all bugs showing up were
fixed ...

  Ralf

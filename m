Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 15:48:01 +0200 (CEST)
Received: from p508B64CB.dip.t-dialin.net ([80.139.100.203]:11400 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123897AbSJBNsB>; Wed, 2 Oct 2002 15:48:01 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g92Dlrn16976;
	Wed, 2 Oct 2002 15:47:53 +0200
Date: Wed, 2 Oct 2002 15:47:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [resend] 2.4: Support R4000 as a distinct CPU type
Message-ID: <20021002154753.F17373@linux-mips.org>
References: <Pine.GSO.3.96.1021001163617.13606J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021001163617.13606J-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Oct 01, 2002 at 06:17:11PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 01, 2002 at 06:17:11PM +0200, Maciej W. Rozycki wrote:

>  Here is a new version that takes your recent mips64 cache code rearrange
> into account.  OK to apply?

I'm not sure if that's really a good idea.  Technically it's ok but I expect
users of the R4000 to missconfigure their kernels.  So I wonder if it might
be more appropriate to have just automatically enabled this workaround for
systems that are affected?  If we keep it user-selectable then we at least
want a safety check somewhere in the startup code telling users to rebuild
their code with the workaround enabled.

Having this workaround enabled by default would also ensure Linux
distributions ship working code - you don't want users having to recompile
their whole distribution ...

>  BTW, how about renaming r5k-sc.c to sc-r5k.c for consistency?

Yes.  Though there's a bit of confusion hidden there - the Indy SC code
is named ip22-sc.c - but that at least in a different directory.

  Ralf

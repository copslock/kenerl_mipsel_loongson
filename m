Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 15:24:36 +0100 (BST)
Received: from p508B6582.dip.t-dialin.net ([IPv6:::ffff:80.139.101.130]:15853
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTDCOYf>; Thu, 3 Apr 2003 15:24:35 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h33EOTv03207;
	Thu, 3 Apr 2003 16:24:29 +0200
Date: Thu, 3 Apr 2003 16:24:29 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030403162428.A2460@linux-mips.org>
References: <20030403133610Z8225197-1272+1139@linux-mips.org> <Pine.GSO.3.96.1030403154337.19058E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030403154337.19058E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Apr 03, 2003 at 04:11:02PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 03, 2003 at 04:11:02PM +0200, Maciej W. Rozycki wrote:

>  Hmm, erratum #2 is about status output pins.  I suppose you mean erratum
> #5.  But then it applies to V3.0, too.
> 
>  Then the bit is r/w, so how about toggling it instead of panicking? 
> With an informational message like:
> 
> printk(KERN_ERR "Firmware bug: 32-byte I-cache line size unsupported for
> the R4000...\n");
> printk(KERN_ERR "... fixing up to 16-byte size.\n");
> 
> Of course that probably requires a temporary cache inhibition and
> invalidation.

I know of one machine where changing the size of the cacheline is supposed
not to work, that's the MIPS Magnum 4000 and it's close relatives.

Anyway, I put the check there for the unlikely case there are broken
systems out there.  In practice I assume vendors were aware of this
problem and the check is purely theoretical and for paranoid correctness's
sake.

It seems like changing the configuration to larger cache lines where
possible should improve performance somewhat.  If all the cache code is
working truly correct we also should no longer see VCE exceptions on
R4000SC processors - the reason why Indys are still a valuable test tool.

  Ralf

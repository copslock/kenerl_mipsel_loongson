Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KEBDEC027721
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:11:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KEBDka027720
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:11:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f39.dialo.tiscali.de [62.246.16.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KEB1EC027710
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:11:03 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7KE3BE26998;
	Tue, 20 Aug 2002 16:03:11 +0200
Date: Tue, 20 Aug 2002 16:03:11 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Bring back R4600 V1.7 support
Message-ID: <20020820160311.A26912@linux-mips.org>
References: <Pine.GSO.3.96.1020820152046.8700E-100000@delta.ds2.pg.gda.pl> <Pine.GSO.3.96.1020820153410.8700F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020820153410.8700F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Aug 20, 2002 at 03:55:34PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 03:55:34PM +0200, Maciej W. Rozycki wrote:

>  An additional thought that just came to my mind: it might be possible to
> avoid masking interrupts with a dummy ll/sc pair only checking if an
> interrupt happened within the critical code.  It should be easy to
> validate since only a single mask of a processor would make use of the
> code.  The real question is: "Do the affected cache operations corrupt any
> state or do they only work on wrong lines?"  If the latter, the approach
> should work for all operations except from "Hit_Invalidate_D" that
> corrupts state by definition (but it isn't used by any R4k processor, so
> it may simply be replaced with a panic()).  Unfortunately, the knowledge
> does no longer exist within IDT, but maybe someone else knows? 

I was thinking about that already but the erratas don't provide enough
details.  The only problem I can see is that ll/sc are fairly slow on some
architectures.  They're supposed to be quite light according to the docs
but in reality I benchmarked ~ 13 cycles for a spinlock on a R10000 and
~ 44 on a more recent chip.

  Ralf

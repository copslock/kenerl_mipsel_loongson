Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71DNkRw032564
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 06:23:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71DNkxB032563
	for linux-mips-outgoing; Thu, 1 Aug 2002 06:23:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f3.dialo.tiscali.de [62.246.17.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71DNaRw032554
	for <linux-mips@oss.sgi.com>; Thu, 1 Aug 2002 06:23:38 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g71DP0129522;
	Thu, 1 Aug 2002 15:25:00 +0200
Date: Thu, 1 Aug 2002 15:25:00 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
Message-ID: <20020801152500.A31808@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020705170554.11897A-100000@delta.ds2.pg.gda.pl> <Pine.GSO.3.96.1020729161214.22288H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020729161214.22288H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 29, 2002 at 04:29:35PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 29, 2002 at 04:29:35PM +0200, Maciej W. Rozycki wrote:

>  The following patch fixes all the places the default caching policy is
> used but various local hacks are coded.  Also the sc coherency algorithm
> is configured for R4k processors which was previously left as set (or not)
> by the firmware.  A side effect is <asm-mips64/pgtable-bits.h> is created
> and all conditional CPU options are set somehow.  Tested on an R4400SC
> (for both MIPS and MIPS64) and on an R3400. 
> 
>  Admittedly, CONF_CM_DEFAULT is defined in a bit weird way, but I couldn't
> figure any better one that wouldn't result in a serious but unnecessary
> header bloat.  If anyone has a better idea, please share any suggestions
> here.
> 
>  OK to apply?

Looks mostly right except that the code in config-shared.in which deciedes
if a system is coherent is wrong.  Basically it assumes every R10000 or
every uniprocessor system is non-coherent and that's wrong.  As coherency
between CPUs and for DMA I/O is basically the same thing I've changed your
code from the use of CONFIG_CPU_CACHE_COHERENCY to CONFIG_NONCOHERENT_IO
which did already exist; I don't think we need another config symbol to
handle this.  Will apply once I did a few test builds and patches the
whole thing into 2.5 ...

  Ralf

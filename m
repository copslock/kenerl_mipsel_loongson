Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 12:23:22 +0000 (GMT)
Received: from p508B7762.dip.t-dialin.net ([IPv6:::ffff:80.139.119.98]:9669
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225201AbTBUMXV>; Fri, 21 Feb 2003 12:23:21 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1LCNEZ31340;
	Fri, 21 Feb 2003 13:23:14 +0100
Date: Fri, 21 Feb 2003 13:23:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Cobalt IRQ handler CP0 interlock?
Message-ID: <20030221132314.A28300@linux-mips.org>
References: <20030220195314.C30853@linux-mips.org> <Pine.GSO.3.96.1030221125800.13836I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030221125800.13836I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 21, 2003 at 01:11:58PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 21, 2003 at 01:11:58PM +0100, Maciej W. Rozycki wrote:

> > >  Does Cobalt have a processor that implements its pipeline differently or
> > > interlocks on CP0 loads?  If not, I'll apply the following fix. 
> > 
> > Mfc0 doesn't need a nops on any R4000 class CPU I know of.
> 
>  Well, my MIPS R4k manual is vague on this matter and my IDT software
> manual for R3k, R4k, R5k is even explicit on the load delay slot of mfc0. 
> But a run-time test proves otherwise. 
> 
>  I stand corrected then unless someone finds a counter-example.

All I can say it's working fine like this since 1984 for R4000 class CPUs.

  Ralf

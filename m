Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 15:03:41 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:21455 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28575868AbYBHPDd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Feb 2008 15:03:33 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 37D1A400A9;
	Fri,  8 Feb 2008 16:03:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id qPTWq6ior5QK; Fri,  8 Feb 2008 16:03:23 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 529AE40044;
	Fri,  8 Feb 2008 16:03:23 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m18F3RHE003487;
	Fri, 8 Feb 2008 16:03:27 +0100
Date:	Fri, 8 Feb 2008 15:03:18 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
In-Reply-To: <20080208144417.GA22331@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0802081500290.7017@blysk.ds.pg.gda.pl>
References: <200802071932.23965.florian.fainelli@telecomint.eu>
 <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
 <20080208122858.GA8267@alpha.franken.de> <20080208144417.GA22331@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5739/Fri Feb  8 11:19:58 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 8 Feb 2008, Ralf Baechle wrote:

> > Jazz has the same problem. Right now it's solved by using wired tlb
> > entries. Which is sort of an early_ioremap.
> 
> One with a totally awkward API requiring the user having to know about
> the underlying TLB organization.  A better implementation wouldn't be
> hard to do, for anything that's outside of KSEG1's address range grab
> a new TLB entry if needed and wire an entry into it.  Use the same
> API as good old ioremap() and call the result early_ioremap().

 And presumably by the time paging has been set up for real, all the early 
allocations could get automatically graduated to ordinary ones, freeing up 
all the wired TLB entries set up so far and keeping the values of cookies 
obtained intact.

  Maciej

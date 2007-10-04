Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:04:04 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:29399 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20026204AbXJDPDz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:03:55 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C7E27400A8;
	Thu,  4 Oct 2007 17:03:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id XcuYlHWymnUt; Thu,  4 Oct 2007 17:03:51 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6CCAB40095;
	Thu,  4 Oct 2007 17:03:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94F3tEu027882;
	Thu, 4 Oct 2007 17:03:55 +0200
Date:	Thu, 4 Oct 2007 16:03:50 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
In-Reply-To: <1191508413.10050.26.camel@scarafaggio>
Message-ID: <Pine.LNX.4.64N.0710041533460.10573@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org> 
 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl> 
 <20071004130318.GC28928@linux-mips.org> <1191508413.10050.26.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4471/Thu Oct  4 15:22:27 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Giuseppe Sacco wrote:

> I'll provide a new patch tomorrow, using inline functions instead of
> macros. About the maximum number of PCI buses, I used 1 since the ip32
> only have 1 slot. If this maximum value should be changed, please let me
> know.

 You can have more than one bridge on a card.  Or if you have e.g. a 
PCI-HyperTransport bridge on a PCI card, then who knows what may lie 
beyond.  In any case there is no need to do this check here and it is even 
harmful in the sense it just bumps the unnecessary limitation by one 
rather than removing it altogether -- the generic PCI code that we have in 
drivers/pci/ will scan the bus behind the bridge and find out whether 
there are any others and act accordingly.

 In general you need not do any range checking here, even for the root 
bus, unless the host bridge is broken somehow and produces unexpected 
behaviour when an inexistent device is accessed with a configuration 
cycle.  Normally such a transaction should result with a Master Abort and 
be handled gracefully by the originating host bridge.  This is not always 
the case, sometimes because of a flaw in hardware and sometimes because of 
misconfiguration -- unfortunately the quality of bootstrap firmware varies 
and fixing it up requires bridge-specific knowledge, which we sometimes 
have and use (grep for MSC01_PCI_CFG_MAXRTRY_MSK for an example), but 
sometimes we do not.

  Maciej

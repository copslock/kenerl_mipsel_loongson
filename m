Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 13:28:13 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:31386 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022072AbXJEM2E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 13:28:04 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4BE53400CD;
	Fri,  5 Oct 2007 14:27:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id hpcDpU4LTP3W; Fri,  5 Oct 2007 14:27:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 58AA940095;
	Fri,  5 Oct 2007 14:27:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l95CRTvt008670;
	Fri, 5 Oct 2007 14:27:29 +0200
Date:	Fri, 5 Oct 2007 13:27:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
In-Reply-To: <Pine.LNX.4.64N.0710041459270.10573@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64N.0710051319470.17849@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
 <20071004130318.GC28928@linux-mips.org> <Pine.LNX.4.64N.0710041459270.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4475/Fri Oct  5 10:56:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Maciej W. Rozycki wrote:

> to be careful about the device #31 in general; it is seldom used anyway as 
> there are only 20 IDSEL lines defined by the standard and they are usually 
> mapped starting from the device #0.

 Just to correct myself not to confuse anybody -- there are actually 21 
IDSEL lines which map from bits 31:11 of the address provided for Type 0 
configuration access cycles -- at most one bit from that range is ever set 
for such cycles.  The issuing bridge is free to set no bits for device 
numbers it has no assigned IDSEL line for; such transactions will never be 
claimed by any device and thus will always terminate with Master-Abort.

  Maciej

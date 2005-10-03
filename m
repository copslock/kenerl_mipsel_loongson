Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 12:56:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54790 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3465607AbVJCL4R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 12:56:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5255BF59AE; Mon,  3 Oct 2005 13:56:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18870-03; Mon,  3 Oct 2005 13:56:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1EF7FF5991; Mon,  3 Oct 2005 13:56:12 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j93BuD6B013495;
	Mon, 3 Oct 2005 13:56:13 +0200
Date:	Mon, 3 Oct 2005 12:56:20 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [patch 1/5] SiByte fixes for 2.6.12
In-Reply-To: <20051001092807.GD14463@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0510031239260.8056@blysk.ds.pg.gda.pl>
References: <20050622230042.GA17919@broadcom.com>
 <Pine.LNX.4.61L.0506231153080.17155@blysk.ds.pg.gda.pl>
 <20051001092807.GD14463@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1107/Sun Oct  2 10:09:39 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 1 Oct 2005, Ralf Baechle wrote:

> >  Of course if your TLB is indeed different from that of the R4k, then you 
> > shouldn't be setting cp0.config.mt to 1 in the first place...
> 
> The reason was primarily the tiny bit of extra performance because the
> SB1 doesn't need the hazard handling overhead.  Also tlb-sb1 has a few

 That's hardly a justification for duplicating all the code; I've thought 
the reason was actually historical -- hadn't it been simply written 
separately initially and never got merged properly afterwards?

> changes that are needed to initialize a TLB in undefined state after
> powerup.  That was needed to run Linux on firmware-less SB1 cores.

 But that's true about the power-up state of the TLB on any MIPS CPU, 
isn't it?

  Maciej

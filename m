Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2005 19:44:24 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:49937 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225214AbVBRToG>; Fri, 18 Feb 2005 19:44:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D5189E1CAF; Fri, 18 Feb 2005 20:43:58 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06829-01; Fri, 18 Feb 2005 20:43:58 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2A46EE1CA8; Fri, 18 Feb 2005 20:43:58 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1IJhwxO028226;
	Fri, 18 Feb 2005 20:44:01 +0100
Date:	Fri, 18 Feb 2005 19:44:08 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, macro@mips.com,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <20050217013406.GA14909@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0502181939020.11881@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0501131824350.21179@perivale.mips.com>
 <87k6qh2e6j.fsf@redhat.com> <Pine.LNX.4.61.0501141956520.21179@perivale.mips.com>
 <20050122.015040.108744446.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.61L.0501211739410.16576@blysk.ds.pg.gda.pl>
 <20050217013406.GA14909@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 17 Feb 2005, Ralf Baechle wrote:

> >  Thanks for your insight -- your comments are not lost and I am working on 
> > taking them into account.  But meanwhile a confusion around the semantics 
> > of these operations arose (there is no documentation on them and some 
> > drivers expect some of these functions to swap, while others expect them 
> > not to) and changes were made to the tree that invalidated some of the 
> > fixes.  That needs to be addressed first and I expect another update to 
> > the file.  Here's a patch I'm going to start with.  Functions it adds have 
> > been named dma_* to indicate they are meant to preserve memory byte 
> > ordering.
> 
> Looks good but I don't really like the dma_* name prefix as these functions
> really have nothing to do with DMA - in fact they're the opposite.

 Well, the name is meant to imply DMA byte ordering is preserved.  If 
that's not clear enough (I don't insist it is), then I'd love to hear a 
reasonable proposal for an alternative.

  Maciej

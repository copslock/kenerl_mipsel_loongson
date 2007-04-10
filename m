Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2007 16:50:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:51974 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021719AbXDJPul (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Apr 2007 16:50:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id ADF26E1CAD;
	Tue, 10 Apr 2007 17:49:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LxiKL6ti4j6F; Tue, 10 Apr 2007 17:49:59 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 69FD2E1C6B;
	Tue, 10 Apr 2007 17:49:59 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l3AFoCo4023676;
	Tue, 10 Apr 2007 17:50:12 +0200
Date:	Tue, 10 Apr 2007 16:50:07 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
In-Reply-To: <20070409151630.GA9284@alpha.franken.de>
Message-ID: <Pine.LNX.4.64N.0704101626270.29069@blysk.ds.pg.gda.pl>
References: <20070408113457.GB7553@alpha.franken.de> <4619245F.4030704@ru.mvista.com>
 <20070408230710.GA9092@alpha.franken.de> <461A50E0.1060602@ru.mvista.com>
 <20070409151630.GA9284@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/3061/Tue Apr 10 13:56:50 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 9 Apr 2007, Thomas Bogendoerfer wrote:

> >    To me, it doesn't make much sense with or without reading the code.
> > And note that no other boards claim ports 0x0000 thru 0x0fff to PCI.
> 
> no other board MIPS board has EISA behind PCI afaik. So this is a new
> situation.

 To everybody involved: quite a few Alpha boxes use the PCEB bridge, which 
may or may not be the same as in here, so they may be used as a reference 
of how things may be set up.  Though, being quite an old port, this code 
may not necessarily represent the best approach possible.

 Personally I think ISA and EISA resources that are behind a PCI bus (or 
any other, for that matter) should be registered as descendants to that 
bus.  It's only the PC architecture that makes (E)ISA resources special -- 
almost any other platform will relocate them arbitrarily (they will not 
start from zero in the host address space, which may even have no notion 
of the I/O address space at all) and may have multiple copies if multiple 
PCI buses are used in a non-tree configuration.  It may be useful to 
register PCI I/O windows in the MMIO space as appropriate too.

 Also mapping PCI I/O addresses from 0 does make sense in some actual 
hardware configurations which do not have any legacy bridges involved, so 
making sure code is prepared to do this is not an unreasonable thing to 
do.  There is currently (or used to be, not so long ago) a problem with 
some code somewhere as I tried such a setup with a SWARM board and I 
recall getting a failure somewhere, which I mean to get back to at one 
point.

  Maciej

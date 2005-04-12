Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 12:18:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:267 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224916AbVDLLST>; Tue, 12 Apr 2005 12:18:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 18D3AE1C7D; Tue, 12 Apr 2005 13:18:08 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07216-04; Tue, 12 Apr 2005 13:18:07 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B01DAE1C7B; Tue, 12 Apr 2005 13:18:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j3CBIAY7006694;
	Tue, 12 Apr 2005 13:18:10 +0200
Date:	Tue, 12 Apr 2005 12:18:15 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Paul Chapman <paul.chapman@BrockU.CA>, linux-mips@linux-mips.org
Subject: Re: ip27 PCI devices
In-Reply-To: <20050412105815.GC5573@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0504121213400.18606@blysk.ds.pg.gda.pl>
References: <1113251422.21580.33.camel@paul.dev.brocku.ca>
 <20050412105815.GC5573@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/822/Tue Apr 12 06:55:55 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 12 Apr 2005, Ralf Baechle wrote:

> > I've been experimenting with trying various PCI cards I have lying
> > around in my Origin 200, to see if I can make any of them work.
> 
> The current Linux implementation limits IP27 to cards with 64-bit
> addressing capability.

 Do we have a problem with our implementation of PCI DMA masks or is the 
low 4GB of PCI address space already consumed on this system?  The problem 
is most 32-bit PCI cards unfortunately do not support DAC.

  Maciej

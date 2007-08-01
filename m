Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 16:53:02 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52371 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20021917AbXHAPw5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 16:52:57 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l71FwCec015653;
	Wed, 1 Aug 2007 16:58:12 +0100
Date:	Wed, 1 Aug 2007 16:58:12 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
Message-ID: <20070801165812.3bdb269f@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org>
	<46B07B36.1000501@ru.mvista.com>
	<Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
	<46B086EB.2030101@ru.mvista.com>
	<20070801163926.038c48db@the-village.bc.nu>
	<Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.13; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> > >     Even on a CPU with 36-bit physical address? ;-)
> > 
> > Nope. This is one problem for example with ioremap on a Pentium Pro.
> 
>  Well, but we only consider MIPS processors here which do not have such 
> odd restrictions resulting from bad design decisions in the past. ;-)  
> The 32-bit TLB entry format allows for up to 36 bits of the physical 
> address space (34 bits if support for the page size of 1kB has been 

So does the Pentium Pro. We can map 36bit physical addresses.

> enabled).  For anything beyond that you need a 64-bit MIPS processor using 
> the 64-bit TLB entry format.

Your problem is a little higher up the stack. ioremap takes an unsigned
long, which on a 32bit system usually means you can't give it a 36bit bus
address to remap.

Alan

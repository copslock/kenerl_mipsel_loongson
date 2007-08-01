Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 16:49:21 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:17417 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021902AbXHAPtO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 16:49:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8319BE1C7C;
	Wed,  1 Aug 2007 17:49:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 213EH-QuC+vw; Wed,  1 Aug 2007 17:49:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1EC10E1C79;
	Wed,  1 Aug 2007 17:49:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l71FnJqr027546;
	Wed, 1 Aug 2007 17:49:19 +0200
Date:	Wed, 1 Aug 2007 16:49:14 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <20070801163926.038c48db@the-village.bc.nu>
Message-ID: <Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <20070801163926.038c48db@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Alan Cox wrote:

> > >  Of course it will.  It shall work with whatever physical address space is 
> > > supported by your MMU.  As long as the MMU is handled correctly that is, 
> > > but I guess I may have omitted this clarification as obvious.
> > 
> >     Even on a CPU with 36-bit physical address? ;-)
> 
> Nope. This is one problem for example with ioremap on a Pentium Pro.

 Well, but we only consider MIPS processors here which do not have such 
odd restrictions resulting from bad design decisions in the past. ;-)  
The 32-bit TLB entry format allows for up to 36 bits of the physical 
address space (34 bits if support for the page size of 1kB has been 
enabled).  For anything beyond that you need a 64-bit MIPS processor using 
the 64-bit TLB entry format.

  Maciej

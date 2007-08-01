Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 17:00:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:26128 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021932AbXHAQAv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 17:00:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8B93EE1C78;
	Wed,  1 Aug 2007 18:00:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id udPkY26Tr4ip; Wed,  1 Aug 2007 18:00:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 354B6E1C63;
	Wed,  1 Aug 2007 18:00:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l71G0RpQ028918;
	Wed, 1 Aug 2007 18:00:27 +0200
Date:	Wed, 1 Aug 2007 17:00:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <20070801165812.3bdb269f@the-village.bc.nu>
Message-ID: <Pine.LNX.4.64N.0708011657190.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <20070801163926.038c48db@the-village.bc.nu> <Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl>
 <20070801165812.3bdb269f@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Alan Cox wrote:

> > enabled).  For anything beyond that you need a 64-bit MIPS processor using 
> > the 64-bit TLB entry format.
> 
> Your problem is a little higher up the stack. ioremap takes an unsigned
> long, which on a 32bit system usually means you can't give it a 36bit bus
> address to remap.

 Well, phys_t is what it takes for MIPS and for MIPS:

#ifdef CONFIG_64BIT_PHYS_ADDR
typedef unsigned long long phys_t;
#else
typedef unsigned long phys_t;
#endif

so no problem here as long as you enable CONFIG_64BIT_PHYS_ADDR which is 
implied in such a case.

  Maciej

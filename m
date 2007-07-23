Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 16:12:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:60423 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022675AbXGWPMH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 16:12:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6BC54E1CC8;
	Mon, 23 Jul 2007 17:11:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x6g6YmUhtoCa; Mon, 23 Jul 2007 17:11:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0DE39E1C78;
	Mon, 23 Jul 2007 17:11:33 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6NFBdus019013;
	Mon, 23 Jul 2007 17:11:39 +0200
Date:	Mon, 23 Jul 2007 16:11:37 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] bcm1480 serial build fix
In-Reply-To: <20070723134431.GB18207@networkno.de>
Message-ID: <Pine.LNX.4.64N.0707231609010.13557@blysk.ds.pg.gda.pl>
References: <20070722075515.GB23747@networkno.de>
 <Pine.LNX.4.64N.0707231353030.13557@blysk.ds.pg.gda.pl>
 <20070723134431.GB18207@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3742/Mon Jul 23 13:31:24 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Jul 2007, Thiemo Seufer wrote:

> >  Aren't all the bits in "bcm1480_regs.h" meant to be prefixed with 
> > BCM1480_DUART?
> 
> Appatenly not, guessing from the header's contents.

 There are two or three exceptions buried indeed.

> >  These headers are a horrible mess anyway -- a single definition should be 
> > enough to access the two DUARTs the BCM1480 seems to have...
> 
> Indeed. I just took the path of least resistance to make it work again.

 Sure. :)  But it looks like you merely follow the tradition here...

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 17:46:03 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:8161 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023164AbXJHQpz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 17:45:55 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3A2C040256;
	Mon,  8 Oct 2007 18:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id QmLWiisNsVte; Mon,  8 Oct 2007 18:45:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 767764024E;
	Mon,  8 Oct 2007 18:45:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l98GjnRk029328;
	Mon, 8 Oct 2007 18:45:49 +0200
Date:	Mon, 8 Oct 2007 17:45:44 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071008164130.GA7538@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710081745120.8873@blysk.ds.pg.gda.pl>
References: <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com>
 <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com>
 <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <20071004153008.GE6897@linux-mips.org> <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl>
 <20071004154215.GA10682@linux-mips.org> <Pine.LNX.4.64N.0710041739400.10573@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0710081642020.8873@blysk.ds.pg.gda.pl> <20071008164130.GA7538@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4503/Mon Oct  8 15:16:03 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 8 Oct 2007, Ralf Baechle wrote:

> >  On the second thought though -- I am afraid <asm/stackframe.h> is still 
> > the big showstopper.  Or actually the design around it.  That does not 
> > mean it is undoable, but I shall defer it for now.
> 
> There will be a few more issues so I guess we best tackle this step by
> step.

 OK, you first!

  Maciej

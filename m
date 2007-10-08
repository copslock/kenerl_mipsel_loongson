Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 16:47:07 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:9680 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022568AbXJHPq6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 16:46:58 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 052E14024F;
	Mon,  8 Oct 2007 17:46:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 7p3A6af1Bwrd; Mon,  8 Oct 2007 17:46:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9E82E40251;
	Mon,  8 Oct 2007 17:46:18 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l98FkMwW017415;
	Mon, 8 Oct 2007 17:46:22 +0200
Date:	Mon, 8 Oct 2007 16:46:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <Pine.LNX.4.64N.0710041739400.10573@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64N.0710081642020.8873@blysk.ds.pg.gda.pl>
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <20071004153008.GE6897@linux-mips.org> <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl>
 <20071004154215.GA10682@linux-mips.org> <Pine.LNX.4.64N.0710041739400.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4503/Mon Oct  8 15:16:03 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Maciej W. Rozycki wrote:

> > than any other system.  Or for your personal toy project, all DECs wouldn't
> > be too hard either, or?
> 
>  The DECs should be reletively easy if we finally managed to get rid of 
> all the 64-bit-isms in the 32-bit kernel even if built for MIPS III or 
> above.  Which, given the recent commitment to 32-bit cores is what I would 
> actually expect.

 On the second thought though -- I am afraid <asm/stackframe.h> is still 
the big showstopper.  Or actually the design around it.  That does not 
mean it is undoable, but I shall defer it for now.

  Maciej

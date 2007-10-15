Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 14:18:21 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:49645 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20036617AbXJONSN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 14:18:13 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DF26D400E0;
	Mon, 15 Oct 2007 15:17:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id bUFV2a+KQGxf; Mon, 15 Oct 2007 15:17:36 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9D4A540085;
	Mon, 15 Oct 2007 15:17:36 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9FDHcQc015035;
	Mon, 15 Oct 2007 15:17:38 +0200
Date:	Mon, 15 Oct 2007 14:17:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <rsandifo@nildram.co.uk>
cc:	Nigel Stephens <nigel@mips.com>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [SPAM?]  Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <878x679tge.fsf@firetop.home>
Message-ID: <Pine.LNX.4.64N.0710151350330.16262@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
 <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
 <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
 <470CC0CE.9080303@mips.com> <Pine.LNX.4.64N.0710111242530.16370@blysk.ds.pg.gda.pl>
 <878x679tge.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 13 Oct 2007, Richard Sandiford wrote:

> >  Good point, but if we decide the lone instruction is worth the hassle, 
> > then we should use "-msmartmips" on top of the base ISA selection.  
> > Likewise with "lwx" and "-mdsp".
> 
> For the record, although that's true of SDE, it isn't (yet) true of
> FSF GCC; you need -msmartmips for that.

 Ah, another argument in favour to the generic approach...  Thanks for the 
point.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 17:53:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64668 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023368AbXJHQxR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 17:53:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l98GrGP4007850;
	Mon, 8 Oct 2007 17:53:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l98Gr6ZT007843;
	Mon, 8 Oct 2007 17:53:06 +0100
Date:	Mon, 8 Oct 2007 17:53:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071008165306.GC7538@linux-mips.org>
References: <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <20071004153008.GE6897@linux-mips.org> <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl> <20071004154215.GA10682@linux-mips.org> <Pine.LNX.4.64N.0710041739400.10573@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0710081642020.8873@blysk.ds.pg.gda.pl> <20071008164130.GA7538@linux-mips.org> <Pine.LNX.4.64N.0710081745120.8873@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710081745120.8873@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 08, 2007 at 05:45:44PM +0100, Maciej W. Rozycki wrote:

> > >  On the second thought though -- I am afraid <asm/stackframe.h> is still 
> > > the big showstopper.  Or actually the design around it.  That does not 
> > > mean it is undoable, but I shall defer it for now.
> > 
> > There will be a few more issues so I guess we best tackle this step by
> > step.
> 
>  OK, you first!

You got the R3000 :-)

  Ralf

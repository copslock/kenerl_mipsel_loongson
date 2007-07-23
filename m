Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 15:52:32 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:8413 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022668AbXGWOwa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jul 2007 15:52:30 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 6B35484A3D;
	Mon, 23 Jul 2007 15:44:33 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ICyDA-0006B4-26; Mon, 23 Jul 2007 14:44:32 +0100
Date:	Mon, 23 Jul 2007 14:44:32 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] bcm1480 serial build fix
Message-ID: <20070723134431.GB18207@networkno.de>
References: <20070722075515.GB23747@networkno.de> <Pine.LNX.4.64N.0707231353030.13557@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707231353030.13557@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 22 Jul 2007, Thiemo Seufer wrote:
> 
> > diff --git a/include/asm-mips/sibyte/bcm1480_regs.h b/include/asm-mips/sibyte/bcm1480_regs.h
> > index 2738c13..c34d36b 100644
> > --- a/include/asm-mips/sibyte/bcm1480_regs.h
> > +++ b/include/asm-mips/sibyte/bcm1480_regs.h
> > @@ -227,10 +227,15 @@
> >  	(A_BCM1480_DUART(chan) +					\
> >  	 BCM1480_DUART_CHANREG_SPACING * 3 + (reg))
> >  
> > +#define DUART_IMRISR_SPACING	    0x20
> > +#define DUART_INCHNG_SPACING	    0x10
> > +
> 
>  Aren't all the bits in "bcm1480_regs.h" meant to be prefixed with 
> BCM1480_DUART?

Appatenly not, guessing from the header's contents.

> If these are to be the same as for the BCM1250, then they 
> can probably be defined "in sb1250_regs.h" unconditionally.
> 
>  These headers are a horrible mess anyway -- a single definition should be 
> enough to access the two DUARTs the BCM1480 seems to have...

Indeed. I just took the path of least resistance to make it work again.


Thiemo

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 20:08:00 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:39571 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S28573819AbXB0UHz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 20:07:55 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 6295DBAC53;
	Tue, 27 Feb 2007 21:01:38 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HM8Y1-0004Ri-1v; Tue, 27 Feb 2007 20:03:41 +0000
Date:	Tue, 27 Feb 2007 20:03:41 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070227200340.GE12230@networkno.de>
References: <45E47197.7010204@pmc-sierra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45E47197.7010204@pmc-sierra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Marc St-Jean wrote:
> 
> 
> Thiemo Seufer wrote:
> > Marc St-Jean wrote:
> > [snip]
> >  > >  > +#ifdef CONFIG_PMC_MSP
> >  > >  > +     jal     kernel_entry
> >  > >  > +#else
> > 
> > Maybe introduce a CONFIG_BOOT_RAW (and use it in arch/mips/Makefile
> > to objcopy the kernel to a raw binary).
> > 
> >  > >  > +     /*
> >  > >  >        * Reserved space for exception handlers.
> >  > >  >        * Necessary for machines which link their kernels at KSEG0.
> >  > >  >        */
> >  > >  >       .fill   0x400
> >  > >  > +#endif /* CONFIG_PMC_MSP */
> >  > >
> >  > > This is getting kind of ugly.  There are a whole lot of config choices
> >  > > that need to use the 'j kernel_entry'.  Do they all have to have their
> >  > > own?  I'm not sure what the best way is to handle them all.
> >  >
> >  > I agree but don't know the best way to handle this. I could introduce a
> >  > SYS_NO_EXEPT_FILL or similar flag but this seems excessive.
> >  >
> >  > Any other ideas from arch/mips folks?
> > 
> > Something like
> > 
> > #if LOADADDR == 0xffffffff80000000
> >         .fill   0x400
> > #endif
> > 
> > but by defining an appropriate name in arch/mips/Makefile instead of
> > externalizing the load-y/LOADADDR there.
> 
> Thanks for the suggestions Thiemo.
> 
> We only need one of these solutions and I think the second one is cleaner.

You need both as they solve two independent problems. One is rerouting
the kernel entry, the other saves some space in the image.

> I do have a few questions before respinning the patch:
> 
> 1. Why do you want to create another name, wouldn't there be less confusion
> and chance for errors by reusing LOADADDR and ensuring it's the same as what
> the linker script uses?

LOADADDR is a short and thus bad name for a global symbol.

> 2. Looking at arch/mips/Makefile there are many boards not using
> 0xffffffff80000000. If we introduce this check it seems that all of these
> boards will have their _stext changed and it'll affect their "jump" address
> from monitor/boot scripts?

For targets with a raw binary kernel the assumption is that their
firmware jumps to the start of the image. The .fill translates to nops.

Targets which don't use 0x80000000 as load address don't need to
reserve space at the start for exception handlers.


Thiemo

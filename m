Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 21:28:56 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:36774 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039178AbXB0V2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Feb 2007 21:28:51 +0000
Received: (qmail 16763 invoked by uid 101); 27 Feb 2007 21:27:40 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 27 Feb 2007 21:27:40 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1RLRd7K007073;
	Tue, 27 Feb 2007 13:27:39 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCP17JJ>; Tue, 27 Feb 2007 13:27:39 -0800
Message-ID: <45E4A247.7050407@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Tue, 27 Feb 2007 13:27:35 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 27 Feb 2007 21:27:37.0232 (UTC) FILETIME=[1A21D100:01C75AB6]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Thiemo Seufer wrote:
> Marc St-Jean wrote:
>  >
>  >
>  > Thiemo Seufer wrote:
>  > > Marc St-Jean wrote:
>  > > [snip]
>  > >  > >  > +#ifdef CONFIG_PMC_MSP
>  > >  > >  > +     jal     kernel_entry
>  > >  > >  > +#else
>  > >
>  > > Maybe introduce a CONFIG_BOOT_RAW (and use it in arch/mips/Makefile
>  > > to objcopy the kernel to a raw binary).

Thanks, I'll introduce this config option to add the above 'jal kernel_entry'.
Our build system already takes care of doing the objcopy as well as
combining a rootfs, etc. so I'd rather not change the makefile if you
have no objections.


>  > >  > >  > +     /*
>  > >  > >  >        * Reserved space for exception handlers.
>  > >  > >  >        * Necessary for machines which link their kernels at 
> KSEG0.
>  > >  > >  >        */
>  > >  > >  >       .fill   0x400
>  > >  > >  > +#endif /* CONFIG_PMC_MSP */
>  > >  > >
>  > >  > > This is getting kind of ugly.  There are a whole lot of config 
> choices
>  > >  > > that need to use the 'j kernel_entry'.  Do they all have to 
> have their
>  > >  > > own?  I'm not sure what the best way is to handle them all.
>  > >  >
>  > >  > I agree but don't know the best way to handle this. I could 
> introduce a
>  > >  > SYS_NO_EXEPT_FILL or similar flag but this seems excessive.
>  > >  >
>  > >  > Any other ideas from arch/mips folks?
>  > >
>  > > Something like
>  > >
>  > > #if LOADADDR == 0xffffffff80000000
>  > >         .fill   0x400
>  > > #endif
>  > >
>  > > but by defining an appropriate name in arch/mips/Makefile instead of
>  > > externalizing the load-y/LOADADDR there.
>  >
>  > Thanks for the suggestions Thiemo.
>  >
>  > We only need one of these solutions and I think the second one is 
> cleaner.
> 
> You need both as they solve two independent problems. One is rerouting
> the kernel entry, the other saves some space in the image.

I thought without the .fill that the kernel_entry function would be at
the start of text. Apparently not, a quick test shows a crash with both
the jal and .fill removed.


>  > I do have a few questions before respinning the patch:
>  >
>  > 1. Why do you want to create another name, wouldn't there be less 
> confusion
>  > and chance for errors by reusing LOADADDR and ensuring it's the same 
> as what
>  > the linker script uses?
> 
> LOADADDR is a short and thus bad name for a global symbol.
> 
>  > 2. Looking at arch/mips/Makefile there are many boards not using
>  > 0xffffffff80000000. If we introduce this check it seems that all of 
> these
>  > boards will have their _stext changed and it'll affect their "jump" 
> address
>  > from monitor/boot scripts?
> 
> For targets with a raw binary kernel the assumption is that their
> firmware jumps to the start of the image. The .fill translates to nops.
> 
> Targets which don't use 0x80000000 as load address don't need to
> reserve space at the start for exception handlers.

Thanks for clarifying,
Marc

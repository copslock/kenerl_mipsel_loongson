Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 10:01:27 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:30901 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026742AbXK2KBT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2007 10:01:19 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IxgCs-00038t-01; Thu, 29 Nov 2007 11:01:18 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 40DA3C2B3D; Thu, 29 Nov 2007 10:58:44 +0100 (CET)
Date:	Thu, 29 Nov 2007 10:58:44 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 support
Message-ID: <20071129095844.GA9106@alpha.franken.de>
References: <20071126224004.D885AC2B26@solo.franken.de> <20071128143459.GA22943@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071128143459.GA22943@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Nov 28, 2007 at 02:34:59PM +0000, Ralf Baechle wrote:
> > diff --git a/include/asm-mips/dma.h b/include/asm-mips/dma.h
> > index 833437d..80caf6b 100644
> > --- a/include/asm-mips/dma.h
> > +++ b/include/asm-mips/dma.h
> > @@ -88,6 +88,9 @@
> >  /* Horrible hack to have a correct DMA window on IP22 */
> >  #include <asm/sgi/mc.h>
> >  #define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
> > +#elif defined(CONFIG_SGI_IP28)
> > +#include <asm/sgi/mc.h>
> > +#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG1_BADDR + 0x01000000)
> >  #else
> >  #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
> >  #endif
> 
> I've always been wondering if the even the IP22 segment was correct at
> all.  Afair nobody ever had (E)ISA DMA working on Indigo 2 so that code
> is a shot into the dark.  Of course for now it's the sanest thing to
> assume that IP28 is the same as the "classic" Indigo 2.

I've changed that in the updated IP28 patch. I don't see a way to
support ISA busmaster devices, because they will generate a physical
address between 0 and 0x1000000, which will only hit the 512 KB
mirrored RAM. Anything which uses ISA slave DMA is able to address
the full 32bit address space.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

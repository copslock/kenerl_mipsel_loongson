Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 12:22:31 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:20135 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023308AbXILLWX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 12:22:23 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IVQIR-0004bD-00; Wed, 12 Sep 2007 13:22:15 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id DBFACC2B61; Wed, 12 Sep 2007 13:22:04 +0200 (CEST)
Date:	Wed, 12 Sep 2007 13:22:04 +0200
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	florian@openwrt.org, nbd@openwrt.org, ejka@imfi.kspu.ru,
	nico@openwrt.org, ralf@linux-mips.org,
	openwrt-devel@lists.openwrt.org, akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
Message-ID: <20070912112204.GA7197@alpha.franken.de>
References: <200709080143.12345.technoboy85@gmail.com> <200709080218.50236.technoboy85@gmail.com> <20070909.024020.61508994.anemo@mba.ocn.ne.jp> <200709120043.43452.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709120043.43452.technoboy85@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 12:43:42AM +0200, Matteo Croce wrote:
> Il Saturday 08 September 2007 19:40:20 Atsushi Nemoto ha scritto:
> > > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > > index 6379003..75a46ba 100644
> > > --- a/arch/mips/kernel/traps.c
> > > +++ b/arch/mips/kernel/traps.c
> > > @@ -1075,9 +1075,23 @@ void *set_except_vector(int n, void *addr)
> > >  
> > >  	exception_handlers[n] = handler;
> > >  	if (n == 0 && cpu_has_divec) {
> > > +#ifdef CONFIG_AR7
> > > +		/* lui k0, 0x0000 */
> > > +		*(volatile u32 *)(CAC_BASE+0x200) =
> > > +				0x3c1a0000 | (handler >> 16);
> > > +		/* ori k0, 0x0000 */
> > > +		*(volatile u32 *)(CAC_BASE+0x204) =
> > > +				0x375a0000 | (handler & 0xffff);
> > > +		/* jr k0 */
> > > +		*(volatile u32 *)(CAC_BASE+0x208) = 0x03400008;
> > > +		/* nop */
> > > +		*(volatile u32 *)(CAC_BASE+0x20C) = 0x00000000;
> > > +		flush_icache_range(CAC_BASE+0x200, CAC_BASE+0x210);
> > > +#else
> > >  		*(volatile u32 *)(ebase + 0x200) = 0x08000000 |
> > >  		                                 (0x03ffffff & (handler >> 2));
> > >  		flush_icache_range(ebase + 0x200, ebase + 0x204);
> > > +#endif
> > >  	}
> > >  	return (void *)old_handler;
> > >  }
> > 
> > Runtime checking, something like this would be better than ifdef:
> > 
> > 	if ((handler ^ (ebase + 4)) & 0xfc000000)
> > 		/* use jr */
> > 		...
> > 	} else {
> > 		/* use j */
> > 		...
> > 	}
> This will not make the code bigger? What's wrong with #ifdef?

probably nothing, but having a generic decision whether we need
a version with j or jr will help other platforms as well. Why make
AR7 a special case ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

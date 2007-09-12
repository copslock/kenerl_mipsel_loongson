Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 12:10:55 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61366 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023206AbXILLKw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 12:10:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8CBAncE016790;
	Wed, 12 Sep 2007 12:10:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8CBAgsb016789;
	Wed, 12 Sep 2007 12:10:42 +0100
Date:	Wed, 12 Sep 2007 12:10:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	florian@openwrt.org, nbd@openwrt.org, ejka@imfi.kspu.ru,
	nico@openwrt.org, openwrt-devel@lists.openwrt.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
Message-ID: <20070912111041.GB4571@linux-mips.org>
References: <200709080143.12345.technoboy85@gmail.com> <200709080218.50236.technoboy85@gmail.com> <20070909.024020.61508994.anemo@mba.ocn.ne.jp> <200709120043.43452.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709120043.43452.technoboy85@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 12:43:42AM +0200, Matteo Croce wrote:

> > > --- a/arch/mips/kernel/traps.c
> > > +++ b/arch/mips/kernel/traps.c
> > > @@ -1075,9 +1075,23 @@ void *set_except_vector(int n, void *addr)
> > >  
> > >  	exception_handlers[n] = handler;
> > >  	if (n == 0 && cpu_has_divec) {
> > > +#ifdef CONFIG_AR7
> > > +		/* lui k0, 0x0000 */
> > > +		*(volatile u32 *)(CAC_BASE+0x200) =

s/CAC_BASE/ebase/

> > > +				0x3c1a0000 | (handler >> 16);
> > > +		/* ori k0, 0x0000 */
> > > +		*(volatile u32 *)(CAC_BASE+0x204) =
> > > +				0x375a0000 | (handler & 0xffff);
> > > +		/* jr k0 */
> > > +		*(volatile u32 *)(CAC_BASE+0x208) = 0x03400008;
> > > +		/* nop */
> > > +		*(volatile u32 *)(CAC_BASE+0x20C) = 0x00000000;
> > > +		flush_icache_range(CAC_BASE+0x200, CAC_BASE+0x210);

All these volatile keywords are unnecessary btw.

You may want to read Documentation/volatile-considered-harmful.txt on
why volatile is almost always a bad idea.

> > > +#else
> > >  		*(volatile u32 *)(ebase + 0x200) = 0x08000000 |
> > >  		                                 (0x03ffffff & (handler >> 2));

Just like this one, so I will remove it now.

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
> This will not make the code bigger?

It will by a miniscule amount.  Which hardly matters because the function
is (whops, should be ...) __init code anyway.

> What's wrong with #ifdef?

#ifdef makes for harder to read code (To paraphrase Linus - the kernel is
write once and read 10 million times) , is less flexible and has a tendence
to hide bugs in the deactivated part.  So generally avoid.

And actually in this specific case it also should be a runtime decission
simply because in the not so distant future the will be hardware which
will simply need that.

  Ralf

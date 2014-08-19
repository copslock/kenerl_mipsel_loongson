Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 12:10:55 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:55250 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855253AbaHSKKrviZnJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 12:10:47 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1XJgNH-0005Eu-00; Tue, 19 Aug 2014 12:10:43 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 828AB1D268; Tue, 19 Aug 2014 12:05:02 +0200 (CEST)
Date:   Tue, 19 Aug 2014 12:05:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: IP28: Correct IO_BASE in mach-ip28/spaces.h for
 proper ioremap
Message-ID: <20140819100502.GA5321@alpha.franken.de>
References: <53F2BC86.8000506@gentoo.org>
 <20140819080034.GA11547@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140819080034.GA11547@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Aug 19, 2014 at 10:00:34AM +0200, Ralf Baechle wrote:
> On Mon, Aug 18, 2014 at 10:55:02PM -0400, Joshua Kinard wrote:
> 
> > --- a/arch/mips/include/asm/mach-ip28/spaces.h
> > +++ b/arch/mips/include/asm/mach-ip28/spaces.h
> > @@ -18,7 +18,7 @@
> >  #define PHYS_OFFSET	_AC(0x20000000, UL)
> > 
> >  #define UNCAC_BASE	_AC(0xc0000000, UL)     /* 0xa0000000 + PHYS_OFFSET */
> > -#define IO_BASE		UNCAC_BASE
> > +#define IO_BASE		_AC(0x9000000000000000, UL)
> > 
> >  #include <asm/mach-generic/spaces.h>
> 
> I think the real culprit is not the definition of IO_BASE but of
> UNCAC_BASE.  0xc0000000UL is KSEG2 for a 32 bit kernel - but for a 64 bit
> kernel UNCAC_BASE should be defined as _AC(0x9000000000000000, UL).

that was my first thought as well. I just wondered whether it's necessary
to reflect PHY_OFFSET != 0... nevertheless UNCAC_BASE is not usuable
for memory access on IP28 at all. At least not without poking at the
memory controller for slower access cycles, which the current kernel
avoids totaly.

> Which are the defaults in <asm/mach-generic/spaces.h> so just deleting
> both UNCAC_BASE and IO_BASE from mach-ip28/spaces.h should fix things?

I'll give a spin later.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

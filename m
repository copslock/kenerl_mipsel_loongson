Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 08:39:33 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:32640 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225209AbTF3Hja>; Mon, 30 Jun 2003 08:39:30 +0100
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP
	id DA8E0FACE; Mon, 30 Jun 2003 00:39:28 -0700 (PDT)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id 9BF4624; Mon, 30 Jun 2003 00:39:28 -0700 (PDT)
Date: Mon, 30 Jun 2003 00:39:28 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: ilya@theIlya.com
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ip32 specific stuff
Message-ID: <20030630073928.GA31773@foobazco.org>
References: <20030630003636.GI13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630003636.GI13617@gateway.total-knowledge.com>
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 29, 2003 at 05:36:36PM -0700, ilya@theIlya.com wrote:

> This is the patch that includes most of things that I have in IP32-specific
> parts of my tree.

> 2. Propper memory detection pathc by Keith.

Please don't apply this.  It's a mostly nice piece of code with one
horrible hack, and we're better off for now staying with
CONFIG_ARC_MEMORY until we decide how to best support >256MB of
memory.

The CRIME error handling part is golden however.

> 3. Some other minor fixlets.

>  void ip32_irq1(struct pt_regs *regs)
> Index: arch/mips/sgi-ip32/ip32-setup.c
>  
> +#ifdef CONFIG_FB_SGIO2
> +#include "../../../drivers/video/sgio2fb.h"
> +void *sgio2fb_mem;
> +#endif

You can't reference this because that driver doesn't exist yet.  And
including that here is kind of ugly anyway.

> -#ifdef CONFIG_SERIAL_CONSOLE
> +#ifdef CONFIG_SERIAL_MACE_SGIO2
> +#warning O2MACECONSOLE compiled in
> +	o2serial_console_init();
> +#endif

Debugging snippet leaked in.

> -}
> -
> -int __init page_is_ram (unsigned long pagenr)
> -{
> -	/* XXX: to do? */
> -	return 1;
>  }

Yes, this appears to be unused.

> Index: include/asm-mips64/ip32/crime.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips64/ip32/crime.h,v
...
> -static inline u64 crime_read_64 (unsigned long __offset) {
> -        return *((volatile u64 *) (CRIME_BASE + __offset));
> -}
> -static inline void crime_write_64 (unsigned long __offset, u64 __val) {
> -        *((volatile u64 *) (CRIME_BASE + __offset)) = __val;
> -}
> +#define crime_read_64(__offset)		__in64(CRIME_BASE+(__offset))
> +#define crime_write_64(__offset,__val)	__out64(__val,CRIME_BASE+(__offset))

You can't do this yet because I just sent Ralf the patch to add those
functions, and they're going to be named __raw_readq and __raw_writeq
as well.  I'll take care of this as soon as that patch is approved.

> --- /dev/null	Sun Jul 17 16:46:18 1994
> +++ include/asm-mips/io64.h	Sun Jun 15 10:35:18 2003

There will be no io64.h.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake

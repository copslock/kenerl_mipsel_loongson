Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 15:28:47 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:2827 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225243AbVAJP2l>;
	Mon, 10 Jan 2005 15:28:41 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Co1ZB-0001ae-00; Mon, 10 Jan 2005 15:34:49 +0000
Received: from [192.168.192.200] (helo=perivale.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Co1Sy-0005hB-00; Mon, 10 Jan 2005 15:28:24 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Co1Sy-0004km-00; Mon, 10 Jan 2005 15:28:24 +0000
Date: Mon, 10 Jan 2005 15:28:24 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <20050107.004521.74752947.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
 <20050107.004521.74752947.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.72,
	required 4, AWL, BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Fri, 7 Jan 2005, Atsushi Nemoto wrote:

> 1. How about adding 'volatile' and '__iomem' to *read*()/*write*() ?
>    While some archs use 'volatile void __iomem *' and some are not, I
>    think *read*()/*write*()/ioremap()/iounmap() should use same type.
>    This will remove some compiler warnings.

 Hmm, what's the semantics of "volatile void *"?  I can't imagine any, so 
I don't think it would be useful.  OTOH, I do agree the types used should 
be the same for all the mentioned functions and I'm inclined to make it 
"void __iomem *".  For *read*(), "const" would be included as well.

> 2. How about using 'const void *' for outs*()?  This will remove some
>    compiler warnings too.

 Agreed.

> 3. In *in*()/*out*(), it would be better to call __swizzle_addr*()
>    AFTER adding mips_io_port_base.  This unifies the meaning of the
>    argument of __swizzle_addr*() (always virtual address).  Then,
>    mach-specific __swizzle_addr*() can to every evil thing based on
>    the argument.

 Well, it shouldn't really matter as mips_io_port_base is expected to be 
page-aligned anyway.  But I have no objections either.

> 4. How about enclosing all *ioswab*() by '#ifndef' ?  Also how about
>    passing virtual address to *ioswab*() ?  I mean something like:
> 
> # ifndef ioswabw
> #  define ioswabw(a,x)		le16_to_cpu(x)
> # endif
> # ifndef __raw_ioswabw
> #  define __raw_ioswabw(a,x)	(x)
> # endif
> ...
> 	__val = pfx##ioswab##bwlq(__mem, val);				\
> 
>   Then we can provide mach-specific *ioswab*() in mach-*/mangle-port.h
>   and can do every evil thing based on its argument.  It is usefull on
>   machines which have regions with defirrent endian conversion scheme.
>   Also, this can clean up CONFIG_SGI_IP22 from io.h
>   (mach-ip22/mangle-port.h can provide its own *ioswabw*()).

 Instead of using "#ifndef" the generic versions could be moved to 
<asm-mips/mach-generic/mangle-port.h>.  Otherwise it sounds reasonable.

 Note that __mem is a virtual address, though, so you'd have to perform a 
physical address lookup before deciding on a swapping strategy -- would we 
really have a gain on any system from using regions with different 
swapping properties?

 Thanks for your feedback.

  Maciej

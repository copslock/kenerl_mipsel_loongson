Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 15:28:23 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37905 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021520AbXGKO2V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 15:28:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C9BCDE1CBD;
	Wed, 11 Jul 2007 16:28:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YnatOS+C8+KX; Wed, 11 Jul 2007 16:28:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 755D3E1C66;
	Wed, 11 Jul 2007 16:28:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6BESMiw007642;
	Wed, 11 Jul 2007 16:28:22 +0200
Date:	Wed, 11 Jul 2007 15:28:19 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Workaround for a sparse warning in include/asm-mips/io.h
In-Reply-To: <20070711.231200.05599385.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0707111516250.26459@blysk.ds.pg.gda.pl>
References: <20070711.231200.05599385.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3635/Wed Jul 11 13:30:51 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007, Atsushi Nemoto wrote:

> CKSEG1ADDR() returns unsigned int value on 32bit kernel.  Cast it to
> unsigned long to get rid of this warning:
> 
> include2/asm/io.h:215:12: warning: cast adds address space to expression (<asn:2>)
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
> index 12bcc1f..7ba9289 100644
> --- a/include/asm-mips/io.h
> +++ b/include/asm-mips/io.h
> @@ -212,7 +212,8 @@ static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
>  		 */
>  		if (__IS_LOW512(phys_addr) && __IS_LOW512(last_addr) &&
>  		    flags == _CACHE_UNCACHED)
> -			return (void __iomem *)CKSEG1ADDR(phys_addr);
> +			return (void __iomem *)
> +				(unsigned long)CKSEG1ADDR(phys_addr);
>  	}

 It looks like a bug in sparse.  The result of CKSEG1ADDR() has the same 
size as the pointer.  Perhaps we could append 'L' to the expansion of 
KSEG1 et al, but that should not really matter.

 But -- I have just checked two example calls to this function, one with a 
32-bit configuration and another one with a 64-bit one and sparse did not 
complain.  The cpp expansions of the expression in question are:

return (void *)((((int)(int)(phys_addr)) & 0x1fffffff) | 0xa0000000);

and:

return (void *)((((long int)(int)(phys_addr)) & 0x1fffffff) | 0xffffffffa0000000L);

respectively, so your cast is definitely redundant in these cases.  What 
sort of configuration are you using?  What's the preprocessor output for 
the problematic case?

  Maciej

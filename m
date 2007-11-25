Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 10:03:40 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:32941 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031985AbXKYKDc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2007 10:03:32 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IwEKp-0005yB-00; Sun, 25 Nov 2007 11:03:31 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 65E83C223F; Sun, 25 Nov 2007 11:03:12 +0100 (CET)
Date:	Sun, 25 Nov 2007 11:03:12 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] IP22: Fix modules for 64bit kernels by using a CKSEG2 MAP_BASE
Message-ID: <20071125100224.GA17974@alpha.franken.de>
References: <20071123195152.B86B0C2E30@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071123195152.B86B0C2E30@solo.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Nov 23, 2007 at 08:41:55PM +0100, Thomas Bogendoerfer wrote:
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  include/asm-mips/mach-ip22/spaces.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-mips/mach-ip22/spaces.h b/include/asm-mips/mach-ip22/spaces.h
> index 7f9fa6f..8264d0a 100644
> --- a/include/asm-mips/mach-ip22/spaces.h
> +++ b/include/asm-mips/mach-ip22/spaces.h
> @@ -18,7 +18,7 @@
>  #define CAC_BASE		0xffffffff80000000
>  #define IO_BASE			0xffffffffa0000000
>  #define UNCAC_BASE		0xffffffffa0000000
> -#define MAP_BASE		0xc000000000000000
> +#define MAP_BASE		0xffffffffc0000000
>  
>  #endif /* CONFIG_64BIT */

please drop this bogus patch, it causes vmalloc allocations fails. The bug
it tries to fix isn't even there.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

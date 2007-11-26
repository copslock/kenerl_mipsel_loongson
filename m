Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 23:06:38 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:53006 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S28573840AbXKZXG3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 23:06:29 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 26 Nov 2007 15:06:01 -0800
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 26 Nov 2007 15:06:01 -0800
Date:	Mon, 26 Nov 2007 15:06:01 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix warning when using PHYS_TO_XKSEG_xx()
Message-ID: <20071126150601.2cd8efc0@ripper.onstor.net>
In-Reply-To: <20071126223948.C7CB3C2B26@solo.franken.de>
References: <20071126223948.C7CB3C2B26@solo.franken.de>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2007 23:06:01.0512 (UTC) FILETIME=[E9B77280:01C83080]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

This is the basically the patch I submitted 10/31 and I believe is
queued for 2.6.25 ...

On Sun, 25 Nov 2007 11:28:03 +0100 Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:

> use CONST64 cast in PHYS_TO_XPHYS macro to avoid warning about shifts
> longer than the target type.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/lib/uncached.c     |    8 ++++----
>  include/asm-mips/addrspace.h |    2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
> index 58d14f4..b59b770 100644
> --- a/arch/mips/lib/uncached.c
> +++ b/arch/mips/lib/uncached.c
> @@ -46,8 +46,8 @@ unsigned long __init run_uncached(void *func)
>  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
>  		usp = CKSEG1ADDR(sp);
>  #ifdef CONFIG_64BIT
> -	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0)
> &&
> -		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
> +	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
> +		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
>  		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
>  				     XKPHYS_TO_PHYS((long long)sp));
>  #endif
> @@ -58,8 +58,8 @@ unsigned long __init run_uncached(void *func)
>  	if (lfunc >= (long)CKSEG0 && lfunc < (long)CKSEG2)
>  		ufunc = CKSEG1ADDR(lfunc);
>  #ifdef CONFIG_64BIT
> -	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0LL,
> 0) &&
> -		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8LL,
> 0))
> +	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0, 0)
> &&
> +		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8, 0))
>  		ufunc = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
>  				       XKPHYS_TO_PHYS((long
> long)lfunc)); #endif
> diff --git a/include/asm-mips/addrspace.h
> b/include/asm-mips/addrspace.h index 0bb7a93..9002d66 100644
> --- a/include/asm-mips/addrspace.h
> +++ b/include/asm-mips/addrspace.h
> @@ -127,7 +127,7 @@
>  #define PHYS_TO_XKSEG_CACHED(p)
> PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE, (p)) #define
> XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK) #define
> PHYS_TO_XKPHYS(cm, a)		(_CONST64_(0x8000000000000000) |
> \
> -					 ((cm)<<59) | (a))
> +					 (_CONST64_(cm)<<59) | (a))
>  
>  /*
>   * The ultimate limited of the 64-bit MIPS architecture:  2 bits for
> selecting

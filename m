Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2009 01:25:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25816 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S20808306AbZBYBZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Feb 2009 01:25:07 +0000
Date:	Wed, 25 Feb 2009 01:25:07 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
In-Reply-To: <1235516662-24919-1-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0902250043130.1122@ftp.linux-mips.org>
References: <1235516662-24919-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 Feb 2009, David Daney wrote:

> @@ -16,4 +16,11 @@
>  #define GCC_REG_ACCUM "accum"
>  #endif
>  
> +#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 4)
> +#define GCC_NO_H_CONSTRAINT
> +#ifdef CONFIG_64BIT
> +typedef unsigned int uint128_t __attribute__((mode(TI)));
> +#endif
> +#endif
> +
>  #endif /* _ASM_COMPILER_H */

 I suggest to call it u128 in line with all the other such types (and 
place it in <asm/types.h>?).  Also it might be more reasonable to call the 
macro something like GCC_HAS_EXT64_MULT or suchlike as in my opinion we 
should prefer using C code for a calculation like this even if the "h" 
constraint still worked.  We might want to have i128 too. :)

> @@ -62,8 +62,9 @@ static inline void __delay(unsigned long loops)
>  
>  static inline void __udelay(unsigned long usecs, unsigned long lpj)
>  {
> +#ifndef GCC_NO_H_CONSTRAINT
>  	unsigned long hi, lo;
> -
> +#endif
>  	/*
>  	 * The rates of 128 is rounded wrongly by the catchall case
>  	 * for 64-bit.  Excessive precission?  Probably ...
> @@ -77,6 +78,12 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
>  	                           0x80000000ULL) >> 32);
>  #endif
>  
> +#ifdef GCC_NO_H_CONSTRAINT
> +	if (sizeof(long) == 4)
> +		usecs = ((u64)usecs * lpj) >> 32;
> +	else
> +		usecs = ((uint128_t)usecs * lpj) >> 64;
> +#else
>  	if (sizeof(long) == 4)
>  		__asm__("multu\t%2, %3"
>  		: "=h" (usecs), "=l" (lo)
> @@ -92,6 +99,7 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
>  		: "=r" (usecs), "=h" (hi), "=l" (lo)
>  		: "r" (usecs), "r" (lpj)
>  		: GCC_REG_ACCUM);
> +#endif
>  
>  	__delay(usecs);
>  }

 Ouch, this is horribly ugly.  It begs for making the conditional chunks a 
pair of separate static inline functions.  You could then do something 
like __delay(__usecs_to_loops(usecs, lpj)) and simply have two variants of 
__usecs_to_loops() with no need to chop code with #ifdefs in the middle.

  Maciej

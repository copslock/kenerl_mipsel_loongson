Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 13:01:47 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:10955 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20026618AbXKKNBj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Nov 2007 13:01:39 +0000
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 857CD490D9;
	Sun, 11 Nov 2007 12:47:33 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1IrCRP-0008AB-48; Sun, 11 Nov 2007 13:01:31 +0000
Date:	Sun, 11 Nov 2007 13:01:31 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero()
Message-ID: <20071111130130.GB8363@networkno.de>
References: <4736C1EA.2050009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4736C1EA.2050009@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Currently memset() is used to fill a user space area (clear_user) or
> kernel one (memset). These two functions don't have the same
> prototype, the former returning the number of bytes not copied and the
> latter returning the start address of the area to clear. This forces
> memset() to actually returns two values in an unconventional way ie
> the number of bytes not copied is given by $a2. Therefore clear_user()
> needs to call memset() using inline assembly.
> 
> Instead this patch creates __fill_user() which is the same as memset()
> except it always returns the number of bytes not copied. This simplify
> clear_user() and makes its definition saner.
> 
> Also an out of line version of memset is given because gcc generates
> some calls to it since builtin functions have been disabled. It allows
> assembly code to call it too.
> 
> Eventually __bzero() has been removed because it's not part of the
> Linux uaccess API. And the nano-optimization it brings is not
> worthing.
> 
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
>  arch/mips/kernel/mips_ksyms.c |    3 +-
>  arch/mips/lib/csum_partial.S  |    2 +-
>  arch/mips/lib/memcpy.S        |    2 +-
>  arch/mips/lib/memset.S        |   49 ++++++++++++++++++++++++++--------------
>  include/asm-mips/string.h     |    7 +++++-
>  include/asm-mips/uaccess.h    |   17 ++-----------
>  6 files changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> index 225755d..a801e09 100644
> --- a/arch/mips/kernel/mips_ksyms.c
> +++ b/arch/mips/kernel/mips_ksyms.c
> @@ -14,7 +14,6 @@
>  #include <asm/pgtable.h>
>  #include <asm/uaccess.h>
>  
> -extern void *__bzero(void *__s, size_t __count);
>  extern long __strncpy_from_user_nocheck_asm(char *__to,
>                                              const char *__from, long __len);
>  extern long __strncpy_from_user_asm(char *__to, const char *__from,
> @@ -36,9 +35,9 @@ EXPORT_SYMBOL(kernel_thread);
>  /*
>   * Userspace access stuff.
>   */
> +EXPORT_SYMBOL(__fill_user);
>  EXPORT_SYMBOL(__copy_user);
>  EXPORT_SYMBOL(__copy_user_inatomic);
> -EXPORT_SYMBOL(__bzero);
>  EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
>  EXPORT_SYMBOL(__strncpy_from_user_asm);
>  EXPORT_SYMBOL(__strlen_user_nocheck_asm);
> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
> index c0a77fe..8d3fa1e 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -694,7 +694,7 @@ l_exc:
>  	ADD	dst, t0			# compute start address in a1
>  	SUB	dst, src
>  	/*
> -	 * Clear len bytes starting at dst.  Can't call __bzero because it
> +	 * Clear len bytes starting at dst.  Can't call memset because it
>  	 * might modify len.  An inefficient loop for these rare times...
>  	 */
>  	beqz	len, done
> diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
> index a526c62..425f2c3 100644
> --- a/arch/mips/lib/memcpy.S
> +++ b/arch/mips/lib/memcpy.S
> @@ -443,7 +443,7 @@ l_exc:
>  	ADD	dst, t0			# compute start address in a1
>  	SUB	dst, src
>  	/*
> -	 * Clear len bytes starting at dst.  Can't call __bzero because it
> +	 * Clear len bytes starting at dst.  Can't call memset because it
>  	 * might modify len.  An inefficient loop for these rare times...
>  	 */
>  	beqz	len, done
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 3f8b8b3..cb6b83d 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -46,17 +46,34 @@
>  	.endm
>  
>  /*
> - * memset(void *s, int c, size_t n)
> + * An outline version of memset, which should be used either by gcc or
> + * by assembly code.
> + */
> +NESTED(memset, 24, ra)
> +	PTR_ADDU	sp, sp, -24
> +	LONG_S		a0, 16(sp)
> +	LONG_S		ra, 20(sp)
> +	jal		__fill_user
> +	LONG_L		v0, 16(sp)
> +	LONG_L		ra, 20(sp)
> +	PTR_ADDU	sp, sp, 24
> +	jr		ra
> +END(memset)

This will break on 64bit kernels.


Thiemo

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2012 19:30:31 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53532 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903381Ab2IDRaX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2012 19:30:23 +0200
Received: by pbbrq8 with SMTP id rq8so10274491pbb.36
        for <multiple recipients>; Tue, 04 Sep 2012 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ttf0tJ5HhyKcV6Ci+IX3SCERhB9/TzVi7Ul/2Y9LYvo=;
        b=dNXzJShYl9rDQDCeuinqcKn1bPQTX6kEmAeuzt3IWVTNoF1wHtdVJgPKDtdQySRt6f
         zqVurVJPyk8u6K3Nxi5JS4inOWBHnmkl3JxiOX3NoatU5UAv91C2kzuWSzysEWm/Ss1L
         +XLsmSZb+Q6qO+VqD3KKHJqak69oCX0ylFIGOM6tbyVTWHTa2oyun0fzF38JHLB9+i1t
         8YDYIwqwpktdWLwcOtK8iSlIggnTec3Mnv5I2xWA0LbDTcM+6/ra38eyGKmHP525FG/d
         ieGBnomcUvSg51RSn1EeclCilezrO1f3tJfvWlmWRv6hB/r3nNpmJsN4mx6qkYZMSYzj
         wh9g==
Received: by 10.68.221.225 with SMTP id qh1mr47981575pbc.50.1346779816977;
        Tue, 04 Sep 2012 10:30:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tt6sm10205620pbc.51.2012.09.04.10.30.14
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 10:30:15 -0700 (PDT)
Message-ID: <50463AA5.1000506@gmail.com>
Date:   Tue, 04 Sep 2012 10:30:13 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Jim Quinlan <jim2101024@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org, cernekee@gmail.com
Subject: Re: [PATCH V3 1/2] MIPS: Remove irqflags.h dependency from bitops.h
References: <y> <1346709137-3448-1-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1346709137-3448-1-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/03/2012 02:52 PM, Jim Quinlan wrote:
> The "else clause" of most functions in bitops.h invoked
> raw_local_irq_{save,restore}() and so had a dependency on irqflags.h.  This
> fix moves said code to bitops.c, removing the dependency.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>


This is much better I think.

Now only a few very minor things I would change...

> ---
>   arch/mips/include/asm/bitops.h |  114 +++++++------------------
>   arch/mips/include/asm/io.h     |    1 +
>   arch/mips/lib/Makefile         |    2 +-
>   arch/mips/lib/bitops.c         |  180 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 214 insertions(+), 83 deletions(-)
>   create mode 100644 arch/mips/lib/bitops.c
>
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index 82ad35c..9fd0b1d 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -14,7 +14,6 @@
>   #endif
>
>   #include <linux/compiler.h>
> -#include <linux/irqflags.h>
>   #include <linux/types.h>
>   #include <asm/barrier.h>
>   #include <asm/byteorder.h>		/* sigh ... */
> @@ -44,6 +43,24 @@
>   #define smp_mb__before_clear_bit()	smp_mb__before_llsc()
>   #define smp_mb__after_clear_bit()	smp_llsc_mb()
>
> +
> +/*
> + * These are the "slower" versions of the functions and are in bitops.c.
> + * These functions call raw_local_irq_{save,restore}().
> + */
> +extern void atomic_set_bit(unsigned long nr, volatile unsigned long *addr);
> +extern void atomic_clear_bit(unsigned long nr, volatile unsigned long *addr);
> +extern void atomic_change_bit(unsigned long nr, volatile unsigned long *addr);
> +extern int atomic_test_and_set_bit(unsigned long nr,
> +				   volatile unsigned long *addr);
> +extern int atomic_test_and_set_bit_lock(unsigned long nr,
> +					volatile unsigned long *addr);
> +extern int atomic_test_and_clear_bit(unsigned long nr,
> +				     volatile unsigned long *addr);
> +extern int atomic_test_and_change_bit(unsigned long nr,
> +				      volatile unsigned long *addr);
> +

No 'extern' needed.

These shouldn't be directly called from user code.  I would suggest 
renaming the functions to something like:

__mips_set_bit();


[...]
> diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
> new file mode 100644
> index 0000000..6562ab2
> --- /dev/null
> +++ b/arch/mips/lib/bitops.c
> @@ -0,0 +1,180 @@
> +
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (c) 1994-1997, 99, 2000, 06, 07 Ralf Baechle (ralf@linux-mips.org)
> + * Copyright (c) 1999, 2000  Silicon Graphics, Inc.
> + */
> +
> +#include <linux/irqflags.h>
> +
> +#if _MIPS_SZLONG == 32
> +#define SZLONG_LOG 5
> +#define SZLONG_MASK 31UL
> +#elif _MIPS_SZLONG == 64
> +#define SZLONG_MASK 63UL
> +#define SZLONG_LOG 6
> +#endif
> +

There has to be a cleaner way to do this...  Perhaps:



#define SZLONG_LOG (ilog2(sizeof(unsigned long)) + 3)
#define SZLONG_MASK ((1 << SZLONG_LOG) - 1)

> +
> +/*
> + * atomic_set_bit - Atomically set a bit in memory.  This is called by
> + * if set_bit() if it cannot find a faster solution.
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + */
> +void atomic_set_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	volatile unsigned long *a = addr;
> +	unsigned short bit = nr & SZLONG_MASK;

just make bit type 'int'.  In some cases forcing a narrower type than 
necessary requires the compiler to emit extra code.  I am not sure if it 
would here, but why use a type other than int unless absolutely necessary?

> +	unsigned long mask;
> +	unsigned long flags;
> +
> +	a += nr >> SZLONG_LOG;
> +	mask = 1UL << bit;
> +	raw_local_irq_save(flags);
> +	*a |= mask;
> +	raw_local_irq_restore(flags);
> +}

All these must be EXPORT_SYMBOL(), so the bitop intrinsics can be used 
from modules.

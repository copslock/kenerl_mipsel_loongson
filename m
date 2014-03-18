Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 15:04:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60610 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822314AbaCROEhDA9oc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Mar 2014 15:04:37 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2IE4UaF022780;
        Tue, 18 Mar 2014 15:04:30 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2IE4R57022779;
        Tue, 18 Mar 2014 15:04:27 +0100
Date:   Tue, 18 Mar 2014 15:04:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V19 02/13] MIPS: Loongson: Add basic Loongson-3 definition
Message-ID: <20140318140427.GC17197@linux-mips.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
 <1392537690-5961-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392537690-5961-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Feb 16, 2014 at 04:01:19PM +0800, Huacai Chen wrote:

> diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
> index 3f74545..41c030e 100644
> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -116,7 +116,9 @@
>  #define K_CALG_UNCACHED		2
>  #define K_CALG_NONCOHERENT	3
>  #define K_CALG_COH_EXCL		4
> +#ifndef K_CALG_COH_SHAREABLE
>  #define K_CALG_COH_SHAREABLE	5
> +#endif

It seems this segment isn't even necessary - can we just drop it?

Octeon also uses cache mode 3 for coherent.

Just to avoid yet another ifdef.

>  #define K_CALG_NOTUSED		6
>  #define K_CALG_UNCACHED_ACCEL	7
>  
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index e195de5..35a4e18 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -230,6 +230,7 @@
>  #define PRID_REV_LOONGSON1B	0x0020
>  #define PRID_REV_LOONGSON2E	0x0002
>  #define PRID_REV_LOONGSON2F	0x0003
> +#define PRID_REV_LOONGSON3A	0x0005
>  
>  /*
>   * Older processors used to encode processor version and revision in two
> @@ -303,8 +304,8 @@ enum cpu_type_enum {
>  	 * MIPS64 class processors
>  	 */
>  	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
> -	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
> -	CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
> +	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
> +	CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
>  
>  	CPU_LAST
>  };
> diff --git a/arch/mips/include/asm/mach-loongson/spaces.h b/arch/mips/include/asm/mach-loongson/spaces.h
> new file mode 100644
> index 0000000..d368d95
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/spaces.h
> @@ -0,0 +1,13 @@
> +#ifndef __ASM_MACH_LOONGSON_SPACES_H_
> +#define __ASM_MACH_LOONGSON_SPACES_H_
> +
> +#ifndef CAC_BASE

This file should only be included from the top of <asm/addrspace.h> where
CAC_BASE should not be defined yet.

> +#if defined(CONFIG_64BIT)
> +#define CAC_BASE        _AC(0x9800000000000000, UL)
> +#endif /* CONFIG_64BIT */
> +#endif /* CONFIG_CAC_BASE */

The Symbol in this comment doesn't match the symbol used in the opening #ifndef.

> +
> +#define K_CALG_COH_SHAREABLE	3
> +
> +#include <asm/mach-generic/spaces.h>
> +#endif
> diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
> index 44b705d..c2edae3 100644
> --- a/arch/mips/include/asm/module.h
> +++ b/arch/mips/include/asm/module.h
> @@ -126,6 +126,8 @@ search_module_dbetables(unsigned long addr)
>  #define MODULE_PROC_FAMILY "LOONGSON1 "
>  #elif defined CONFIG_CPU_LOONGSON2
>  #define MODULE_PROC_FAMILY "LOONGSON2 "
> +#elif defined CONFIG_CPU_LOONGSON3
> +#define MODULE_PROC_FAMILY "LOONGSON3 "
>  #elif defined CONFIG_CPU_CAVIUM_OCTEON
>  #define MODULE_PROC_FAMILY "OCTEON "
>  #elif defined CONFIG_CPU_XLR
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index 32aea48..e592f36 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -235,6 +235,15 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>  #define _CACHE_CACHABLE_NONCOHERENT (5<<_CACHE_SHIFT)
>  #define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)
>  
> +#elif defined(CONFIG_CPU_LOONGSON3)
> +
> +/* Using COHERENT flag for NONCOHERENT doesn't hurt. */
> +
> +#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
> +#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
> +#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
> +#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
> +
>  #else

Ok.

Yes, it adds another #ifdef but cleaning up this should not be subject of
this patch.

  Ralf

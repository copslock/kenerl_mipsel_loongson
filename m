Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2014 20:58:44 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:33651 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870559AbaAHT6h3meSh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jan 2014 20:58:37 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W0zGq-0007ek-L1; Wed, 08 Jan 2014 20:58:32 +0100
Date:   Wed, 8 Jan 2014 20:58:32 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 01/12] MIPS: Loongson: Add basic Loongson-3 definition
Message-ID: <20140108195832.GA10409@hall.aurel32.net>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
 <1389149068-24376-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1389149068-24376-2-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Wed, Jan 08, 2014 at 10:44:17AM +0800, Huacai Chen wrote:
> Loongson-3 is a multi-core MIPS family CPU, it support MIPS64R2 fully.
> Loongson-3 has the same IMP field (0x6300) as Loongson-2.
> 
> Loongson-3 has a hardware-maintained cache, system software doesn't
> need to maintain coherency.
> 
> Loongson-3A is the first revision of Loongson-3, and it is the quad-
> core version of Loongson-2G. Loongson-3A has a simplified version named
> Loongson-2Gq, the main difference between Loongson-3A/2Gq is 3A has two
> HyperTransport controller but 2Gq has only one. HT0 is used for cross-
> chip interconnection and HT1 is used to link PCI bus. Therefore, 2Gq
> cannot support NUMA but 3A can. For software, Loongson-2Gq is simply
> identified as Loongson-3A.
> 
> Exsisting Loongson family CPUs:
> Loongson-1: Loongson-1A, Loongson-1B, they are 32-bit MIPS CPUs.
> Loongson-2: Loongson-2E, Loongson-2F, Loongson-2G, they are 64-bit
>             single-core MIPS CPUs.
> Loongson-3: Loongson-3A(including so-called Loongson-2Gq), they are
>             64-bit multi-core MIPS CPUs.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/addrspace.h            |    2 ++
>  arch/mips/include/asm/cpu.h                  |    5 +++--
>  arch/mips/include/asm/mach-loongson/spaces.h |   13 +++++++++++++
>  arch/mips/include/asm/module.h               |    2 ++
>  arch/mips/include/asm/pgtable-bits.h         |    9 +++++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
> 
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
>  #define K_CALG_NOTUSED		6
>  #define K_CALG_UNCACHED_ACCEL	7
>  
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index d2035e1..7fffaf1 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -224,6 +224,7 @@
>  #define PRID_REV_LOONGSON1B	0x0020
>  #define PRID_REV_LOONGSON2E	0x0002
>  #define PRID_REV_LOONGSON2F	0x0003
> +#define PRID_REV_LOONGSON3A	0x0005
>  
>  /*
>   * Older processors used to encode processor version and revision in two
> @@ -295,8 +296,8 @@ enum cpu_type_enum {
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
> +#if defined(CONFIG_64BIT)
> +#define CAC_BASE        _AC(0x9800000000000000, UL)
> +#endif /* CONFIG_64BIT */
> +#endif /* CONFIG_CAC_BASE */
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
>  
>  #define _CACHE_CACHABLE_NO_WA	    (0<<_CACHE_SHIFT)  /* R4600 only	  */

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

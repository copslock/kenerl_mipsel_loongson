Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 23:17:18 +0200 (CEST)
Received: from mail-vb0-f54.google.com ([209.85.212.54]:33268 "EHLO
        mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819473Ab3IYVRP2vfbU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 23:17:15 +0200
Received: by mail-vb0-f54.google.com with SMTP id q14so218805vbe.27
        for <multiple recipients>; Wed, 25 Sep 2013 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9VTAip6Ze5rWTlHvxfTRRNaCPMXggA9vhvvobK//+cE=;
        b=CMQx3O6pCfeD2tLOTGMzkLjjduLWdYWclUwAtwjtuKo2sKp8okNc66uwX34AUQPQ1S
         4fsAANs7u3gejY2hiIGoxCDGda2lEMQxRPx0sZeykMZVBG4FBrwUPyXy3g8M/tBGt589
         iMFbIYbt6cSnVMAhGoUCeTJa8BLdI/UdFVG312jE97ewHJ+5LawNVpZs3vr9BxeTK5XK
         Ezp4O1CrUoGTBbRW6P4+A+Z0UlVmOq0r0160gjdKXIc80JsTsiM5LoXtLlbTArXoCLkj
         N8RNRjen2Ye0eD9v2Nilhr7xhSKInxmqq5k3LuFHx65JT0O8OxvovXQ9blmO/Y2fF2aY
         uN5Q==
X-Received: by 10.220.43.19 with SMTP id u19mr34908578vce.3.1380143829311;
        Wed, 25 Sep 2013 14:17:09 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id n10sm28075736vew.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 14:17:08 -0700 (PDT)
Message-ID: <524352D2.10600@gmail.com>
Date:   Wed, 25 Sep 2013 14:17:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V12 01/12] MIPS: Loongson: Add basic Loongson-3 definition
References: <1380100546-8302-1-git-send-email-chenhc@lemote.com> <1380100546-8302-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1380100546-8302-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37978
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

On 09/25/2013 02:15 AM, Huacai Chen wrote:
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
>              single-core MIPS CPUs.
> Loongson-3: Loongson-3A(including so-called Loongson-2Gq), they are
>              64-bit multi-core MIPS CPUs.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>   arch/mips/include/asm/addrspace.h            |    6 ++++++
>   arch/mips/include/asm/cpu.h                  |    5 +++--
>   arch/mips/include/asm/mach-loongson/spaces.h |   15 +++++++++++++++
>   arch/mips/include/asm/module.h               |    2 ++
>   arch/mips/include/asm/pgtable-bits.h         |    7 +++++++
>   arch/mips/loongson/Platform                  |    1 +
>   6 files changed, 34 insertions(+), 2 deletions(-)
>   create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
>
> diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
> index 13d61c0..fdbadf3 100644
> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -116,7 +116,13 @@
>   #define K_CALG_UNCACHED		2
>   #define K_CALG_NONCOHERENT	3
>   #define K_CALG_COH_EXCL		4
> +
> +#ifdef CONFIG_CPU_LOONGSON3
> +#define K_CALG_COH_SHAREABLE	3
> +#else
>   #define K_CALG_COH_SHAREABLE	5
> +#endif

Change this to:

#ifndef K_CALG_COH_SHAREABLE
#define K_CALG_COH_SHAREABLE	5
#endif

This would then be a separate patch from the LOONGSON3 sopecific things.

Then move your LOONGSON3 specific version to spaces.h


> +
>   #define K_CALG_NOTUSED		6
>   #define K_CALG_UNCACHED_ACCEL	7
>
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index d2035e1..7fffaf1 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -224,6 +224,7 @@
>   #define PRID_REV_LOONGSON1B	0x0020
>   #define PRID_REV_LOONGSON2E	0x0002
>   #define PRID_REV_LOONGSON2F	0x0003
> +#define PRID_REV_LOONGSON3A	0x0005
>
>   /*
>    * Older processors used to encode processor version and revision in two
> @@ -295,8 +296,8 @@ enum cpu_type_enum {
>   	 * MIPS64 class processors
>   	 */
>   	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
> -	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
> -	CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
> +	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
> +	CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
>
>   	CPU_LAST
>   };

These cpu.h things should probably go into a separate patch.

> diff --git a/arch/mips/include/asm/mach-loongson/spaces.h b/arch/mips/include/asm/mach-loongson/spaces.h
> new file mode 100644
> index 0000000..1e82804
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/spaces.h
> @@ -0,0 +1,15 @@
> +#ifndef __ASM_MACH_LOONGSON_SPACES_H_
> +#define __ASM_MACH_LOONGSON_SPACES_H_
> +
> +#ifndef CAC_BASE
> +#if defined(CONFIG_64BIT)
> +#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_CPU_LOONGSON3)
> +#define CAC_BASE        _AC(0x9800000000000000, UL)
> +#else
> +#define CAC_BASE        _AC(0xa800000000000000, UL)
> +#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_CPU_LOONGSON3 */
> +#endif /* CONFIG_64BIT */
> +#endif /* CONFIG_CAC_BASE */
> +
> +#include <asm/mach-generic/spaces.h>
> +#endif
> diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
> index 44b705d..c2edae3 100644
> --- a/arch/mips/include/asm/module.h
> +++ b/arch/mips/include/asm/module.h
> @@ -126,6 +126,8 @@ search_module_dbetables(unsigned long addr)
>   #define MODULE_PROC_FAMILY "LOONGSON1 "
>   #elif defined CONFIG_CPU_LOONGSON2
>   #define MODULE_PROC_FAMILY "LOONGSON2 "
> +#elif defined CONFIG_CPU_LOONGSON3
> +#define MODULE_PROC_FAMILY "LOONGSON3 "
>   #elif defined CONFIG_CPU_CAVIUM_OCTEON
>   #define MODULE_PROC_FAMILY "OCTEON "
>   #elif defined CONFIG_CPU_XLR
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index 32aea48..6c1e99e 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -235,6 +235,13 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>   #define _CACHE_CACHABLE_NONCOHERENT (5<<_CACHE_SHIFT)
>   #define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)
>
> +#elif defined(CONFIG_CPU_LOONGSON3)
> +
> +#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
> +#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
> +#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
> +#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
> +
>   #else
>
>   #define _CACHE_CACHABLE_NO_WA	    (0<<_CACHE_SHIFT)  /* R4600 only	  */
> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> index 29692e5..6205372 100644
> --- a/arch/mips/loongson/Platform
> +++ b/arch/mips/loongson/Platform
> @@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
>   cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
>   load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
>   load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
> +load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
>

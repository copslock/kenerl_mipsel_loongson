Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2014 10:10:40 +0200 (CEST)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60113 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815784AbaFIIKe6MdrN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2014 10:10:34 +0200
Received: by mail-ob0-f173.google.com with SMTP id wm4so5582850obc.32
        for <multiple recipients>; Mon, 09 Jun 2014 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=++l3OitMC97os3x8FvSjMqgcDVj4BV1V7jpQTXQIjjQ=;
        b=BSwBIEFodO8Rge0oTrzTqcd5Gnm+uHqyq8p3qL/LtI006sevGhB0nT7rZToRpk9L24
         VQkcmmzIw+kAoEYmnUCt/rKCzDmBwZ3eSci6QxXwf0Iq/B2WRih5rg/LJ41u7rRl2Olu
         2m4lL9w19mRH5sR5ElPoNW42UXbFNB5BpupdarcpMDb2ByGLFtLhCqBnDg+zYrxUnunp
         PSeMexUsddKztzMiCsn6DBfsd/VT5MZLZgIHtynHBfEr1klQZt9v+KrIG0ZYTV5L+NkB
         RDv1OxymqYUGnGX9rE/vzrB2CvZYMYLLKgMqF6vY6oRzFuW0eXnleV2YbcvwLHzapdvJ
         4KcA==
MIME-Version: 1.0
X-Received: by 10.182.19.196 with SMTP id h4mr23219645obe.20.1402301428208;
 Mon, 09 Jun 2014 01:10:28 -0700 (PDT)
Received: by 10.60.13.233 with HTTP; Mon, 9 Jun 2014 01:10:28 -0700 (PDT)
In-Reply-To: <1395398650-19292-2-git-send-email-chenhc@lemote.com>
References: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
        <1395398650-19292-2-git-send-email-chenhc@lemote.com>
Date:   Mon, 9 Jun 2014 16:10:28 +0800
Message-ID: <CAKcpw6XDiG1gcfAGXVyW2BXRYAzj=ysKCrtTy-uO0aF1Td6Vjw@mail.gmail.com>
Subject: Re: [PATCH V20 01/12] MIPS: Loongson: Add basic Loongson-3 definition
From:   Yunqiang Su <wzssyqa@gmail.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

On Fri, Mar 21, 2014 at 6:43 PM, Huacai Chen <chenhc@lemote.com> wrote:
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
> Tested-by: Alex Smith <alex.smith@imgtec.com>
> Reviewed-by: Alex Smith <alex.smith@imgtec.com>
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
>  #define K_CALG_UNCACHED                2
>  #define K_CALG_NONCOHERENT     3
>  #define K_CALG_COH_EXCL                4
> +#ifndef K_CALG_COH_SHAREABLE
>  #define K_CALG_COH_SHAREABLE   5
> +#endif
>  #define K_CALG_NOTUSED         6
>  #define K_CALG_UNCACHED_ACCEL  7
>
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 01d757c..530eb8b 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -231,6 +231,7 @@
>  #define PRID_REV_LOONGSON1B    0x0020
>  #define PRID_REV_LOONGSON2E    0x0002
>  #define PRID_REV_LOONGSON2F    0x0003
> +#define PRID_REV_LOONGSON3A    0x0005
>
>  /*
>   * Older processors used to encode processor version and revision in two
> @@ -304,8 +305,8 @@ enum cpu_type_enum {
>          * MIPS64 class processors
>          */
>         CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
> -       CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
> -       CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
> +       CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
> +       CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
>
>         CPU_LAST
>  };
> diff --git a/arch/mips/include/asm/mach-loongson/spaces.h b/arch/mips/include/asm/mach-loongson/spaces.h
> new file mode 100644
> index 0000000..883868b
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
> +#endif /* CAC_BASE */
> +
> +#define K_CALG_COH_SHAREABLE   3
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
>  #define _CACHE_CACHABLE_NO_WA      (0<<_CACHE_SHIFT)  /* R4600 only      */
> --
> 1.7.7.3
>
>

I tried new released rc7:

If don't install the non-free firmwares, this kernel cannot display
anything on monitor.
Is it possible to make it work without firmware installed, even it is
not performance
as good as firmware installed.


-- 
Yunqiang Su

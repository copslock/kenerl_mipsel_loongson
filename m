Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 06:23:59 +0200 (CEST)
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34419 "EHLO
        mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008182AbbGIEX46DQDn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 06:23:56 +0200
Received: by ykcp133 with SMTP id p133so39613861ykc.1;
        Wed, 08 Jul 2015 21:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=exwHeQ7an7I4YgZh14i9pRrHy4RhKi0sXtWlN/HmAKo=;
        b=aQRC+1vSuZyMr8Fro/N7k/z6/RNhg1YRFI/Dp0PCSUt5Dr7L9W3SEh71YEm6xugxnm
         r4WXEpUImy27RlogtywNtpnRmKC6rZlmgGGnYQ+51hM12wRjv32p42N4AZoqGWHrgH7F
         eFH5ahDwsoxkHzbAekdff1jlmnc9m/HnPr/T7Sjz/zTfPSY6mv4mEmHBH8skoWkgJ4+c
         Y5oA9omCDn5mvj+23GKFk1NcRk1dp3kbxe14xBhZ/hz9kl+KB7/GmrqBeQKWLSCdWU4N
         VXfqrWyvyVFNMuiOcEMW4dmmFGMAQ5zhQT6fzB4vFdYvpBwXQ1jMyPqslqTHKmEj8tU5
         Ypgg==
MIME-Version: 1.0
X-Received: by 10.170.82.131 with SMTP id y125mr15340200yky.115.1436415830994;
 Wed, 08 Jul 2015 21:23:50 -0700 (PDT)
Received: by 10.37.215.15 with HTTP; Wed, 8 Jul 2015 21:23:50 -0700 (PDT)
In-Reply-To: <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com>
References: <1424996199-21366-1-git-send-email-Steven.Hill@imgtec.com>
        <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com>
Date:   Thu, 9 Jul 2015 12:23:50 +0800
Message-ID: <CAAhV-H4B226tYvWHdTSuFaKqcgC4EOkA5PK9cwzoYnuenyEDQw@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] MIPS: Rearrange PTE bits into fixed positions.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Steven,

After this patch applied, Loongson-3 is broken....
Reason 1: old Loongson-3 doesn't support RI/XI, but newer Loongson-3
support RI/XI.
Reason 2: Loongson-3 is not fully MIPSR2 compatible (so we can't
enable CONFIG_MIPSR2).

Before this patch, RI/XI is dectected at runtime, so we can make a
single kernel to run on both old and new Loongson-3. After this patch,
because we can't enable CONFIG_MIPSR2, the pagetable bits of
Loongson-3 is the same as non-RI/XI CPU. However, new Loongson-3 will
detect RI/XI via CP0.CONF3 and cpu_has_rixi will be true. This totally
break Loongson.

So, what is the best way to solve this problem? At present I must
disable RI/XI to make kernel works.

Huacai

On Fri, Feb 27, 2015 at 8:16 AM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>
> This patch rearranges the PTE bits into fixed positions for R2
> and later cores. In the past, the TLB handling code did runtime
> checking of RI/XI and adjusted the shifts and rotates in order
> to fit the largest PFN value into the PTE. The checking now
> occurs when building the TLB handler, thus eliminating those
> checks. These new arrangements also define the largest possible
> PFN value that can fit in the PTE. HUGE page support is only
> available for 64-bit cores. Layouts of the PTE bits are now:
>
>    64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
>    32-bit, R1 or earler:      CCC D V G M A W R P
>    64-bit, R2 or later:       CCC D V G RI/R XI [S H] M A W P
>    32-bit, R2 or later:       CCC D V G RI/R XI M A W P
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>  arch/mips/include/asm/pgtable-bits.h |   87 ++++++++++++++++++++++------------
>  arch/mips/include/asm/pgtable.h      |   38 +++++++--------
>  arch/mips/mm/tlbex.c                 |    6 +--
>  3 files changed, 79 insertions(+), 52 deletions(-)
>
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index 91747c2..f8915b5 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -37,7 +37,7 @@
>  /*
>   * The following bits are implemented by the TLB hardware
>   */
> -#define _PAGE_GLOBAL_SHIFT     0
> +#define _PAGE_GLOBAL_SHIFT     (0)
>  #define _PAGE_GLOBAL           (1 << _PAGE_GLOBAL_SHIFT)
>  #define _PAGE_VALID_SHIFT      (_PAGE_GLOBAL_SHIFT + 1)
>  #define _PAGE_VALID            (1 << _PAGE_VALID_SHIFT)
> @@ -95,50 +95,67 @@
>
>  #else
>  /*
> - * When using the RI/XI bit support, we have 13 bits of flags below
> - * the physical address. The RI/XI bits are placed such that a SRL 5
> - * can strip off the software bits, then a ROTR 2 can move the RI/XI
> - * into bits [63:62]. This also limits physical address to 56 bits,
> - * which is more than we need right now.
> + * Below are the "Normal" R4K cases
>   */
>
>  /*
>   * The following bits are implemented in software
>   */
> -#define _PAGE_PRESENT_SHIFT    0
> +#define _PAGE_PRESENT_SHIFT    (0)
>  #define _PAGE_PRESENT          (1 << _PAGE_PRESENT_SHIFT)
> -#define _PAGE_READ_SHIFT       (cpu_has_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
> -#define _PAGE_READ ({BUG_ON(cpu_has_rixi); 1 << _PAGE_READ_SHIFT; })
> +/* R2 or later cores check for RI/XI support to determine _PAGE_READ */
> +#ifdef CONFIG_CPU_MIPSR2
> +#define _PAGE_WRITE_SHIFT      (_PAGE_PRESENT_SHIFT + 1)
> +#define _PAGE_WRITE            (1 << _PAGE_WRITE_SHIFT)
> +#else
> +#define _PAGE_READ_SHIFT       (_PAGE_PRESENT_SHIFT + 1)
> +#define _PAGE_READ             (1 << _PAGE_READ_SHIFT)
>  #define _PAGE_WRITE_SHIFT      (_PAGE_READ_SHIFT + 1)
>  #define _PAGE_WRITE            (1 << _PAGE_WRITE_SHIFT)
> +#endif
>  #define _PAGE_ACCESSED_SHIFT   (_PAGE_WRITE_SHIFT + 1)
>  #define _PAGE_ACCESSED         (1 << _PAGE_ACCESSED_SHIFT)
>  #define _PAGE_MODIFIED_SHIFT   (_PAGE_ACCESSED_SHIFT + 1)
>  #define _PAGE_MODIFIED         (1 << _PAGE_MODIFIED_SHIFT)
>
> -#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> -/* huge tlb page */
> +#if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
> +/* Huge TLB page */
>  #define _PAGE_HUGE_SHIFT       (_PAGE_MODIFIED_SHIFT + 1)
>  #define _PAGE_HUGE             (1 << _PAGE_HUGE_SHIFT)
>  #define _PAGE_SPLITTING_SHIFT  (_PAGE_HUGE_SHIFT + 1)
>  #define _PAGE_SPLITTING                (1 << _PAGE_SPLITTING_SHIFT)
> +
> +/* Only R2 or newer cores have the XI bit */
> +#ifdef CONFIG_CPU_MIPSR2
> +#define _PAGE_NO_EXEC_SHIFT    (_PAGE_SPLITTING_SHIFT + 1)
>  #else
> -#define _PAGE_HUGE_SHIFT       (_PAGE_MODIFIED_SHIFT)
> -#define _PAGE_HUGE             ({BUG(); 1; })  /* Dummy value */
> -#define _PAGE_SPLITTING_SHIFT  (_PAGE_HUGE_SHIFT)
> -#define _PAGE_SPLITTING                ({BUG(); 1; })  /* Dummy value */
> -#endif
> +#define _PAGE_GLOBAL_SHIFT     (_PAGE_SPLITTING_SHIFT + 1)
> +#define _PAGE_GLOBAL           (1 << _PAGE_GLOBAL_SHIFT)
> +#endif /* CONFIG_CPU_MIPSR2 */
>
> -/* Page cannot be executed */
> -#define _PAGE_NO_EXEC_SHIFT    (cpu_has_rixi ? _PAGE_SPLITTING_SHIFT + 1 : _PAGE_SPLITTING_SHIFT)
> -#define _PAGE_NO_EXEC          ({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_EXEC_SHIFT; })
> +#endif /* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
> +
> +#ifdef CONFIG_CPU_MIPSR2
> +/* XI - page cannot be executed */
> +#ifndef _PAGE_NO_EXEC_SHIFT
> +#define _PAGE_NO_EXEC_SHIFT    (_PAGE_MODIFIED_SHIFT + 1)
> +#endif
> +#define _PAGE_NO_EXEC          (cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
>
> -/* Page cannot be read */
> -#define _PAGE_NO_READ_SHIFT    (cpu_has_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
> -#define _PAGE_NO_READ          ({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_READ_SHIFT; })
> +/* RI - page cannot be read */
> +#define _PAGE_READ_SHIFT       (_PAGE_NO_EXEC_SHIFT + 1)
> +#define _PAGE_READ             (cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
> +#define _PAGE_NO_READ_SHIFT    _PAGE_READ_SHIFT
> +#define _PAGE_NO_READ          (cpu_has_rixi ? (1 << _PAGE_READ_SHIFT) : 0)
>
>  #define _PAGE_GLOBAL_SHIFT     (_PAGE_NO_READ_SHIFT + 1)
>  #define _PAGE_GLOBAL           (1 << _PAGE_GLOBAL_SHIFT)
> +
> +#else  /* !CONFIG_CPU_MIPSR2 */
> +#define _PAGE_GLOBAL_SHIFT     (_PAGE_MODIFIED_SHIFT + 1)
> +#define _PAGE_GLOBAL           (1 << _PAGE_GLOBAL_SHIFT)
> +#endif /* CONFIG_CPU_MIPSR2 */
> +
>  #define _PAGE_VALID_SHIFT      (_PAGE_GLOBAL_SHIFT + 1)
>  #define _PAGE_VALID            (1 << _PAGE_VALID_SHIFT)
>  #define _PAGE_DIRTY_SHIFT      (_PAGE_VALID_SHIFT + 1)
> @@ -150,18 +167,26 @@
>
>  #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
>
> +#ifndef _PAGE_NO_EXEC
> +#define _PAGE_NO_EXEC          (0)
> +#endif
> +#ifndef _PAGE_NO_READ
> +#define _PAGE_NO_READ          (0)
> +#endif
> +
>  #define _PAGE_SILENT_READ      _PAGE_VALID
>  #define _PAGE_SILENT_WRITE     _PAGE_DIRTY
>
>  #define _PFN_MASK              (~((1 << (_PFN_SHIFT)) - 1))
>
> -#ifndef _PAGE_NO_READ
> -#define _PAGE_NO_READ ({BUG(); 0; })
> -#define _PAGE_NO_READ_SHIFT ({BUG(); 0; })
> -#endif
> -#ifndef _PAGE_NO_EXEC
> -#define _PAGE_NO_EXEC ({BUG(); 0; })
> -#endif
> +/*
> + * The final layouts of the PTE bits are:
> + *
> + *   64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
> + *   32-bit, R1 or earler:      CCC D V G M A W R P
> + *   64-bit, R2 or later:       CCC D V G RI/R XI [S H] M A W P
> + *   32-bit, R2 or later:       CCC D V G RI/R XI M A W P
> + */
>
>
>  #ifndef __ASSEMBLY__
> @@ -171,6 +196,7 @@
>   */
>  static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>  {
> +#ifdef CONFIG_CPU_MIPSR2
>         if (cpu_has_rixi) {
>                 int sa;
>  #ifdef CONFIG_32BIT
> @@ -186,6 +212,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>                 return (pte_val >> _PAGE_GLOBAL_SHIFT) |
>                         ((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
>         }
> +#endif
>
>         return pte_val >> _PAGE_GLOBAL_SHIFT;
>  }
> @@ -245,7 +272,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>  #define _CACHE_UNCACHED_ACCELERATED    (7<<_CACHE_SHIFT)
>  #endif
>
> -#define __READABLE     (_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_rixi ? 0 : _PAGE_READ))
> +#define __READABLE     (_PAGE_SILENT_READ | _PAGE_READ | _PAGE_ACCESSED)
>  #define __WRITEABLE    (_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
>
>  #define _PAGE_CHG_MASK (_PAGE_ACCESSED | _PAGE_MODIFIED |      \
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index bef782c..e1fec02 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -24,17 +24,17 @@ struct mm_struct;
>  struct vm_area_struct;
>
>  #define PAGE_NONE      __pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
> -#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | (cpu_has_rixi ? 0 : _PAGE_READ) | \
> +#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | \
>                                  _page_cachable_default)
> -#define PAGE_COPY      __pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | \
> -                                (cpu_has_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
> -#define PAGE_READONLY  __pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | \
> +#define PAGE_COPY      __pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_NO_EXEC | \
> +                                _page_cachable_default)
> +#define PAGE_READONLY  __pgprot(_PAGE_PRESENT | _PAGE_READ | \
>                                  _page_cachable_default)
>  #define PAGE_KERNEL    __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
>                                  _PAGE_GLOBAL | _page_cachable_default)
>  #define PAGE_KERNEL_NC __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
>                                  _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
> -#define PAGE_USERIO    __pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
> +#define PAGE_USERIO    __pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
>                                  _page_cachable_default)
>  #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
>                         __WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
> @@ -332,13 +332,13 @@ static inline pte_t pte_mkdirty(pte_t pte)
>  static inline pte_t pte_mkyoung(pte_t pte)
>  {
>         pte_val(pte) |= _PAGE_ACCESSED;
> -       if (cpu_has_rixi) {
> -               if (!(pte_val(pte) & _PAGE_NO_READ))
> -                       pte_val(pte) |= _PAGE_SILENT_READ;
> -       } else {
> -               if (pte_val(pte) & _PAGE_READ)
> -                       pte_val(pte) |= _PAGE_SILENT_READ;
> -       }
> +#ifdef CONFIG_CPU_MIPSR2
> +       if (!(pte_val(pte) & _PAGE_NO_READ))
> +               pte_val(pte) |= _PAGE_SILENT_READ;
> +       else
> +#endif
> +       if (pte_val(pte) & _PAGE_READ)
> +               pte_val(pte) |= _PAGE_SILENT_READ;
>         return pte;
>  }
>
> @@ -534,13 +534,13 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
>  {
>         pmd_val(pmd) |= _PAGE_ACCESSED;
>
> -       if (cpu_has_rixi) {
> -               if (!(pmd_val(pmd) & _PAGE_NO_READ))
> -                       pmd_val(pmd) |= _PAGE_SILENT_READ;
> -       } else {
> -               if (pmd_val(pmd) & _PAGE_READ)
> -                       pmd_val(pmd) |= _PAGE_SILENT_READ;
> -       }
> +#ifdef CONFIG_CPU_MIPSR2
> +       if (!(pmd_val(pmd) & _PAGE_NO_READ))
> +               pmd_val(pmd) |= _PAGE_SILENT_READ;
> +       else
> +#endif
> +       if (pmd_val(pmd) & _PAGE_READ)
> +               pmd_val(pmd) |= _PAGE_SILENT_READ;
>
>         return pmd;
>  }
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index d75ff73..137d790 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -231,12 +231,12 @@ static void output_pgtable_bits_defines(void)
>         pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
>         pr_define("_PAGE_SPLITTING_SHIFT %d\n", _PAGE_SPLITTING_SHIFT);
>  #endif
> +#ifdef CONFIG_CPU_MIPSR2
>         if (cpu_has_rixi) {
> -#ifdef _PAGE_NO_EXEC_SHIFT
> +# ifdef _PAGE_NO_EXEC_SHIFT
>                 pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
> -#endif
> -#ifdef _PAGE_NO_READ_SHIFT
>                 pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
> +# endif
>  #endif
>         }
>         pr_define("_PAGE_GLOBAL_SHIFT %d\n", _PAGE_GLOBAL_SHIFT);
> --
> 1.7.10.4
>
>

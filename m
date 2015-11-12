Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 04:55:54 +0100 (CET)
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36651 "EHLO
        mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbbKLDzvy3FUU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2015 04:55:51 +0100
Received: by ykdr82 with SMTP id r82so82158826ykd.3;
        Wed, 11 Nov 2015 19:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oq13Ag1AW7wwoG1pRG6Nxuz2m73EOkqpAClwC8VNUUA=;
        b=QwhRv5izRuiSQdIVSx04+LDQleEBrBQBcsqMtpDttWLRRMI9Kk/CEHk4mfjvMZInmw
         diylcFjNyJwQTuW6j/OOyDQBO6ery+2lkf/ums1Xh9sOUw8kCrP2PvlGoApiEBEv6o6l
         pdp2ziTUIfojeOUwZZHyAOCugdR+4E0dBy1OQE9eQd5DLxrLIKu3Us6oCaODCocrCHjv
         uCZh7ozrdDS6nePKRjLHW+zAZkupuBQA1frSl+YY+npq8AuS3WXW0DaZYM8EhTiriJn+
         RF5XGlrGo0xYjpiQR40/Fl7GlH+h9yMzhbnkCPhDTwQGSLZucNmF93p4TeAsPYeKR26+
         0nQQ==
MIME-Version: 1.0
X-Received: by 10.129.91.214 with SMTP id p205mr13998323ywb.308.1447300546183;
 Wed, 11 Nov 2015 19:55:46 -0800 (PST)
Received: by 10.37.68.212 with HTTP; Wed, 11 Nov 2015 19:55:46 -0800 (PST)
In-Reply-To: <1444198082-24128-4-git-send-email-chenhc@lemote.com>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
        <1444198082-24128-4-git-send-email-chenhc@lemote.com>
Date:   Thu, 12 Nov 2015 11:55:46 +0800
X-Google-Sender-Auth: OzTxwmP1Ts1ATPb9lopCysustb0
Message-ID: <CAAhV-H6XVKH6Jx1U0KGoZmVpkbboj1N04PzGeik1NRzhdqd+VQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

Can this patch be merged? or does it have problems to be fix?

Huacai

On Wed, Oct 7, 2015 at 2:08 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
> feature named cpu_has_coherent_cache and use it to modify MIPS's cache
> flushing functions.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> ---
>  arch/mips/Kconfig                                   |  3 +++
>  arch/mips/include/asm/cpu-features.h                |  3 +++
>  .../asm/mach-loongson64/cpu-feature-overrides.h     |  1 +
>  arch/mips/mm/c-r4k.c                                | 21 +++++++++++++++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 9322d26..3a8b7e5 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1769,6 +1769,7 @@ config CPU_BMIPS5000
>  config SYS_HAS_CPU_LOONGSON3
>         bool
>         select CPU_SUPPORTS_CPUFREQ
> +       select CPU_SUPPORTS_COHERENT_CACHE
>
>  config SYS_HAS_CPU_LOONGSON2E
>         bool
> @@ -1950,6 +1951,8 @@ config CPU_SUPPORTS_HUGEPAGES
>         bool
>  config CPU_SUPPORTS_UNCACHED_ACCELERATED
>         bool
> +config CPU_SUPPORTS_COHERENT_CACHE
> +       bool
>  config MIPS_PGD_C0_CONTEXT
>         bool
>         default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index d1e04c9..565940e 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -157,6 +157,9 @@
>  #ifndef cpu_has_pindexed_dcache
>  #define cpu_has_pindexed_dcache        (cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
>  #endif
> +#ifndef cpu_has_coherent_cache
> +#define cpu_has_coherent_cache 0
> +#endif
>  #ifndef cpu_has_local_ebase
>  #define cpu_has_local_ebase    1
>  #endif
> diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> index 98963c2..e0bef38 100644
> --- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> @@ -57,5 +57,6 @@
>  #define cpu_has_local_ebase    0
>
>  #define cpu_has_wsbh           IS_ENABLED(CONFIG_CPU_LOONGSON3)
> +#define cpu_has_coherent_cache IS_ENABLED(CONFIG_CPU_SUPPORTS_COHERENT_CACHE)
>
>  #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 5d3a25e..ed6e36e 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -428,6 +428,9 @@ static void r4k_blast_scache_setup(void)
>
>  static inline void local_r4k___flush_cache_all(void * args)
>  {
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         switch (current_cpu_type()) {
>         case CPU_LOONGSON2:
>         case CPU_LOONGSON3:
> @@ -456,6 +459,9 @@ static inline void local_r4k___flush_cache_all(void * args)
>
>  static void r4k___flush_cache_all(void)
>  {
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
>  }
>
> @@ -502,6 +508,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
>  {
>         int exec = vma->vm_flags & VM_EXEC;
>
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
>                 r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
>  }
> @@ -625,6 +634,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>  {
>         struct flush_cache_page_args args;
>
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         args.vma = vma;
>         args.addr = addr;
>         args.pfn = pfn;
> @@ -634,11 +646,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>
>  static inline void local_r4k_flush_data_cache_page(void * addr)
>  {
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         r4k_blast_dcache_page((unsigned long) addr);
>  }
>
>  static void r4k_flush_data_cache_page(unsigned long addr)
>  {
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         if (in_atomic())
>                 local_r4k_flush_data_cache_page((void *)addr);
>         else
> @@ -823,6 +841,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>
>  static void r4k_flush_cache_sigtramp(unsigned long addr)
>  {
> +       if (cpu_has_coherent_cache)
> +               return;
> +
>         r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
>  }
>
> --
> 2.4.6
>
>
>
>
>

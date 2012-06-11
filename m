Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2012 06:16:28 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:37175 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901334Ab2FKEQW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jun 2012 06:16:22 +0200
Received: by ghbf11 with SMTP id f11so2459116ghb.36
        for <multiple recipients>; Sun, 10 Jun 2012 21:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l3fK+rcW3MGkW1zOH2gQoy74NlStA5xZynYVGjrayOc=;
        b=mbTwcPTdXYIl6omKRnvKQTpKJHeivw+nq6ff8EvdJSCeZPR6tv/SG93d7rlYHWJbzz
         4cV5sxrUF6TzwmnE12UtltzE6jG8qK9iYNmmv7A0/8L14TW2EApkku/FUORXlC4b83QY
         plEB5KsuGmbiL97PQayfb+7Hg8ernIot7q1YOCcAPs81fTcSzuogMPYkM+9EPW1NHjNy
         4njYZdB2c7GLhV5CP+aK51ZZj0hsBSF+5+w3yahqgkHEM61FncJ6qFjO50zIC910QzDx
         1YTHx9QuAxZs+639NS4AlP/MsNs1It+OaGdQ1NyzkRLDwK0bRejh+2O8ia3sMjYp3Ykw
         2AfA==
MIME-Version: 1.0
Received: by 10.50.36.227 with SMTP id t3mr5719282igj.13.1339388175438; Sun,
 10 Jun 2012 21:16:15 -0700 (PDT)
Received: by 10.231.219.5 with HTTP; Sun, 10 Jun 2012 21:16:15 -0700 (PDT)
In-Reply-To: <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
        <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>
Date:   Sun, 10 Jun 2012 22:16:15 -0600
Message-ID: <CACoURw4+N8Nk-N81kryXHOg9O_=ntvqv9prOLAZW6KKEYQ9v+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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

I've run into a problem in linux-3.5-rc1, and I've tracked it down
to this patch, MIPS: Move cache setup to setup_arch().,
commit 6650df3c380e0db558dbfec63ed860402c6afb2a.

On Mon, May 14, 2012 at 6:04 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa (jump-label: initialize
> jump-label subsystem much earlier) breaks MIPS.  The jump_label_init()
> call was moved before trap_init() which is where we initialize
> flush_icache_range().
>
> In order to be good citizens, we move cache initialization earlier so
> that we don't jump through a null flush_icache_range function pointer
> when doing the jump label initialization.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/include/asm/setup.h |    3 ++-
>  arch/mips/kernel/setup.c      |    2 ++
>  arch/mips/kernel/smp.c        |    2 +-
>  arch/mips/kernel/traps.c      |    9 +++++----
>  4 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
> index 6dce6d8..2560b6b 100644
> --- a/arch/mips/include/asm/setup.h
> +++ b/arch/mips/include/asm/setup.h
> @@ -14,7 +14,8 @@ extern void *set_vi_handler(int n, vi_handler_t addr);
>
>  extern void *set_except_vector(int n, void *addr);
>  extern unsigned long ebase;
> -extern void per_cpu_trap_init(void);
> +extern void per_cpu_trap_init(bool);
> +extern void cpu_cache_init(void);
>
>  #endif /* __KERNEL__ */
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index c504b21..a53f8ec 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -605,6 +605,8 @@ void __init setup_arch(char **cmdline_p)
>
>        resource_init();
>        plat_smp_setup();
> +
> +       cpu_cache_init();
>  }
>
>  unsigned long kernelsp[NR_CPUS];
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index ba9376b..dc019a1 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -106,7 +106,7 @@ asmlinkage __cpuinit void start_secondary(void)
>  #endif /* CONFIG_MIPS_MT_SMTC */
>        cpu_probe();
>        cpu_report();
> -       per_cpu_trap_init();
> +       per_cpu_trap_init(false);
>        mips_clockevent_init();
>        mp_ops->init_secondary();
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 2b5675b..0ba66c0 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1538,7 +1538,6 @@ void *set_vi_handler(int n, vi_handler_t addr)
>        return set_vi_srs_handler(n, addr, 0);
>  }
>
> -extern void cpu_cache_init(void);
>  extern void tlb_init(void);
>  extern void flush_tlb_handlers(void);
>
> @@ -1565,7 +1564,7 @@ static int __init ulri_disable(char *s)
>  }
>  __setup("noulri", ulri_disable);
>
> -void __cpuinit per_cpu_trap_init(void)
> +void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
>  {
>        unsigned int cpu = smp_processor_id();
>        unsigned int status_set = ST0_CU0;
> @@ -1664,7 +1663,9 @@ void __cpuinit per_cpu_trap_init(void)
>  #ifdef CONFIG_MIPS_MT_SMTC
>        if (bootTC) {
>  #endif /* CONFIG_MIPS_MT_SMTC */
> -               cpu_cache_init();
> +               /* Boot CPU's cache setup in setup_arch(). */
> +               if (!is_boot_cpu)
> +                       cpu_cache_init();
>                tlb_init();
>  #ifdef CONFIG_MIPS_MT_SMTC
>        } else if (!secondaryTC) {
> @@ -1741,7 +1742,7 @@ void __init trap_init(void)
>
>        if (board_ebase_setup)
>                board_ebase_setup();
> -       per_cpu_trap_init();
> +       per_cpu_trap_init(true);
>
>        /*
>         * Copy the generic exception handlers to their final destination.
> --
> 1.7.2.3

I'm running a single-CPU, PMC-Sierra RM7035C-based system.

Before applying this patch, cca_setup() in arch/mips/mm/c-r4k.c
is called before coherency_setup() (called from rk4_cache_init()).
After applying the patch, it is called afterwards.  Because
coherency_setup() relies on cca_setup() properly setting the
variable cca, it won't use the value of cca supplied on the
kernel command line.

I haven't verified it, but I suspect the same problem will occur
with the call to setcoherentio(), also in c-r4k.c.

Unfortunately, I don't have the knowledge to formulate a patch
to this problem, but I wanted to raise the issue.

Shane McDonald

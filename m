Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jan 2013 15:49:16 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:43182 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3AFOtOLzNMm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jan 2013 15:49:14 +0100
Received: by mail-la0-f51.google.com with SMTP id fj20so13274511lab.38
        for <multiple recipients>; Sun, 06 Jan 2013 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qtkM/7er6/jOUoSNAyiuydlapo7HxifrkeqNP6joOwE=;
        b=zN+2/23SVZpeihnp1eTtv89TYtEmewXnARDpDNrmf08+gqYBj2b99srtCn+Igw4sJi
         zHhJD2lR64E+jPaWkGJRIwLSVERSxMcUhq8/NjBnr3aBQXRSYw0b6yn36DPSq7A3SgRa
         ThJV9RG1w0Wa1oNvSize2ztuQycNvz3nALWLrzZn7QHdY7QfpiWVkE5IjNQXUxB5T6dZ
         wCmKLpOkYUb3LO0uLqnv7fpwCtHJYXVZgyJCLBVtIB4ACDno4cxgpU47MvyVenBd2bUe
         UtakdoG1qU/8Pjv+IuPO0y1XLcf1FVcGlsWFmTQ+KWtlK1DeURlLHnbT4tOJWjmF6zSD
         hJyQ==
MIME-Version: 1.0
Received: by 10.152.144.38 with SMTP id sj6mr54560419lab.48.1357483748258;
 Sun, 06 Jan 2013 06:49:08 -0800 (PST)
Received: by 10.112.114.37 with HTTP; Sun, 6 Jan 2013 06:49:07 -0800 (PST)
In-Reply-To: <1357249701-2386-1-git-send-email-sjhill@mips.com>
References: <1357249701-2386-1-git-send-email-sjhill@mips.com>
Date:   Sun, 6 Jan 2013 08:49:07 -0600
Message-ID: <CACoURw5XEo-7-LRBCfA5j-uquW=bSejMgFuf0zOZ3LPdrb-nag@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Add option to disable software I/O coherency.
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35381
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

Hi Steven:

On Thu, Jan 3, 2013 at 3:48 PM, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Some MIPS controllers have hardware I/O coherency. This patch
> detects those and turns off software coherency. A new kernel
> command line option also allows the user to manually turn
> software coherency on or off.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

I have tested this patch on my RM7035C-based system on l-m.o's
3.8-rc2 kernel.  My configuration files sets CONFIG_DMA_NONCOHERENT.
Using my standard kernel command line, the kernel hangs while booting.
I am able to get it to run normally by adding the new kernel parameter
"nocoherentio" to the command line.

I'm not that crazy that this patch requires me to change the way
I normally boot my machine, and I suspect everyone with a
CONFIG_DMA_NONCOHERENT configuration will have the same issue.
I don't think that's too difficult to fix, though; see my comments in-line.

Disclaimer: I'm far from an expert on the coherency issues, so take
my comments with a grain of salt.

> ---
>  arch/mips/include/asm/mach-generic/dma-coherence.h |    5 +-
>  arch/mips/mm/c-r4k.c                               |   37 +++++++---
>  arch/mips/mm/dma-default.c                         |    6 +-
>  arch/mips/mti-malta/malta-setup.c                  |   71 ++++++++++++++++++++
>  4 files changed, 108 insertions(+), 11 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
> index 9c95177..cd17f22 100644
> --- a/arch/mips/include/asm/mach-generic/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
> @@ -57,13 +57,16 @@ static inline int plat_dma_mapping_error(struct device *dev,
>         return 0;
>  }
>
> +extern int coherentio;
> +extern int hw_coherentio;
> +
>  static inline int plat_device_is_coherent(struct device *dev)
>  {
>  #ifdef CONFIG_DMA_COHERENT
>         return 1;
>  #endif
>  #ifdef CONFIG_DMA_NONCOHERENT
> -       return 0;
> +       return coherentio;
>  #endif
>  }

Just thinking out loud here: if CONFIG_DMA_COHERENT is defined,
we're always report the device as coherent;
if CONFIG_DMA_NONCOHERENT is defined, we can override it
with a command line parameter to report it's coherent.

Is this something we want to do?  If I understand correctly,
in c-r4k.c, when we have this situation, we report that "this will break".
Should we not just leave the old behaviour as-is?

>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 606e828..bdb0ea7 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1379,19 +1379,37 @@ static void __cpuinit coherency_setup(void)
>         }
>  }
>
> -#if defined(CONFIG_DMA_NONCOHERENT)
> -
> -static int __cpuinitdata coherentio;
> +int coherentio = -1;   /* no DMA cache coherency (may be set by user) */
> +int hw_coherentio = 0; /* no HW DMA cache coherency (reflects real HW) */

Thank you for the comments on those lines -- just those two little snippets
made the code so much easier for me to follow!

Would it make sense to only allow the "coherentio" parameter to be set
when CONFIG_DMA_NONCOHERENT is defined, and to only allow the
"nocoherentio" parameter to be set when it's CONFIG_DMA_NONCOHERENT
is not defined?

Also, and this is my biggest concern in this whole patch, by setting
coherentio to -1, you are requiring every platform to implement code to
change this setting, as you've done with the Malta in the
plat_setup_iocoherency() function.  Would it be better to set it to 0
if CONFIG_DMA_NONCOHERENT is defined and to 1 if it's not defined?
Platforms would still have the option of overriding this setting with their
own (now optional) plat_setup_iocoherency() call.  Otherwise, I believe this
patch breaks every CONFIG_DMA_NONCOHERENT platform.

I did test a modified patch on my platform where I set the initial value
of coherentio to 0 here, and it worked fine -- no command line parameter
changes required.

>
>  static int __init setcoherentio(char *str)
>  {
> -       coherentio = 1;
> +       if (coherentio < 0)
> +               pr_info("Command line checking done before"
> +                               " plat_setup_iocoherency!!\n");

Again, we're forcing every platform to add a plat_setup_iocoherency().

> +       if (coherentio == 0)
> +               pr_info("Command line enabling coherentio"
> +                               " (this will break...)!!\n");

If it will break (and my platform does), should we not just panic here?
Or even better, not allow coherentio to be specified in this case?
I'm probably wrong, though, because I believe the pre-patch code
allows this to be set.

>
> +       coherentio = 1;
> +       pr_info("Hardware DMA cache coherency (command line)\n");
>         return 0;
>  }
> -
>  early_param("coherentio", setcoherentio);
> -#endif
> +
> +static int __init setnocoherentio(char *str)
> +{
> +       if (coherentio < 0)
> +               pr_info("Command line checking done before"
> +                               " plat_setup_iocoherency!!\n");
> +       if (coherentio == 1)
> +               pr_info("Command line disabling coherentio\n");
> +
> +       coherentio = 0;
> +       pr_info("Software DMA cache coherency (command line)\n");
> +       return 0;
> +}
> +early_param("nocoherentio", setnocoherentio);

Same comments as for coherentio -- does it make sense to allow
this when CONFIG_DMA_NONCOHERENT is defined?  And, any platform
that doesn't define their own plat_setup_iocoherency() will get an info
message.

If you're adding a new kernel parameter, I'd really like to see it
documented in Documentation/kernel-parameters.txt.  I know that
there are lots of other ones that aren't documented, including
both coherentio and cca that are handled in this file, but we might
as well do the right thing.

The next few code changes are way beyond my level of knowledge,
so I would have no rationale comments -- if this is doing what you want,
I'm assuming it's good.  I didn't notice any averse behaviour on my
system.

>
>  static void __cpuinit r4k_cache_error_setup(void)
>  {
> @@ -1415,6 +1433,7 @@ void __cpuinit r4k_cache_init(void)
>  {
>         extern void build_clear_page(void);
>         extern void build_copy_page(void);
> +       extern int coherentio;
>         struct cpuinfo_mips *c = &current_cpu_data;
>
>         probe_pcache();
> @@ -1474,9 +1493,11 @@ void __cpuinit r4k_cache_init(void)
>
>         build_clear_page();
>         build_copy_page();
> -#if !defined(CONFIG_MIPS_CMP)
> +
> +       /* We want to run CMP kernels on core(s) with and without coherent caches */
> +       /* Therefore can't use CONFIG_MIPS_CMP to decide to flush cache */
>         local_r4k___flush_cache_all(NULL);
> -#endif
> +
>         coherency_setup();
>         board_cache_error_setup = r4k_cache_error_setup;
>  }
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 3fab204..aad5f7e 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -115,7 +115,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
>
>                 if (!plat_device_is_coherent(dev)) {
>                         dma_cache_wback_inv((unsigned long) ret, size);
> -                       ret = UNCAC_ADDR(ret);
> +                       if (!hw_coherentio)
> +                               ret = UNCAC_ADDR(ret);
>                 }
>         }
>
> @@ -143,7 +144,8 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
>         plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
>
>         if (!plat_device_is_coherent(dev))
> -               addr = CAC_ADDR(addr);
> +               if (!hw_coherentio)
> +                       addr = CAC_ADDR(addr);
>
>         free_pages(addr, get_order(size));
>  }
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index ed68073..4187102 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -31,6 +31,7 @@
>  #include <asm/mips-boards/maltaint.h>
>  #include <asm/dma.h>
>  #include <asm/traps.h>
> +#include <asm/gcmpregs.h>
>  #ifdef CONFIG_VT
>  #include <linux/console.h>
>  #endif
> @@ -104,6 +105,74 @@ static void __init fd_activate(void)
>  }
>  #endif
>
> +static int __init
> +plat_enable_iocoherency(void)

I found this function name confusing -- does this enable iocoherency, or is it
just checking to see if the HW supports iocoherency?  Perhaps a better name
might be something like "plat_is_iocoherency_supported", although I don't
like that name either.

> +{
> +       int supported = 0;
> +       if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
> +               if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
> +                       BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
> +                       pr_info("Enabled Bonito CPU coherency\n");
> +                       supported = 1;
> +               }
> +               if (strstr(fw_getcmdline(), "iobcuncached")) {
> +                       BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
> +                       BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
> +                               ~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
> +                                 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
> +                       pr_info("Disabled Bonito IOBC coherency\n");
> +               } else {
> +                       BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
> +                       BONITO_PCIMEMBASECFG |=
> +                               (BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
> +                                BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
> +                       pr_info("Enabled Bonito IOBC coherency\n");
> +               }
> +       } else if (gcmp_niocu() != 0) {
> +               /* Nothing special needs to be done to enable coherency */
> +               pr_info("CMP IOCU detected\n");
> +               if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {

Do you have any #define's for these?  I found the BONITO_* defines above
to be quite easy to follow; can the same be done for these numbers?

> +                       pr_crit("IOCU OPERATION DISABLED BY SWITCH"
> +                               " - DEFAULTING TO SW IO COHERENCY\n");
> +                       return 0;

Oh, an early return in a non-error case; I don't like that.  Can't you just
set supported to 0 in this case, and put the following "supported = 1;"
in an else, and let things fall through as normal?  But maybe that messes
up your value of hw_coherentio, although if I understand correctly, setting
that switch at bf403000 essentially turns off hw io concurrency support?

> +               }
> +               supported = 1;
> +       }
> +       hw_coherentio = supported;
> +       return supported;
> +}
> +
> +static void __init
> +plat_setup_iocoherency(void)
> +{
> +#ifdef CONFIG_DMA_NONCOHERENT
> +       /*
> +        * Kernel has been configured with software coherency
> +        * but we might choose to turn it off
> +        */
> +       if (plat_enable_iocoherency()) {

I'm a little confused -- does this situation ever come up?  You've got a kernel
configured that says hardware DMA cache coherency is not supported
(CONFIG_DMA_NONCOHERENT is defined), but the hardware does
support it, but then you're turning it off on the command line?
Would it not just be easier to configure the kernel differently?
Of course, if you're going to run the same kernel on both coherent
and non-coherent hardware, I guess you've got no choice.

> +               if (coherentio == 0)
> +                       pr_info("Hardware DMA cache coherency supported"
> +                                       " but disabled from command line\n");
> +               else {
> +                       coherentio = 1;
> +                       printk(KERN_INFO "Hardware DMA cache coherency\n");

pr_info?

> +               }
> +       } else {
> +               if (coherentio == 1)
> +                       pr_info("Hardware DMA cache coherency not supported"
> +                               " but enabled from command line\n");

If this is the case, would you want to panic() instead, like what you've done
later when the kernel is configured for hardware coherency support but
the platform doesn't support it?

> +               else {
> +                       coherentio = 0;
> +                       pr_info("Software DMA cache coherency\n");
> +               }
> +       }
> +#else
> +       if (!plat_enable_iocoherency())
> +               panic("Hardware DMA cache coherency not supported");
> +#endif

This is the panic I've mentioned a couple times in my previous comments.

> +}
> +
>  #ifdef CONFIG_BLK_DEV_IDE
>  static void __init pci_clock_check(void)
>  {
> @@ -205,6 +274,8 @@ void __init plat_mem_setup(void)
>         if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
>                 bonito_quirks_setup();
>
> +       plat_setup_iocoherency();
> +
>  #ifdef CONFIG_BLK_DEV_IDE
>         pci_clock_check();
>  #endif
> --
> 1.7.9.5
>

You know, I'd almost suggest splitting this into two patches.  The first
patch could deal with the kernel parameters, assuming that you update it
so that it doesn't break existing systems.  The second patch could then
add in the Malta code that does the plat_setup_iocoherency() and
related calls.

Shane

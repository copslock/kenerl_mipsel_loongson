Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 14:58:48 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:65522 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491064Ab1FOM6j convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 14:58:39 +0200
Received: by qyl38 with SMTP id 38so221142qyl.15
        for <multiple recipients>; Wed, 15 Jun 2011 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=BNcxTr6JjX6mozvNl/8pMjSTNrfNOwDSg6KhGFcd2xs=;
        b=IJ3k+aYZ8ZoX+Mv3ABha1IiuKx71gAAxbfOZpMJGJJM89+PNN+z4I7EmxbkhtJ7FHA
         TuMM9szdcTkZ95ij3GNngvkJJyoFh+VOVG1oZmI23xBFKuJGVyl5wbwIcpwM3YWve+ig
         t34yGq3aFLiMCk4eR2vZwvr7G3Qheuqh6AyhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h76TgZLOKRSewgrpGbgJHjQUOji+AYogwoncnQiyB4XVvlKG+y7Zn5FvgRCJP+KclN
         2arFlUmIBi7wF6ZvbIUNuEnGJHI19ZeC3NMbdAJ15fPbUtVIAQaITTe19Ox4tX5BGNue
         1aX106QykQT0TT5UHoi6Ueiet4LgacajS3t1c=
Received: by 10.229.66.25 with SMTP id l25mr356098qci.265.1308142713175; Wed,
 15 Jun 2011 05:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.212.206 with HTTP; Wed, 15 Jun 2011 05:58:13 -0700 (PDT)
In-Reply-To: <1307742441-28284-12-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr> <1307742441-28284-12-git-send-email-mbizon@freebox.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 15 Jun 2011 14:58:13 +0200
Message-ID: <BANLkTikXGiwp2UX0oCbKxzMUamg=ogfEqA@mail.gmail.com>
Subject: Re: [PATCH 11/11] MIPS: BCM63XX: add support for bcm6368 CPU.
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12325

On 10 June 2011 23:47, Maxime Bizon <mbizon@freebox.fr> wrote:
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  arch/mips/bcm63xx/Kconfig                         |    4 +
>  arch/mips/bcm63xx/clk.c                           |   70 +++++++++++++-
>  arch/mips/bcm63xx/cpu.c                           |   76 ++++++++++++---
>  arch/mips/bcm63xx/dev-uart.c                      |    2 +-
>  arch/mips/bcm63xx/irq.c                           |   16 +++
>  arch/mips/bcm63xx/prom.c                          |    7 +-
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |   99 +++++++++++++++++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    2 +
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  106 ++++++++++++++++++++-
>  arch/mips/include/asm/mach-bcm63xx/ioremap.h      |    4 +
>  arch/mips/pci/pci-bcm63xx.c                       |    4 +-
>  11 files changed, 364 insertions(+), 26 deletions(-)
>
> diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
> index fb177d6..6b1b9ad 100644
> --- a/arch/mips/bcm63xx/Kconfig
> +++ b/arch/mips/bcm63xx/Kconfig
> @@ -20,6 +20,10 @@ config BCM63XX_CPU_6348
>  config BCM63XX_CPU_6358
>        bool "support 6358 CPU"
>        select HW_HAS_PCI
> +
> +config BCM63XX_CPU_6368
> +       bool "support 6368 CPU"
> +       select HW_HAS_PCI
>  endmenu
>
>  source "arch/mips/bcm63xx/boards/Kconfig"
> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
> index 2c68ee9..9d57c71 100644
> --- a/arch/mips/bcm63xx/clk.c
> +++ b/arch/mips/bcm63xx/clk.c
> @@ -10,6 +10,7 @@
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <bcm63xx_cpu.h>
>  #include <bcm63xx_io.h>
>  #include <bcm63xx_regs.h>
> @@ -113,6 +114,34 @@ static struct clk clk_ephy = {
>  };
>
>  /*
> + * Ethernet switch clock
> + */
> +static void enetsw_set(struct clk *clk, int enable)
> +{
> +       if (!BCMCPU_IS_6368())
> +               return;
> +       bcm_hwclock_set(CKCTL_6368_ROBOSW_CLK_EN |
> +                       CKCTL_6368_SWPKT_USB_EN |
> +                       CKCTL_6368_SWPKT_SAR_EN, enable);
> +       if (enable) {
> +               u32 val;
> +
> +               /* reset switch core afer clock change */
> +               val = bcm_perf_readl(PERF_SOFTRESET_6368_REG);
> +               val &= ~SOFTRESET_6368_ENETSW_MASK;
> +               bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
> +               msleep(10);
> +               val |= SOFTRESET_6368_ENETSW_MASK;
> +               bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
> +               msleep(10);
> +       }
> +}
> +
> +static struct clk clk_enetsw = {
> +       .set    = enetsw_set,
> +};
> +
> +/*
>  * PCM clock
>  */
>  static void pcm_set(struct clk *clk, int enable)
> @@ -131,9 +160,10 @@ static struct clk clk_pcm = {
>  */
>  static void usbh_set(struct clk *clk, int enable)
>  {
> -       if (!BCMCPU_IS_6348())
> -               return;
> -       bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
> +       if (BCMCPU_IS_6348())
> +               bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
> +       else if (BCMCPU_IS_6368())
> +               bcm_hwclock_set(CKCTL_6368_USBH_CLK_EN, enable);
>  }
>
>  static struct clk clk_usbh = {
> @@ -162,6 +192,36 @@ static struct clk clk_spi = {
>  };
>
>  /*
> + * XTM clock
> + */
> +static void xtm_set(struct clk *clk, int enable)
> +{
> +       if (!BCMCPU_IS_6368())
> +               return;
> +
> +       bcm_hwclock_set(CKCTL_6368_SAR_CLK_EN |
> +                       CKCTL_6368_SWPKT_SAR_EN, enable);
> +
> +       if (enable) {
> +               u32 val;
> +
> +               /* reset sar core afer clock change */
> +               val = bcm_perf_readl(PERF_SOFTRESET_6368_REG);
> +               val &= ~SOFTRESET_6368_SAR_MASK;
> +               bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
> +               mdelay(1);
> +               val |= SOFTRESET_6368_SAR_MASK;
> +               bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
> +               mdelay(1);
> +       }
> +}
> +
> +
> +static struct clk clk_xtm = {
> +       .set    = xtm_set,
> +};
> +
> +/*
>  * Internal peripheral clock
>  */
>  static struct clk clk_periph = {
> @@ -204,12 +264,16 @@ struct clk *clk_get(struct device *dev, const char *id)
>                return &clk_enet0;
>        if (!strcmp(id, "enet1"))
>                return &clk_enet1;
> +       if (!strcmp(id, "enetsw"))
> +               return &clk_enetsw;
>        if (!strcmp(id, "ephy"))
>                return &clk_ephy;
>        if (!strcmp(id, "usbh"))
>                return &clk_usbh;
>        if (!strcmp(id, "spi"))
>                return &clk_spi;
> +       if (!strcmp(id, "xtm"))
> +               return &clk_xtm;
>        if (!strcmp(id, "periph"))
>                return &clk_periph;
>        if (BCMCPU_IS_6358() && !strcmp(id, "pcm"))
> diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> index 027ac30..3ea2533 100644
> --- a/arch/mips/bcm63xx/cpu.c
> +++ b/arch/mips/bcm63xx/cpu.c
> @@ -66,6 +66,15 @@ static const int bcm96358_irqs[] = {
>
>  };
>
> +static const unsigned long bcm96368_regs_base[] = {
> +       __GEN_CPU_REGS_TABLE(6368)
> +};
> +
> +static const int bcm96368_irqs[] = {
> +       __GEN_CPU_IRQ_TABLE(6368)
> +
> +};
> +
>  u16 __bcm63xx_get_cpu_id(void)
>  {
>        return bcm63xx_cpu_id;
> @@ -92,20 +101,19 @@ unsigned int bcm63xx_get_memory_size(void)
>
>  static unsigned int detect_cpu_clock(void)
>  {
> -       unsigned int tmp, n1 = 0, n2 = 0, m1 = 0;
> -
> -       /* BCM6338 has a fixed 240 Mhz frequency */
> -       if (BCMCPU_IS_6338())
> +       switch (bcm63xx_get_cpu_id()) {
> +       case BCM6338_CPU_ID:
> +               /* BCM6338 has a fixed 240 Mhz frequency */
>                return 240000000;
>
> -       /* BCM6345 has a fixed 140Mhz frequency */
> -       if (BCMCPU_IS_6345())
> +       case BCM6345_CPU_ID:
> +               /* BCM6345 has a fixed 140Mhz frequency */
>                return 140000000;
>
> -       /*
> -        * frequency depends on PLL configuration:
> -        */
> -       if (BCMCPU_IS_6348()) {
> +       case BCM6348_CPU_ID:
> +       {
> +               unsigned int tmp, n1, n2, m1;
> +
>                /* 16MHz * (N1 + 1) * (N2 + 2) / (M1_CPU + 1) */
>                tmp = bcm_perf_readl(PERF_MIPSPLLCTL_REG);
>                n1 = (tmp & MIPSPLLCTL_N1_MASK) >> MIPSPLLCTL_N1_SHIFT;
> @@ -114,17 +122,47 @@ static unsigned int detect_cpu_clock(void)
>                n1 += 1;
>                n2 += 2;
>                m1 += 1;
> +               return (16 * 1000000 * n1 * n2) / m1;
>        }
>
> -       if (BCMCPU_IS_6358()) {
> +       case BCM6358_CPU_ID:
> +       {
> +               unsigned int tmp, n1, n2, m1;
> +
>                /* 16MHz * N1 * N2 / M1_CPU */
>                tmp = bcm_ddr_readl(DDR_DMIPSPLLCFG_REG);
>                n1 = (tmp & DMIPSPLLCFG_N1_MASK) >> DMIPSPLLCFG_N1_SHIFT;
>                n2 = (tmp & DMIPSPLLCFG_N2_MASK) >> DMIPSPLLCFG_N2_SHIFT;
>                m1 = (tmp & DMIPSPLLCFG_M1_MASK) >> DMIPSPLLCFG_M1_SHIFT;
> +               return (16 * 1000000 * n1 * n2) / m1;
>        }
>
> -       return (16 * 1000000 * n1 * n2) / m1;
> +       case BCM6368_CPU_ID:
> +       {
> +               unsigned int tmp, p1, p2, ndiv, m1;
> +
> +               /* (64MHz / P1) * P2 * NDIV / M1_CPU */
> +               tmp = bcm_ddr_readl(DDR_DMIPSPLLCFG_6368_REG);
> +
> +               p1 = (tmp & DMIPSPLLCFG_6368_P1_MASK) >>
> +                       DMIPSPLLCFG_6368_P1_SHIFT;
> +
> +               p2 = (tmp & DMIPSPLLCFG_6368_P2_MASK) >>
> +                       DMIPSPLLCFG_6368_P2_SHIFT;
> +
> +               ndiv = (tmp & DMIPSPLLCFG_6368_NDIV_MASK) >>
> +                       DMIPSPLLCFG_6368_NDIV_SHIFT;
> +
> +               tmp = bcm_ddr_readl(DDR_DMIPSPLLDIV_6368_REG);
> +               m1 = (tmp & DMIPSPLLDIV_6368_MDIV_MASK) >>
> +                       DMIPSPLLDIV_6368_MDIV_SHIFT;
> +
> +               return (((64 * 1000000) / p1) * p2 * ndiv) / m1;
> +       }
> +
> +       default:
> +               BUG();
> +       }
>  }
>
>  /*
> @@ -146,7 +184,7 @@ static unsigned int detect_memory_size(void)
>                banks = (val & SDRAM_CFG_BANK_MASK) ? 2 : 1;
>        }
>
> -       if (BCMCPU_IS_6358()) {
> +       if (BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
>                val = bcm_memc_readl(MEMC_CFG_REG);
>                rows = (val & MEMC_CFG_ROW_MASK) >> MEMC_CFG_ROW_SHIFT;
>                cols = (val & MEMC_CFG_COL_MASK) >> MEMC_CFG_COL_SHIFT;
> @@ -191,9 +229,15 @@ void __init bcm63xx_cpu_init(void)
>                bcm63xx_irqs = bcm96345_irqs;
>                break;
>        case CPU_BMIPS4350:
> -               expected_cpu_id = BCM6358_CPU_ID;
> -               bcm63xx_regs_base = bcm96358_regs_base;
> -               bcm63xx_irqs = bcm96358_irqs;
> +               if ((read_c0_prid() & 0xf0) == 0x0030) {
> +                       expected_cpu_id = BCM6368_CPU_ID;
> +                       bcm63xx_regs_base = bcm96368_regs_base;
> +                       bcm63xx_irqs = bcm96368_irqs;
> +               } else {
> +                       expected_cpu_id = BCM6358_CPU_ID;
> +                       bcm63xx_regs_base = bcm96358_regs_base;
> +                       bcm63xx_irqs = bcm96358_irqs;
> +               }

You might want to change that to an explicitly check for the BCM6358 -
at least mine evaluates to 0x0010, while for my BCM6328 it does to
0x0070.

>                break;
>        }
>
> diff --git a/arch/mips/bcm63xx/dev-uart.c b/arch/mips/bcm63xx/dev-uart.c
> index c2963da..d6e42c6 100644
> --- a/arch/mips/bcm63xx/dev-uart.c
> +++ b/arch/mips/bcm63xx/dev-uart.c
> @@ -54,7 +54,7 @@ int __init bcm63xx_uart_register(unsigned int id)
>        if (id >= ARRAY_SIZE(bcm63xx_uart_devices))
>                return -ENODEV;
>
> -       if (id == 1 && !BCMCPU_IS_6358())
> +       if (id == 1 && (!BCMCPU_IS_6358() && !BCMCPU_IS_6368()))

No need for brackets around the CPU checks (but I didn't find anything
in the code style documentation about this).

>                return -ENODEV;
>
>        if (id == 0) {
> diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
> index f2d5e30..f111ccd 100644
> --- a/arch/mips/bcm63xx/irq.c
> +++ b/arch/mips/bcm63xx/irq.c
> @@ -59,6 +59,14 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
>  #define ext_irq_start          (BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE)
>  #define ext_irq_end            (BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE)
>  #endif
> +#ifdef CONFIG_BCM63XX_CPU_6368
> +#define irq_stat_reg           PERF_IRQSTAT_6368_REG
> +#define irq_mask_reg           PERF_IRQMASK_6368_REG
> +#define irq_bits               64
> +#define is_ext_irq_cascaded    1
> +#define ext_irq_start          (BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE)
> +#define ext_irq_end            (BCM_6368_EXT_IRQ3 - IRQ_INTERNAL_BASE)

This is different from ...

> +#endif
>
>  #if irq_bits == 32
>  #define dispatch_internal                      __dispatch_internal
> @@ -116,6 +124,14 @@ static void bcm63xx_init_irq(void)
>                ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
>                ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
>                break;
> +       case BCM6368_CPU_ID:
> +               irq_stat_addr += PERF_IRQSTAT_6368_REG;
> +               irq_mask_addr += PERF_IRQMASK_6368_REG;
> +               irq_bits = 64;
> +               is_ext_irq_cascaded = 1;
> +               ext_irq_start = BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE;
> +               ext_irq_end = BCM_6368_EXT_IRQ5 - IRQ_INTERNAL_BASE;

... this one - you should fix the non runtime detection case.

> +               break;
>        default:
>                BUG();
>        }

You are missing in bcm63xx_external_irq_mask,
bcm63xx_external_irq_unmask and bcm63xx_external_irq_clear special
handling for 6368's external IRQs. According to the Broadcom sources,
PERF_EXTIRQ_CFG_REG is at 0x18 for the 6368; for IRQ4 and IRQ5 it's at
0x1c.

> diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
> index be252ef..99d7f40 100644
> --- a/arch/mips/bcm63xx/prom.c
> +++ b/arch/mips/bcm63xx/prom.c
> @@ -32,9 +32,12 @@ void __init prom_init(void)
>                mask = CKCTL_6345_ALL_SAFE_EN;
>        else if (BCMCPU_IS_6348())
>                mask = CKCTL_6348_ALL_SAFE_EN;
> -       else
> -               /* BCMCPU_IS_6358() */
> +       else if (BCMCPU_IS_6358())
>                mask = CKCTL_6358_ALL_SAFE_EN;
> +       else if (BCMCPU_IS_6368())
> +               mask = CKCTL_6368_ALL_SAFE_EN;
> +       else
> +               mask = 0;
>
>        reg = bcm_perf_readl(PERF_CKCTL_REG);
>        reg &= ~mask;
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> index ce6b3ca..cf145ea 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> @@ -13,6 +13,7 @@
>  #define BCM6345_CPU_ID         0x6345
>  #define BCM6348_CPU_ID         0x6348
>  #define BCM6358_CPU_ID         0x6358
> +#define BCM6368_CPU_ID         0x6368
>
>  void __init bcm63xx_cpu_init(void);
>  u16 __bcm63xx_get_cpu_id(void);
> @@ -71,6 +72,19 @@ unsigned int bcm63xx_get_cpu_freq(void);
>  # define BCMCPU_IS_6358()      (0)
>  #endif
>
> +#ifdef CONFIG_BCM63XX_CPU_6368
> +# ifdef bcm63xx_get_cpu_id
> +#  undef bcm63xx_get_cpu_id
> +#  define bcm63xx_get_cpu_id() __bcm63xx_get_cpu_id()
> +#  define BCMCPU_RUNTIME_DETECT
> +# else
> +#  define bcm63xx_get_cpu_id() BCM6368_CPU_ID
> +# endif
> +# define BCMCPU_IS_6368()      (bcm63xx_get_cpu_id() == BCM6368_CPU_ID)
> +#else
> +# define BCMCPU_IS_6368()      (0)
> +#endif
> +
>  #ifndef bcm63xx_get_cpu_id
>  #error "No CPU support configured"
>  #endif
> @@ -309,6 +323,47 @@ enum bcm63xx_regs_set {
>  #define BCM_6358_PCMDMAS_BASE          (0xfffe1a00)
>
>
> +/*
> + * 6368 register sets base address
> + */
> +#define BCM_6368_DSL_LMEM_BASE         (0xdeadbeef)

0xb0f80000 ;-)

> +#define BCM_6368_PERF_BASE             (0xb0000000)
> +#define BCM_6368_TIMER_BASE            (0xb0000040)
> +#define BCM_6368_WDT_BASE              (0xb000005c)
> +#define BCM_6368_UART0_BASE            (0xb0000100)
> +#define BCM_6368_UART1_BASE            (0xb0000120)
> +#define BCM_6368_GPIO_BASE             (0xb0000080)
> +#define BCM_6368_SPI_BASE              (0xdeadbeef)
> +#define BCM_6368_SPI2_BASE             (0xb0000800)
> +#define BCM_6368_UDC0_BASE             (0xdeadbeef)
> +#define BCM_6368_OHCI0_BASE            (0xb0001600)
> +#define BCM_6368_OHCI_PRIV_BASE                (0xdeadbeef)
> +#define BCM_6368_USBH_PRIV_BASE                (0xb0001700)
> +#define BCM_6368_MPI_BASE              (0xb0001000)
> +#define BCM_6368_PCMCIA_BASE           (0xb0001054)
> +#define BCM_6368_SDRAM_REGS_BASE       (0xdeadbeef)
> +#define BCM_6368_M2M_BASE              (0xdeadbeef)
> +#define BCM_6368_DSL_BASE              (0xdeadbeef)

0xb0f56000


Jonas

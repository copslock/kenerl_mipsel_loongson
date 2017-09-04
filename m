Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Sep 2017 19:40:59 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:34819
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994888AbdIDRkfYrRaF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Sep 2017 19:40:35 +0200
Received: by mail-io0-x243.google.com with SMTP id n74so599341ioe.2;
        Mon, 04 Sep 2017 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kEz+PGvICendyK9BnQk1j69HDu2T/tDVW90Z4PJ92RU=;
        b=F3SrBSBIhcY2XIzveqnEASGFiYL4FtMnm/9Ddfta4t21w4CKwWorWY+t4f/zHeNVAu
         On0TIHNrML2w8dQuumb6tj1pWW9KrvgMxJ0AAfXiUOrmXEk13/5lG5hI3IFakHUu6trO
         Sh/7py0GXXN7Chm3YbpkG/hPHtQ0GlrrANtwvyK25bRqO2nyoWrXef5Y3gVIa+ByoPGi
         sXQFOonaWUDPQ+b6kdjWiDK3JY+4OdQ/QnOT3UZANubT8aRWo1gFX8lglm8bMV3gL7f1
         yJoWdI9GCE2EvsNKKKEwhuFcSl2IG6s0XPNB8X10DjQDaCwPjG7UbbTQslajUDhpArfj
         6fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kEz+PGvICendyK9BnQk1j69HDu2T/tDVW90Z4PJ92RU=;
        b=PErlq2iCRqu8q84IF2FLu/uTpS32JcGMucb2VB2MHh5AtKWhsfTXj7tkAh+qED8Jeu
         ajUrZ4oiEVhFVPN1GsBlkM8DYyuiGFplWL8r3mqbxxPBVWp6b3D/94m7L5IHIZUPpJL6
         20vS+stg9D6chh8T3wZkSYgJkqwSxUjpuXVUi1IWl5reHlqjBh6llcVIkVySYnd8Vu1N
         fkv45Dz4mTFjexitfcwdiD/GxEzZy60Cx3iAQrcPerc8Owv0wfJiF0Tz45sKmTduTKxI
         orjTY4O//q1v8R2QAkyUzfEocAfrzokvYoy0WZE4/y5RsJNe0+8xYa0v+10Iy1C+++dA
         +q/w==
X-Gm-Message-State: AHPjjUjwsa9N0NoGsjysvZoj+7UhwNGDPdNa1ORW60EbNiE+FDj/podi
        +SvT6ElN6smyDRrjUO02nq9Z7Mufxi8qq1o=
X-Google-Smtp-Source: ADKCNb5s6Y8y51KtJBL/N/lhx75NFQGDItBYdXVXwZYwx9+ZWy6Mm3CgaygedXJkB3USvkJJ8ofsFHZs5hmJ56j7ZHw=
X-Received: by 10.107.134.29 with SMTP id i29mr1621864iod.262.1504546828649;
 Mon, 04 Sep 2017 10:40:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.153.53 with HTTP; Mon, 4 Sep 2017 10:40:08 -0700 (PDT)
In-Reply-To: <20170819221823.13850-17-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de> <20170819221823.13850-17-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Sep 2017 19:40:08 +0200
Message-ID: <CAFBinCCHvvu02zYoA92qKb2_BVZ3NTPv3bOwxbGi_TDccgcRxw@mail.gmail.com>
Subject: Re: [PATCH v10 16/16] MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c
 implementation
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Sun, Aug 20, 2017 at 12:18 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> The RCU register are now access through separates drivers. remove the
> last pieces of the old implementation.
>
> The GPHY reset bits are now set by the GPHY driver which registers a
> reboot notifier. The reboot is triggered by a syscon-reboot driver and
> the MIPS specific parts are done by the generic MIPS implementation in
> arch/mips/kernel/reset.c.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/mips/lantiq/Kconfig       |   1 +
>  arch/mips/lantiq/xway/Makefile |   2 +-
>  arch/mips/lantiq/xway/reset.c  | 147 -----------------------------------------
>  3 files changed, 2 insertions(+), 148 deletions(-)
>  delete mode 100644 arch/mips/lantiq/xway/reset.c
>
> diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
> index f5db4a426568..35bc69b78268 100644
> --- a/arch/mips/lantiq/Kconfig
> +++ b/arch/mips/lantiq/Kconfig
> @@ -18,6 +18,7 @@ config SOC_XWAY
>         select SOC_TYPE_XWAY
>         select HW_HAS_PCI
>         select MFD_SYSCON
> +       select MFD_CORE
>
>  config SOC_FALCON
>         bool "FALCON"
> diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
> index 6daf3149e7ca..fbb0747c70b7 100644
> --- a/arch/mips/lantiq/xway/Makefile
> +++ b/arch/mips/lantiq/xway/Makefile
> @@ -1,3 +1,3 @@
> -obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o dcdc.o
> +obj-y := prom.o sysctrl.o clk.o dma.o gptu.o dcdc.o
>
>  obj-y += vmmc.o
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> deleted file mode 100644
> index 04cd9a7c04a3..000000000000
> --- a/arch/mips/lantiq/xway/reset.c
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -/*
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License version 2 as published
> - *  by the Free Software Foundation.
> - *
> - *  Copyright (C) 2010 John Crispin <john@phrozen.org>
> - *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
> - */
> -
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> -#include <linux/pm.h>
> -#include <linux/export.h>
> -#include <linux/delay.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
> -#include <linux/reset-controller.h>
> -
> -#include <asm/reboot.h>
> -
> -#include <lantiq_soc.h>
> -
> -#include "../prom.h"
> -
> -/* reset request register */
> -#define RCU_RST_REQ            0x0010
> -/* reset status register */
> -#define RCU_RST_STAT           0x0014
> -
> -/* xbar BE flag */
> -#define RCU_AHB_ENDIAN          0x004C
> -#define RCU_VR9_BE_AHB1S        0x00000008
> -
> -/* reboot bit */
> -#define RCU_RD_GPHY0_XRX200    BIT(31)
> -#define RCU_RD_SRST            BIT(30)
> -#define RCU_RD_GPHY1_XRX200    BIT(29)
> -
> -/* reset cause */
> -#define RCU_STAT_SHIFT         26
> -/* boot selection */
> -#define RCU_BOOT_SEL(x)                ((x >> 18) & 0x7)
> -#define RCU_BOOT_SEL_XRX200(x) (((x >> 17) & 0xf) | ((x >> 8) & 0x10))
> -
> -/* dwc2 USB configuration registers */
> -#define RCU_USB1CFG            0x0018
> -#define RCU_USB2CFG            0x0034
> -
> -/* USB DMA endianness bits */
> -#define RCU_USBCFG_HDSEL_BIT   BIT(11)
> -#define RCU_USBCFG_HOST_END_BIT        BIT(10)
> -#define RCU_USBCFG_SLV_END_BIT BIT(9)
> -
> -/* USB reset bits */
> -#define RCU_USBRESET           0x0010
> -
> -#define USBRESET_BIT           BIT(4)
> -
> -#define RCU_USBRESET2          0x0048
> -
> -#define USB1RESET_BIT          BIT(4)
> -#define USB2RESET_BIT          BIT(5)
> -
> -#define RCU_CFG1A              0x0038
> -#define RCU_CFG1B              0x003C
> -
> -/* USB PMU devices */
> -#define PMU_AHBM               BIT(15)
> -#define PMU_USB0               BIT(6)
> -#define PMU_USB1               BIT(27)
> -
> -/* USB PHY PMU devices */
> -#define PMU_USB0_P             BIT(0)
> -#define PMU_USB1_P             BIT(26)
> -
> -/* remapped base addr of the reset control unit */
> -static void __iomem *ltq_rcu_membase;
> -static struct device_node *ltq_rcu_np;
> -
> -static void ltq_rcu_w32(uint32_t val, uint32_t reg_off)
> -{
> -       ltq_w32(val, ltq_rcu_membase + reg_off);
> -}
> -
> -static uint32_t ltq_rcu_r32(uint32_t reg_off)
> -{
> -       return ltq_r32(ltq_rcu_membase + reg_off);
> -}
> -
> -static void ltq_machine_restart(char *command)
> -{
> -       u32 val = ltq_rcu_r32(RCU_RST_REQ);
> -
> -       if (of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200"))
> -               val |= RCU_RD_GPHY1_XRX200 | RCU_RD_GPHY0_XRX200;
> -
> -       val |= RCU_RD_SRST;
> -
> -       local_irq_disable();
> -       ltq_rcu_w32(val, RCU_RST_REQ);
> -       unreachable();
> -}
> -
> -static void ltq_machine_halt(void)
> -{
> -       local_irq_disable();
> -       unreachable();
> -}
> -
> -static void ltq_machine_power_off(void)
> -{
> -       local_irq_disable();
> -       unreachable();
> -}
> -
> -static int __init mips_reboot_setup(void)
> -{
> -       struct resource res;
> -
> -       ltq_rcu_np = of_find_compatible_node(NULL, NULL, "lantiq,rcu-xway");
> -       if (!ltq_rcu_np)
> -               ltq_rcu_np = of_find_compatible_node(NULL, NULL,
> -                                                       "lantiq,rcu-xrx200");
> -
> -       /* check if all the reset register range is available */
> -       if (!ltq_rcu_np)
> -               panic("Failed to load reset resources from devicetree");
> -
> -       if (of_address_to_resource(ltq_rcu_np, 0, &res))
> -               panic("Failed to get rcu memory range");
> -
> -       if (!request_mem_region(res.start, resource_size(&res), res.name))
> -               pr_err("Failed to request rcu memory");
> -
> -       ltq_rcu_membase = ioremap_nocache(res.start, resource_size(&res));
> -       if (!ltq_rcu_membase)
> -               panic("Failed to remap core memory");
> -
> -       _machine_restart = ltq_machine_restart;
> -       _machine_halt = ltq_machine_halt;
> -       pm_power_off = ltq_machine_power_off;
> -
> -       return 0;
> -}
> -
> -arch_initcall(mips_reboot_setup);
> --
> 2.11.0
>

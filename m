Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2017 23:29:24 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:33447
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdDQV3QUkATy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2017 23:29:16 +0200
Received: by mail-wr0-x244.google.com with SMTP id l28so22104507wre.0;
        Mon, 17 Apr 2017 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ABehy2fzvzidXNa+ldeJEFAAJE+RZauXHW4txbmSYz4=;
        b=X1Bj03iNYTLm9O+DxiTFukLNopMb9XCHFGdy/z0KcTih5Qxsfi9RTZsqW9hzd8JUna
         gG7+oL0aVzpqERNBpZMJa1neOLrt+FfOFgbNJVnKLjiKgr5wEqBOaQZgnikDGyXQPnkx
         LpHMeBx1ixVt/cRgcH/tTQ4JfEq8L6JWkNKmg3maxPnaksmL7GVlBDnfh7lByU6bHwAX
         KzPG9/iDjjQIAb3TAe93jTtESF5hYVVODqiDWCCd7YE12g3DCszoTPFCzFDBSqsyXZ4K
         huwlFfm9h8UBAcs38wa0l88rfq9RdvZNSKwJ9tcEWCnPJOxF6y1DHnCixJPRcXINB5jX
         EvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ABehy2fzvzidXNa+ldeJEFAAJE+RZauXHW4txbmSYz4=;
        b=KQEw3yvZOGrtOb5VnOSlxskEFPfi5E2uIIJ8ZtcqxqtwU3uFDGwrJyC/KmCJ4lm1hs
         lAd1m8YMDuwbgQgA7/nPf9um9SUBrsLgQFy6DOjvsQNhP5gHRNpcDMxSkEBeCteCTSl4
         c79xW2sHoH2Le1wICxAjA9tRZ4u2V8yHtr0JdAlWN5BOcCDJNfAFMDXdTuF2wa8+ywpN
         3Uaf54nVhHgq5TsYruaeeS3UztbRuYPsXOD4gJMcjPTGXqZPKL/6Gx3aIH9CBCW+nXfm
         xii2v1uhE6eafrHhFJOOrmW7qZFVmhS1Eu3PbBjfooIa7Gilyh2QxKMZ7QBtiwMQ5bHg
         23Ng==
X-Gm-Message-State: AN3rC/6t2Dook39M0Xg2hs5EKamzNB0LuQerGWam3J6QrAYNvrav6VPf
        oJ0BS858UquL5L0MvMMSruZesfIASg==
X-Received: by 10.223.173.143 with SMTP id w15mr19893067wrc.125.1492464551020;
 Mon, 17 Apr 2017 14:29:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.166.80 with HTTP; Mon, 17 Apr 2017 14:28:50 -0700 (PDT)
In-Reply-To: <20170417192942.32219-14-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-14-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 17 Apr 2017 23:28:50 +0200
Message-ID: <CAFBinCDwbrBBov6UV00O2tBwMTimTW=LY+n1AD92Yz-ugthavA@mail.gmail.com>
Subject: Re: [PATCH 13/13] MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c
 implementation
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57724
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

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> The RCU register are now access through separates drivers. remove the
> last peaces of the old implementation.
s/peaces/pieces/

you should probably mention that arch/mips/kernel/reset.c handles the
ltq_machine_halt and ltq_machine_power_off code, while
ltq_machine_restart (setting some reset bits) can be replaced with
"syscon-reboot"

apart from that: great to see that this gets some love! :)

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/lantiq/Kconfig       |   1 +
>  arch/mips/lantiq/xway/Makefile |   2 +-
>  arch/mips/lantiq/xway/reset.c  | 157 -----------------------------------------
>  3 files changed, 2 insertions(+), 158 deletions(-)
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
> index 5aec1f54275b..000000000000
> --- a/arch/mips/lantiq/xway/reset.c
> +++ /dev/null
> @@ -1,157 +0,0 @@
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
> -static DEFINE_SPINLOCK(ltq_rcu_lock);
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
> -static void ltq_rcu_w32_mask(uint32_t clr, uint32_t set, uint32_t reg_off)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&ltq_rcu_lock, flags);
> -       ltq_rcu_w32((ltq_rcu_r32(reg_off) & ~(clr)) | (set), reg_off);
> -       spin_unlock_irqrestore(&ltq_rcu_lock, flags);
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

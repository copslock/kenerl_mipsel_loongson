Return-Path: <SRS0=g2b/=ST=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170AC282DA
	for <linux-mips@archiver.kernel.org>; Wed, 17 Apr 2019 07:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6875E2073F
	for <linux-mips@archiver.kernel.org>; Wed, 17 Apr 2019 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjZI4WvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDQHdy (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:33:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37951 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQHdy (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 17 Apr 2019 03:33:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id a6so19222208oie.5;
        Wed, 17 Apr 2019 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubda/WvxTGYZagrwssgME3XOPK9tofVYmjX9XeNa6/8=;
        b=cjZI4WvMQNrbMqDba8YAzw5mW5y68cETg9oHuao3b9FnN75M/4goph9fMmzLDMy/3t
         EvUFrRyYVxDscL4hjiBYlmrXwxQSYkN7qYOiaJ9vwxcE0hCQLCnExVI0NH9Uc9wPJ/VY
         dqxSrQFh5E5fhrZCTv0nmluEaMhDbSeChSTyz0yYp2anRE6Vhp/+e/9KI8K4mWNZwHBG
         AvhG9iFKKWIfEtZ0ITdwkzr+vuGq9nrIREj1ihAx+xjxEWqCdWEhz06VPvwRn7jjIj13
         j408ZvUD9FKjpH/Cm3Je0Yr5yU8Z07Ipc0mu7fu1uAx3UolI6x3DT0NnDs6HOWFB5Mbu
         CYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubda/WvxTGYZagrwssgME3XOPK9tofVYmjX9XeNa6/8=;
        b=rKZT3YkOHY5S0Z+jAhoY86i0I/EDX9LfIDJ/8ZWfKFPe/idx34sp+c6efz74ssU0KQ
         ej6RnzEAprFBeFCrJhUtP1B5TDp7R0esYaEli2kuKOIWgMkEz6JLARogqEQkeUrYfxW3
         DfFhinO98B4icMAyrbQBHLLtJluW5pviEcUsO1V7k1+i2SGZz6rrOggXgdj5VGvOafRz
         Y8w4fnYn6j+Vs7Jy/fBiz+OvjeplpUb5HYVRwZj6hNcYNfAMEfMfNdfeVa8iuX4x9hLS
         GCyCLSRkdSR4XIDmcAXjDQC/U5qS7TuylTlkDLyx82BSDJfRgJb2wXU8RdU5UfdvmyR+
         vaLg==
X-Gm-Message-State: APjAAAUUncQvpHBKcYZWGqYlHEzvzQPNLwiVA1ZpFG/2ZNq/UeijPgaz
        chI1/NFes2QGN4LyPhWfy2eC8lpnx532P4uWlDI=
X-Google-Smtp-Source: APXvYqzS9xDFjF9+5nfqt7PjciMuP1ceTfbaypwQ7MRRoytjE9sSG0ZQmoxwMbyb10ycJT7P9sjDW8bFFSWFuYdF/tM=
X-Received: by 2002:aca:d4d8:: with SMTP id l207mr25621920oig.29.1555486433412;
 Wed, 17 Apr 2019 00:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190330055038.18958-1-sergio.paracuellos@gmail.com>
 <20190330055038.18958-3-sergio.paracuellos@gmail.com> <a5236ba2-4403-d871-b0fe-1675356b4c0f@ti.com>
In-Reply-To: <a5236ba2-4403-d871-b0fe-1675356b4c0f@ti.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 17 Apr 2019 09:33:42 +0200
Message-ID: <CAMhs-H-4O0U1Fcn49yZdX9Uyv+DqTnkLkReKRXUqzrugMGWL8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: ralink: Add PHY driver for MT7621 PCIe PHY
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        driverdev-devel@linuxdriverproject.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, John Crispin <john@phrozen.org>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Kishon,

On Wed, Apr 17, 2019 at 7:58 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 30/03/19 11:20 AM, Sergio Paracuellos wrote:
> > This patch adds a driver for the PCIe PHY of MT7621 SoC.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/phy/ralink/Kconfig          |   7 +
> >  drivers/phy/ralink/Makefile         |   1 +
> >  drivers/phy/ralink/phy-mt7621-pci.c | 401 ++++++++++++++++++++++++++++
> >  3 files changed, 409 insertions(+)
> >  create mode 100644 drivers/phy/ralink/phy-mt7621-pci.c
> >
> > diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
> > index 14fd219535ef..87943a10f210 100644
> > --- a/drivers/phy/ralink/Kconfig
> > +++ b/drivers/phy/ralink/Kconfig
> > @@ -1,6 +1,13 @@
> >  #
> >  # PHY drivers for Ralink platforms.
> >  #
> > +config PHY_MT7621_PCI
> > +     tristate "MediaTek MT7621 PCI PHY Driver"
>
> Shouldn't this be in drivers/phy/mediatek/ then?

I am not sure about this, it is mediatek but it only appears on ralink so,
I don't know where it should be placed. Maybe Neil has an opinion about this.

> > +     depends on RALINK && OF
>
> Add depends on COMPILE_TEST.

Will do.

> > +     select GENERIC_PHY
> > +     help
> > +       Say 'Y' here to add support for MediaTek MT7621 PCI PHY driver,
> > +
> >  config PHY_RALINK_USB
> >       tristate "Ralink USB PHY driver"
> >       depends on RALINK || COMPILE_TEST
> > diff --git a/drivers/phy/ralink/Makefile b/drivers/phy/ralink/Makefile
> > index 5c9e326e8757..2052d5649863 100644
> > --- a/drivers/phy/ralink/Makefile
> > +++ b/drivers/phy/ralink/Makefile
> > @@ -1 +1,2 @@
> > +obj-$(CONFIG_PHY_MT7621_PCI) += phy-mt7621-pci.o
> >  obj-$(CONFIG_PHY_RALINK_USB) += phy-ralink-usb.o
> > diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
> > new file mode 100644
> > index 000000000000..118302c122ee
> > --- /dev/null
> > +++ b/drivers/phy/ralink/phy-mt7621-pci.c
> > @@ -0,0 +1,401 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Mediatek MT7621 PCI PHY Driver
> > + * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > + */
> > +
> > +#include <dt-bindings/phy/phy.h>
> > +#include <linux/bitops.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <mt7621.h>
> > +#include <ralink_regs.h>
> > +
> > +#define RALINK_CLKCFG1                               0x30
> > +#define CHIP_REV_MT7621_E2                   0x0101
>
> Is this PHY specific or SoC revision? If it is SoC, we should use
> soc_device_attribute and soc_device_match.

Depending on revision reset lines are inverted and somebypasses need
to be performed to properly initialize the phy. I'll take a look of
how this can be
done better using soc_device_attribute and soc_device_match as you are
pointing out here.

> > +
> > +#define PCIE_PORT_CLK_EN(x)                  BIT(24 + (x))
> > +
> > +#define RG_PE1_PIPE_REG                              0x02c
> > +#define RG_PE1_PIPE_RST                              BIT(12)
> > +#define RG_PE1_PIPE_CMD_FRC                  BIT(4)
> > +
> > +#define RG_P0_TO_P1_WIDTH                    0x100
> > +#define RG_PE1_H_LCDDS_REG                   0x49c
> > +#define RG_PE1_H_LCDDS_PCW                   GENMASK(30, 0)
> > +#define RG_PE1_H_LCDDS_PCW_VAL(x)            ((0x7fffffff & (x)) << 0)
> > +
> > +#define RG_PE1_FRC_H_XTAL_REG                        0x400
> > +#define RG_PE1_FRC_H_XTAL_TYPE                       BIT(8)
> > +#define RG_PE1_H_XTAL_TYPE                   GENMASK(10, 9)
> > +#define RG_PE1_H_XTAL_TYPE_VAL(x)            ((0x3 & (x)) << 9)
> > +
> > +#define RG_PE1_FRC_PHY_REG                   0x000
> > +#define RG_PE1_FRC_PHY_EN                    BIT(4)
> > +#define RG_PE1_PHY_EN                                BIT(5)
> > +
> > +#define RG_PE1_H_PLL_REG                     0x490
> > +#define RG_PE1_H_PLL_BC                              GENMASK(23, 22)
> > +#define RG_PE1_H_PLL_BC_VAL(x)                       ((0x3 & (x)) << 22)
> > +#define RG_PE1_H_PLL_BP                              GENMASK(21, 18)
> > +#define RG_PE1_H_PLL_BP_VAL(x)                       ((0xf & (x)) << 18)
> > +#define RG_PE1_H_PLL_IR                              GENMASK(15, 12)
> > +#define RG_PE1_H_PLL_IR_VAL(x)                       ((0xf & (x)) << 12)
> > +#define RG_PE1_H_PLL_IC                              GENMASK(11, 8)
> > +#define RG_PE1_H_PLL_IC_VAL(x)                       ((0xf & (x)) << 8)
> > +#define RG_PE1_H_PLL_PREDIV                  GENMASK(7, 6)
> > +#define RG_PE1_H_PLL_PREDIV_VAL(x)           ((0x3 & (x)) << 6)
> > +#define RG_PE1_PLL_DIVEN                     GENMASK(3, 1)
> > +#define RG_PE1_PLL_DIVEN_VAL(x)                      ((0x7 & (x)) << 1)
> > +
> > +#define RG_PE1_H_PLL_FBKSEL_REG                      0x4bc
> > +#define RG_PE1_H_PLL_FBKSEL                  GENMASK(5, 4)
> > +#define RG_PE1_H_PLL_FBKSEL_VAL(x)           ((0x3 & (x)) << 4)
> > +
> > +#define      RG_PE1_H_LCDDS_SSC_PRD_REG              0x4a4
> > +#define RG_PE1_H_LCDDS_SSC_PRD                       GENMASK(15, 0)
> > +#define RG_PE1_H_LCDDS_SSC_PRD_VAL(x)                ((0xffff & (x)) << 0)
> > +
> > +#define RG_PE1_H_LCDDS_SSC_DELTA_REG         0x4a8
> > +#define RG_PE1_H_LCDDS_SSC_DELTA             GENMASK(11, 0)
> > +#define RG_PE1_H_LCDDS_SSC_DELTA_VAL(x)              ((0xfff & (x)) << 0)
> > +#define RG_PE1_H_LCDDS_SSC_DELTA1            GENMASK(27, 16)
> > +#define RG_PE1_H_LCDDS_SSC_DELTA1_VAL(x)     ((0xff & (x)) << 16)
> > +
> > +#define RG_PE1_LCDDS_CLK_PH_INV_REG          0x4a0
> > +#define RG_PE1_LCDDS_CLK_PH_INV                      BIT(5)
> > +
> > +#define RG_PE1_H_PLL_BR_REG                  0x4ac
> > +#define RG_PE1_H_PLL_BR                              GENMASK(18, 16)
> > +#define RG_PE1_H_PLL_BR_VAL(x)                       ((0x7 & (x)) << 16)
> > +
> > +#define      RG_PE1_MSTCKDIV_REG                     0x414
> > +#define RG_PE1_MSTCKDIV                              GENMASK(7, 6)
> > +#define RG_PE1_MSTCKDIV_VAL(x)                       ((0x3 & (x)) << 6)
> > +
> > +#define RG_PE1_FRC_MSTCKDIV                  BIT(5)
> > +
> > +#define MAX_PHYS     2
> > +
> > +/**
> > + * struct mt7621_pci_phy_instance - Mt7621 Pcie PHY device
> > + * @phy: pointer to the kernel PHY device
> > + * @port_base: base register
> > + * @index: internal ID to identify the Mt7621 PCIe PHY
> > + */
> > +struct mt7621_pci_phy_instance {
> > +     struct phy *phy;
> > +     void __iomem *port_base;
> > +     u32 index;
> > +};
> > +
> > +/**
> > + * struct mt7621_pci_phy - Mt7621 Pcie PHY core
> > + * @dev: pointer to device
> > + * @phys: pointer to Mt7621 PHY device
> > + * @nphys: number of PHY devices for this core
> > + */
> > +struct mt7621_pci_phy {
> > +     struct device *dev;
> > +     struct mt7621_pci_phy_instance **phys;
> > +     int nphys;
> > +};
> > +
> > +static inline u32 phy_read(struct mt7621_pci_phy_instance *instance, u32 reg)
> > +{
> > +     return readl(instance->port_base + reg);
> > +}
> > +
> > +static inline void phy_write(struct mt7621_pci_phy_instance *instance,
> > +                          u32 val, u32 reg)
> > +{
> > +     writel(val, instance->port_base + reg);
> > +}
> > +
> > +static void mt7621_bypass_pipe_rst(struct mt7621_pci_phy *phy,
> > +                                struct mt7621_pci_phy_instance *instance)
> > +{
> > +     u32 offset = (instance->index != 1) ?
> > +             RG_PE1_PIPE_REG : RG_PE1_PIPE_REG + RG_P0_TO_P1_WIDTH;
> > +     u32 reg;
> > +
> > +     reg = phy_read(instance, offset);
> > +     reg &= ~(RG_PE1_PIPE_RST | RG_PE1_PIPE_CMD_FRC);
> > +     reg |= (RG_PE1_PIPE_RST | RG_PE1_PIPE_CMD_FRC);
> > +     phy_write(instance, reg, offset);
> > +}
> > +
> > +static void mt7621_set_phy_for_ssc(struct mt7621_pci_phy *phy,
> > +                                struct mt7621_pci_phy_instance *instance)
> > +{
> > +     struct device *dev = phy->dev;
> > +     u32 reg = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0);
> > +     u32 offset;
> > +     u32 val;
> > +
> > +     reg = (reg >> 6) & 0x7;
> > +     /* Set PCIe Port PHY to disable SSC */
> > +     /* Debug Xtal Type */
> > +     val = phy_read(instance, RG_PE1_FRC_H_XTAL_REG);
> > +     val &= ~(RG_PE1_FRC_H_XTAL_TYPE | RG_PE1_H_XTAL_TYPE);
> > +     val |= RG_PE1_FRC_H_XTAL_TYPE;
> > +     val |= RG_PE1_H_XTAL_TYPE_VAL(0x00);
>
> All this will be easier to maintain if regmap reg_field is used instead of
> using readl/writel directly.

I'll take a look of how phy_read and phy_write can be changed to use regmap.

> > +     phy_write(instance, val, RG_PE1_FRC_H_XTAL_REG);
> > +
> > +     /* disable port */
> > +     offset = (instance->index != 1) ?
> > +             RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
> > +     val = phy_read(instance, offset);
> > +     val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
> > +     val |= RG_PE1_FRC_PHY_EN;
> > +     phy_write(instance, val, offset);
> > +
> > +     /* Set Pre-divider ratio (for host mode) */
> > +     val = phy_read(instance, RG_PE1_H_PLL_REG);
> > +     val &= ~(RG_PE1_H_PLL_PREDIV);
> > +
> > +     if (reg <= 5 && reg >= 3) { /* 40MHz Xtal */
> > +             val |= RG_PE1_H_PLL_PREDIV_VAL(0x01);
> > +             phy_write(instance, val, RG_PE1_H_PLL_REG);
> > +             dev_info(dev, "Xtal is 40MHz\n");
> > +     } else { /* 25MHz | 20MHz Xtal */
> > +             val |= RG_PE1_H_PLL_PREDIV_VAL(0x00);
> > +             phy_write(instance, val, RG_PE1_H_PLL_REG);
> > +             if (reg >= 6) {
> > +                     dev_info(dev, "Xtal is 25MHz\n");
> > +
> > +                     /* Select feedback clock */
> > +                     val = phy_read(instance, RG_PE1_H_PLL_FBKSEL_REG);
> > +                     val &= ~(RG_PE1_H_PLL_FBKSEL);
> > +                     val |= RG_PE1_H_PLL_FBKSEL_VAL(0x01);
> > +                     phy_write(instance, val, RG_PE1_H_PLL_FBKSEL_REG);
> > +
> > +                     /* DDS NCPO PCW (for host mode) */
> > +                     val = phy_read(instance, RG_PE1_H_LCDDS_SSC_PRD_REG);
> > +                     val &= ~(RG_PE1_H_LCDDS_SSC_PRD);
> > +                     val |= RG_PE1_H_LCDDS_SSC_PRD_VAL(0x18000000);
> > +                     phy_write(instance, val, RG_PE1_H_LCDDS_SSC_PRD_REG);
> > +
> > +                     /* DDS SSC dither period control */
> > +                     val = phy_read(instance, RG_PE1_H_LCDDS_SSC_PRD_REG);
> > +                     val &= ~(RG_PE1_H_LCDDS_SSC_PRD);
> > +                     val |= RG_PE1_H_LCDDS_SSC_PRD_VAL(0x18d);
> > +                     phy_write(instance, val, RG_PE1_H_LCDDS_SSC_PRD_REG);
> > +
> > +                     /* DDS SSC dither amplitude control */
> > +                     val = phy_read(instance, RG_PE1_H_LCDDS_SSC_DELTA_REG);
> > +                     val &= ~(RG_PE1_H_LCDDS_SSC_DELTA |
> > +                              RG_PE1_H_LCDDS_SSC_DELTA1);
> > +                     val |= RG_PE1_H_LCDDS_SSC_DELTA_VAL(0x4a);
> > +                     val |= RG_PE1_H_LCDDS_SSC_DELTA1_VAL(0x4a);
> > +                     phy_write(instance, val, RG_PE1_H_LCDDS_SSC_DELTA_REG);
> > +             } else {
> > +                     dev_info(dev, "Xtal is 20MHz\n");
> > +             }
> > +     }
> > +
> > +     /* DDS clock inversion */
> > +     val = phy_read(instance, RG_PE1_LCDDS_CLK_PH_INV_REG);
> > +     val &= ~(RG_PE1_LCDDS_CLK_PH_INV);
> > +     val |= RG_PE1_LCDDS_CLK_PH_INV;
> > +     phy_write(instance, val, RG_PE1_LCDDS_CLK_PH_INV_REG);
> > +
> > +     /* Set PLL bits */
> > +     val = phy_read(instance, RG_PE1_H_PLL_REG);
> > +     val &= ~(RG_PE1_H_PLL_BC | RG_PE1_H_PLL_BP | RG_PE1_H_PLL_IR |
> > +              RG_PE1_H_PLL_IC | RG_PE1_PLL_DIVEN);
> > +     val |= RG_PE1_H_PLL_BC_VAL(0x02);
> > +     val |= RG_PE1_H_PLL_BP_VAL(0x06);
> > +     val |= RG_PE1_H_PLL_IR_VAL(0x02);
> > +     val |= RG_PE1_H_PLL_IC_VAL(0x01);
> > +     val |= RG_PE1_PLL_DIVEN_VAL(0x02);
> > +     phy_write(instance, val, RG_PE1_H_PLL_REG);
> > +
> > +     val = phy_read(instance, RG_PE1_H_PLL_BR_REG);
> > +     val &= ~(RG_PE1_H_PLL_BR);
> > +     val |= RG_PE1_H_PLL_BR_VAL(0x00);
> > +     phy_write(instance, val, RG_PE1_H_PLL_BR_REG);
> > +
> > +     if (reg <= 5 && reg >= 3) { /* 40MHz Xtal */
> > +             /* set force mode enable of da_pe1_mstckdiv */
> > +             val = phy_read(instance, RG_PE1_MSTCKDIV_REG);
> > +             val &= ~(RG_PE1_MSTCKDIV | RG_PE1_FRC_MSTCKDIV);
> > +             val |= (RG_PE1_MSTCKDIV_VAL(0x01) | RG_PE1_FRC_MSTCKDIV);
> > +             phy_write(instance, val, RG_PE1_MSTCKDIV_REG);
> > +     }
> > +}
> > +
> > +static int mt7621_pci_phy_init(struct phy *phy)
> > +{
> > +     struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
> > +     struct mt7621_pci_phy *mphy = dev_get_drvdata(phy->dev.parent);
> > +     u32 chip_rev_id = rt_sysc_r32(SYSC_REG_CHIP_REV);
> > +
> > +     if ((chip_rev_id & 0xFFFF) == CHIP_REV_MT7621_E2)
> > +             mt7621_bypass_pipe_rst(mphy, instance);
> > +
> > +     mt7621_set_phy_for_ssc(mphy, instance);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pci_phy_power_on(struct phy *phy)
> > +{
> > +     struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
> > +     u32 offset = (instance->index != 1) ?
> > +             RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
> > +     u32 val;
> > +
> > +     /* Enable PHY and disable force mode */
> > +     val = phy_read(instance, offset);
> > +     val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
> > +     val |= (RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
> > +     phy_write(instance, val, offset);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pci_phy_power_off(struct phy *phy)
> > +{
> > +     struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
> > +     u32 offset = (instance->index != 1) ?
> > +             RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
> > +     u32 val;
> > +
> > +     /* Disable PHY */
> > +     val = phy_read(instance, offset);
> > +     val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
> > +     val |= RG_PE1_FRC_PHY_EN;
> > +     phy_write(instance, val, offset);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pci_phy_exit(struct phy *phy)
> > +{
> > +     struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
> > +
> > +     rt_sysc_m32(PCIE_PORT_CLK_EN(instance->index), 0, RALINK_CLKCFG1);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct phy_ops mt7621_pci_phy_ops = {
> > +     .init           = mt7621_pci_phy_init,
> > +     .exit           = mt7621_pci_phy_exit,
> > +     .power_on       = mt7621_pci_phy_power_on,
> > +     .power_off      = mt7621_pci_phy_power_off,
> > +     .owner          = THIS_MODULE,
> > +};
> > +
> > +static struct phy *mt7621_pcie_phy_of_xlate(struct device *dev,
> > +                                         struct of_phandle_args *args)
> > +{
> > +     struct mt7621_pci_phy *mt7621_phy = dev_get_drvdata(dev);
> > +
> > +     if (args->args_count == 0)
> > +             return mt7621_phy->phys[0]->phy;
> > +
> > +     if (WARN_ON(args->args[0] >= MAX_PHYS))
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     return mt7621_phy->phys[args->args[0]]->phy;
> > +}
> > +
> > +static int mt7621_pci_phy_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct device_node *np = dev->of_node;
> > +     struct device_node *child_np;
> > +     struct phy_provider *provider;
> > +     struct mt7621_pci_phy *phy;
> > +     struct resource res;
> > +     int port, ret;
> > +     void __iomem *port_base;
> > +
> > +     phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> > +     if (!phy)
> > +             return -ENOMEM;
> > +
> > +     phy->nphys = MAX_PHYS;
> > +     phy->phys = devm_kcalloc(dev, phy->nphys,
> > +                              sizeof(*phy->phys), GFP_KERNEL);
> > +     if (!phy->phys)
> > +             return -ENOMEM;
> > +
> > +     phy->dev = dev;
> > +     platform_set_drvdata(pdev, phy);
> > +
> > +     ret = of_address_to_resource(np, 0, &res);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get address resource(id-%d)\n", port);
> > +             return ret;
> > +     }
>
> Use platform_get_resource instead?

Ok, I'll change this also to use platform_get_resource.

>
> Thanks
> Kishon

Thank you very much for the review. I will post all this changes to
staging to be properly
tested and resend a v3 with the final result.

Best regards,
    Sergio Paracuellos

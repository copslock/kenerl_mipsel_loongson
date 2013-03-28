Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Mar 2013 13:00:09 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:20597 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834890Ab3C1MAGhtjF7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Mar 2013 13:00:06 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 28 Mar 2013 04:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,925,1355126400"; 
   d="scan'208";a="309713021"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.160])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2013 04:59:54 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Svetoslav Neykov <svetoslav@neykov.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: Re: [PATCH v2 2/2] usb: chipidea: AR933x platform support for the chipidea driver
In-Reply-To: <1362176257-2328-3-git-send-email-svetoslav@neykov.name>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-3-git-send-email-svetoslav@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Thu, 28 Mar 2013 14:01:58 +0200
Message-ID: <87r4izivgp.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.shishkin@linux.intel.com
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

Svetoslav Neykov <svetoslav@neykov.name> writes:

> Support host and device usb modes for the chipidea controller in AR933x.
>
> Changes since last version of the patch:
> 	* conditionally include ci13xxx_ar933x.c for compilation
> 	* removed __devinit/__devexit/__devexit_p()
> 	* use a dynamically allocated structure for ci13xxx_platform_data
> 	* move controller mode check to platform usb registration
> 	* pick a different name for the ar933x chipidea driver
> 	* use a correct MODE_ALIAS name
> 	* use the dr_mode changes in "[PATCH 0/3] otg-for-v3.10-v2:
> 	  separate phy code and add DT helper"
>
> Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>

This can go in either through chipidea or mips tree, but in either case
it has to have an Acked-by from the maintainer of the other tree.

> ---
>  arch/mips/ath79/dev-usb.c                          |   50 +++++++++++++
>  arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |    3 +
>  .../asm/mach-ath79/ar933x_chipidea_platform.h      |   18 +++++
>  drivers/usb/chipidea/Makefile                      |    5 ++
>  drivers/usb/chipidea/ci13xxx_ar933x.c              |   75 ++++++++++++++++++++
>  5 files changed, 151 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
>  create mode 100644 drivers/usb/chipidea/ci13xxx_ar933x.c
>
> diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
> index bd2bc10..0c285d9 100644
> --- a/arch/mips/ath79/dev-usb.c
> +++ b/arch/mips/ath79/dev-usb.c
> @@ -19,9 +19,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/usb/ehci_pdriver.h>
>  #include <linux/usb/ohci_pdriver.h>
> +#include <linux/usb/otg.h>
>  
>  #include <asm/mach-ath79/ath79.h>
>  #include <asm/mach-ath79/ar71xx_regs.h>
> +#include <asm/mach-ath79/ar933x_chipidea_platform.h>
>  #include "common.h"
>  #include "dev-usb.h"
>  
> @@ -68,6 +70,22 @@ static struct platform_device ath79_ehci_device = {
>  	},
>  };
>  
> +static struct resource ar933x_chipidea_resources[2];
> +
> +static struct ar933x_chipidea_platform_data ar933x_chipidea_data = {
> +};

No need to initialize it like this, it should save a few bytes in
.data.

> +
> +static struct platform_device ar933x_chipidea_device = {
> +	.name		= "ar933x-chipidea",
> +	.id		= -1,
> +	.resource	= ar933x_chipidea_resources,
> +	.num_resources	= ARRAY_SIZE(ar933x_chipidea_resources),
> +	.dev = {
> +		.dma_mask		= &ath79_ehci_dmamask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +};
> +
>  static void __init ath79_usb_init_resource(struct resource res[2],
>  					   unsigned long base,
>  					   unsigned long size,
> @@ -174,8 +192,32 @@ static void __init ar913x_usb_setup(void)
>  	platform_device_register(&ath79_ehci_device);
>  }
>  
> +static void __init ar933x_usb_setup_ctrl_config(void)
> +{
> +	void __iomem *usb_ctrl_base, *usb_config_reg;
> +	u32 usb_config;
> +
> +	usb_ctrl_base = ioremap(AR71XX_USB_CTRL_BASE, AR71XX_USB_CTRL_SIZE);
> +	usb_config_reg = usb_ctrl_base + AR71XX_USB_CTRL_REG_CONFIG;
> +	usb_config = __raw_readl(usb_config_reg);
> +	usb_config &= ~AR933X_USB_CONFIG_HOST_ONLY;
> +	__raw_writel(usb_config, usb_config_reg);
> +	iounmap(usb_ctrl_base);
> +}
> +
>  static void __init ar933x_usb_setup(void)
>  {
> +	u32 bootstrap;
> +	enum usb_dr_mode dr_mode;
> +
> +	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
> +	if (bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST) {
> +		dr_mode = USB_DR_MODE_HOST;
> +	} else {
> +		dr_mode = USB_DR_MODE_PERIPHERAL;
> +		ar933x_usb_setup_ctrl_config();
> +	}
> +
>  	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
>  	mdelay(10);
>  
> @@ -187,8 +229,16 @@ static void __init ar933x_usb_setup(void)
>  
>  	ath79_usb_init_resource(ath79_ehci_resources, AR933X_EHCI_BASE,
>  				AR933X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
> +
>  	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
>  	platform_device_register(&ath79_ehci_device);
> +
> +	ath79_usb_init_resource(ar933x_chipidea_resources, AR933X_EHCI_BASE,
> +				AR933X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
> +
> +	ar933x_chipidea_data.dr_mode = dr_mode;
> +	ar933x_chipidea_device.dev.platform_data = &ar933x_chipidea_data;
> +	platform_device_register(&ar933x_chipidea_device);
>  }
>  
>  static void __init ar934x_usb_setup(void)
> diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> index a5e0f17..13eb2d9 100644
> --- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> +++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> @@ -297,6 +297,7 @@
>  #define AR934X_RESET_USB_PHY		BIT(4)
>  #define AR934X_RESET_USBSUS_OVERRIDE	BIT(3)
>  
> +#define AR933X_BOOTSTRAP_USB_MODE_HOST	BIT(3)
>  #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
>  
>  #define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
> @@ -315,6 +316,8 @@
>  #define AR934X_BOOTSTRAP_SDRAM_DISABLED	BIT(1)
>  #define AR934X_BOOTSTRAP_DDR1		BIT(0)
>  
> +#define AR933X_USB_CONFIG_HOST_ONLY	BIT(8)
> +
>  #define AR934X_PCIE_WMAC_INT_WMAC_MISC		BIT(0)
>  #define AR934X_PCIE_WMAC_INT_WMAC_TX		BIT(1)
>  #define AR934X_PCIE_WMAC_INT_WMAC_RXLP		BIT(2)
> diff --git a/arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h b/arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
> new file mode 100644
> index 0000000..2b0ee30
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
> @@ -0,0 +1,18 @@
> +/*
> + *  Platform data definition for Atheros AR933X Chipidea USB controller
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#ifndef _AR933X_CHIPIDEA_PLATFORM_H
> +#define _AR933X_CHIPIDEA_PLATFORM_H
> +
> +#include <linux/usb/otg.h>
> +
> +struct ar933x_chipidea_platform_data {
> +	enum usb_dr_mode dr_mode;
> +};

Why can't you just use ci13xxx_platform_data?
It looks like you don't need a glue driver is drivers/usb/chipidea at
all, you can register ci_hdrc right from the ath79/dev-usb.c

Regards,
--
Alex

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Feb 2013 12:22:10 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:20704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823072Ab3BNLVyKZtOh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Feb 2013 12:21:54 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 14 Feb 2013 03:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,664,1355126400"; 
   d="scan'208";a="285674811"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.164])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2013 03:21:42 -0800
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
Subject: Re: [PATCH 4/5] usb: chipidea: AR933x platform support for the chipidea driver
In-Reply-To: <1360791538-6332-5-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <1360791538-6332-5-git-send-email-svetoslav@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Feb 2013 13:23:19 +0200
Message-ID: <877gmbb0m0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35750
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
> The controller doesn't support OTG functionality so the platform code
> forces one of the modes based on the state of GPIO13 pin at startup.

Some comments below.

>
> Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
> ---
>  arch/mips/ath79/dev-usb.c                      |   19 ++++++
>  arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +
>  drivers/usb/chipidea/Makefile                  |    1 +
>  drivers/usb/chipidea/ci13xxx_ar933x.c          |   73 ++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 drivers/usb/chipidea/ci13xxx_ar933x.c
>
> diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
> index bd2bc10..52966b3 100644
> --- a/arch/mips/ath79/dev-usb.c
> +++ b/arch/mips/ath79/dev-usb.c
> @@ -174,8 +174,27 @@ static void __init ar913x_usb_setup(void)
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
> +
> +	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
> +	if (!(bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST))
> +		ar933x_usb_setup_ctrl_config();
> +
>  	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
>  	mdelay(10);
>  
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
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index d92ca32..196b7b4 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -10,6 +10,7 @@ ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
>  # Glue/Bridge layers go here
>  
>  obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
> +obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_ar933x.o

The problem is that this will only compile for mips target, so you
should probably change the Makefile to only compile it for mips.

>  
>  # PCI doesn't provide stubs, need to check
>  ifneq ($(CONFIG_PCI),)
> diff --git a/drivers/usb/chipidea/ci13xxx_ar933x.c b/drivers/usb/chipidea/ci13xxx_ar933x.c
> new file mode 100644
> index 0000000..046a4b6
> --- /dev/null
> +++ b/drivers/usb/chipidea/ci13xxx_ar933x.c
> @@ -0,0 +1,73 @@
> +/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/usb/ulpi.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/chipidea.h>
> +#include <asm/mach-ath79/ath79.h>
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +
> +#include "ci.h"
> +
> +static struct ci13xxx_platform_data ci13xxx_ar933x_platdata = {
> +	.name			= "ci13xxx_ar933x",
> +	.flags			= 0,
> +	.capoffset		= DEF_CAPOFFSET
> +};
> +
> +static int __devinit ci13xxx_ar933x_probe(struct platform_device *pdev)

__devinit/__devexit/__devexit_p() are gone from the kernel.

Regards,
--
Alex

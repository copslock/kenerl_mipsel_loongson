Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Feb 2013 15:19:40 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:60547 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823080Ab3BNOTjTo4y9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Feb 2013 15:19:39 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G56qhYG9OGOO; Thu, 14 Feb 2013 15:19:24 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7EAEB284467;
        Thu, 14 Feb 2013 15:19:24 +0100 (CET)
Message-ID: <511CF27F.3080604@openwrt.org>
Date:   Thu, 14 Feb 2013 15:19:43 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Svetoslav Neykov <svetoslav@neykov.name>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/5] usb: chipidea: AR933x platform support for the chipidea
 driver
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <1360791538-6332-5-git-send-email-svetoslav@neykov.name>
In-Reply-To: <1360791538-6332-5-git-send-email-svetoslav@neykov.name>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-archive-position: 35752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

Hi Svetoslav,

> Support host and device usb modes for the chipidea controller in AR933x.
> The controller doesn't support OTG functionality so the platform code
> forces one of the modes based on the state of GPIO13 pin at startup.
> 
> Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
> ---

<...>

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

Static data only works if there are only one USB IP in the SoCs. It is true for
the AR9330 SoC, but newer SoCs may have more. Please use a dynamically allocated
structure and fill that in the probe routine.

> +
> +static int __devinit ci13xxx_ar933x_probe(struct platform_device *pdev)
> +{
> +	u32 bootstrap;
> +	struct platform_device *plat_ci;
> +
> +	dev_dbg(&pdev->dev, "ci13xxx_ar933x_probe\n");
> +
> +	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
> +	if (bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST)
> +		ci13xxx_ar933x_platdata.flags = CI13XXX_FORCE_HOST_MODE;
> +	else
> +		ci13xxx_ar933x_platdata.flags = CI13XXX_FORCE_DEVICE_MODE;

This bootstrap setting is only valid for the AR933x SoCs. It would be better to
move this code into the SoC specific USB device registration code, and use
platform data to pass that information to this driver.

> +
> +	plat_ci = ci13xxx_add_device(&pdev->dev,
> +				pdev->resource, pdev->num_resources,
> +				&ci13xxx_ar933x_platdata);
> +	if (IS_ERR(plat_ci)) {
> +		dev_err(&pdev->dev, "ci13xxx_add_device failed!\n");
> +		return PTR_ERR(plat_ci);
> +	}
> +
> +	platform_set_drvdata(pdev, plat_ci);
> +
> +	pm_runtime_no_callbacks(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int __devexit ci13xxx_ar933x_remove(struct platform_device *pdev)
> +{
> +	struct platform_device *plat_ci = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	ci13xxx_remove_device(plat_ci);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ci13xxx_ar933x_driver = {
> +	.probe = ci13xxx_ar933x_probe,
> +	.remove = __devexit_p(ci13xxx_ar933x_remove),
> +	.driver = { .name = "ehci-platform", },

This name is used by the ehci-platform driver. You should pick a different one
for this driver. Additionally, the device registration code in
'arch/mips/ath79/dev-usb.c' must be adjusted as well.

> +};
> +
> +module_platform_driver(ci13xxx_ar933x_driver);
> +
> +MODULE_ALIAS("platform:ar933x_hsusb");

The driver part of the MODULE_ALIAS string should match with the driver name.
You should use this instead ci13xxx_ar933x_driver

> +MODULE_LICENSE("GPL v2");

Regards,
Gabor

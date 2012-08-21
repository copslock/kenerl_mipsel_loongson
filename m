Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 23:14:08 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:40376 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903498Ab2HUVN7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 23:13:59 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T3vlt-0007TX-BF; Tue, 21 Aug 2012 23:13:57 +0200
Date:   Tue, 21 Aug 2012 23:13:55 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, sebastian@breakpoint.cc,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH V2] usb: gadget: bcm63xx UDC driver
Message-ID: <20120821211355.GB6307@breakpoint.cc>
References: <b3bb6f2afb3ed82fd1e64563c68fb8df@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3bb6f2afb3ed82fd1e64563c68fb8df@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
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

On Mon, Aug 20, 2012 at 06:49:36PM -0700, Kevin Cernekee wrote:
> Driver for the "USB20D" / "USBD" block on BCM6328, BCM6368, BCM6816,
> BCM6362, BCM3383, and others.

looks good btw.

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 51ab5fd..01efd9d 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -160,6 +160,19 @@ config USB_ATMEL_USBA
>  	  USBA is the integrated high-speed USB Device controller on
>  	  the AT32AP700x, some AT91SAM9 and AT91CAP9 processors from Atmel.
>  
> +config USB_BCM63XX_UDC
> +	tristate "Broadcom BCM63xx Peripheral Controller"
> +	select USB_GADGET_DUALSPEED
> +	depends on BCM63XX
> +	help
> +	   Many Broadcom BCM63xx chipsets (such as the BCM6328) have a
> +	   high speed USB Device Port with support for four fixed endpoints
> +	   (plus endpoint zero).
> +
> +	   Say "y" to link the driver statically, or "m" to build a
> +	   dynamically linked module called "bcm63xx_udc" and force
> +	   all gadget drivers to also be dynamically linked.
please drop the "force all gadget drivers to also be dynamically linked" part.
We may want to change this one day :)

> +
>  config USB_FSL_USB2
>  	tristate "Freescale Highspeed USB DR Peripheral Controller"
>  	depends on FSL_SOC || ARCH_MXC
> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index 3fd8cd0..d84f923 100644

> diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
> new file mode 100644
> index 0000000..a44352b
> --- /dev/null
> +++ b/drivers/usb/gadget/bcm63xx_udc.c
...

> +static bool use_fullspeed;
> +module_param(use_fullspeed, bool, S_IRUGO);
> +MODULE_PARM_DESC(use_fullspeed, "true for fullspeed only");

How important is this option? Maybe this should become a generic option?

> +static int bcm63xx_udc_start(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver)
> +{
> +	struct bcm63xx_udc *udc = gadget_to_udc(gadget);
> +	unsigned long flags;
> +
> +	if (!driver || driver->max_speed < USB_SPEED_HIGH ||
Hmm. But if you set use_fullspeed isn't this kinda legal?

> +static int __devinit bcm63xx_udc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm63xx_usbd_platform_data *pd = dev->platform_data;
> +	struct bcm63xx_udc *udc;
> +	struct resource *res;
> +	int rc = -ENOMEM, i, irq;
> +
> +	udc = devm_kzalloc(dev, sizeof(*udc), GFP_KERNEL);
> +	if (!udc) {
> +		dev_err(dev, "cannot allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, udc);
> +	udc->dev = dev;
> +	udc->pd = pd;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "error finding USBD resource\n");
> +		return -ENXIO;
> +	}
> +	udc->usbd_regs = devm_request_and_ioremap(dev, res);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(dev, "error finding IUDMA resource\n");
> +		return -ENXIO;
> +	}
> +	udc->iudma_regs = devm_request_and_ioremap(dev, res);
> +
> +	if (!udc->usbd_regs || !udc->iudma_regs) {
> +		dev_err(dev, "error requesting resources\n");
> +		return -ENXIO;
> +	}
> +
> +	spin_lock_init(&udc->lock);
> +	dev_set_name(&udc->gadget.dev, "gadget");
> +
> +	udc->gadget.ops = &bcm63xx_udc_ops;
> +	udc->gadget.name = dev_name(dev);
> +	udc->gadget.dev.parent = dev;
> +	udc->gadget.dev.release = bcm63xx_udc_gadget_release;
> +	udc->gadget.dev.dma_mask = dev->dma_mask;
> +
> +	if (!pd->use_fullspeed && !use_fullspeed)
so it is a good advice to have pd not set to NULL :)

Sebastian

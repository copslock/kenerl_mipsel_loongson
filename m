Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 04:43:23 +0000 (GMT)
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:26454 "HELO
	smtp118.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S23648487AbYKREnR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 04:43:17 +0000
Received: (qmail 13022 invoked from network); 18 Nov 2008 04:43:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:Reply-To:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=iKBUDAOZr0OHwIPl/rrHQdEQxto/2YKZW3BpGVKSiNs3QmGJQSGDN5vTfY0OlF4XhMfnyabAlz4mnInXULdIm6QhENnPRAP/5cRMtQv+OWFiYmd7hL7KgMn+StHIXXdbaup+G9+LpfKaPUa0KLJ+hphwMiTc31oZiw8XxdnTs1Y=  ;
Received: from unknown (HELO pogo.local) (david-b@69.226.222.107 with plain)
  by smtp118.sbc.mail.sp1.yahoo.com with SMTP; 18 Nov 2008 04:43:08 -0000
X-YMail-OSG: qXaZR.8VM1mNQzeuqSGmRkaFlAYsETXBzStfMmtWFSXMwZSL0kaF3StimBvayVW5MaQczmz7BX1TPsdL8nOzhclTZM7q6_GjNoQovFYK5NLbVpaz0YM6J3dzHMtixI5nRl27Pfxp.7kQPPQFFUhEj6ZqcQwyUII5gcv6JqNXyoQC9XZ9SoEv_vcEunMM
X-Yahoo-Newman-Property: ymail-3
From:	David Brownell <david-b@pacbell.net>
Reply-To: dbrownell@users.sourceforge.net
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH/RFC v1 07/12] [MIPS] BCM63XX: Add USB OHCI support.
Date:	Mon, 17 Nov 2008 20:41:28 -0800
User-Agent: KMail/1.9.10
Cc:	linux-mips@linux-mips.org, linux-usb@vger.kernel.org
References: <1224382023-24342-1-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1224382023-24342-1-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811172041.29423.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Saturday 18 October 2008, Maxime Bizon wrote:
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  arch/mips/bcm63xx/Kconfig                          |    6 +
>  arch/mips/bcm63xx/Makefile                         |    1 +
>  arch/mips/bcm63xx/dev-usb-ohci.c                   |   50 ++++++
>  .../asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h        |    6 +

The arch/mips stuff should be one patch, going through the MIPS tree
(presumably along with board init code calling it) ...

>  drivers/usb/host/ohci-bcm63xx.c                    |  159 ++++++++++++++++++++
>  drivers/usb/host/ohci-hcd.c                        |    5 +
>  drivers/usb/host/ohci.h                            |    7 +-

... and the OHCI (and EHCI) stuff should be in another patch, going
through the USB tree.


I gave a really quick glance to the arch/mips stuff and it seemed
reasonable.  Maybe a bit short on board-specific issues like pinmux
for "this board exposes only ports 1 & 3" etc, but for all I know
those issues don't even exist for these chips.  ;)

The OHCI bits don't seem unusual ... a few comments though.


> --- /dev/null
> +++ b/drivers/usb/host/ohci-bcm63xx.c
> @@ -0,0 +1,159 @@
> 

> +static const struct hc_driver ohci_bcm63xx_hc_driver = {
> +	.description =		hcd_name,
> +	.product_desc =		"BCM63XX integrated OHCI controller",
> +	.hcd_priv_size =	sizeof(struct ohci_hcd),
> +
> +	.irq =			ohci_irq,
> +	.flags =		HCD_USB11 | HCD_MEMORY,
> +	.start =		ohci_bcm63xx_start,
> +	.stop =			ohci_stop,
> +	.shutdown =		ohci_shutdown,
> +	.urb_enqueue =		ohci_urb_enqueue,
> +	.urb_dequeue =		ohci_urb_dequeue,
> +	.endpoint_disable =	ohci_endpoint_disable,
> +	.get_frame_number =	ohci_get_frame,
> +	.hub_status_data =	ohci_hub_status_data,
> +	.hub_control =		ohci_hub_control,
> +	.start_port_reset =	ohci_start_port_reset,

Saving power management for later, it seems.  :)


> +};
> +
> +static int __devinit ohci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem, *res_irq;
> +	struct usb_hcd *hcd;
> +	struct ohci_hcd *ohci;
> +	u32 reg;
> +	int ret;
> +
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

irq = platform_get_irq(pdev, 0) is a bit cleaner.

> +	if (!res_mem || !res_irq)
> +		return -ENODEV;
> +
> +	if (BCMCPU_IS_6348()) {
> +		struct clk *clk;
> +		/* enable USB host clock */
> +		clk = clk_get(&pdev->dev, "usbh");
> +		if (IS_ERR(clk))
> +			return -ENODEV;
> +
> +		clk_enable(clk);
> +		usb_host_clock = clk;
> +		bcm_rset_writel(RSET_OHCI_PRIV, 0, OHCI_PRIV_REG);
> +
> +	} else if (BCMCPU_IS_6358()) {
> +		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_REG);
> +		reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
> +		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
> +		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
> +		/* don't ask... */

Best if you describe the errata this works around, even if you'd
rather not go into detail about that part of the sausage-making.
That way the next person may be able to say "oh yeah, they finally
fixed that one", or whatever.  ;)


> +		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
> +	} else
> +		return 0;
> +


> +static struct platform_driver ohci_hcd_bcm63xx_driver = {
> +	.probe		= ohci_hcd_bcm63xx_drv_probe,
> +	.remove		= __devexit_p(ohci_hcd_bcm63xx_drv_remove),
> +	.shutdown	= usb_hcd_platform_shutdown,
> +	.driver		= {
> +		.name	= "bcm63xx_ohci",
> +		.owner	= THIS_MODULE,
> +		.bus	= &platform_bus_type

Don't set the bus type here; the platform_bus code does that.


> +	},
> +};
> +
> +MODULE_ALIAS("platform:bcm63xx_ohci");
> --- a/drivers/usb/host/ohci.h
> +++ b/drivers/usb/host/ohci.h
> @@ -549,6 +549,11 @@ static inline struct usb_hcd *ohci_to_hcd (const struct ohci_hcd *ohci)
>  #define writel_be(val, addr)	out_be32((__force unsigned *)addr, val)
>  #endif
>  
> +#if defined(CONFIG_MIPS) && defined(CONFIG_BCM63XX)
> +#define readl_be(addr)		__raw_readl((__force unsigned *)addr)
> +#define writel_be(val, addr)	__raw_writel(val, (__force unsigned *)addr)
> +#endif

I'd expect those to be defined in <asm/...> or <mach/...> headers,
as they are in all other cases.

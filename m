Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 21:45:50 +0200 (CEST)
Received: from netrider.rowland.org ([192.131.102.5]:42767 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1904117Ab2DGTpn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 21:45:43 +0200
Received: (qmail 32454 invoked by uid 500); 7 Apr 2012 15:45:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Apr 2012 15:45:37 -0400
Date:   Sat, 7 Apr 2012 15:45:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, <ralf@linux-mips.org>,
        <linux-usb@vger.kernel.org>, Chris Dearman <chris@mips.com>
Subject: Re: [PATCH 10/10] usb: host: mips: sead3: USB Host controller support
 for SEAD-3 platform.
In-Reply-To: <1333817979-30288-1-git-send-email-sjhill@mips.com>
Message-ID: <Pine.LNX.4.44L0.1204071527590.32196-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 7 Apr 2012, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Add EHCI driver for MIPS SEAD-3 development platform.
> 
> Signed-off-by: Chris Dearman <chris@mips.com>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  drivers/usb/host/Kconfig      |    4 +-
>  drivers/usb/host/ehci-hcd.c   |    5 +
>  drivers/usb/host/ehci-sead3.c |  299 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/usb/host/ehci-sead3.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index f788eb8..db29a9f 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -110,13 +110,13 @@ config USB_EHCI_BIG_ENDIAN_MMIO
>  	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || \
>  				    ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
>  				    PPC_MPC512x || CPU_CAVIUM_OCTEON || \
> -				    PMC_MSP || SPARC_LEON)
> +				    PMC_MSP || SPARC_LEON || MIPS_SEAD3)
>  	default y
>  
>  config USB_EHCI_BIG_ENDIAN_DESC
>  	bool
>  	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
> -				    PPC_MPC512x || PMC_MSP || SPARC_LEON)
> +				    PPC_MPC512x || PMC_MSP || SPARC_LEON || MIPS_SEAD3)

How about wrapping this to another line, to respect the 80-column 
limit?

>  	default y
>  
>  config XPS_USB_HCD_XILINX

> --- /dev/null
> +++ b/drivers/usb/host/ehci-sead3.c

> +#ifdef CONFIG_PM
> +static void mips_start_ehc(void)
> +{
> +	pr_debug("mips_start_ehc\n");
> +}
> +#endif
> +
> +static void mips_stop_ehc(void)
> +{
> +	pr_debug("mips_start_ehc\n");
> +}

Do these really need to be separate functions?

Also, you should use ehci_dbg() instead of pr_debug().  Likewise throughout
the rest of this file.

> +
> +static int mips_run(struct usb_hcd *hcd)
> +{
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	u32 temp;
> +
> +	temp = ehci_reset(ehci);
> +	if (temp != 0) {
> +		ehci_mem_cleanup(ehci);
> +		return temp;
> +	}
> +
> +	return ehci_run(hcd);
> +}
> +
> +const struct hc_driver ehci_mips_hc_driver = {
> +	.description		= hcd_name,
> +	.product_desc		= "MIPS EHCI",
> +	.hcd_priv_size		= sizeof(struct ehci_hcd),
> +
> +	/*
> +	 * generic hardware linkage
> +	 */
> +	.irq			= ehci_irq,
> +	.flags			= HCD_MEMORY | HCD_USB2,
> +
> +	/*
> +	 * basic lifecycle operations
> +	 *
> +	 */
> +	.reset			= ehci_init,
> +	.start			= mips_run,
> +	.stop			= ehci_stop,
> +	.shutdown		= ehci_shutdown,
> +
> +	/*
> +	 * managing i/o requests and associated device resources
> +	 */
> +	.urb_enqueue		= ehci_urb_enqueue,
> +	.urb_dequeue		= ehci_urb_dequeue,
> +	.endpoint_disable	= ehci_endpoint_disable,
> +
> +	/*
> +	 * scheduling support
> +	 */
> +	.get_frame_number	= ehci_get_frame,
> +
> +	/*
> +	 * root hub support
> +	 */
> +	.hub_status_data	= ehci_hub_status_data,
> +	.hub_control		= ehci_hub_control,
> +	.bus_suspend		= ehci_bus_suspend,
> +	.bus_resume		= ehci_bus_resume,
> +	.relinquish_port	= ehci_relinquish_port,
> +	.port_handed_over	= ehci_port_handed_over,
> +};

This looks like it was copied from a rather old copy of ehci-au1xxx.
You should allways base new work on the current version.

> +static int ehci_hcd_mips_drv_probe(struct platform_device *pdev)
> +{
> +	struct usb_hcd *hcd;
> +	struct ehci_hcd *ehci;
> +	int ret;
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> +		pr_debug("resource[1] is not IORESOURCE_IRQ");
> +		return -ENOMEM;
> +	}
> +	hcd = usb_create_hcd(&ehci_mips_hc_driver, &pdev->dev, "MIPS");
> +	if (!hcd)
> +		return -ENOMEM;
> +
> +	hcd->rsrc_start = pdev->resource[0].start;
> +	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
> +
> +	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
> +		pr_debug("request_mem_region failed");
> +		ret = -EBUSY;
> +		goto err1;
> +	}
> +
> +	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
> +	if (!hcd->regs) {
> +		pr_debug("ioremap failed");
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	hcd->has_tt = 1;
> +
> +	ehci = hcd_to_ehci(hcd);
> +	ehci->caps = hcd->regs + 0x100;

Some of this (along with mips_run() above) can be replaced with a call
to ehci_setup().

> +	ehci->regs = hcd->regs + 0x100 +
> +		HC_LENGTH(ehci, readl(&ehci->caps->hc_capbase));
> +	/* cache this readonly data; minimize chip reads */
> +	ehci->hcs_params = readl(&ehci->caps->hcs_params);
> +
> +	/* SEAD-3 EHCI matches CPU endianness. */
> +#ifdef __BIG_ENDIAN
> +	ehci->big_endian_mmio = 1;
> +	ehci->big_endian_desc = 1;
> +#endif
> +
> +	/* Set burst length to 16 words */
> +	/* FIXME: should be tunable */
> +	ehci_writel(ehci, 0x1010, &ehci->regs->reserved[1]);
> +
> +	ret = usb_add_hcd(hcd, pdev->resource[1].start,
> +			  IRQF_DISABLED | IRQF_SHARED);
> +	if (ret == 0) {
> +		platform_set_drvdata(pdev, hcd);
> +		return ret;
> +	}

Alan Stern

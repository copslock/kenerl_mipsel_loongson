Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Apr 2012 17:00:53 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:45685 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903647Ab2DLPAt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Apr 2012 17:00:49 +0200
Received: (qmail 2917 invoked by uid 2102); 12 Apr 2012 11:00:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Apr 2012 11:00:45 -0400
Date:   Thu, 12 Apr 2012 11:00:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, <ralf@linux-mips.org>,
        <linux-usb@vger.kernel.org>, Chris Dearman <chris@mips.com>
Subject: Re: [PATCH v3 10/10] usb: host: mips: sead3: USB Host controller
 support for SEAD-3 platform.
In-Reply-To: <1334175197-9049-1-git-send-email-sjhill@mips.com>
Message-ID: <Pine.LNX.4.44L0.1204121056330.1496-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 11 Apr 2012, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Add EHCI driver for MIPS SEAD-3 development platform.
> 
> Signed-off-by: Chris Dearman <chris@mips.com>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

Even better than before.  But...

> +const struct hc_driver ehci_sead3_hc_driver = {
> +	.description		= hcd_name,
> +	.product_desc		= "SEAD-3 EHCI",
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
> +	.reset			= ehci_setup,

You no longer care about the ehci->need_io_watchdog setting?

> +static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
> +{
> +	struct usb_hcd *hcd;
> +	struct ehci_hcd *ehci;
> +	struct resource *res;
> +	int ret;
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> +		pr_debug("resource[1] is not IORESOURCE_IRQ");
> +		return -ENOMEM;
> +	}
> +	hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");
> +	if (!hcd)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	hcd->rsrc_start = res->start;
> +	hcd->rsrc_len = resource_size(res);
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
> +	ehci = hcd_to_ehci(hcd);
> +	ehci->caps = hcd->regs + 0x100;
> +	ehci->regs = hcd->regs + 0x100 +
> +		HC_LENGTH(ehci, readl(&ehci->caps->hc_capbase));
> +	/* cache this readonly data; minimize chip reads */
> +	ehci->hcs_params = readl(&ehci->caps->hcs_params);

The last four lines above are duplicates of code that is already
present in ehci_setup.

Alan Stern

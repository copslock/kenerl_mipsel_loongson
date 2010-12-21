Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 17:00:10 +0100 (CET)
Received: from netrider.rowland.org ([192.131.102.5]:50186 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1492663Ab0LUQAF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 17:00:05 +0100
Received: (qmail 32521 invoked by uid 500); 21 Dec 2010 11:00:02 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Dec 2010 11:00:02 -0500
Date:   Tue, 21 Dec 2010 11:00:02 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Anoop P <anoop.pa@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, <gregkh@suse.de>,
        <dbrownell@users.sourceforge.net>, <sarah.a.sharp@linux.intel.com>,
        <andiry.xu@amd.com>, <agust@denx.de>, <ddaney@caviumnetworks.com>,
        <gadiyar@ti.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] EHCI support for on-chip PMC MSP USB controller.
In-Reply-To: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1012211050470.31667-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+4d08bae8@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Tue, 21 Dec 2010, Anoop P wrote:

> From: Anoop P A <anoop.pa@gmail.com>
> 
> This patch includes.
> 
> 1. USB host driver for MSP71xx family SoC on-chip USB controller.
> 2. Platform support for USB controller.

It also contains changes to the core USB hub driver code.  You should 
mention things like that in the patch description.

...

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 27115b4..f2a45ba 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3377,12 +3377,43 @@ static void hub_events(void)
>  			}
>  			
>  			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
> +#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
> +#define OVER_CURR_DELAY 100

What happens if CONFIG_USB_EHCI_HCD_PMC_MSP is defined, but an 
overcurrent status is detected on an external hub instead of the root 
hub?

> +				/* clear OCC bit */
> +				clear_port_feature(hdev, i,
> +					USB_PORT_FEAT_C_OVER_CURRENT);
> +
> +				/* This step is required to toggle the PP bit
> +				 * to 0 and 1 (by hub_power_on) in order the
> +				 * CSC bit to be transitioned
> +				 * properly for device hotplug
> +				 */
> +				/* clear PP bit */
> +				clear_port_feature(hdev, i,
> +				USB_PORT_FEAT_POWER);
> +
> +				/* resume power */
> +				hub_power_on(hub, true);
> +
> +				/* delay 100 usec */
> +				udelay(OVER_CURR_DELAY);
> +
> +				/* read OCA bit */
> +				if (portstatus &
> +					(1<<USB_PORT_FEAT_OVER_CURRENT)) {
> +					/* declare overcurrent */
> +					dev_err(hub_dev,
> +						"over-current change on port %d\n",
> +						i);
> +				}
> +#else
>  				dev_err (hub_dev,
>  					"over-current change on port %d\n",
>  					i);
>  				clear_port_feature(hdev, i,
>  					USB_PORT_FEAT_C_OVER_CURRENT);
>  				hub_power_on(hub, true);
> +#endif
>  			}

"#ifdef" inside code like this is strongly discouraged.  This should be 
written using a separate subroutine.

...

> diff --git a/drivers/usb/host/ehci-pmcmsp.c b/drivers/usb/host/ehci-pmcmsp.c
> new file mode 100644
> index 0000000..b1b4f21
> --- /dev/null
> +++ b/drivers/usb/host/ehci-pmcmsp.c

> +static const struct hc_driver ehci_msp_hc_driver = {
> +	.description =		hcd_name,
> +	.product_desc =		"PMC MSP EHCI",
> +	.hcd_priv_size =	sizeof(struct ehci_hcd),
> +
> +	/*
> +	 * generic hardware linkage
> +	 */
> +#ifdef CONFIG_MSP_HAS_DUAL_USB
> +	.irq =			ehci_msp_irq,
> +#else
> +	.irq =			ehci_irq,
> +#endif
> +	.flags =		HCD_MEMORY | HCD_USB2,
> +
> +	/*
> +	 * basic lifecycle operations
> +	 */
> +	.reset =		ehci_msp_setup,
> +	.start =		ehci_run,
> +#ifdef	CONFIG_PM
> +	.suspend =		ehci_msp_suspend,
> +	.resume =		ehci_msp_resume,
> +#endif /*CONFIG_PM*/
> +	.stop =			ehci_stop,
> +
> +	/*
> +	 * managing i/o requests and associated device resources
> +	 */
> +	.urb_enqueue =		ehci_urb_enqueue,
> +	.urb_dequeue =		ehci_urb_dequeue,
> +	.endpoint_disable =	ehci_endpoint_disable,
> +
> +	/*
> +	 * scheduling support
> +	 */
> +	.get_frame_number =	ehci_get_frame,
> +
> +	/*
> +	 * root hub support
> +	 */
> +	.hub_status_data =	ehci_hub_status_data,
> +	.hub_control =		ehci_hub_control,
> +};

This appears to have been copied from a really old version of 
ehci-pci.c.  You should start with the most up-to-date code.

Alan Stern

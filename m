Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2011 16:11:17 +0100 (CET)
Received: from co202.xi-lite.net ([149.6.83.202]:48318 "EHLO co202.xi-lite.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491773Ab1BIPLO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Feb 2011 16:11:14 +0100
Received: from ONYX.xi-lite.lan (unknown [193.34.35.244])
        by co202.xi-lite.net (Postfix) with ESMTPS id 6C2842602B6;
        Wed,  9 Feb 2011 17:19:09 +0100 (CET)
Received: from [172.20.223.18] (84.14.91.202) by mail.xi-lite.com
 (193.34.32.105) with Microsoft SMTP Server (TLS) id 8.1.336.0; Wed, 9 Feb
 2011 15:16:26 +0000
Message-ID: <4D52AE7E.8000907@parrot.com>
Date:   Wed, 9 Feb 2011 16:10:54 +0100
From:   Matthieu CASTET <matthieu.castet@parrot.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100228)
MIME-Version: 1.0
To:     Anoop P.A <anoop.pa@gmail.com>
CC:     "gregkh@suse.de" <gregkh@suse.de>,
        "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
        "ust@denx.de" <ust@denx.de>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gadiyar@ti.com" <gadiyar@ti.com>,
        "alek.du@intel.com" <alek.du@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v3] EHCI bus glue for on-chip PMC MSP USB controller.
References: <AANLkTimu_gzsd3NY+HDp7jV+EMtrHGZq7qNc3OedyT3C@mail.gmail.com> <1296127736-28208-1-git-send-email-anoop.pa@gmail.com>
In-Reply-To: <1296127736-28208-1-git-send-email-anoop.pa@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <matthieu.castet@parrot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthieu.castet@parrot.com
Precedence: bulk
X-list: linux-mips

Anoop P.A a écrit :

>  config XPS_USB_HCD_XILINX
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 6fee3cd..a591890 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -262,6 +262,8 @@ static void tdi_reset (struct ehci_hcd *ehci)
>         if (ehci_big_endian_mmio(ehci))
>                 tmp |= USBMODE_BE;
>         ehci_writel(ehci, tmp, reg_ptr);
> +       if (ehci->pmc_msp_tdi)
> +               usb_hcd_tdi_set_mode(ehci);
>  }
This is ugly to add callback to your driver here.
How this will build on other platform, usb_hcd_tdi_set_mode is only 
defined on ehci-pmcmsp.c


> +void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci)
> +{
> +	u8 *base;
> +	u8 *statreg;
> +	u8 *fiforeg;
> +	u32 val;
> +	struct ehci_regs *reg_base = ehci->regs;
> +
> +	/* get register base */
> +	base = (u8 *)reg_base + USB_EHCI_REG_USB_MODE;
> +	statreg = (u8 *)reg_base + USB_EHCI_REG_USB_STATUS;
> +	fiforeg = (u8 *)reg_base + USB_EHCI_REG_USB_FIFO;
> +
> +	/* set the controller to host mode and BIG ENDIAN */
> +	ehci_writel(ehci, (USB_CTRL_MODE_HOST | USB_CTRL_MODE_BIG_ENDIAN
> +		| USB_CTRL_MODE_STREAM_DISABLE), (u32 *)base);
> +
We have done that in tdi_reset, why do you do it again ?


Matthieu

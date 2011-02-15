Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 18:44:54 +0100 (CET)
Received: from co202.xi-lite.net ([149.6.83.202]:54959 "EHLO co202.xi-lite.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491009Ab1BORov (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Feb 2011 18:44:51 +0100
Received: from ONYX.xi-lite.lan (unknown [193.34.35.244])
        by co202.xi-lite.net (Postfix) with ESMTPS id 82800260289;
        Tue, 15 Feb 2011 19:54:53 +0100 (CET)
Received: from [172.20.223.18] (84.14.91.202) by mail.xi-lite.com
 (193.34.32.105) with Microsoft SMTP Server (TLS) id 8.1.336.0; Tue, 15 Feb
 2011 17:43:40 +0000
Message-ID: <4D5ABB65.3090101@parrot.com>
Date:   Tue, 15 Feb 2011 18:44:05 +0100
From:   Matthieu CASTET <matthieu.castet@parrot.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100228)
MIME-Version: 1.0
To:     Anoop P.A <anoop.pa@gmail.com>
CC:     "gregkh@suse.de" <gregkh@suse.de>,
        "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "alek.du@intel.com" <alek.du@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gadiyar@ti.com" <gadiyar@ti.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Greg KH <greg@kroah.com>
Subject: Re: [PATCH v4] EHCI bus glue for on-chip PMC MSP USB controller
References: <1296127736-28208-1-git-send-email-anoop.pa@gmail.com> <1297766591-11919-1-git-send-email-anoop.pa@gmail.com>
In-Reply-To: <1297766591-11919-1-git-send-email-anoop.pa@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <matthieu.castet@parrot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthieu.castet@parrot.com
Precedence: bulk
X-list: linux-mips

Anoop P.A a écrit :
> From: Anoop <paanoop1@paanoop1-desktop.(none)>
> 
> This patch add bus glue for USB controller commonly found in PMC-Sierra MSP71xx family of SoC's.
> Patch includes a tdi reset quirk as well .
> 
> Signed-off-by: Anoop P A <anoop.pa@gmail.com>
> Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
> ---
> Changes.
>  ehci-pmcmsp.c is based on latest ehci-pci.c.Addressed some stylistic issue pointed by Greg.
>  Addressed review comments of Matthieu CASTET.
> 
>  config XPS_USB_HCD_XILINX
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index cbf451a..913e7df 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -260,6 +260,8 @@ static void tdi_reset (struct ehci_hcd *ehci)
>         if (ehci_big_endian_mmio(ehci))
>                 tmp |= USBMODE_BE;
>         ehci_writel(ehci, tmp, reg_ptr);
> +       if (ehci->pmc_msp_tdi)
> +               usb_hcd_tdi_set_mode(ehci);
>  }
> 
 > +#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
 > +extern void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci);
 > +#else
 > +static inline void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci)
 > +{ }
 > +#endif
 > +
 >  /* convert between an HCD pointer and the corresponding EHCI_HCD */
 >  static inline struct ehci_hcd *hcd_to_ehci (struct usb_hcd *hcd)
 >  {
 > --

This won't work it you build CONFIG_USB_EHCI_HCD_PMC_MSP and other ehci 
controller.

A better alternative could something like : 
http://article.gmane.org/gmane.linux.usb.general/42624




> +
> +/* host mode */
> +#define USB_CTRL_MODE_HOST             0x3
> +
> +/* big endian */
> +#define USB_CTRL_MODE_BIG_ENDIAN       0x4
> +
> +/* stream disable*/
> +#define USB_CTRL_MODE_STREAM_DISABLE   0x10
> +
This doesn't seem to be used anymore.


Matthieu

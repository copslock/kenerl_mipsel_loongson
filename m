Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 15:28:33 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:44884 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903614Ab2CLO2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2012 15:28:25 +0100
Received: (qmail 1237 invoked by uid 2102); 12 Mar 2012 10:28:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Mar 2012 10:28:22 -0400
Date:   Mon, 12 Mar 2012 10:28:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Hauke Mehrtens <hauke@hauke-m.de>
cc:     gregkh@linuxfoundation.org, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <m@bues.ch>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 6/7] USB: OHCI: remove old SSB OHCI driver
In-Reply-To: <1331496505-18697-7-git-send-email-hauke@hauke-m.de>
Message-ID: <Pine.LNX.4.44L0.1203121023490.1216-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, 11 Mar 2012, Hauke Mehrtens wrote:

> This is now replaced by the new ssb USB driver, which also supports
> devices with an EHCI controller.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/usb/host/Kconfig    |   13 --
>  drivers/usb/host/ohci-hcd.c |   21 +----
>  drivers/usb/host/ohci-ssb.c |  260 -------------------------------------------
>  3 files changed, 1 insertions(+), 293 deletions(-)
>  delete mode 100644 drivers/usb/host/ohci-ssb.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index eab27d5..665fb89 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -360,19 +360,6 @@ config USB_OHCI_HCD_PCI
>  	  Enables support for PCI-bus plug-in USB controller cards.
>  	  If unsure, say Y.
>  
> -config USB_OHCI_HCD_SSB
> -	bool "OHCI support for Broadcom SSB OHCI core"
> -	depends on USB_OHCI_HCD && (SSB = y || SSB = USB_OHCI_HCD) && EXPERIMENTAL
> -	default n
> -	---help---
> -	  Support for the Sonics Silicon Backplane (SSB) attached
> -	  Broadcom USB OHCI core.
> -
> -	  This device is present in some embedded devices with
> -	  Broadcom based SSB bus.
> -
> -	  If unsure, say N.
> -

I don't like the idea of removing this section entirely.  It will leave 
people wondering what happened to their driver.

Instead, for the next few kernel releases, how about leaving this
section in place and causing it to select USB_OHCI_HCD_PLATFORM?  Maybe 
also add a line to the help section explaining that from now on, this 
driver has been replaced by the generic OHCI platform driver.

And likewise for the SSB EHCI driver, of course.

Alan Stern

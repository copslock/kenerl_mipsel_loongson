Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 20:28:23 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:54576 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S23990845AbeCZS2LrmzY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2018 20:28:11 +0200
Received: (qmail 2376 invoked by uid 2102); 26 Mar 2018 14:28:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Mar 2018 14:28:09 -0400
Date:   Mon, 26 Mar 2018 14:28:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Alban Bedel <albeu@free.fr>
cc:     linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Elder <elder@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: Remove the deprecated ATH79 USB host config
 options
In-Reply-To: <1521931644-31326-1-git-send-email-albeu@free.fr>
Message-ID: <Pine.LNX.4.44L0.1803261427380.1382-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+5aab093e@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
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

On Sat, 24 Mar 2018, Alban Bedel wrote:

> The options USB_EHCI_ATH79 and USB_OHCI_ATH79 only enable the
> generic EHCI and OHCI platform drivers, and have been marked as
> deprecated since 2012.
> 
> These can be safely removed if we make sure that USB_EHCI_ROOT_HUB_TT
> still get enabled for the EHCI driver. This is now done be selecting
> this option when the EHCI platform driver is enabled on the ATH79
> platform.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/Kconfig        |  1 +
>  drivers/usb/host/Kconfig | 25 -------------------------
>  2 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8128c3b..61e9a24 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -200,6 +200,7 @@ config ATH79
>  	select SYS_SUPPORTS_MIPS16
>  	select SYS_SUPPORTS_ZBOOT_UART_PROM
>  	select USE_OF
> +	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
>  	help
>  	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
>  
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 4fcfb30..55b45dc 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -293,19 +293,6 @@ config USB_CNS3XXX_EHCI
>  	  It is needed for high-speed (480Mbit/sec) USB 2.0 device
>  	  support.
>  
> -config USB_EHCI_ATH79
> -	bool "EHCI support for AR7XXX/AR9XXX SoCs (DEPRECATED)"
> -	depends on (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X)
> -	select USB_EHCI_ROOT_HUB_TT
> -	select USB_EHCI_HCD_PLATFORM
> -	default y
> -	---help---
> -	  This option is deprecated now and the driver was removed, use
> -	  USB_EHCI_HCD_PLATFORM instead.
> -
> -	  Enables support for the built-in EHCI controller present
> -	  on the Atheros AR7XXX/AR9XXX SoCs.
> -
>  config USB_EHCI_HCD_PLATFORM
>  	tristate "Generic EHCI driver for a platform device"
>  	default n
> @@ -489,18 +476,6 @@ config USB_OHCI_HCD_DAVINCI
>  	  controller. This driver cannot currently be a loadable
>  	  module because it lacks a proper PHY abstraction.
>  
> -config USB_OHCI_ATH79
> -	bool "USB OHCI support for the Atheros AR71XX/AR7240 SoCs (DEPRECATED)"
> -	depends on (SOC_AR71XX || SOC_AR724X)
> -	select USB_OHCI_HCD_PLATFORM
> -	default y
> -	help
> -	  This option is deprecated now and the driver was removed, use
> -	  USB_OHCI_HCD_PLATFORM instead.
> -
> -	  Enables support for the built-in OHCI controller present on the
> -	  Atheros AR71XX/AR7240 SoCs.
> -
>  config USB_OHCI_HCD_PPC_OF_BE
>  	bool "OHCI support for OF platform bus (big endian)"
>  	depends on PPC

For the EHCI and OHCI portions:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

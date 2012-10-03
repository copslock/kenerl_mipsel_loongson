Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 15:38:15 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:39920 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S6870386Ab2JDNgmO66dE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 15:36:42 +0200
Received: (qmail 2898 invoked by uid 2102); 3 Oct 2012 12:47:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2012 12:47:58 -0400
Date:   Wed, 3 Oct 2012 12:47:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Florian Fainelli <florian@openwrt.org>
cc:     linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/25] MIPS: Netlogic: use ehci-platform driver
In-Reply-To: <1349276601-8371-5-git-send-email-florian@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1210031151300.1441-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34599
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 3 Oct 2012, Florian Fainelli wrote:

> Signed-off-by: Florian Fainelli <florian@openwrt.org>

IMO, patches should always have a non-empty changelog.  Even if it is 
relatively trivial.  The same comment applies to several other patches 
in this series.

> ---
>  arch/mips/netlogic/xlr/platform.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Does this need to enable CONFIG_USB_EHCI_HCD_PLATFORM is some 
defconfig file, like you did with the MIPS Loongson 1B?

And likewise for quite a few of the other patches in this series.

> diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
> index 71b44d8..1731dfd 100644
> --- a/arch/mips/netlogic/xlr/platform.c
> +++ b/arch/mips/netlogic/xlr/platform.c
> @@ -15,6 +15,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
>  #include <linux/i2c.h>
> +#include <linux/usb/ehci_pdriver.h>
>  
>  #include <asm/netlogic/haldefs.h>
>  #include <asm/netlogic/xlr/iomap.h>
> @@ -123,6 +124,10 @@ static u64 xls_usb_dmamask = ~(u32)0;
>  		},							\
>  	}
>  
> +static struct usb_ehci_pdata xls_usb_ehci_pdata = {
> +	.caps_offset	= 0,
> +};
> +
>  static struct platform_device xls_usb_ehci_device =
>  			 USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
>  static struct platform_device xls_usb_ohci_device_0 =
> @@ -172,6 +177,7 @@ int xls_platform_usb_init(void)
>  	memres = CPHYSADDR((unsigned long)usb_mmio);
>  	xls_usb_ehci_device.resource[0].start = memres;
>  	xls_usb_ehci_device.resource[0].end = memres + 0x400 - 1;
> +	xls_usb_ehci_device.dev.platform_data = &xls_usb_ehci_pdata;
>  
>  	memres += 0x400;
>  	xls_usb_ohci_device_0.resource[0].start = memres;

Don't you need to change/set the pdev name also?  Likewise for patch 
20/25 and 24/25.

Alan Stern

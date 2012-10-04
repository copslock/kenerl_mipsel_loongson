Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 12:54:30 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:60702 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870457Ab2JDKyQBDQJJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 12:54:16 +0200
Received: by mail-oa0-f49.google.com with SMTP id l10so324234oag.36
        for <multiple recipients>; Thu, 04 Oct 2012 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eKslMpOgp4ZL8HjzbCZPyhKdJqVVyY+8w2VI/Tj0oY0=;
        b=IGLhhqyYLCSrGVFQwIZr5y1645dz4yLtsdP3oTK+FthIl5s3Hw2qlDh87k7n2zSrHO
         oWtCXRRPtpHyyNyuxwiXcJ5w8kwhTuOmJ281fx254o+FXZir2HDGxdOiPhhxI2xrHm2Z
         PKODYUgjhLK0RTXTM1hy6b/+eGeFvt5WiWWm0XJp5Sdb/hfDmcF2lUBsdS8fI8qva1eO
         0/tvHFKMyg9Sp9dcNDVS+NLv4fqA/2D4RPexLLr/jjM/Nq8VOsTxOubQCBwEXHgOFZma
         YCqLmkVg0zrUfF4T0B2j5vXdrX47+JFp092uKI5tPCiSizL5oxmEQ0tE+mPsB/MpTHqS
         cpBA==
Received: by 10.182.172.74 with SMTP id ba10mr3842130obc.83.1349348049801;
 Thu, 04 Oct 2012 03:54:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.3.15 with HTTP; Thu, 4 Oct 2012 03:53:49 -0700 (PDT)
In-Reply-To: <1349276601-8371-22-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-22-git-send-email-florian@openwrt.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 4 Oct 2012 12:53:49 +0200
Message-ID: <CAOiHx==kUd4MCF7iKOPitEEgrXR+_oJL0jCPHvoJ+s90eG1xdg@mail.gmail.com>
Subject: Re: [PATCH 20/25] MIPS: Netlogic: convert to use OHCI platform driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 3 October 2012 17:03, Florian Fainelli <florian@openwrt.org> wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/netlogic/xlr/platform.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
> index 320b7ef..755ddcc 100644
> --- a/arch/mips/netlogic/xlr/platform.c
> +++ b/arch/mips/netlogic/xlr/platform.c
> @@ -16,6 +16,7 @@
>  #include <linux/serial_reg.h>
>  #include <linux/i2c.h>
>  #include <linux/usb/ehci_pdriver.h>
> +#include <linux/usb/ohci_pdriver.h>
>
>  #include <asm/netlogic/haldefs.h>
>  #include <asm/netlogic/xlr/iomap.h>
> @@ -129,6 +130,8 @@ static struct usb_ehci_pdata xls_usb_ehci_pdata = {
>         .need_io_watchdog = 1,
>  };
>
> +static struct usb_ohci_pdata xls_usb_ohci_pdata;
> +
>  static struct platform_device xls_usb_ehci_device =
>                          USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
>  static struct platform_device xls_usb_ohci_device_0 =

And change after the device names of the ohci devices to "ohci-platform"?

> @@ -183,10 +186,12 @@ int xls_platform_usb_init(void)
>         memres += 0x400;
>         xls_usb_ohci_device_0.resource[0].start = memres;
>         xls_usb_ohci_device_0.resource[0].end = memres + 0x400 - 1;
> +       xls_usb_ohci_device_0.dev.platform_data = &xls_usb_ohci_pdata;
>
>         memres += 0x400;
>         xls_usb_ohci_device_1.resource[0].start = memres;
>         xls_usb_ohci_device_1.resource[0].end = memres + 0x400 - 1;
> +       xls_usb_ohci_device_1.dev.platform_data = &xls_usb_ohci_pdata;
>
>         return platform_add_devices(xls_platform_devices,
>                                 ARRAY_SIZE(xls_platform_devices));
> --
> 1.7.9.5

Jonas

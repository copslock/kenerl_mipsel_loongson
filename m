Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 12:51:42 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52402 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870431Ab2JDKv1oyb10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 12:51:27 +0200
Received: by mail-ob0-f177.google.com with SMTP id wd20so319513obb.36
        for <multiple recipients>; Thu, 04 Oct 2012 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rCLrRet5mMz4nCEWxVkXl64h+UR93755sKMeuvqjk1M=;
        b=nTDd4c2MBhXmcnsQllY7Wy5AT+JRyqabfheMXymey0cx511ZYfr5rLTSVX8R2tP5yU
         9/Wi7VKEcYOm7vYuJzL8lhFuDpAguW97FiijfLxr7JPDmx+TzUfT8D3w2lAgAHgDTTSD
         MkpMByFuTXsZLvb0eP1rMiVkqchrz6PVDBVTmk2BIg0oRT8DkhWm25M6JZJQxEE5LJ+n
         Wc2z7iPRRubwXocA8m+14SP6Wkd/xDoyHmnLmTzDEGA0GjDKlzYQMwdYPuz2KLQsRgIo
         4WhDkgkxHc4eX0tCm9qswkI//4GXKvOvJWtvUraahApMVE1YsszdugNb166K1q7fDFca
         9IVg==
Received: by 10.60.11.162 with SMTP id r2mr3756741oeb.114.1349347881376; Thu,
 04 Oct 2012 03:51:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.3.15 with HTTP; Thu, 4 Oct 2012 03:51:01 -0700 (PDT)
In-Reply-To: <1349276601-8371-5-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-5-git-send-email-florian@openwrt.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 4 Oct 2012 12:51:01 +0200
Message-ID: <CAOiHx==UaweOJ2sCqkRvW3KWVeGFGoi_YwreNWBo99_Xswv=Kg@mail.gmail.com>
Subject: Re: [PATCH 04/25] MIPS: Netlogic: use ehci-platform driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34588
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

On 3 October 2012 17:02, Florian Fainelli <florian@openwrt.org> wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/netlogic/xlr/platform.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
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
>                 },                                                      \
>         }
>
> +static struct usb_ehci_pdata xls_usb_ehci_pdata = {
> +       .caps_offset    = 0,
> +};
> +
>  static struct platform_device xls_usb_ehci_device =
>                          USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);

Don't you also need to change this to "ehci-platform"?

>  static struct platform_device xls_usb_ohci_device_0 =
> @@ -172,6 +177,7 @@ int xls_platform_usb_init(void)
>         memres = CPHYSADDR((unsigned long)usb_mmio);
>         xls_usb_ehci_device.resource[0].start = memres;
>         xls_usb_ehci_device.resource[0].end = memres + 0x400 - 1;
> +       xls_usb_ehci_device.dev.platform_data = &xls_usb_ehci_pdata;
>
>         memres += 0x400;
>         xls_usb_ohci_device_0.resource[0].start = memres;
> --
> 1.7.9.5

Jonas

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 13:35:21 +0200 (CEST)
Received: from mail-yh0-f49.google.com ([209.85.213.49]:40050 "EHLO
        mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871126Ab2JDLfFpTlE6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 13:35:05 +0200
Received: by mail-yh0-f49.google.com with SMTP id j52so32848yhj.36
        for <multiple recipients>; Thu, 04 Oct 2012 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gz3/6vFgAP+EwgkF1kgusgPhq2i4IdusC7rozyWrBUk=;
        b=HxtO8Efc5AefLZMvWPrIDjLPltNN5FkIl3DezJL0PBtX2KNl/p6tyBAfdcim5qfRJb
         WywIx9BXrUPn851Kln1OlVoymKF9clcN1agVrVWQDKJUvmws/oYWPIVuGgOHG++rdMjY
         uFuwh4w4MGmo1b0sCwKLHbPrNth/MUGepAXsGmYDJKLEpyIDwZFycXnmkjCiUi5/hTcF
         Wm1mefup8cLlLK4NqEuKr3wG9LRXCPDzavIfD6Dd5jnpo76k1VOpqGW65caaoOFqdLf7
         wv+i6hf1bYw1yFuTxdSNrjgnL5wNa9aUgRuk743ZopU/UdNYRws5XK6GI9E/a8F7Tevy
         mtYQ==
Received: by 10.236.170.135 with SMTP id p7mr2270839yhl.109.1349280488896;
 Wed, 03 Oct 2012 09:08:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.176.229 with HTTP; Wed, 3 Oct 2012 09:07:28 -0700 (PDT)
In-Reply-To: <1349276601-8371-26-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-26-git-send-email-florian@openwrt.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 3 Oct 2012 18:07:28 +0200
Message-ID: <CAOLZvyEcFePtAhcX4r32VvemWqriuyVfkE8b-AAL=xWOww+=7g@mail.gmail.com>
Subject: Re: [PATCH 24/25] MIPS: Alchemy: use the OHCI platform driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, Oct 3, 2012 at 5:03 PM, Florian Fainelli <florian@openwrt.org> wrote:
> This also greatly simplifies the power_{on,off} callbacks and make them
> work on platform device id instead of checking the OHCI controller base
> address like what was done in ohci-au1xxx.c.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/alchemy/common/platform.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 57335a2..cd12458 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -18,6 +18,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/slab.h>
>  #include <linux/usb/ehci_pdriver.h>
> +#include <linux/usb/ohci_pdriver.h>
>
>  #include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> @@ -142,6 +143,34 @@ static struct usb_ehci_pdata alchemy_ehci_pdata = {
>         .power_suspend          = alchemy_ehci_power_off,
>  };
>
> +/* Power on callback for the ohci platform driver */
> +static int alchemy_ohci_power_on(struct platform_device *pdev)
> +{
> +       int unit;
> +
> +       unit = (pdev->id == 1) ?
> +               ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
> +
> +       return alchemy_usb_control(unit, 1);
> +}
> +
> +/* Power off/suspend callback for the ohci platform driver */
> +static void alchemy_ohci_power_off(struct platform_device *pdev)
> +{
> +       int unit;
> +
> +       unit = (pdev->id == 1) ?
> +               ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
> +
> +       alchemy_usb_control(unit, 0);
> +}
> +
> +static struct usb_ohci_pdata alchemy_ohci_pdata = {
> +       .power_on               = alchemy_ohci_power_on,
> +       .power_off              = alchemy_ohci_power_off,
> +       .power_suspend          = alchemy_ohci_power_off,
> +};
> +
>  static unsigned long alchemy_ohci_data[][2] __initdata = {
>         [ALCHEMY_CPU_AU1000] = { AU1000_USB_OHCI_PHYS_ADDR, AU1000_USB_HOST_INT },
>         [ALCHEMY_CPU_AU1500] = { AU1000_USB_OHCI_PHYS_ADDR, AU1500_USB_HOST_INT },
> @@ -192,6 +221,7 @@ static void __init alchemy_setup_usb(int ctype)
>         pdev->name = "au1xxx-ohci";

Should be "ohci-platform" (2x).  With this change USB works on all my
Alchemy boards.
I'd also suggest to move drivers/usb/host/alchemy-common.c to
arch/mips/alchemy/common/usb.c.
(same for octeon2-common.c)

Manuel

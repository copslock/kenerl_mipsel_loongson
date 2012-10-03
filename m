Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 14:19:59 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:45780 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870370Ab2JDMTwN8Xi5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 14:19:52 +0200
Received: by mail-gg0-f177.google.com with SMTP id h1so56327gge.36
        for <multiple recipients>; Thu, 04 Oct 2012 05:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FPlfk/B8izx1anehGg3j6PzGHNf06NbsbVx9eLP1e4w=;
        b=y5EBoKDcf+2YNKpLMGO5OIC0r8zHPslAcVexSdNM73WYopoFFXlX+xHY+aSOW2gJIK
         AP9yYD9gi+ZFaYx15AAylXVhne5+SLeKsj40Pqvp4itwMHvQ656ftjB6d4I3SEF7wWka
         aEHVGLSzNviF3X4kcbOqczYJNqcRfl6puHXH8XIBEf8ICoZuJh3IAjS92Yjtcxz4zw49
         QI4X0k/oxg3ZxKjCC06JmcSE+bxG3XfSK0XL4w7L2DpIvlMx1UzFx1tjCnMfnLjTssC/
         lRrNTrjFep9PPcmSoTdIbXaPucslE8day1ltQnmFg47Apxa/58OzAaVXXg6AaDJ7Y0Xg
         2/yg==
Received: by 10.236.76.234 with SMTP id b70mr2190106yhe.31.1349277301636; Wed,
 03 Oct 2012 08:15:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.176.229 with HTTP; Wed, 3 Oct 2012 08:14:21 -0700 (PDT)
In-Reply-To: <1349276601-8371-8-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-8-git-send-email-florian@openwrt.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 3 Oct 2012 17:14:21 +0200
Message-ID: <CAOLZvyEfagtJSQyL7MHkw+40NYbmFtT35Y4b8pGNUNc6dTzS=Q@mail.gmail.com>
Subject: Re: [PATCH 07/25] MIPS: Alchemy: use the ehci platform driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34597
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
> Use the ehci platform driver power_{on,suspend,off} callbacks to perform the
> USB block gate enabling/disabling as what the ehci-au1xxx.c driver does.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/alchemy/common/platform.c |   23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index c0f3ce6..57335a2 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/serial_8250.h>
>  #include <linux/slab.h>
> +#include <linux/usb/ehci_pdriver.h>
>
>  #include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> @@ -122,6 +123,25 @@ static void __init alchemy_setup_uarts(int ctype)
>  static u64 alchemy_ohci_dmamask = DMA_BIT_MASK(32);
>  static u64 __maybe_unused alchemy_ehci_dmamask = DMA_BIT_MASK(32);
>
> +/* Power on callback for the ehci platform driver */
> +static int alchemy_ehci_power_on(struct platform_device *pdev)
> +{
> +       return alchemy_usb_control(ALCHEMY_USB_EHCI0, 1);
> +}
> +
> +/* Power off/suspend callback for the ehci platform driver */
> +static void alchemy_ehci_power_off(struct platform_device *pdev)
> +{
> +       alchemy_usb_control(ALCHEMY_USB_EHCI0, 0);
> +}
> +
> +static struct usb_ehci_pdata alchemy_ehci_pdata = {
> +       .need_io_watchdog       = 0,

This member doesn't exist.

Manuel

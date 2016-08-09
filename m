Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 16:09:25 +0200 (CEST)
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35103 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993098AbcHIOJOYIwCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 16:09:14 +0200
Received: by mail-ua0-f196.google.com with SMTP id 109so1060713uat.2;
        Tue, 09 Aug 2016 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uL60TrrZcF08KG8718Zn63OiBp7dhPwWeFxrMO3UJa0=;
        b=JL2dQUKTDAynUwNPG4roF2cBGpQYrfDmA46K5UI0oKzeTV8ySE1BpPoNqqOHvJJWHY
         1i7pVKay4VpZBfmBeXQMc0ERuWzKPDNUF0mkF1GX0Dnw4z60IwXrOFIEgklvvpNdpw1/
         8PZRiGepR2hKIImzN+rlF4+EdZjoBzqv/TphG0LuZtXPqB2aEyYD53UIj/KefOHEslEJ
         FlvYTkBnn1ccNVznNWDyurTym005F+B7jM7tj15Aj7BSvyH7aUTM54awj1w2sQ8MsJSE
         UvVSRvi1orxGBaxPkbilUfqcx2c2tRa4COICt+3nYgaYu1VXw0GS82uLkDi00bxHUPKv
         noFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uL60TrrZcF08KG8718Zn63OiBp7dhPwWeFxrMO3UJa0=;
        b=ilB2G+locXcFXBRFfmxhugR3SmnNYJyWm+ELzDPAhQOyaNTdNHbacbhRG/7B5T0AsN
         UKrdfExONHuZmALds5eGH6dJcBXhxTzHRFoatSmjX7yuFoJBkpmahTVMBUEurJ/TgOBS
         EchreZw+2W/NznoFS028Uk8pdXtTjg+egYGywFjeJrqVLdFlXcB6+STtiabrf/l/BIk2
         5hgE0bm4LN4PLuRRtbg1qnChC0mwbV5x2Ar9DNUIpFrkOXN4Dma7ErLeBBc34TySIDcP
         Bz7b9lESuGs1POAU8eFbww2NYzO72nBO/QwoD0H0C1VleIiHGemaTbGeuuPQvyfHirAv
         g5sw==
X-Gm-Message-State: AEkoouv8V4Rzemk/sQOKHNNWxo15Ry7Ymts4K1bJRqRbKvHILk25FMDHT/GmCw5q4+/T0w851SxBNzcrFuG+hg==
X-Received: by 10.31.74.199 with SMTP id x190mr50585530vka.42.1470751748464;
 Tue, 09 Aug 2016 07:09:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.129 with HTTP; Tue, 9 Aug 2016 07:08:48 -0700 (PDT)
In-Reply-To: <20160809123546.10190-7-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com> <20160809123546.10190-7-paul.burton@imgtec.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 9 Aug 2016 16:08:48 +0200
Message-ID: <CAOiHx=mmB8C7rn24=RekjvX8dusyNbj6i9U06fM3gurSLtCang@mail.gmail.com>
Subject: Re: [PATCH 06/20] usb: host: ehci-sead3: Support probing using device tree
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54459
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

Hi,

On 9 August 2016 at 14:35, Paul Burton <paul.burton@imgtec.com> wrote:
> Introduce support for probing the SEAD3 EHCI driver using device tree.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  drivers/usb/host/ehci-sead3.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
> index 3d86cc2..05db1ae 100644
> --- a/drivers/usb/host/ehci-sead3.c
> +++ b/drivers/usb/host/ehci-sead3.c
> @@ -20,6 +20,7 @@
>   */
>
>  #include <linux/err.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>
>  static int ehci_sead3_setup(struct usb_hcd *hcd)
> @@ -96,15 +97,25 @@ static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
>  {
>         struct usb_hcd *hcd;
>         struct resource *res;
> -       int ret;
> +       int ret, irq;
>
>         if (usb_disabled())
>                 return -ENODEV;
>
> -       if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> -               pr_debug("resource[1] is not IORESOURCE_IRQ");
> -               return -ENOMEM;
> +       if (pdev->dev.of_node) {
> +               irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +               if (!irq) {
> +                       dev_err(&pdev->dev, "failed to map IRQ\n");
> +                       return -ENODEV;
> +               }
> +       } else {
> +               if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> +                       pr_debug("resource[1] is not IORESOURCE_IRQ");
> +                       return -ENOMEM;
> +               }
> +               irq = pdev->resource[1].start;
>         }
> +

Why not just use platform_get_irq(pdev, 0) instead of this whole
block? Then you wouldn't need to care anymore whether resource 1 is
the IRQ resource (and avoid a potential overrun when the device has
only one resource), or if it is probed through of.

>         hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");
>         if (!hcd)
>                 return -ENOMEM;
> @@ -121,8 +132,7 @@ static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
>         /* Root hub has integrated TT. */
>         hcd->has_tt = 1;
>
> -       ret = usb_add_hcd(hcd, pdev->resource[1].start,
> -                         IRQF_SHARED);
> +       ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>         if (ret == 0) {
>                 platform_set_drvdata(pdev, hcd);
>                 device_wakeup_enable(hcd->self.controller);
> @@ -172,12 +182,19 @@ static const struct dev_pm_ops sead3_ehci_pmops = {
>  #define SEAD3_EHCI_PMOPS NULL
>  #endif
>
> +static const struct of_device_id sead3_ehci_of_match[] = {
> +       { .compatible = "mti,sead3-ehci" },

I don't see this compatible documented anywhere, please add binding
documentation for it first (and CC devicetree@vger ).

> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, sead3_ehci_of_match);
> +
>  static struct platform_driver ehci_hcd_sead3_driver = {
>         .probe          = ehci_hcd_sead3_drv_probe,
>         .remove         = ehci_hcd_sead3_drv_remove,
>         .shutdown       = usb_hcd_platform_shutdown,
>         .driver = {
>                 .name   = "sead3-ehci",
> +               .of_match_table = sead3_ehci_of_match,
>                 .pm     = SEAD3_EHCI_PMOPS,
>         }
>  };

Regards
Jonas

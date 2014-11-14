Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 05:45:05 +0100 (CET)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:56493 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009680AbaKNEpES9nv9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 05:45:04 +0100
Received: by mail-ig0-f182.google.com with SMTP id hn18so902566igb.9
        for <linux-mips@linux-mips.org>; Thu, 13 Nov 2014 20:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tyMjBV6iBjwTY3TjUuBPv4BoAYm8qEld58LWt7JyVSQ=;
        b=ZjN/U+JHtsySj7mOvcK8lDbw4x6NgeQc7QeJaYs/SowTATLx/Q9bCG6Ej14MNrgV3K
         EbX6xJ/zAJdzDe8uhFx0N89Psv0B+D8tC2nnYQOVHO377xhoPpLZnowmcvp/OpINI4NM
         ILYwpsTca1ZipJYhKJyDVTOsUrltQVmXbq1DIzKYwiiy6EM93CBNVfy5NYre9MokTSWP
         UlpXYMZYNDE5MG4Xw5F0KTOLmYq1aF9FSFMbTOwlKt2QkAJ333xXHogWDQUjeAD6PDqy
         aIZIWmVfOPibD82hcMCBSx+qBqSLa2XCPg+QZVC4zeDC9iyZwH/UqrZyocnWIi+0bccL
         pFtA==
X-Received: by 10.50.25.100 with SMTP id b4mr3500624igg.17.1415940298244; Thu,
 13 Nov 2014 20:44:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.14.16 with HTTP; Thu, 13 Nov 2014 20:44:17 -0800 (PST)
In-Reply-To: <1415914590-31647-4-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-4-git-send-email-andreas.herrmann@caviumnetworks.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 13 Nov 2014 20:44:17 -0800
Message-ID: <CAGVrzcbAjMGBdTenpJv6_OQ4oPYGScQ0gMOFsO8gf-R7Wy-=Lg@mail.gmail.com>
Subject: Re: [PATCH 3/3] USB: host: Introduce flag to enable use of 64-bit
 dma_mask for ehci-platform
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-11-13 13:36 GMT-08:00 Andreas Herrmann
<andreas.herrmann@caviumnetworks.com>:
> ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
> and usage of ehci-platform ehci dma_mask is now limited to 32 bits
> (coerced in ehci_platform_probe).
>
> Provide a flag in ehci platform data to allow use of 64 bits for
> dma_mask.

Why not just allow enforcing an arbitrary DMA mask?

>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c |    4 +---
>  drivers/usb/host/ehci-platform.c          |    3 ++-
>  include/linux/usb/ehci_pdriver.h          |    1 +
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index eea60b6..12410a2 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -310,6 +310,7 @@ static struct usb_ehci_pdata octeon_ehci_pdata = {
>  #ifdef __BIG_ENDIAN
>         .big_endian_mmio        = 1,
>  #endif
> +       .dma_mask_64    = 1,
>         .power_on       = octeon_ehci_power_on,
>         .power_off      = octeon_ehci_power_off,
>  };
> @@ -331,8 +332,6 @@ static void __init octeon_ehci_hw_start(struct device *dev)
>         octeon2_usb_clocks_stop();
>  }
>
> -static u64 octeon_ehci_dma_mask = DMA_BIT_MASK(64);
> -
>  static int __init octeon_ehci_device_init(void)
>  {
>         struct platform_device *pd;
> @@ -347,7 +346,6 @@ static int __init octeon_ehci_device_init(void)
>         if (!pd)
>                 return 0;
>
> -       pd->dev.dma_mask = &octeon_ehci_dma_mask;
>         pd->dev.platform_data = &octeon_ehci_pdata;
>         octeon_ehci_hw_start(&pd->dev);
>
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2da18ea..6df808b 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -155,7 +155,8 @@ static int ehci_platform_probe(struct platform_device *dev)
>         if (!pdata)
>                 pdata = &ehci_platform_defaults;
>
> -       err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
> +       err = dma_coerce_mask_and_coherent(&dev->dev,
> +               pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
>         if (err)
>                 return err;
>
> diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
> index 7eb4dcd..f69529e 100644
> --- a/include/linux/usb/ehci_pdriver.h
> +++ b/include/linux/usb/ehci_pdriver.h
> @@ -45,6 +45,7 @@ struct usb_ehci_pdata {
>         unsigned        big_endian_desc:1;
>         unsigned        big_endian_mmio:1;
>         unsigned        no_io_watchdog:1;
> +       unsigned        dma_mask_64:1;
>
>         /* Turn on all power and clocks */
>         int (*power_on)(struct platform_device *pdev);
> --
> 1.7.9.5
>
>



-- 
Florian

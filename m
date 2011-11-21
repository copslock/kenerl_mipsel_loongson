Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 14:52:36 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:40487 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903752Ab1KUNw2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 14:52:28 +0100
Received: by vcbfo13 with SMTP id fo13so4063232vcb.36
        for <multiple recipients>; Mon, 21 Nov 2011 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZgZqy0zJgndWT8D5nxehhhXuYc9tqRaZrn23E9u8ods=;
        b=rlW8hhAk1VkRNiNaAfK1QOdqSJyVRNfoa1AuvkXWXoNIfiYm/atq3+JJpKxTi3RWu5
         CUvBy2ZirwIU5nR+sJaQlzvPKBJhdnVmsmH/huwAceS/VFy3kY4Ja/3MPPzMirlpX45m
         wdRO/4L4xKE3ENE0KH18k4A2yWNvhIvBXkW1M=
MIME-Version: 1.0
Received: by 10.182.146.72 with SMTP id ta8mr3039413obb.35.1321883542090; Mon,
 21 Nov 2011 05:52:22 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Mon, 21 Nov 2011 05:52:22 -0800 (PST)
In-Reply-To: <1321825151-16053-3-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
        <1321825151-16053-3-git-send-email-juhosg@openwrt.org>
Date:   Mon, 21 Nov 2011 14:52:22 +0100
Message-ID: <CAEWqx59E5gvpO6uGrddeaOOT_+cpWmkHpmV7d8nnQSb-xqK9=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] MIPS: ath79: rename pci-ath724x.h
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17303

Acked-by: Rene Bolldorf <xsecute@googlemail.com>

On Sun, Nov 20, 2011 at 10:39 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The declared function in this header file is used by the
> ath79 platform code only. Move the header to the platform
> directory.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> v3: - move include "pci.h" out of the #ifdef CONFIG_PCI section
> v2: - no changes
> ---
>  arch/mips/ath79/mach-ubnt-xm.c                     |    2 +-
>  arch/mips/ath79/pci.c                              |    2 +-
>  .../asm/mach-ath79/pci-ath724x.h => ath79/pci.h}   |    0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/mips/{include/asm/mach-ath79/pci-ath724x.h => ath79/pci.h} (100%)
>
> diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
> index 3c311a5..a043500 100644
> --- a/arch/mips/ath79/mach-ubnt-xm.c
> +++ b/arch/mips/ath79/mach-ubnt-xm.c
> @@ -15,13 +15,13 @@
>
>  #ifdef CONFIG_PCI
>  #include <linux/ath9k_platform.h>
> -#include <asm/mach-ath79/pci-ath724x.h>
>  #endif /* CONFIG_PCI */
>
>  #include "machtypes.h"
>  #include "dev-gpio-buttons.h"
>  #include "dev-leds-gpio.h"
>  #include "dev-spi.h"
> +#include "pci.h"
>
>  #define UBNT_XM_GPIO_LED_L1            0
>  #define UBNT_XM_GPIO_LED_L2            1
> diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
> index 8db076e..4957428 100644
> --- a/arch/mips/ath79/pci.c
> +++ b/arch/mips/ath79/pci.c
> @@ -9,7 +9,7 @@
>  */
>
>  #include <linux/pci.h>
> -#include <asm/mach-ath79/pci-ath724x.h>
> +#include "pci.h"
>
>  static struct ath724x_pci_data *pci_data;
>  static int pci_data_size;
> diff --git a/arch/mips/include/asm/mach-ath79/pci-ath724x.h b/arch/mips/ath79/pci.h
> similarity index 100%
> rename from arch/mips/include/asm/mach-ath79/pci-ath724x.h
> rename to arch/mips/ath79/pci.h
> --
> 1.7.2.1
>
>

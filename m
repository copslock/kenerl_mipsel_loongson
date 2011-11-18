Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:32:22 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:51849 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904133Ab1KRScM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 19:32:12 +0100
Received: by ghbg15 with SMTP id g15so1038490ghb.36
        for <multiple recipients>; Fri, 18 Nov 2011 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uurAEUQRX9Pkm05KDbDhsw0QwzssIKbfZ3kK7NZHokE=;
        b=kSkT1fKjY3HWblVQScT/ktYer1IF0Pltc8JQAY0oXjPKxxsqB8axZI2OAKNdX/ecgB
         lF624gjC25TdY9lHw6pe0p/Q9Zuj/OwjftS/SaQAKkQwQbmYDP6bxkKquJ/dY83FqKCy
         tOQWCmdevEOxy7v+x4p1iMyJ5ue9YVjUWHaKA=
MIME-Version: 1.0
Received: by 10.182.73.71 with SMTP id j7mr956488obv.55.1321641125908; Fri, 18
 Nov 2011 10:32:05 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Fri, 18 Nov 2011 10:32:05 -0800 (PST)
In-Reply-To: <1321629720-29035-4-git-send-email-juhosg@openwrt.org>
References: <1321629720-29035-1-git-send-email-juhosg@openwrt.org>
        <1321629720-29035-4-git-send-email-juhosg@openwrt.org>
Date:   Fri, 18 Nov 2011 19:32:05 +0100
Message-ID: <CAEWqx59XzDyGWi7q-PYjiXx7t1Jinoz8ygypbk65CmD+zcyW2g@mail.gmail.com>
Subject: Re: [PATCH 4/7] MIPS: ath79: add a common PCI registration function
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15778

On Fri, Nov 18, 2011 at 4:21 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The current code unconditionally registers the AR724X
> specific PCI controller, even if the kernel is running
> on a different SoC.
>
This is not true, take a look in the ath79 Kconfig file...

> Add a common function for PCI controller registration,
> and only register the AR724X PCI controller if the kernel
> is running on an AR724X SoC.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
>  arch/mips/ath79/mach-ubnt-xm.c |    1 +
>  arch/mips/ath79/pci.c          |   14 ++++++++++++++
>  arch/mips/ath79/pci.h          |    6 ++++++
>  arch/mips/pci/pci-ath724x.c    |    2 --
>  4 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
> index 5853bd7..1d44cc2 100644
> --- a/arch/mips/ath79/mach-ubnt-xm.c
> +++ b/arch/mips/ath79/mach-ubnt-xm.c
> @@ -111,6 +111,7 @@ static void __init ubnt_xm_init(void)
>        ath724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
>  #endif /* CONFIG_PCI */
>
> +       ath79_register_pci();
>  }
>
>  MIPS_MACHINE(ATH79_MACH_UBNT_XM,
> diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
> index 4957428..a2dae75 100644
> --- a/arch/mips/ath79/pci.c
> +++ b/arch/mips/ath79/pci.c
> @@ -9,6 +9,8 @@
>  */
>
>  #include <linux/pci.h>
> +#include <asm/mach-ath79/ath79.h>
> +#include <asm/mach-ath79/pci.h>
>  #include "pci.h"
>
>  static struct ath724x_pci_data *pci_data;
> @@ -44,3 +46,15 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>
>        return PCIBIOS_SUCCESSFUL;
>  }
> +
> +int ath79_register_pci(void)
> +{
> +       int ret;
> +
> +       if (soc_is_ar724x())
> +               ret = ath724x_pcibios_init();
> +       else
> +               ret = -ENODEV;
> +
> +       return ret;
> +}
> diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
> index 454885f..4653ca8 100644
> --- a/arch/mips/ath79/pci.h
> +++ b/arch/mips/ath79/pci.h
> @@ -18,4 +18,10 @@ struct ath724x_pci_data {
>
>  void ath724x_pci_add_data(struct ath724x_pci_data *data, int size);
>
> +#ifdef CONFIG_PCI
> +int ath79_register_pci(void);
> +#else
> +static inline int ath79_register_pci(void) {};
> +#endif
> +
>  #endif /* __ASM_MACH_ATH79_PCI_ATH724X_H */
> diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ath724x.c
> index be01b7f..ebefc16 100644
> --- a/arch/mips/pci/pci-ath724x.c
> +++ b/arch/mips/pci/pci-ath724x.c
> @@ -137,5 +137,3 @@ int __init ath724x_pcibios_init(void)
>
>        return PCIBIOS_SUCCESSFUL;
>  }
> -
> -arch_initcall(ath724x_pcibios_init);
> --
> 1.7.2.1
>
>

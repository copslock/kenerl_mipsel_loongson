Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 11:34:29 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:60039 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903549Ab1KWKeZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 11:34:25 +0100
Received: by vbbfs19 with SMTP id fs19so1349091vbb.36
        for <multiple recipients>; Wed, 23 Nov 2011 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yb+ROfgb2gE/bBAHkCsS0yOuuNVpcDzFdlXZXmvxZTM=;
        b=C3zXcSw1pNgxFokBorNi4rHy+xixeWbj5tRJZEWGyr601RC9akTolHV0MBwdT4Qc0c
         boFp49hGGSeomQbLij6ARC+48SbmEXFtRmzgo2+W429aro2mTDRZGLxXuEpo1V7KEUTq
         TM/2po1KtRqXhhnV6ShJhggeAiZEi9qP6S1pE=
MIME-Version: 1.0
Received: by 10.182.146.72 with SMTP id ta8mr8442671obb.35.1322044459084; Wed,
 23 Nov 2011 02:34:19 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Wed, 23 Nov 2011 02:34:18 -0800 (PST)
In-Reply-To: <1321887999-14546-5-git-send-email-juhosg@openwrt.org>
References: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
        <1321887999-14546-5-git-send-email-juhosg@openwrt.org>
Date:   Wed, 23 Nov 2011 11:34:18 +0100
Message-ID: <CAEWqx5-05WSPYfWOO=TBtQAJ0NmvCGvtJ1LEgfiJ3UdzJF+q2g@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] MIPS: ath79: add a common PCI registration function
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19736

And where is 'arch/mips/ath79/pci.h' ?

On Mon, Nov 21, 2011 at 4:06 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The current code unconditionally registers the AR724X
> specific PCI controller, even if the kernel is running
> on a different SoC.
>
> Add a common function for PCI controller registration,
> and only register the AR724X PCI controller if the kernel
> is running on an AR724X SoC.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> v4: - simplify ath79_register_pci function
> v3: - fix compile error if CONFIG_PCI is not defined
>    - add __init annotation to ath79_register_pci
> v2: - no changes
> ---
>  arch/mips/ath79/mach-ubnt-xm.c |    1 +
>  arch/mips/ath79/pci.c          |   10 ++++++++++
>  arch/mips/ath79/pci.h          |    6 ++++++
>  arch/mips/pci/pci-ath724x.c    |    2 --
>  4 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
> index a043500..edbc093 100644
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
> index 4957428..855a69d 100644
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
> @@ -44,3 +46,11 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>
>        return PCIBIOS_SUCCESSFUL;
>  }
> +
> +int __init ath79_register_pci(void)
> +{
> +       if (soc_is_ar724x())
> +               return ath724x_pcibios_init();
> +
> +       return -ENODEV;
> +}
> diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
> index 454885f..787fac2 100644
> --- a/arch/mips/ath79/pci.h
> +++ b/arch/mips/ath79/pci.h
> @@ -18,4 +18,10 @@ struct ath724x_pci_data {
>
>  void ath724x_pci_add_data(struct ath724x_pci_data *data, int size);
>
> +#ifdef CONFIG_PCI
> +int ath79_register_pci(void);
> +#else
> +static inline int ath79_register_pci(void) { return 0; }
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

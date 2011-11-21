Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 14:53:33 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:47359 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903756Ab1KUNxM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 14:53:12 +0100
Received: by mail-vw0-f49.google.com with SMTP id fs19so517607vbb.36
        for <multiple recipients>; Mon, 21 Nov 2011 05:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Op46bVLwWwkz8pD8Ua+DSmF57GVUm632FAFtA6mKLko=;
        b=ifprKWxqIBU2vdY2HUC6UOyxsK3k22pGwGgQbP8UD5Od6Iu8rC+AGW5LaaVRbBtBot
         LSgXYbnmXxOTOwfAlhPhSQOAQiKN4vNRpUDNfjTkeKB6CamBYKCV3+bbGPxeb+EtqvzC
         o7ERgKvMnM+PrnTZMEZCSFRjgu4MEbf3MicVE=
MIME-Version: 1.0
Received: by 10.182.31.78 with SMTP id y14mr3013845obh.25.1321883592084; Mon,
 21 Nov 2011 05:53:12 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Mon, 21 Nov 2011 05:53:12 -0800 (PST)
In-Reply-To: <1321825151-16053-2-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
        <1321825151-16053-2-git-send-email-juhosg@openwrt.org>
Date:   Mon, 21 Nov 2011 14:53:12 +0100
Message-ID: <CAEWqx58nqYXW9vtONQxAvKYnmE0_oon76cfAYR9n4ZyyPqXadQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] MIPS: ath79: separate common PCI code
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17305

Acked-by: Rene Bolldorf <xsecute@googlemail.com>

On Sun, Nov 20, 2011 at 10:39 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The 'pcibios_map_irq' and 'pcibios_plat_dev_init'
> are common functions and only instance one of them
> can be present in a single kernel.
>
> Currently these functions can be built only if the
> CONFIG_SOC_AR724X option is selected. However the
> ath79 platform contain support for the AR71XX SoCs,.
> The AR71XX SoCs have a differnet PCI controller,
> and those will require a different code.
>
> Move the common PCI code into a separeate file in
> order to be able to use that with other SoCs as
> well.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> v3: - no changes
> v2: - no changes
> ---
>  arch/mips/ath79/Makefile    |    1 +
>  arch/mips/ath79/pci.c       |   46 +++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/pci/pci-ath724x.c |   34 -------------------------------
>  3 files changed, 47 insertions(+), 34 deletions(-)
>  create mode 100644 arch/mips/ath79/pci.c
>
> diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
> index 3b911e09..221a76a9 100644
> --- a/arch/mips/ath79/Makefile
> +++ b/arch/mips/ath79/Makefile
> @@ -11,6 +11,7 @@
>  obj-y  := prom.o setup.o irq.o common.o clock.o gpio.o
>
>  obj-$(CONFIG_EARLY_PRINTK)             += early_printk.o
> +obj-$(CONFIG_PCI)                      += pci.o
>
>  #
>  # Devices
> diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
> new file mode 100644
> index 0000000..8db076e
> --- /dev/null
> +++ b/arch/mips/ath79/pci.c
> @@ -0,0 +1,46 @@
> +/*
> + *  Atheros AR71XX/AR724X specific PCI setup code
> + *
> + *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include <linux/pci.h>
> +#include <asm/mach-ath79/pci-ath724x.h>
> +
> +static struct ath724x_pci_data *pci_data;
> +static int pci_data_size;
> +
> +void ath724x_pci_add_data(struct ath724x_pci_data *data, int size)
> +{
> +       pci_data        = data;
> +       pci_data_size   = size;
> +}
> +
> +int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
> +{
> +       unsigned int devfn = dev->devfn;
> +       int irq = -1;
> +
> +       if (devfn > pci_data_size - 1)
> +               return irq;
> +
> +       irq = pci_data[devfn].irq;
> +
> +       return irq;
> +}
> +
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{
> +       unsigned int devfn = dev->devfn;
> +
> +       if (devfn > pci_data_size - 1)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       dev->dev.platform_data = pci_data[devfn].pdata;
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ath724x.c
> index a4dd24a..1e810be 100644
> --- a/arch/mips/pci/pci-ath724x.c
> +++ b/arch/mips/pci/pci-ath724x.c
> @@ -9,7 +9,6 @@
>  */
>
>  #include <linux/pci.h>
> -#include <asm/mach-ath79/pci-ath724x.h>
>
>  #define reg_read(_phys)                (*(unsigned int *) KSEG1ADDR(_phys))
>  #define reg_write(_phys, _val) ((*(unsigned int *) KSEG1ADDR(_phys)) = (_val))
> @@ -19,8 +18,6 @@
>  #define ATH724X_PCI_MEM_SIZE   0x08000000
>
>  static DEFINE_SPINLOCK(ath724x_pci_lock);
> -static struct ath724x_pci_data *pci_data;
> -static int pci_data_size;
>
>  static int ath724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
>                            int size, uint32_t *value)
> @@ -133,37 +130,6 @@ static struct pci_controller ath724x_pci_controller = {
>        .mem_resource   = &ath724x_mem_resource,
>  };
>
> -void ath724x_pci_add_data(struct ath724x_pci_data *data, int size)
> -{
> -       pci_data        = data;
> -       pci_data_size   = size;
> -}
> -
> -int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
> -{
> -       unsigned int devfn = dev->devfn;
> -       int irq = -1;
> -
> -       if (devfn > pci_data_size - 1)
> -               return irq;
> -
> -       irq = pci_data[devfn].irq;
> -
> -       return irq;
> -}
> -
> -int pcibios_plat_dev_init(struct pci_dev *dev)
> -{
> -       unsigned int devfn = dev->devfn;
> -
> -       if (devfn > pci_data_size - 1)
> -               return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -       dev->dev.platform_data = pci_data[devfn].pdata;
> -
> -       return PCIBIOS_SUCCESSFUL;
> -}
> -
>  static int __init ath724x_pcibios_init(void)
>  {
>        register_pci_controller(&ath724x_pci_controller);
> --
> 1.7.2.1
>
>

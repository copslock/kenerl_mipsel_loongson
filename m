Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 14:16:57 +0100 (CET)
Received: from gateway-2929.mvista.com ([206.112.117.47]:51736 "HELO
        gateway-2929.mvista.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492366Ab0AaNQw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 14:16:52 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by hermes.mvista.com (Postfix) with ESMTP
        id B78E21DC58; Sun, 31 Jan 2010 05:16:43 -0800 (PST)
Message-ID: <4B6582A1.6050708@ru.mvista.com>
Date:   Sun, 31 Jan 2010 16:16:17 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/7] MIPS: bcm63xx: register integrated EHCI controller
 device.
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr> <1264872898-28149-3-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1264872898-28149-3-git-send-email-mbizon@freebox.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 25790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19731

Hello.

Maxime Bizon wrote:

> The bcm63xx SOC has an integrated EHCI controller, this patch adds
> platform device registration and change board code to register
> EHCI device when necessary.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
>   

[...]

> diff --git a/arch/mips/bcm63xx/dev-usb-ehci.c b/arch/mips/bcm63xx/dev-usb-ehci.c
> new file mode 100644
> index 0000000..4bdd675
> --- /dev/null
> +++ b/arch/mips/bcm63xx/dev-usb-ehci.c
> @@ -0,0 +1,49 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2010 Maxime Bizon <mbizon@freebox.fr>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <bcm63xx_cpu.h>
> +#include <bcm63xx_dev_usb_ehci.h>
> +
> +static struct resource ehci_resources[] = {
> +	{
> +		/* start & end filled at runtime */
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		/* start filled at runtime */
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 ehci_dmamask = ~(u32)0;
>   

   Should be DMA_BIT_MASK(32).

> +
> +static struct platform_device bcm63xx_ehci_device = {
> +	.name		= "bcm63xx_ehci",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(ehci_resources),
> +	.resource	= ehci_resources,
> +	.dev		= {
> +		.dma_mask		= &ehci_dmamask,
> +		.coherent_dma_mask	= 0xffffffff,
>   

   Same here...

> +	},
> +};
> +
> +int __init bcm63xx_ehci_register(void)
> +{
> +	if (!BCMCPU_IS_6358())
> +		return 0;
> +
> +	ehci_resources[0].start = bcm63xx_regset_address(RSET_EHCI0);
> +	ehci_resources[0].end = ehci_resources[0].start;
> +	ehci_resources[0].end += RSET_EHCI_SIZE - 1;
>   

   Why not do it in a single statement? Besides you could initialize the 
field with that, and then do

    ehci_resources[0].end += ehci_resources[0].start;

WBR, Sergei

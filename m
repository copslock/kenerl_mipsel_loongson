Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 14:29:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49774 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992314AbdKNN30Vtev0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 14:29:26 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEDTPHG012963;
        Tue, 14 Nov 2017 14:29:25 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEDTP0f012962;
        Tue, 14 Nov 2017 14:29:25 +0100
Date:   Tue, 14 Nov 2017 14:29:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     jiaxun.yang@flygoat.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: Loongson64: Load platform device during boot
 This patch just add pdev during boot to load the platform driver
Message-ID: <20171114132925.GD13046@linux-mips.org>
References: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
 <20171112063617.26546-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112063617.26546-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Nov 12, 2017 at 02:36:17PM +0800, jiaxun.yang@flygoat.com wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/loongson64/lemote-2f/Makefile   |  2 +-
>  arch/mips/loongson64/lemote-2f/platform.c | 45 +++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/loongson64/lemote-2f/platform.c
> 
> diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
> index 08b8abcbfef5..31c90737b98c 100644
> --- a/arch/mips/loongson64/lemote-2f/Makefile
> +++ b/arch/mips/loongson64/lemote-2f/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for lemote loongson2f family machines
>  #
>  
> -obj-y += clock.o machtype.o irq.o reset.o ec_kb3310b.o
> +obj-y += clock.o machtype.o irq.o reset.o ec_kb3310b.o platform.o
>  
>  #
>  # Suspend Support
> diff --git a/arch/mips/loongson64/lemote-2f/platform.c b/arch/mips/loongson64/lemote-2f/platform.c
> new file mode 100644
> index 000000000000..c36efcccb9a9
> --- /dev/null
> +++ b/arch/mips/loongson64/lemote-2f/platform.c
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright (C) 2017 Jiaxun Yang.
> + * Author: Jiaxun Yang, jiaxun.yang@flygoat.com
> +
> + * Copyright (C) 2009 Lemote Inc.
> + * Author: Wu Zhangjin, wuzhangjin@gmail.com
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/bootinfo.h>
> +
> +static struct platform_device yeeloong_pdev = {
> +	.name = "yeeloong_laptop",
> +	.id = -1,
> +};
> +
> +
> +static int __init lemote2f_platform_init(void)
> +{
> +	struct platform_device *pdev = NULL;
> +
> +	switch (mips_machtype) {
> +	case MACH_LEMOTE_YL2F89:
> +		pdev = &yeeloong_pdev;
> +		break;
> +
> +	default:
> +		break;
> +
> +	}
> +
> +	if (pdev != NULL)
> +		return platform_device_register(pdev);
> +
> +	return -ENODEV;
> +}
> +
> +arch_initcall(lemote2f_platform_init);

Looks like you can simplify this by using something like:

> +static int __init lemote2f_platform_init(void)
> +{
> +     struct platform_device *pdev = NULL;
> +
> +     switch (mips_machtype) {
> +     case MACH_LEMOTE_YL2F89:
> +             pdev = &yeeloong_pdev;
> +             break;
> +
> +     default:
> +             break;
> +
> +     }
> +
> +     if (pdev != NULL)
> +             return platform_device_register(pdev);
> +
> +     return -ENODEV;
> +}

Looks like this can be simplified to:

static int __init lemote2f_platform_init(void)
{
	if (mips_machtype != MACH_LEMOTE_YL2F89)
		return -ENODEV;

	return platform_device_register_simple("yeeloong_laptop", -1, NULL, 0);
}


  Ralf

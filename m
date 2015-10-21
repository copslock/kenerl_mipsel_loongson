Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 16:36:15 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:62002 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011290AbbJUOfQVsSc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Oct 2015 16:35:16 +0200
Received: from avionic-0020 (unknown [91.60.20.71])
        (Authenticated sender: albeu@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7B06E4B0081;
        Wed, 21 Oct 2015 16:35:05 +0200 (CEST)
Date:   Wed, 21 Oct 2015 16:35:02 +0200
From:   Alban <albeu@free.fr>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Alban <albeu@free.fr>, <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: xilfpga: Add mipsfpga platform code
Message-ID: <20151021163502.44be785f@avionic-0020>
In-Reply-To: <1444827117-10939-5-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
        <1444827117-10939-5-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Am Wed, 14 Oct 2015 13:51:56 +0100
schrieb Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>:

> The xilfpga platform will be DT only.
> 
> Add required platform code. DT files have already been added separately
>
> [...]
>
> diff --git a/arch/mips/include/asm/mach-xilfpga/gpio.h b/arch/mips/include/asm/mach-xilfpga/gpio.h
> new file mode 100644
> index 0000000..26778fc
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-xilfpga/gpio.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (C) 2015 Imagination Technologies
> + * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __ASM_MACH_XILFPGA_GPIO_H
> +#define __ASM_MACH_XILFPGA_GPIO_H
> +
> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value __gpio_get_value
> +#define gpio_set_value __gpio_set_value
> +
> +#endif /* __ASM_MACH_XILFPGA_GPIO_H */

Custom gpio.h has been disabled, this file won't be used, it can just
be dropped.

> diff --git a/arch/mips/include/asm/mach-xilfpga/irq.h b/arch/mips/include/asm/mach-xilfpga/irq.h
> new file mode 100644
> index 0000000..0132a5b9
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-xilfpga/irq.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2015 Imagination Technologies
> + * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __MIPS_ASM_MACH_XILFPGA_IRQ_H__
> +#define __MIPS_ASM_MACH_XILFPGA_IRQ_H__
> +
> +#define NR_IRQS 32
> +
> +#include_next <irq.h>
> +
> +#endif /* __MIPS_ASM_MACH_XILFPGA_IRQ_H__ */

Is this really needed? If not I would not add it to keep the maintenance
burden down.

> [...]
>
> diff --git a/arch/mips/xilfpga/time.c b/arch/mips/xilfpga/time.c
> new file mode 100644
> index 0000000..3f2e39e
> --- /dev/null
> +++ b/arch/mips/xilfpga/time.c
> @@ -0,0 +1,41 @@
> +/*
> + * Xilfpga clocksource/timer setup
> + *
> + * Copyright (C) 2015 Imagination Technologies
> + * Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +#include <linux/of.h>
> +
> +#include <asm/time.h>
> +
> +void __init plat_time_init(void)
> +{
> +	struct device_node *np;
> +	struct clk *clk = 0;
> +
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +
> +	np = of_get_cpu_node(0, NULL);
> +	if (!np) {
> +		pr_err("Failed to get CPU node\n");
> +		return;
> +	}
> +
> +	clk = of_clk_get(np, 0);
> +	if (IS_ERR(clk)) {
> +		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
> +		return;
> +	}
> +
> +	mips_hpt_frequency = clk_get_rate(clk) / 2;
> +	clk_put(clk);
> +}

I wanted to use something similar on ATH79 once all boards moved to DT.
On the other hand I saw that BMIPS use a dedicated property on the CPU
node to represent the HPT frequency. If possible it would make sense to
use a common scheme for all MIPS platforms. However I personally don't
know enough about MIPS in general to judge this.

On the other hand I think it might make more sense to have a dedicated
node in DT to represent the HPT timer instead of hacking on the CPU
node. That would also fit better if the HPT code ever become is a real
driver.

Alban

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 13:50:03 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:55439 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011324AbcATMuAuXL4K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 13:50:00 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52CA3A8;
        Wed, 20 Jan 2016 04:49:15 -0800 (PST)
Received: from sofa.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970F53F21A;
        Wed, 20 Jan 2016 04:49:52 -0800 (PST)
Date:   Wed, 20 Jan 2016 12:49:48 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] MIPS: ath79: irq: Move the CPU IRQ driver to
 drivers/irqchip
Message-ID: <20160120124948.6917859f@sofa.wild-wind.fr.eu.org>
In-Reply-To: <1447788896-15553-7-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
        <1447788896-15553-7-git-send-email-albeu@free.fr>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.13.2-1-geb0880 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On Tue, 17 Nov 2015 20:34:56 +0100
Alban Bedel <albeu@free.fr> wrote:

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/ath79/irq.c                    | 81 ++------------------------
>  arch/mips/include/asm/mach-ath79/ath79.h |  1 +
>  drivers/irqchip/Makefile                 |  1 +
>  drivers/irqchip/irq-ath79-cpu.c          | 97 ++++++++++++++++++++++++++++++++
>  4 files changed, 105 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/irqchip/irq-ath79-cpu.c
>

[...]
 
> diff --git a/drivers/irqchip/irq-ath79-cpu.c b/drivers/irqchip/irq-ath79-cpu.c
> new file mode 100644
> index 0000000..befe93c
> --- /dev/null
> +++ b/drivers/irqchip/irq-ath79-cpu.c
> @@ -0,0 +1,97 @@
> +/*
> + *  Atheros AR71xx/AR724x/AR913x specific interrupt handling
> + *
> + *  Copyright (C) 2015 Alban Bedel <albeu@free.fr>
> + *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
> + *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + *
> + *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
> +#include <linux/of.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/mach-ath79/ath79.h>
> +
> +/*
> + * The IP2/IP3 lines are tied to a PCI/WMAC/USB device. Drivers for
> + * these devices typically allocate coherent DMA memory, however the
> + * DMA controller may still have some unsynchronized data in the FIFO.
> + * Issue a flush in the handlers to ensure that the driver sees
> + * the update.
> + *
> + * This array map the interrupt lines to the DDR write buffer channels.
> + */
> +
> +static unsigned irq_wb_chan[8] = {
> +	-1, -1, -1, -1, -1, -1, -1, -1,
> +};
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned long pending;
> +	int irq;
> +
> +	pending = read_c0_status() & read_c0_cause() & ST0_IM;
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		return;
> +	}
> +
> +	pending >>= CAUSEB_IP;
> +	while (pending) {
> +		irq = fls(pending) - 1;
> +		if (irq < ARRAY_SIZE(irq_wb_chan) && irq_wb_chan[irq] != -1)
> +			ath79_ddr_wb_flush(irq_wb_chan[irq]);
> +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);

I'm rather unfamiliar with the MIPS IRQ handling, but I'm vaguely
surprised by the lack of domain. How do you unsure that the IRQ space
used here doesn't clash with the one created in your "misc" irqchip?

> +		pending &= ~BIT(irq);
> +	}
> +}
> +
> +static int __init ar79_cpu_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	int err, i, count;
> +
> +	/* Fill the irq_wb_chan table */
> +	count = of_count_phandle_with_args(
> +		node, "qca,ddr-wb-channels", "#qca,ddr-wb-channel-cells");
> +
> +	for (i = 0; i < count; i++) {
> +		struct of_phandle_args args;
> +		u32 irq = i;
> +
> +		of_property_read_u32_index(
> +			node, "qca,ddr-wb-channel-interrupts", i, &irq);
> +		if (irq >= ARRAY_SIZE(irq_wb_chan))
> +			continue;
> +
> +		err = of_parse_phandle_with_args(
> +			node, "qca,ddr-wb-channels",
> +			"#qca,ddr-wb-channel-cells",
> +			i, &args);
> +		if (err)
> +			return err;
> +
> +		irq_wb_chan[irq] = args.args[0];
> +	}
> +
> +	return mips_cpu_irq_of_init(node, parent);
> +}
> +IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
> +		ar79_cpu_intc_of_init);
> +
> +void __init ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3)
> +{
> +	irq_wb_chan[2] = irq_wb_chan2;
> +	irq_wb_chan[3] = irq_wb_chan3;
> +	mips_cpu_irq_init();
> +}

Thanks,

	M.
-- 
AAAFNRAA

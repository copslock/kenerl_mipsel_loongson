Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:35:00 +0100 (CET)
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:48405 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991163AbdKBQeqT3YtB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 17:34:46 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6A2CA100E86C5;
        Thu,  2 Nov 2017 16:34:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quill99_46032c0d21e55
X-Filterd-Recvd-Size: 3601
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Nov 2017 16:34:41 +0000 (UTC)
Message-ID: <1509640479.31043.80.camel@perches.com>
Subject: Re: [PATCH v7 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
From:   Joe Perches <joe@perches.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Thu, 02 Nov 2017 09:34:39 -0700
In-Reply-To: <1509639716-4787-3-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509639716-4787-1-git-send-email-aleksandar.markovic@rt-rk.com>
         <1509639716-4787-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Thu, 2017-11-02 at 17:21 +0100, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
> 
> Add device driver for a virtual programmable interrupt controller
> 
> The virtual PIC is designed as a device tree-based interrupt controller.
> 
> The compatible string used by OS for binding the driver is
> "google,goldfish-pic".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> wq

vi much?

> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
[]
> @@ -0,0 +1,134 @@
> +/*
> + * Driver for MIPS Goldfish Programmable Interrupt Controller.
> + *
> + * Author: Miodrag Dinic <miodrag.dinic@mips.com>
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */

Odd mix of spaces and tabs

It'd be good to add a #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before any #include so the pr_<level> output is prefixed appropriately.

> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
[]
> +static int __init goldfish_pic_of_init(struct device_node *of_node,
> +				       struct device_node *parent)
> +{
[]
> +	parent_irq = irq_of_parse_and_map(of_node, 0);
> +	if (!parent_irq) {
> +		pr_err("Failed to map Goldfish PIC parent IRQ!\n");

So these could become

		pr_err("Failed to map parent IRQ\n");

> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	gfpic->base = of_iomap(of_node, 0);
> +	if (!gfpic->base) {
> +		pr_err("Failed to map Goldfish PIC base!\n");

		pr_err("Failed to map base\n");

etc...

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 18:30:50 +0100 (CET)
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:52895 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990740AbdKCRan4jU9P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Nov 2017 18:30:43 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F014783777ED;
        Fri,  3 Nov 2017 17:30:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: van73_22c2dd350184e
X-Filterd-Recvd-Size: 2339
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Nov 2017 17:30:38 +0000 (UTC)
Message-ID: <1509730237.15520.36.camel@perches.com>
Subject: Re: [PATCH v8 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
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
Date:   Fri, 03 Nov 2017 10:30:37 -0700
In-Reply-To: <1509729730-26621-3-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509729730-26621-1-git-send-email-aleksandar.markovic@rt-rk.com>
         <1509729730-26621-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60710
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

On Fri, 2017-11-03 at 18:21 +0100, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
[]
> diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
[]
> +static int __init goldfish_pic_of_init(struct device_node *of_node,
> +				       struct device_node *parent)
> +{
[]
> +	parent_irq = irq_of_parse_and_map(of_node, 0);
> +	if (!parent_irq) {
> +		pr_err("Failed to map parent IRQ!");

All the pr_<foo> uses should end with a newline

		pr_err("Failed to map parent IRQ\n");

etc...

> +	gc = irq_alloc_generic_chip("GFPIC", 1, GFPIC_IRQ_BASE, gfpic->base,
> +				    handle_level_irq);
> +	if (!gc) {
> +		pr_err("Failed to allocate chip structures!");
> +		ret = -ENOMEM;
> +		goto out_unmap_irq;
> +	}

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2016 16:41:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47975 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992166AbcI3OlAbWqPd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2016 16:41:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1FB5441F8D64;
        Fri, 30 Sep 2016 15:40:55 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 30 Sep 2016 15:40:55 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 30 Sep 2016 15:40:55 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 91997C87D880E;
        Fri, 30 Sep 2016 15:40:51 +0100 (IST)
Received: from np-p-burton.localnet (10.100.200.217) by HHMAIL03.hh.imgtec.org
 (10.44.0.22) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 30 Sep 2016
 15:40:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/14] irqchip: i8259: Add domain before mapping parent irq
Date:   Fri, 30 Sep 2016 15:40:48 +0100
Message-ID: <7469373.vRGg21xy4h@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.1 (Linux/4.7.4-1-ARCH; KDE/5.26.0; x86_64; ; )
In-Reply-To: <20160919212132.28893-2-paul.burton@imgtec.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com> <20160919212132.28893-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4762191.RMUhLO6Eyp";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.217]
X-ESG-ENCRYPT-TAG: 541c1663
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart4762191.RMUhLO6Eyp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 19 September 2016 22:21:18 BST Paul Burton wrote:
> Mapping the parent IRQ will use a virq number which may conflict with
> the hardcoded I8259A_IRQ_BASE..I8259A_IRQ_BASE+15 range that the i8259
> driver expects to be free. If this occurs then we'll hit errors when
> adding the i8259 IRQ domain, since one of its virq numbers will already
> be in use.
> 
> Avoid this by adding the i8259 domain before mapping the parent IRQ,
> such that the i8259 virq numbers become used before the parent interrupt
> controller gets a chance to use any of them.

Hello,

Any chance of getting reviews/acks on this & the following 2 patches in the 
series so Ralf can take them through the MIPS tree? The lack of these (well, 
patches 1 & 2 anyway) blocks applying many of the Malta patches later in the 
series.

Thanks,
    Paul

> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/irqchip/irq-i8259.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
> index 6b304eb..85897fd 100644
> --- a/drivers/irqchip/irq-i8259.c
> +++ b/drivers/irqchip/irq-i8259.c
> @@ -370,13 +370,15 @@ int __init i8259_of_init(struct device_node *node,
> struct device_node *parent) struct irq_domain *domain;
>  	unsigned int parent_irq;
> 
> +	domain = __init_i8259_irqs(node);
> +
>  	parent_irq = irq_of_parse_and_map(node, 0);
>  	if (!parent_irq) {
>  		pr_err("Failed to map i8259 parent IRQ\n");
> +		irq_domain_remove(domain);
>  		return -ENODEV;
>  	}
> 
> -	domain = __init_i8259_irqs(node);
>  	irq_set_chained_handler_and_data(parent_irq, i8259_irq_dispatch,
>  					 domain);
>  	return 0;


--nextPart4762191.RMUhLO6Eyp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX7nlwAAoJEIIg2fppPBxl8N4P/jZ9FoGAcVQjbyMxpzBga4Ca
T6WTqClJgPRok6Qh6xs8hCkWXgoBQB/Mv5EX80DW2AnFU1bBQ31rwO2qEckqcFhj
wn9fllhY15SMMU3zDt3e0j73rwyfIbg9lj1rfG7tLhgZAvD/y+SvGXWcKz7nlyrp
XUHk5gl1DbCSzdPx4vGU/2DIQn7zOpM4Bn7Jd80R1QHOUmu34XwuSYQr8y1Rtx0m
IeCwsU43UYvd2PNNgAY1DOznOqa0PylAWXj80RkCXmkN70YQfO6R3dU0y1yii0zG
EkAosOK8x44JYo4++qY/DGhrEMwWoBH7Npi5YRF3w25W51a0tKgHDK9Jk+MUwD4P
JE/5DOSy4u/M2oSy2Rk76hIipvrz2KvTmGzqBQLSIXFbYA1pVXfiR5LW0/OkhD6K
MH6YNE0KDvnlHxHQ1D7bnkN6ZvGQm6ewXcBMzI42hXlRThA8FeONsEnuXys50A/L
JU63wmXxYug/gZ2cvHidRXTSHNAKJmJHCHJ3pG847+MKcvv/2tiKBSLvfUaEoaNt
7x1zwAIE+YDX8Mo+swL3lL5ilxT16JwU+vIZ6OQ8DatQ/Zv3y+sIeskWFg2jVYJq
P34wufB1gA5pwNbJ0XkeaF2rHG6DljfaUoqDEcc7ngW6I2eqg0JLPmqbJwOwYLYr
EtI2zWyWui2F2wcI0gve
=1rjx
-----END PGP SIGNATURE-----

--nextPart4762191.RMUhLO6Eyp--

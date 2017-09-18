Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 23:53:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12361 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993156AbdIRVxNnU4sw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 23:53:13 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 99A351C6A96F;
        Mon, 18 Sep 2017 22:53:02 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 18 Sep 2017 22:53:07 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 18 Sep
 2017 22:53:06 +0100
Received: from np-p-burton.localnet (10.20.78.58) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 18 Sep
 2017 14:53:04 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] irqchip: mips-gic: Fix shared interrupt mask writes
Date:   Mon, 18 Sep 2017 14:52:59 -0700
Message-ID: <1547972.HKse83ZIYs@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170905182846.27994-1-paul.burton@imgtec.com>
References: <20170905182846.27994-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart57944349.xmbn3mLd1X";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.78.58]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60066
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

--nextPart57944349.xmbn3mLd1X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello all,

On Tuesday, 5 September 2017 11:28:46 PDT Paul Burton wrote:
> The write_gic_smask() & write_gic_rmask() functions take a shared
> interrupt number as a parameter, but we're incorrectly providing them a
> bitmask with the shared interrupt's bit set. This effectively means that
> we mask or unmask the shared interrupt 1<<n rather than shared interrupt
> n, and as a result likely drop interrupts.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 68898c8765f4 ("irqchip: mips-gic: Drop gic_(re)set_mask() functions")
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> ---
> With Boston PCIe support & the GIC cleanup series now coming together in
> -next, this bug was uncovered by running next-20170905 on a Boston
> board, which failed to find any rootfs media due to a lack of PCIe
> interrupts. With this fix we're now able to use the Boston's SATA or MMC
> controllers :)
> 
> Ideally this would be applied as a fixup to 68898c8765f4 ("irqchip:
> mips-gic: Drop gic_(re)set_mask() functions"), but even if not it'd be
> great to get into the v4.14 MIPS pull where the breakage is introduced,
> or otherwise just ASAP - my apologies!

So this fix missed the MIPS pull - can we get it in ASAP, thorough either the 
MIPS or irqchip trees?

Thanks,
    Paul

> ---
>  drivers/irqchip/irq-mips-gic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 6e52a88bbd9e..40159ac12ac8 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -169,7 +169,7 @@ static void gic_mask_irq(struct irq_data *d)
>  {
>  	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
> 
> -	write_gic_rmask(BIT(intr));
> +	write_gic_rmask(intr);
>  	gic_clear_pcpu_masks(intr);
>  }
> 
> @@ -179,7 +179,7 @@ static void gic_unmask_irq(struct irq_data *d)
>  	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
>  	unsigned int cpu;
> 
> -	write_gic_smask(BIT(intr));
> +	write_gic_smask(intr);
> 
>  	gic_clear_pcpu_masks(intr);
>  	cpu = cpumask_first_and(affinity, cpu_online_mask);
> @@ -767,7 +767,7 @@ static int __init gic_of_init(struct device_node *node,
>  	for (i = 0; i < gic_shared_intrs; i++) {
>  		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
>  		change_gic_trig(i, GIC_TRIG_LEVEL);
> -		write_gic_rmask(BIT(i));
> +		write_gic_rmask(i);
>  	}
> 
>  	for (i = 0; i < gic_vpes; i++) {


--nextPart57944349.xmbn3mLd1X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlnAQDsACgkQgiDZ+mk8
HGWNnA//YpDpJ6LfJ3yXj92TrB3laClUw/NekQnAWUpWqldlPiI9Mu73eCuAt3iV
WRJVB8CnHRpCJ/nD4r5ZZNaYfUKqHJQWgv6MBNIPvjH4ycbLlc4aXsQPyo0verTK
GGMmNwNjCcfSuXAL58Zh5RhxLXcl7fXPx8mW4UJxlVkMywgwlQ9+jQjYyoTV+38Z
GPzOsOJi56Q1/Po8IxOkidlBu9e4NBUqzR0/pUWoU9r9SBxGsIf9PVkZg3DRopB7
X5mTUUZnhlgkQSW4Hc3MdNOa/RNOTaylEosB5bXJsWccepYfgD5QgXS8/x8yyvI5
ym+bY6E9GTtRfXrn3O+lXn1aGhEqTtfaHPRFLiGfqoa/1PVm8M7njoecEKD5wIuT
BviGbgXaTs265+ymWUFB8ROZrqkusH4gAlHS/VBa+OEuvvS7glwSXzLOtJj5zE7P
y2asdjYRuSKdBnrjDV6S3na04KSUKmcWBuW3bB65W8a1xmu8lFflQt42ZwSjRlM/
ZqJTjFqtUBL0rJxGAwlvYH4JVh4DcdhxUPGZCOcWPtylw4opIAYyUdVZuOMRIuPC
otFuFZHvvRgzgs8ym/Hpo0fVlhmSdDkwMrjpwVIEQdhBDyEgrJniHP+uC5LNouuw
Qs6PYyHa1Uw/qy52XSqzma0cNtCeoSNaTMMe92/0f1ENNttVVno=
=XamO
-----END PGP SIGNATURE-----

--nextPart57944349.xmbn3mLd1X--

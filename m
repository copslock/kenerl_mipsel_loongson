Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 00:36:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63072 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011846AbbD0WgBZaxiQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 00:36:01 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5C10741F8DE7;
        Mon, 27 Apr 2015 23:35:56 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 27 Apr 2015 23:35:56 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 27 Apr 2015 23:35:56 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 97C4B7B14D292;
        Mon, 27 Apr 2015 23:35:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Apr 2015 23:35:55 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Apr
 2015 23:35:55 +0100
Date:   Mon, 27 Apr 2015 23:35:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH v4 15/37] MIPS: JZ4740: remove jz_intc_base global
Message-ID: <20150427223555.GA22974@jhogan-linux.le.imgtec.org>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-16-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1429881457-16016-16-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, Apr 24, 2015 at 02:17:15PM +0100, Paul Burton wrote:
> Avoid the need for the global variable jz_intc_base by introducing a
> struct ingenic_intc_data and passing it around as the IRQ handler data.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> Changes in v4:
>   - None.

I don't think you've addressed my comment on v3 of this patch:
http://patchwork.linux-mips.org/patch/9805/

Cheers
James

>=20
> Changes in v3:
>   - New patch.
> ---
>  arch/mips/jz4740/irq.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
> index 615eaa8..498ff28 100644
> --- a/arch/mips/jz4740/irq.c
> +++ b/arch/mips/jz4740/irq.c
> @@ -32,7 +32,9 @@
> =20
>  #include "../../drivers/irqchip/irqchip.h"
> =20
> -static void __iomem *jz_intc_base;
> +struct ingenic_intc_data {
> +	void __iomem *base;
> +};
> =20
>  #define JZ_REG_INTC_STATUS	0x00
>  #define JZ_REG_INTC_MASK	0x04
> @@ -42,9 +44,10 @@ static void __iomem *jz_intc_base;
> =20
>  static irqreturn_t jz4740_cascade(int irq, void *data)
>  {
> +	struct ingenic_intc_data *intc =3D irq_get_handler_data(irq);
>  	uint32_t irq_reg;
> =20
> -	irq_reg =3D readl(jz_intc_base + JZ_REG_INTC_PENDING);
> +	irq_reg =3D readl(intc->base + JZ_REG_INTC_PENDING);
> =20
>  	if (irq_reg)
>  		generic_handle_irq(__fls(irq_reg) + JZ4740_IRQ_BASE);
> @@ -80,21 +83,30 @@ static struct irqaction jz4740_cascade_action =3D {
>  static int __init jz4740_intc_of_init(struct device_node *node,
>  	struct device_node *parent)
>  {
> +	struct ingenic_intc_data *intc;
>  	struct irq_chip_generic *gc;
>  	struct irq_chip_type *ct;
>  	struct irq_domain *domain;
> -	int parent_irq;
> +	int parent_irq, err =3D 0;
> +
> +	intc =3D kzalloc(sizeof(*intc), GFP_KERNEL);
> +	if (!intc) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> =20
>  	parent_irq =3D irq_of_parse_and_map(node, 0);
> -	if (!parent_irq)
> -		return -EINVAL;
> +	if (!parent_irq) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> =20
> -	jz_intc_base =3D ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
> +	intc->base =3D ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
> =20
>  	/* Mask all irqs */
> -	writel(0xffffffff, jz_intc_base + JZ_REG_INTC_SET_MASK);
> +	writel(0xffffffff, intc->base + JZ_REG_INTC_SET_MASK);
> =20
> -	gc =3D irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE, jz_intc_base,
> +	gc =3D irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE, intc->base,
>  		handle_level_irq);
> =20
>  	gc->wake_enabled =3D IRQ_MSK(32);
> @@ -116,7 +128,12 @@ static int __init jz4740_intc_of_init(struct device_=
node *node,
>  	if (!domain)
>  		pr_warn("unable to register IRQ domain\n");
> =20
> +	err =3D irq_set_handler_data(parent_irq, intc);
> +	if (err)
> +		goto out;
> +
>  	setup_irq(parent_irq, &jz4740_cascade_action);
> -	return 0;
> +out:
> +	return err;
>  }
>  IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
> --=20
> 2.3.5
>=20
>=20

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVPrnLAAoJEGwLaZPeOHZ6MlcQAJANpECqN9Cbe5+GBDrRUwKv
ZZz51mfqA98hFagJMXWgRqieBT8jaxUjkgV1gquF1omtiDkJ97EqTBnxGGUBs97t
1Yr/977Aid9py58JEUKHGzQYTarDr8axNgIPtW+uaCDdEr+2V6TMrkihxPALwiuk
aU99P+N7Ba/lc0NbEZntd7o2fvYJxN0aWXIE21WRL6TC0ualOX/5PoDDi6eY8c4d
+2v04wTVJe6dWucxxDmD58YQT3qblhCRtieVxE6Pah9EbbMqnCB5XSE+NvLoFs/F
hfQoQ1it+KhYKaN8+JbthDX7wFw4hLrY4XttQx3HFiJFvUy61FSUd1Z1Vwavr6d9
FbJUAAQsP0a3RJjoXnm0cJsJB07C1wVDZUrVoccxCMGV84w1fwO2GriMI12WqV4b
4Z1U4dLpjgeTApRthLYTS5J6nvSNPDeCDW5Jo92aDm5UcdtdBQr51DaJKnyeX0FA
F33auSW6Gmy3KtCGE5ksVxbQ+tqb6xAqZ0POb41TX0zu/Lfi7n/vt5v9C/7/GoZC
f3Y5eKGfv9HaOOuJLRPbA4BRNt1dbrmjFvbk4TsknfzlQk8r8NJKs3nAo0LJtjlO
SlFQnFEEikXl/PYOyOuJUfeHfsX/hcBIfrBhogUBrHKT4877OFkCUQWbyLfq7foj
s7Lu26NLyC8uzxM+9IMX
=8qsw
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

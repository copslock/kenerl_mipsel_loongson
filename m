Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 12:46:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52529 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011860AbbD1KqJ2Vsl6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 12:46:09 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D356341F8E2E;
        Tue, 28 Apr 2015 11:46:05 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 28 Apr 2015 11:46:05 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 28 Apr 2015 11:46:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C35FDB7210D9;
        Tue, 28 Apr 2015 11:46:03 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 28 Apr 2015 11:46:05 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 28 Apr
 2015 11:46:05 +0100
Message-ID: <553F64EC.8040602@imgtec.com>
Date:   Tue, 28 Apr 2015 11:46:04 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 13/37] MIPS: JZ4740: register an irq_domain for the
 interrupt controller
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com> <1429881457-16016-14-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1429881457-16016-14-git-send-email-paul.burton@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="hOxx3PEduBGAhadojnuDOlF0KaaFLHi2q"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47125
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

--hOxx3PEduBGAhadojnuDOlF0KaaFLHi2q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 24/04/15 14:17, Paul Burton wrote:
> When probining the interrupt controller, register an IRQ domain such

probining?

Cheers
James

> that the interrupts can be translated by devicetree code & thus used
> from devicetree.
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
>=20
> Changes in v3:
>   - Rebase.
>=20
> Changes in v2:
>   - None.
> ---
>  arch/mips/jz4740/irq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
> index ed51915..ddcf78a 100644
> --- a/arch/mips/jz4740/irq.c
> +++ b/arch/mips/jz4740/irq.c
> @@ -85,6 +85,7 @@ static int __init jz4740_intc_of_init(struct device_n=
ode *node,
>  {
>  	struct irq_chip_generic *gc;
>  	struct irq_chip_type *ct;
> +	struct irq_domain *domain;
>  	int parent_irq;
> =20
>  	parent_irq =3D irq_of_parse_and_map(node, 0);
> @@ -113,6 +114,11 @@ static int __init jz4740_intc_of_init(struct devic=
e_node *node,
> =20
>  	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL=
);
> =20
> +	domain =3D irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BAS=
E, 0,
> +				       &irq_domain_simple_ops, NULL);
> +	if (!domain)
> +		pr_warn("unable to register IRQ domain\n");
> +
>  	setup_irq(parent_irq, &jz4740_cascade_action);
>  	return 0;
>  }
>=20


--hOxx3PEduBGAhadojnuDOlF0KaaFLHi2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVP2TsAAoJEGwLaZPeOHZ69E4P/A5UK8a1wRrXvSVWfnz2eX7q
IoNN7fCdYtn9Wq367XeLSkxj1KR8GRZKsPshOyPwGfVlLq+co0nihoPijVmI3oe/
A1D/UmlCsBYSC9hS71tsUK1QP7YqEvviYAHNcmNYVi6Y6EfjqfDcG4EPuEM2CiNj
JWmRQ+kAyCo6S9ZKXhiViFKs8F6Xfhfgc3J6XCnrzNj+KN28baA6cICa5dqLd/xd
2/dhy5eQbaMnzvBnEb/e4SBxZpyGOkbrS2JZDuLXqFEwpq5no2HkZHK2+QRrDxYj
FN8omstj3de+hz8pOQ0kYo1CpCcOyduS36ZkgHF27ugTMi3niNV8e95EYWse1cv0
aEhq2nnlu9BuveeRtRQ3LKg+C0ADyIxq05pNLaF6iV5Dte/jLE1oBwcJ+NA5lu6X
n9NKNekY14WyY2z3iJMdemIdYK/WFwzW2E8crOJmBtAomJhzIsZ8oW4TAtpIx3cF
mu7lLKRW4DhoCb+pP1wEhXj2DZ/QOeEAndfwS1USWB+ILGbAaTQM7t3BBGeLuugB
3BFLJzACRzcTkpyY8i0LEBuHeeTfJCPmo/g4wB9TDwFKHgS20NmAWXqxTMz7MS1C
xS74dY7RpnA93qIdO55Zqg7kC2wVEoWc7nXM7YDDed+XMKpr7UQcByrn5ncLpHhG
TsQORrp/WgppReuNYh1i
=9hzY
-----END PGP SIGNATURE-----

--hOxx3PEduBGAhadojnuDOlF0KaaFLHi2q--

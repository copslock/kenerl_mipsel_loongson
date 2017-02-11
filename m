Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2017 00:19:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61238 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993201AbdBKXTMgLMvd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Feb 2017 00:19:12 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4B9CE41F8D6C;
        Sun, 12 Feb 2017 00:22:57 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sun, 12 Feb 2017 00:22:57 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sun, 12 Feb 2017 00:22:57 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CC5606C60363F;
        Sat, 11 Feb 2017 23:19:01 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 11 Feb
 2017 23:19:06 +0000
Date:   Sat, 11 Feb 2017 23:19:06 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <john@phrozen.org>
Subject: Re: [PATCH] MIPS: Lantiq: Fix cascaded IRQ setup
Message-ID: <20170211231906.GI24226@jhogan-linux.le.imgtec.org>
References: <20170119112822.59445-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Content-Disposition: inline
In-Reply-To: <20170119112822.59445-1-nbd@nbd.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56777
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

--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Felix,

On Thu, Jan 19, 2017 at 12:28:22PM +0100, Felix Fietkau wrote:
> With the IRQ stack changes integrated, the XRX200 devices started
> emitting a constant stream of kernel messages like this:
>=20
> [  565.415310] Spurious IRQ: CAUSE=3D0x1100c300
>=20
> This appears to be caused by IP0 firing for some reason without being
> handled. Fix this by setting up IP2-6 as a proper chained IRQ handler and
> calling do_IRQ for all MIPS CPU interrupts.
>=20
> Cc: john@phrozen.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Is this still applicable after Matt's fix is applied?
https://patchwork.linux-mips.org/patch/15110/

Cheers
James

> ---
>  arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index 8ac0e5994ed2..0ddf3698b85d 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -269,6 +269,11 @@ static void ltq_hw5_irqdispatch(void)
>  DEFINE_HWx_IRQDISPATCH(5)
>  #endif
> =20
> +static void ltq_hw_irq_handler(struct irq_desc *desc)
> +{
> +	ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
> +}
> +
>  #ifdef CONFIG_MIPS_MT_SMP
>  void __init arch_init_ipiirq(int irq, struct irqaction *action)
>  {
> @@ -313,23 +318,19 @@ static struct irqaction irq_call =3D {
>  asmlinkage void plat_irq_dispatch(void)
>  {
>  	unsigned int pending =3D read_c0_status() & read_c0_cause() & ST0_IM;
> -	unsigned int i;
> -
> -	if ((MIPS_CPU_TIMER_IRQ =3D=3D 7) && (pending & CAUSEF_IP7)) {
> -		do_IRQ(MIPS_CPU_TIMER_IRQ);
> -		goto out;
> -	} else {
> -		for (i =3D 0; i < MAX_IM; i++) {
> -			if (pending & (CAUSEF_IP2 << i)) {
> -				ltq_hw_irqdispatch(i);
> -				goto out;
> -			}
> -		}
> +	int irq;
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		return;
>  	}
> -	pr_alert("Spurious IRQ: CAUSE=3D0x%08x\n", read_c0_status());
> =20
> -out:
> -	return;
> +	pending >>=3D CAUSEB_IP;
> +	while (pending) {
> +		irq =3D fls(pending) - 1;
> +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
> +		pending &=3D ~BIT(irq);
> +	}
>  }
> =20
>  static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number=
_t hw)
> @@ -354,11 +355,6 @@ static const struct irq_domain_ops irq_domain_ops =
=3D {
>  	.map =3D icu_map,
>  };
> =20
> -static struct irqaction cascade =3D {
> -	.handler =3D no_action,
> -	.name =3D "cascade",
> -};
> -
>  int __init icu_of_init(struct device_node *node, struct device_node *par=
ent)
>  {
>  	struct device_node *eiu_node;
> @@ -390,7 +386,7 @@ int __init icu_of_init(struct device_node *node, stru=
ct device_node *parent)
>  	mips_cpu_irq_init();
> =20
>  	for (i =3D 0; i < MAX_IM; i++)
> -		setup_irq(i + 2, &cascade);
> +		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
> =20
>  	if (cpu_has_vint) {
>  		pr_info("Setting up vectored interrupts\n");
> --=20
> 2.11.0
>=20
>=20

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYn5vqAAoJEGwLaZPeOHZ6SA4P/2YSE/MqngZiTtQ5A8v0K3wN
yNxBaLZZpolrYMHke5wS5COFJK7+zOK7+lBggV59jBoIU0ZwdB9uMtRfKp9TYckC
W+W6yzg2gAOZuV2/R9xUeG7GcCfif2YNl4/23/jD2JVZWbG7svzp5he2IzOHQmWT
nbzbX6zBezZWpCUWub8btmPXEZmtzEZbzNCiZDVUOcu5EsKzE8PVUf69OKROVKE7
yanUahHVsxVcaYI+yCMPHk9EzN1OGtMjaVPTY93FKq5ygMH+BIsMtrTCkPJkdqxx
6YujF5zL9GapA67AKP415dFKRlQBuNKqpbMhFwYZzulIIKdHoZVy8f0UcAvTVldp
JHxQtO7Wsv5/4yokjFNb4OohzTW5/2U5JhadbSCnKeSdPG6zGuzc+kDCgSTDjYVt
z1eu2SaOuLm99vvNt/CWiEd5ZPZSpOsg6CZaekuPhze0QThYa/kmTcnifIF5paee
/+ofR/gwmjmJ1dYedjV1UyHSVah9WvlfbtGcqzB5vAMIHqLLBk1wWkQjvOMGeWsq
PH60kIgUq/nCxn+7jNu4UcOJgAinpKkWUQZZwdfCe5+wQoNm/LWb53nMMc7exdVM
D0pHiOA4qphv4dHZldvQEjR7ns1O3cmIqfcccJS0sb57F69bHRrhEgzUOGrwpBlY
M42wBmjfJ5KGjL+m8OAY
=tHYS
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--

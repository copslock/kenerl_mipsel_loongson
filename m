Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 12:22:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58322 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990521AbcJQKWiNCNzU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 12:22:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id EFE9341F8E1B;
        Mon, 17 Oct 2016 11:22:08 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 17 Oct 2016 11:22:08 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 17 Oct 2016 11:22:08 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 99EF8AB4DB027;
        Mon, 17 Oct 2016 11:22:29 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 11:22:32 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 11:22:31 +0100
Date:   Mon, 17 Oct 2016 11:22:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: generic: Fix KASLR for generic kernel.
Message-ID: <20161017102231.GB9443@jhogan-linux.le.imgtec.org>
References: <1476698709-6771-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <1476698709-6771-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55449
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

--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Mon, Oct 17, 2016 at 11:05:09AM +0100, Matt Redfearn wrote:
> The KASLR code requires that the plat_get_fdt() function return the
> address of the device tree, and it must be available early in the boot,
> before prom_init() is called. Move the code determining the address of
> the device tree into plat_get_fdt, and call that from prom_init().
>=20
> The fdt pointer will be set up by plat_get_fdt() called from
> relocate_kernel initially and once the relocated kernel has started,
> prom_init() will use it again to determine the address in the relocated
> image.
>=20
> Fixes: eed0eabd12ef

I believe this is the preferred form:

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board suppo=
rt")

Otherwise looks good to me

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>=20
>  arch/mips/generic/init.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
> index 0ea73e845440..d493ccbf274a 100644
> --- a/arch/mips/generic/init.c
> +++ b/arch/mips/generic/init.c
> @@ -30,9 +30,19 @@ static __initdata const void *mach_match_data;
> =20
>  void __init prom_init(void)
>  {
> +	plat_get_fdt();
> +	BUG_ON(!fdt);
> +}
> +
> +void __init *plat_get_fdt(void)
> +{
>  	const struct mips_machine *check_mach;
>  	const struct of_device_id *match;
> =20
> +	if (fdt)
> +		/* Already set up */
> +		return (void *)fdt;
> +
>  	if ((fw_arg0 =3D=3D -2) && !fdt_check_header((void *)fw_arg1)) {
>  		/*
>  		 * We booted using the UHI boot protocol, so we have been
> @@ -75,12 +85,6 @@ void __init prom_init(void)
>  		/* Retrieve the machine's FDT */
>  		fdt =3D mach->fdt;
>  	}
> -
> -	BUG_ON(!fdt);
> -}
> -
> -void __init *plat_get_fdt(void)
> -{
>  	return (void *)fdt;
>  }
> =20
> --=20
> 2.7.4
>=20
>=20

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBKZnAAoJEGwLaZPeOHZ6X44P/1QazgHAsom8vidd2KFIL1Ii
V245WTuSzuh+Cpzeln1PmJ9blAlv5k03gg2hgYnIGDg+pfOb67qlI2r5yqfkzRTt
22GUFiwFXiyHOzj//9jLc4fal2PlyYDKCWiFf8QOn2l45VyjahIAlItssQ/M/PYf
EfeNFp4Q6Y6gPMz3lbVQGQXbUvPov7hFXbx1ErsZ2GJu8KZPu/Y7rh5oOjNeB6ef
PhQ4kpnl6iMLdmiwJfbxSTgD4dLaxLx5+bDfRo9d7VQYb6s5tqE+3gyN+8Yd9KBw
/aRqkv6B0SiCcJdNPWwj/pi8zqgXAECQHKAbpdkej4jemyX/sI2rSQjOpX11XUCb
B8e9O3VXndTZrjwPaMUAOtOhVyuCXRNntAB9Z0DT6zw1Et+3b8kl39dsm4PqvbBj
22OW4tIJ8sAaAd9zeaQ15IdEq8K0bemJSuB0bHFWw8kkrfZIqDT5PF6eM9JXdD7U
m8zEwPiFIsw+qCA7rasTJ63e5Ub9oZ5EmyOA+BiZjXPolm8MxO5tHeE0ucAeHTF9
KiV1J7IaPs61JYnGC4eTUr8CSUNbiCitUGeEgQwthLXnoHfdVNWhnalIrtdAxXY0
QIhU+RR7g+ArB/DgE2JiM8NiCuaVcaCyjHFHSNJ3AyiHQUY2d6sGJVHM4IlJX7GJ
tK6+QOE+VWNikAVpWszF
=jOH6
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

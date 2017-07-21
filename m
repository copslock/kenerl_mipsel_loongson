Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 17:42:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6309 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993122AbdGUPmHNR-79 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 17:42:07 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B6A7E41F8EBF;
        Fri, 21 Jul 2017 17:53:07 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 17:53:07 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 17:53:07 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B15D664F438F1;
        Fri, 21 Jul 2017 16:41:57 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 16:42:01 +0100
Date:   Fri, 21 Jul 2017 16:42:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 08/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of
 input values with opposite signs
Message-ID: <20170721154201.GM6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-9-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SynvOvfBJIiBbhhO"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-9-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59197
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

--SynvOvfBJIiBbhhO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:06PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the value returned by <MAXA|MINA>.<D|S>, if inputs are normal fp
> numbers of the same absolute value, but opposite signs.
>=20
> The relevant example:
>=20
> MAXA.S fd,fs,ft:
>   If fs contains -3, and ft contains +3, fd is going to contain +3
>   (without this patch, it used to contain -3).

I think its worth mentioning also that for MINA.*, it returns the
negative one when the absolute values are equal (The phrase "For equal
absolute values, returns the smallest positive argument" in the manual
is a bit ambiguous IMO, so I ended up checking what I6500 did).

>=20

Usual fixes/stable thing.

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  arch/mips/math-emu/dp_fmax.c | 8 ++++++--
>  arch/mips/math-emu/dp_fmin.c | 6 +++++-
>  arch/mips/math-emu/sp_fmax.c | 8 ++++++--
>  arch/mips/math-emu/sp_fmin.c | 6 +++++-
>  4 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
> index a0175cc..860b43f9 100644
> --- a/arch/mips/math-emu/dp_fmax.c
> +++ b/arch/mips/math-emu/dp_fmax.c
> @@ -224,7 +224,11 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, u=
nion ieee754dp y)
>  		return y;
> =20
>  	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	if (xm < ym)
>  		return y;
> -	return x;
> +	else if (xm > ym)
> +		return x;
> +	else if (xs =3D=3D 0)
> +		return x;
> +	return y;
>  }
> diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
> index 074a858..73d85e4 100644
> --- a/arch/mips/math-emu/dp_fmin.c
> +++ b/arch/mips/math-emu/dp_fmin.c
> @@ -224,7 +224,11 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, u=
nion ieee754dp y)
>  		return x;
> =20
>  	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	if (xm < ym)
> +		return x;
> +	else if (xm > ym)
> +		return y;
> +	else if (xs =3D=3D 1)
>  		return x;
>  	return y;
>  }
> diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
> index 15825db..fec7f64 100644
> --- a/arch/mips/math-emu/sp_fmax.c
> +++ b/arch/mips/math-emu/sp_fmax.c
> @@ -224,7 +224,11 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, u=
nion ieee754sp y)
>  		return y;
> =20
>  	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	if (xm < ym)
>  		return y;
> -	return x;
> +	else if (xm > ym)
> +		return x;
> +	else if (xs =3D=3D 0)
> +		return x;
> +	return y;
>  }
> diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
> index f1418f7..74780bc 100644
> --- a/arch/mips/math-emu/sp_fmin.c
> +++ b/arch/mips/math-emu/sp_fmin.c
> @@ -225,7 +225,11 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, u=
nion ieee754sp y)
>  		return x;
> =20
>  	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	if (xm < ym)
> +		return x;
> +	else if (xm > ym)
> +		return y;
> +	else if (xs =3D=3D 1)
>  		return x;
>  	return y;
>  }
> --=20
> 2.7.4
>=20

--SynvOvfBJIiBbhhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyIMgACgkQbAtpk944
dnoAuA//dmGmcL/yHnQUkIViJmBN6Hly/2a9FfpFYMabSuX0fyoJG23rGq80fbl6
du35sHVoncEU+bySDOvi+l18gsrEs1wLb2VVq9Q5Dl/duACURYKbYi62XdBZDZqS
za61EPNu4qHW1PGtq/eG6xNyDJbLBbQkU2q+U0x7QIrGfofvskDlx+5K/59NB9F3
I5yrWHOXYvU6pbarpsf+Fix8eHf2mo+kzA6NZcUsTIWYhQNQhVJrC9SK2EMKgvO0
jo85wfCBoUwLH3N5I1yA8/HmKtPwW7DUItLRpl2JsO6GmsbCwLS1xe8Ld5uOpUhS
CzBMftffE+KDVvgvDfunlwpUbbVc6oZei714GCo0CiKizQxWxHDKvSgRyWjLPzME
BRwhry/eytsg8oztysMAeg8wha22TsUDXCxH3THkU3XVTnWX6ke5Zl0Mwlknp+6r
ddfdyYlAht4kT7eFe4rnlVJF4qQPd2LSGKEJg9UEA8b90TQBycrTlP04CgYiaD/D
NUZb3+Xl8oSwyOjmZjkQSj0MW/ZwHuVxDYgqNuw9nIh6rToQG91KxmwCOcjacWn4
Av4L6FfMBrJ4XsKtGz2WyxpVg8IANcHIyCm4GRZyJXa/p+7kSS4bevvku/HbRn+I
FlFxMgcgvSRxJAIH357Wnl1LeA+QeiFmmy0ZZ2ltmAI11yytK2Q=
=9W/X
-----END PGP SIGNATURE-----

--SynvOvfBJIiBbhhO--

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 12:24:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8469 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990510AbdGXKYTBnciN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 12:24:19 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C632741F8E18;
        Mon, 24 Jul 2017 12:35:26 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 24 Jul 2017 12:35:26 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 24 Jul 2017 12:35:26 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56D69ACF301C7;
        Mon, 24 Jul 2017 11:24:11 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 11:24:12 +0100
Date:   Mon, 24 Jul 2017 11:24:12 +0100
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
Subject: Re: [PATCH v3 11/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix NaN
 propagation
Message-ID: <20170724102412.GP6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-12-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfbWTnNdPEvwDq13"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-12-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59218
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

--kfbWTnNdPEvwDq13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:09PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the cases of <MADDF|MSUBF>.<D|S> when any of three inputs is any
> NaN. Correct behavior of <MADDF|MSUBF>.<D|S> fd, fs, ft is following:
>=20
>   - if any of inputs is sNaN, return a sNaN using following rules: if
>     only one input is sNaN, return that one; if more than one input is
>     sNaN, order of precedence for return value is fd, fs, ft
>   - if no input is sNaN, but at least one of inputs is qNaN, return a
>     qNaN using following rules: if only one input is qNaN, return that
>     one; if more than one input is qNaN, order of precedence for
>     return value is fd, fs, ft
>=20
> The previous code contained handling of some above cases, but not all.
> Also, such handling was scattered into various cases of
> "switch (CLPAIR(xc, yc))" statement and elsewhere. With this patch,
> this logic is placed in one place, and "switch (CLPAIR(xc, yc))" is
> significantly simplified.
>=20
> The relevant example:
>=20
> MADDF.S fd,fs,ft:
>   If fs contains qNaN1, ft contains qNaN2, and fd contains qNaN3, fd
>   is going to contain qNaN3 (without this patch, it used to contain
>   qNaN1).
>=20

Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU=
 instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU=
 instruction")

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

If backported, I suspect commits:
6162051e87f6 ("MIPS: math-emu: Unify ieee754sp_m{add,sub}f")
and
d728f6709bcc ("MIPS: math-emu: Unify ieee754dp_m{add,sub}f")
in 4.7 will require manual backporting between 4.3 and 4.7 (due to
separation of maddf/msubf before that point), so I suppose tagging
stable 4.7+ and backporting is best (assuming you consider this fix
worth backporting).

> ---
>  arch/mips/math-emu/dp_maddf.c | 71 ++++++++++++++-----------------------=
------
>  arch/mips/math-emu/sp_maddf.c | 69 ++++++++++++++-----------------------=
----
>  2 files changed, 46 insertions(+), 94 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
> index caa62f2..4f2e783 100644
> --- a/arch/mips/math-emu/dp_maddf.c
> +++ b/arch/mips/math-emu/dp_maddf.c
> @@ -48,52 +48,35 @@ static union ieee754dp _dp_maddf(union ieee754dp z, u=
nion ieee754dp x,
> =20
>  	ieee754_clearcx();
> =20
> -	switch (zc) {
> -	case IEEE754_CLASS_SNAN:
> -		ieee754_setcx(IEEE754_INVALID_OPERATION);
> -		return ieee754dp_nanxcpt(z);
> -	case IEEE754_CLASS_DNORM:
> -		DPDNORMZ;
> -	/* QNAN and ZERO cases are handled separately below */
> -	}
> -
> -	switch (CLPAIR(xc, yc)) {
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
> -		return ieee754dp_nanxcpt(y);
> -
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
> -		return ieee754dp_nanxcpt(x);
> -
> -	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
> +	/* handle the cases when at least one of x, y or z is a NaN */
> +	if (((xc =3D=3D IEEE754_CLASS_SNAN) || (xc =3D=3D IEEE754_CLASS_QNAN)) =
||
> +	    ((yc =3D=3D IEEE754_CLASS_SNAN) || (yc =3D=3D IEEE754_CLASS_QNAN)) =
||
> +	    ((zc =3D=3D IEEE754_CLASS_SNAN) || (zc =3D=3D IEEE754_CLASS_QNAN)))=
 {

This condition basically covers all of the cases below. Any particular
reason not to skip it ...

> +		/* order of precedence is z, x, y */
> +		if (zc =3D=3D IEEE754_CLASS_SNAN)
> +			return ieee754dp_nanxcpt(z);
> +		if (xc =3D=3D IEEE754_CLASS_SNAN)
> +			return ieee754dp_nanxcpt(x);
> +		if (yc =3D=3D IEEE754_CLASS_SNAN)
> +			return ieee754dp_nanxcpt(y);
> +		if (zc =3D=3D IEEE754_CLASS_QNAN)
> +			return z;
> +		if (xc =3D=3D IEEE754_CLASS_QNAN)
> +			return x;
>  		return y;

=2E.. and make this return conditional on (yc =3D=3D IEEE754_CLASS_QNAN)?

Same for sp_maddf.c too.

Otherwise:
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> +	}
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
> -		return x;
> +	if (zc =3D=3D IEEE754_CLASS_DNORM)
> +		DPDNORMZ;
> +	/* ZERO z cases are handled separately below */
> =20
> +	switch (CLPAIR(xc, yc)) {
> =20
>  	/*
>  	 * Infinity handling
>  	 */
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
>  		ieee754_setcx(IEEE754_INVALID_OPERATION);
>  		return ieee754dp_indef();
> =20
> @@ -102,8 +85,6 @@ static union ieee754dp _dp_maddf(union ieee754dp z, un=
ion ieee754dp x,
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
>  		return ieee754dp_inf(xs ^ ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> @@ -120,25 +101,19 @@ static union ieee754dp _dp_maddf(union ieee754dp z,=
 union ieee754dp x,
>  		DPDNORMX;
> =20
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
> -		else if (zc =3D=3D IEEE754_CLASS_INF)
> +		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754dp_inf(zs);
>  		DPDNORMY;
>  		break;
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
> -		else if (zc =3D=3D IEEE754_CLASS_INF)
> +		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754dp_inf(zs);
>  		DPDNORMX;
>  		break;
> =20
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
> -		else if (zc =3D=3D IEEE754_CLASS_INF)
> +		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754dp_inf(zs);
>  		/* fall through to real computations */
>  	}
> diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
> index c91d5e5..9fd2035 100644
> --- a/arch/mips/math-emu/sp_maddf.c
> +++ b/arch/mips/math-emu/sp_maddf.c
> @@ -48,51 +48,36 @@ static union ieee754sp _sp_maddf(union ieee754sp z, u=
nion ieee754sp x,
> =20
>  	ieee754_clearcx();
> =20
> -	switch (zc) {
> -	case IEEE754_CLASS_SNAN:
> -		ieee754_setcx(IEEE754_INVALID_OPERATION);
> -		return ieee754sp_nanxcpt(z);
> -	case IEEE754_CLASS_DNORM:
> -		SPDNORMZ;
> -	/* QNAN and ZERO cases are handled separately below */
> +	/* handle the cases when at least one of x, y or z is a NaN */
> +	if (((xc =3D=3D IEEE754_CLASS_SNAN) || (xc =3D=3D IEEE754_CLASS_QNAN)) =
||
> +	    ((yc =3D=3D IEEE754_CLASS_SNAN) || (yc =3D=3D IEEE754_CLASS_QNAN)) =
||
> +	    ((zc =3D=3D IEEE754_CLASS_SNAN) || (zc =3D=3D IEEE754_CLASS_QNAN)))=
 {
> +		/* order of precedence is z, x, y */
> +		if (zc =3D=3D IEEE754_CLASS_SNAN)
> +			return ieee754sp_nanxcpt(z);
> +		if (xc =3D=3D IEEE754_CLASS_SNAN)
> +			return ieee754sp_nanxcpt(x);
> +		if (yc =3D=3D IEEE754_CLASS_SNAN)
> +			return ieee754sp_nanxcpt(y);
> +		if (zc =3D=3D IEEE754_CLASS_QNAN)
> +			return z;
> +		if (xc =3D=3D IEEE754_CLASS_QNAN)
> +			return x;
> +		return y;
>  	}
> =20
> +	if (zc =3D=3D IEEE754_CLASS_DNORM)
> +		SPDNORMZ;
> +	/* ZERO z cases are handled separately below */
> +
>  	switch (CLPAIR(xc, yc)) {
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
> -		return ieee754sp_nanxcpt(y);
> -
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
> -	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
> -		return ieee754sp_nanxcpt(x);
> -
> -	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
> -		return y;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_INF):
> -		return x;
> =20
>  	/*
>  	 * Infinity handling
>  	 */
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
>  		ieee754_setcx(IEEE754_INVALID_OPERATION);
>  		return ieee754sp_indef();
> =20
> @@ -101,8 +86,6 @@ static union ieee754sp _sp_maddf(union ieee754sp z, un=
ion ieee754sp x,
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
>  		return ieee754sp_inf(xs ^ ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> @@ -119,25 +102,19 @@ static union ieee754sp _sp_maddf(union ieee754sp z,=
 union ieee754sp x,
>  		SPDNORMX;
> =20
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
> -		else if (zc =3D=3D IEEE754_CLASS_INF)
> +		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754sp_inf(zs);
>  		SPDNORMY;
>  		break;
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_NORM):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
> -		else if (zc =3D=3D IEEE754_CLASS_INF)
> +		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754sp_inf(zs);
>  		SPDNORMX;
>  		break;
> =20
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
> -		if (zc =3D=3D IEEE754_CLASS_QNAN)
> -			return z;
> -		else if (zc =3D=3D IEEE754_CLASS_INF)
> +		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754sp_inf(zs);
>  		/* fall through to real computations */
>  	}
> --=20
> 2.7.4
>=20

--kfbWTnNdPEvwDq13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll1yr4ACgkQbAtpk944
dnpyGxAAvAE12wcW6rEfKelJLaqYjsD+QJrcSsDUZPC1nGrRb90R/46kkaF2CuEv
imkuCpyNTsWXbAxdUh4ae5U8bK8oTc/0Z6cxd2ZP6gpKOy+P/Bc8aXEGdaUBMphh
931hJNuaNwSxKlWgGeuGspZ1pe1LtPJIoRDgJQQoXBGGKBrtL3ENt1V4/nLTzMTK
1aQiN66yIs3Hea0dqJzy5Rvxiy/yLTWsH4daB9Pp0xKWuBSN1ivIwC0MXhZwLgRv
ciJZ5Y2TqQHz2FPF6Q1ZpxqqeJlodv5DpdQR2zRbK7PHrQ6iY9oZdXbseag1mbyK
4ACsF0te8OofWlPmzk3Bcg/U88Ao/eHgGreEQbPpeyHXISF3n6O6clizt+9OJJFy
XHNibLgWzHrjvHJP761IayfTEtA87SjmawuOfhKWE802MlgbmSOrsvPur6OrLeaq
b8d4yQ8xR+TaluiOeZS+NzJk0ZAwQ5oPEJzHuLE6/YRqbh4cv4gZrB9GQD0cECDS
XTTQPBToc0b25RdfmieFS9MaqFU9aOAO9wzeRQzDl6jDTHsKuZ9XBSEXJD/LnaIJ
6vYujo9g8tm7y8aGqRLtWnCRVUIHzeQO3kkY1rEl76h8+GmmWK13n3UYRZjziSdW
O/edw+hsMIk7nVOL8g1502FSzsEhBlRV6u39r2eK0kMIfH/h8t0=
=3SxC
-----END PGP SIGNATURE-----

--kfbWTnNdPEvwDq13--

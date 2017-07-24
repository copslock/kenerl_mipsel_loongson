Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 14:06:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65022 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991087AbdGXMGK4MmLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 14:06:10 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0CD9F41F8E18;
        Mon, 24 Jul 2017 14:17:19 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 24 Jul 2017 14:17:19 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 24 Jul 2017 14:17:19 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 28D8B56C6F15A;
        Mon, 24 Jul 2017 13:06:03 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 13:06:05 +0100
Date:   Mon, 24 Jul 2017 13:06:04 +0100
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
Subject: Re: [PATCH v3 16/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Clean up
 maddf_flags enumeration
Message-ID: <20170724120604.GS6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-17-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3X8HaB+/xMECYZdj"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-17-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59221
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

--3X8HaB+/xMECYZdj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:14PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix definition and usage of maddf_flags enumeration. Avoid duplicate
> definition and apply more common capitalization.
>=20
> This patch does not change any scenario. It just make MADDF and MSUBF
> emulation code more readable and easier to maintain, and hopefully
> also prevents future bugs.
>=20
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_maddf.c   | 19 ++++++++-----------
>  arch/mips/math-emu/ieee754int.h |  4 ++++
>  arch/mips/math-emu/sp_maddf.c   | 19 ++++++++-----------
>  3 files changed, 20 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
> index 68b55c8..d36f01a 100644
> --- a/arch/mips/math-emu/dp_maddf.c
> +++ b/arch/mips/math-emu/dp_maddf.c
> @@ -14,9 +14,6 @@
> =20
>  #include "ieee754dp.h"
> =20
> -enum maddf_flags {
> -	maddf_negate_product	=3D 1 << 0,
> -};
> =20
>  /* 128 bits shift right logical with rounding. */
>  void srl128(u64 *hptr, u64 *lptr, int count)
> @@ -111,8 +108,8 @@ static union ieee754dp _dp_maddf(union ieee754dp z, u=
nion ieee754dp x,
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
>  		if ((zc =3D=3D IEEE754_CLASS_INF) &&
> -		    ((!(flags & maddf_negate_product) && (zs !=3D (xs ^ ys))) ||
> -		     ((flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))))) {
> +		    ((!(flags & MADDF_NEGATE_PRODUCT) && (zs !=3D (xs ^ ys))) ||
> +		     ((flags & MADDF_NEGATE_PRODUCT) && (zs =3D=3D (xs ^ ys))))) {
>  			/*
>  			 * Cases of addition of infinities with opposite signs
>  			 * or subtraction of infinities with same signs.
> @@ -124,9 +121,9 @@ static union ieee754dp _dp_maddf(union ieee754dp z, u=
nion ieee754dp x,
>  		 * z is here either not infinity, or infinity of the same sign
>  		 * as maddf_negate_product * x * y. So, the result must be
>  		 * infinity, and its sign is determined only by the value of
> -		 * (flags & maddf_negate_product) and the signs of x and y.
> +		 * (flags & MADDF_NEGATE_PRODUCT) and the signs of x and y.
>  		 */
> -		if (flags & maddf_negate_product)
> +		if (flags & MADDF_NEGATE_PRODUCT)
>  			return ieee754dp_inf(1 ^ (xs ^ ys));
>  		else
>  			return ieee754dp_inf(xs ^ ys);
> @@ -140,8 +137,8 @@ static union ieee754dp _dp_maddf(union ieee754dp z, u=
nion ieee754dp x,
>  			return ieee754dp_inf(zs);
>  		/* Handle cases +0 + (-0) and similar ones. */
>  		if (zc =3D=3D IEEE754_CLASS_ZERO) {
> -			if ((!(flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))) ||
> -			    ((flags & maddf_negate_product) && (zs !=3D (xs ^ ys))))
> +			if ((!(flags & MADDF_NEGATE_PRODUCT) && (zs =3D=3D (xs ^ ys))) ||
> +			    ((flags & MADDF_NEGATE_PRODUCT) && (zs !=3D (xs ^ ys))))
>  				return z;
>  			else
>  				return ieee754dp_zero(ieee754_csr.rm =3D=3D FPU_CSR_RD);
> @@ -184,7 +181,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, u=
nion ieee754dp x,
> =20
>  	re =3D xe + ye;
>  	rs =3D xs ^ ys;
> -	if (flags & maddf_negate_product)
> +	if (flags & MADDF_NEGATE_PRODUCT)
>  		rs ^=3D 1;
> =20
>  	/* shunt to top of word */
> @@ -335,5 +332,5 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, un=
ion ieee754dp x,
>  union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
>  				union ieee754dp y)
>  {
> -	return _dp_maddf(z, x, y, maddf_negate_product);
> +	return _dp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
>  }
> diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754=
int.h
> index 8bc2f69..dd2071f 100644
> --- a/arch/mips/math-emu/ieee754int.h
> +++ b/arch/mips/math-emu/ieee754int.h
> @@ -26,6 +26,10 @@
> =20
>  #define CLPAIR(x, y)	((x)*6+(y))
> =20
> +enum maddf_flags {
> +	MADDF_NEGATE_PRODUCT	=3D 1 << 0,
> +};
> +
>  static inline void ieee754_clearcx(void)
>  {
>  	ieee754_csr.cx =3D 0;
> diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
> index b380189..715cc47 100644
> --- a/arch/mips/math-emu/sp_maddf.c
> +++ b/arch/mips/math-emu/sp_maddf.c
> @@ -14,9 +14,6 @@
> =20
>  #include "ieee754sp.h"
> =20
> -enum maddf_flags {
> -	maddf_negate_product	=3D 1 << 0,
> -};
> =20
>  static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
>  				 union ieee754sp y, enum maddf_flags flags)
> @@ -81,8 +78,8 @@ static union ieee754sp _sp_maddf(union ieee754sp z, uni=
on ieee754sp x,
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
>  		if ((zc =3D=3D IEEE754_CLASS_INF) &&
> -		    ((!(flags & maddf_negate_product) && (zs !=3D (xs ^ ys))) ||
> -		     ((flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))))) {
> +		    ((!(flags & MADDF_NEGATE_PRODUCT) && (zs !=3D (xs ^ ys))) ||
> +		     ((flags & MADDF_NEGATE_PRODUCT) && (zs =3D=3D (xs ^ ys))))) {
>  			/*
>  			 * Cases of addition of infinities with opposite signs
>  			 * or subtraction of infinities with same signs.
> @@ -94,9 +91,9 @@ static union ieee754sp _sp_maddf(union ieee754sp z, uni=
on ieee754sp x,
>  		 * z is here either not infinity, or infinity of the same sign
>  		 * as maddf_negate_product * x * y. So, the result must be
>  		 * infinity, and its sign is determined only by the value of
> -		 * (flags & maddf_negate_product) and the signs of x and y.
> +		 * (flags & MADDF_NEGATE_PRODUCT) and the signs of x and y.
>  		 */
> -		if (flags & maddf_negate_product)
> +		if (flags & MADDF_NEGATE_PRODUCT)
>  			return ieee754sp_inf(1 ^ (xs ^ ys));
>  		else
>  			return ieee754sp_inf(xs ^ ys);
> @@ -110,8 +107,8 @@ static union ieee754sp _sp_maddf(union ieee754sp z, u=
nion ieee754sp x,
>  			return ieee754sp_inf(zs);
>  		/* Handle cases +0 + (-0) and similar ones. */
>  		if (zc =3D=3D IEEE754_CLASS_ZERO) {
> -			if ((!(flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))) ||
> -			    ((flags & maddf_negate_product) && (zs !=3D (xs ^ ys))))
> +			if ((!(flags & MADDF_NEGATE_PRODUCT) && (zs =3D=3D (xs ^ ys))) ||
> +			    ((flags & MADDF_NEGATE_PRODUCT) && (zs !=3D (xs ^ ys))))
>  				return z;
>  			else
>  				return ieee754sp_zero(ieee754_csr.rm =3D=3D FPU_CSR_RD);
> @@ -156,7 +153,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, u=
nion ieee754sp x,
> =20
>  	re =3D xe + ye;
>  	rs =3D xs ^ ys;
> -	if (flags & maddf_negate_product)
> +	if (flags & MADDF_NEGATE_PRODUCT)
>  		rs ^=3D 1;
> =20
>  	/* Multiple 24 bit xm and ym to give 48 bit results */
> @@ -255,5 +252,5 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, un=
ion ieee754sp x,
>  union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
>  				union ieee754sp y)
>  {
> -	return _sp_maddf(z, x, y, maddf_negate_product);
> +	return _sp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
>  }
> --=20
> 2.7.4
>=20

--3X8HaB+/xMECYZdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll14qsACgkQbAtpk944
dnqx3w/+PCjr3XmGjoBvIqoJDcC4uPFOOfZngvNEqduY6fS6J93GcUMrPy9DlRbu
YbR9RT2052VzFYCGww00sKdIsBwKgIzHdlNqDjs0JTX1eIkXS7VOw7jBf8X1u00y
8Cjs48sLlBelGflqpfQF3Oby9IwP935CFVrJdP8z9DsLtKE7OprO1dDUpt57ST2A
7XZmqUSmYuUEcEJEmL1SIwd06KbZ0CILsfShN0bYa43G0T9nTf/0+mh8aLEM0pen
D4j9kTUqe4/kOy8PQBhoLRvHcj0q22MYM970yKlUp+AmuPIvCkubqFHrKDzbPJzb
7GGFf/icApgDhAdUtS9ieYylB2KDDsCtqjC/RHHXtPahwxK88X/LAMh6pL/wyY2A
JIjLerh8ei5X3pFZChxcozG/fZEd14OPk1b5ai2C7Jr4GfTdWs1mArZ/x1lwPxnm
42GCrL65LY+mgMmCCw2uGK2MghYx5U4T8pUj8zLPIPqhidwAmEm/GkT2eilmr/os
xIVsjhPEegE6duC9lLedlla7PykFv8JvFqIzeInK0iz+5BcKE4kj/QDhhx0tmb07
o+xOjISG5c7bCMegRQbK+zoYPdOHiVCl0bv4zSfiQqziGIsqn18tjwlUjxwDrcNG
K+LZLJELLBEg95NBoeZfd3aOSDjzuL9V024zQird2yAqB3TSlrk=
=s8to
-----END PGP SIGNATURE-----

--3X8HaB+/xMECYZdj--

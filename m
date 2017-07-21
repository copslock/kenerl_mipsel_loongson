Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 17:03:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15828 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992974AbdGUPDjOjAwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 17:03:39 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 76D0A41F8EBE;
        Fri, 21 Jul 2017 17:14:39 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 17:14:39 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 17:14:39 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A250715770067;
        Fri, 21 Jul 2017 16:03:29 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 16:03:33 +0100
Date:   Fri, 21 Jul 2017 16:03:32 +0100
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
Subject: Re: [PATCH v3 06/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix
 cases of both inputs zero
Message-ID: <20170721150332.GK6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-7-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/dewtoG6vGg3vzo2"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-7-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59195
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

--/dewtoG6vGg3vzo2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:04PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the value returned by <MAX|MAXA|MIN|MINA>.<D|S>, if both inputs
> are zeros. The right behavior in such cases is stated in instruction
> reference manual and is as follows:
>=20
>    fs  ft       MAX     MIN       MAXA    MINA
>   ---------------------------------------------
>     0   0        0       0         0       0
>     0  -0        0      -0         0      -0
>    -0   0        0      -0         0      -0
>    -0  -0       -0      -0        -0      -0

To be fair I think the min behaviour was already technically correct.
When the values matched it returned that value, and when they didn't
match it returned -0, so max could have just been fixed to return
ieee754*p_zero(0), but its fine IMO to rewrite both like you have.

>=20
> The relevant example:
>=20
> MAX.S fd,fs,ft:
>   If fs contains +0, and ft contains -0, fd is going to contain 0
>   (without this patch, it used to contain -0).
>=20

Consider Fixes and Cc stable as with other patch

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Otherwise
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_fmax.c | 8 ++------
>  arch/mips/math-emu/dp_fmin.c | 8 ++------
>  arch/mips/math-emu/sp_fmax.c | 8 ++------
>  arch/mips/math-emu/sp_fmin.c | 8 ++------
>  4 files changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
> index 567fc33..9517572 100644
> --- a/arch/mips/math-emu/dp_fmax.c
> +++ b/arch/mips/math-emu/dp_fmax.c
> @@ -82,9 +82,7 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union=
 ieee754dp y)
>  		return ys ? x : y;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754dp_zero(1);
> +		return ieee754dp_zero(xs & ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		DPDNORMX;
> @@ -184,9 +182,7 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, un=
ion ieee754dp y)
>  		return y;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754dp_zero(1);
> +		return ieee754dp_zero(xs & ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		DPDNORMX;
> diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
> index 77f7ca9..7069320 100644
> --- a/arch/mips/math-emu/dp_fmin.c
> +++ b/arch/mips/math-emu/dp_fmin.c
> @@ -82,9 +82,7 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union=
 ieee754dp y)
>  		return ys ? y : x;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754dp_zero(1);
> +		return ieee754dp_zero(xs | ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		DPDNORMX;
> @@ -184,9 +182,7 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, un=
ion ieee754dp y)
>  		return y;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754dp_zero(1);
> +		return ieee754dp_zero(xs | ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		DPDNORMX;
> diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
> index d46e8e4..d72111a 100644
> --- a/arch/mips/math-emu/sp_fmax.c
> +++ b/arch/mips/math-emu/sp_fmax.c
> @@ -82,9 +82,7 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union=
 ieee754sp y)
>  		return ys ? x : y;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754sp_zero(1);
> +		return ieee754sp_zero(xs & ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		SPDNORMX;
> @@ -184,9 +182,7 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, un=
ion ieee754sp y)
>  		return y;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754sp_zero(1);
> +		return ieee754sp_zero(xs & ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		SPDNORMX;
> diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
> index b528c4b..61ff9c6 100644
> --- a/arch/mips/math-emu/sp_fmin.c
> +++ b/arch/mips/math-emu/sp_fmin.c
> @@ -82,9 +82,7 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union=
 ieee754sp y)
>  		return ys ? y : x;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754sp_zero(1);
> +		return ieee754sp_zero(xs | ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		SPDNORMX;
> @@ -184,9 +182,7 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, un=
ion ieee754sp y)
>  		return y;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
> -		if (xs =3D=3D ys)
> -			return x;
> -		return ieee754sp_zero(1);
> +		return ieee754sp_zero(xs | ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
>  		SPDNORMX;
> --=20
> 2.7.4
>=20

--/dewtoG6vGg3vzo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyF8MACgkQbAtpk944
dnp3AA/9GkOzYD9a6HiBC6QFz6q6a8lfS9DBZqvqd1z/FV32U/Ovi/KLSXM2rKwg
NvG+Lg8kJcEAn2eNbPHSpNePj87YLGn8Dk9oSdk/SlLMzkT83v3ANLC5pclE5qT+
SujyOvml36mtXC+7CBZdfdOkt7DIMNM2mBTfBS+NCPnWwJU+9ZqWS2mwmzuNaB+n
O+kc6lZruMQ6CxKcmOVsOg04UX/fUvvIK9HDcX36wIR8e19Z+uhcn6LB7RsH3nVy
Tusj1UURMSR/H+7Mv116fFwtahoRGx9yopqxE472HcXEsC+5Z0Tt36S4mV8tDLJO
nQvqYVr6MhQhhjmci+QETR5S67+Eky8FCWaahYz1qM1mAaaap/wZetNE6bS6+vcj
9VgygOFNic+Lbra+UTQLwg93H+lVMTJNKMMuFWtq7AY0DbzIbitu15IbqfQNNnaT
eDHwmUGV9aNp6cDaq7iabftNCZy+ajuxXsU1cAgW488zH3YLwwHJwMjxC2L5O5Mz
4PnFQSGQu+SKsoK+E1pU7a9LVwQj+FnN7cAS72w/zoEqI31FKhQ0MR39jtpbka6G
hWMYVkC788b330ztVYjwT4qzE0bpFZp/zQDxId8bJpSFnZsrm1Npu+++1DDtVBqX
ahnAQyPISCCoHrePMbrUo193e/W0QhTb/lEixra+ssrYZBJI+YY=
=QSd4
-----END PGP SIGNATURE-----

--/dewtoG6vGg3vzo2--

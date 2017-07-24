Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 12:39:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40020 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991087AbdGXKjU4llKv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 12:39:20 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B535641F8E18;
        Mon, 24 Jul 2017 12:50:28 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 24 Jul 2017 12:50:28 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 24 Jul 2017 12:50:28 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 361999BB46322;
        Mon, 24 Jul 2017 11:39:13 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 11:39:14 +0100
Date:   Mon, 24 Jul 2017 11:39:14 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 12/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some
 cases of infinite inputs
Message-ID: <20170724103914.GQ6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-13-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6KCWwYHA2nAj8wHB"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-13-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59219
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

--6KCWwYHA2nAj8wHB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:10PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the cases of <MADDF|MSUBF>.<D|S> when any of two multiplicands is
> infinity. The correct behavior in such cases is affected by the nature
> of third input. Cases of addition of infinities with opposite signs
> and subtraction of infinities with same signs may arise and must be
> handles separately. Also, the value od flags argument (that determines

s/handles/handled/?
s/od/of/

> whether the instruction is MADDF or MSUBF) affects the outcome.
>=20
> The relevant examples:
>=20
> MADDF.S fd,fs,ft:
>   If fs contains +inf, ft contains +inf, and fd contains -inf, fd is
>   going to contain indef (without this patch, it used to contain
>   -inf).
>
> MSUBF.S fd,fs,ft:
>   If fs contains +inf, ft contains 1.0, and fd contains +0.0, fd is
>   going to contain -inf (without this patch, it used to contain +inf).
>=20

Same fixes/stable notes as previous patch.

> Signed-off-by: Douglas Leung <douglas.leung@imgtec.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_maddf.c | 21 ++++++++++++++++++++-
>  arch/mips/math-emu/sp_maddf.c | 21 ++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
> index 4f2e783..45f815d 100644
> --- a/arch/mips/math-emu/dp_maddf.c
> +++ b/arch/mips/math-emu/dp_maddf.c
> @@ -85,7 +85,26 @@ static union ieee754dp _dp_maddf(union ieee754dp z, un=
ion ieee754dp x,
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> -		return ieee754dp_inf(xs ^ ys);
> +		if ((zc =3D=3D IEEE754_CLASS_INF) &&
> +		    ((!(flags & maddf_negate_product) && (zs !=3D (xs ^ ys))) ||
> +		     ((flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))))) {
> +			/*
> +			 * Cases of addition of infinities with opposite signs
> +			 * or subtraction of infinities with same signs.
> +			 */
> +			ieee754_setcx(IEEE754_INVALID_OPERATION);
> +			return ieee754dp_indef();
> +		}
> +		/*
> +		 * z is here either not infinity, or infinity of the same sign
> +		 * as maddf_negate_product * x * y. So, the result must be
> +		 * infinity, and its sign is determined only by the value of
> +		 * (flags & maddf_negate_product) and the signs of x and y.
> +		 */
> +		if (flags & maddf_negate_product)
> +			return ieee754dp_inf(1 ^ (xs ^ ys));
> +		else
> +			return ieee754dp_inf(xs ^ ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
> diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
> index 9fd2035..76856d7 100644
> --- a/arch/mips/math-emu/sp_maddf.c
> +++ b/arch/mips/math-emu/sp_maddf.c
> @@ -86,7 +86,26 @@ static union ieee754sp _sp_maddf(union ieee754sp z, un=
ion ieee754sp x,
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> -		return ieee754sp_inf(xs ^ ys);
> +		if ((zc =3D=3D IEEE754_CLASS_INF) &&
> +		    ((!(flags & maddf_negate_product) && (zs !=3D (xs ^ ys))) ||
> +		     ((flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))))) {
> +			/*
> +			 * Cases of addition of infinities with opposite signs
> +			 * or subtraction of infinities with same signs.
> +			 */
> +			ieee754_setcx(IEEE754_INVALID_OPERATION);
> +			return ieee754sp_indef();
> +		}
> +		/*
> +		 * z is here either not infinity, or infinity of the same sign
> +		 * as maddf_negate_product * x * y. So, the result must be
> +		 * infinity, and its sign is determined only by the value of
> +		 * (flags & maddf_negate_product) and the signs of x and y.
> +		 */
> +		if (flags & maddf_negate_product)
> +			return ieee754sp_inf(1 ^ (xs ^ ys));
> +		else
> +			return ieee754sp_inf(xs ^ ys);
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
> --=20
> 2.7.4
>=20

--6KCWwYHA2nAj8wHB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll1zlEACgkQbAtpk944
dnrAAxAAlJ+g+wpxNjMGliaZUbO8dKzChBnp7upYuC/2O3mLxD05rgrCPfeqlj4Z
/ShrSwgWeO20dugVyGyJ7wlKryYBw6z0Jk83VfscWk5wdyGmVhyfXCUvvf5oyhNL
XpQoRiePdg00n3m/nFWTU3Py4R4dsk1E784wQnsZwUyUHXbT9UwTJrYktAqIBJEN
iECuBcndPFWbS8fLbX8SfYlHcMtFH+KSKh7sBdJMYwerU00d6I2fOPnzX2szEWBy
EE8sghoETiBKMUCRtd4JwVjGXBDzVj4EFCxPzTLXRcq/qocS+fN1C+33hKDM9zpS
2MB+UuBx8dll75FtAOWpY7wpTdmbN/ZDKYI+WbvWMwtshkT4HZMuPkzA4HGlMW4h
2YUVRJUVMiI0116+bO6P9Sw1c0evFytYncZahzN1ipK5OQPegxQRz/RLAEygzI9q
K3zCrIzKlzqRhf9ohUQORTelHj+WW12TA2yya3wBgN/4K3OGMFozdh/4SsPv8xpV
oZX17o+YkF12rlBueNQzthon+aZVeRAo7l+kwjub4WD5smSWBNI1Zs6SzdFjF25O
LP0D/wnlfrvlptUjv9ZDihVrlkABi3SF8XFYt70psy8+/nHDbqGcduKGvpRxwiRH
dbplNF2myc4OB0c51TRyAhhI6lTDoI9BPIRZP8bfE66e97oYfRI=
=JJ5B
-----END PGP SIGNATURE-----

--6KCWwYHA2nAj8wHB--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 17:15:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42360 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992974AbdGUPPProKzm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 17:15:15 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 222A641F8EBE;
        Fri, 21 Jul 2017 17:26:16 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 17:26:16 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 17:26:16 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3B5D069F128B9;
        Fri, 21 Jul 2017 16:15:06 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 16:15:10 +0100
Date:   Fri, 21 Jul 2017 16:15:09 +0100
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
Subject: Re: [PATCH v3 07/16] MIPS: math-emu: <MAX|MIN>.<D|S>: Fix cases of
 both inputs negative
Message-ID: <20170721151509.GL6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-8-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yFHZhmpl2995/sJc"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-8-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59196
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

--yFHZhmpl2995/sJc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:05PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the value returned by <MAX|MIN>.<D|S>, if both inputs are negative
> normal fp numbers. The previous logic did not take into account that
> if both inputs have the same sign, there should be separate treatment
> of the cases when both inputs are negative and when both inputs are
> positive.
>=20
> The relevant example:
>=20
> MAX.S fd,fs,ft:
>   If fs contains -5, and ft contains -7, fd is going to contain -5
>   (without this patch, it used to contain -7).

ouch!

>=20

same fixes/stable comment as for previous min/max patches

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_fmax.c | 33 +++++++++++++++++++++++++--------
>  arch/mips/math-emu/dp_fmin.c | 33 +++++++++++++++++++++++++--------
>  arch/mips/math-emu/sp_fmax.c | 33 +++++++++++++++++++++++++--------
>  arch/mips/math-emu/sp_fmin.c | 32 +++++++++++++++++++++++++-------
>  4 files changed, 100 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
> index 9517572..a0175cc 100644
> --- a/arch/mips/math-emu/dp_fmax.c
> +++ b/arch/mips/math-emu/dp_fmax.c
> @@ -106,16 +106,33 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, u=
nion ieee754dp y)
>  	else if (xs < ys)
>  		return x;
> =20
> -	/* Compare exponent */
> -	if (xe > ye)
> -		return x;
> -	else if (xe < ye)
> -		return y;
> +	/* Signs of inputs are the same, let's compare exponents */
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive */
> +		if (xe > ye)
> +			return x;
> +		else if (xe < ye)
> +			return y;
> +	} else {
> +		/* Inputs are both negative */
> +		if (xe > ye)
> +			return y;
> +		else if (xe < ye)
> +			return x;
> +	}
> =20
> -	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	/* Signs and exponents of inputs are the same, let's compare mantissas =
*/
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive, with equal exponents */
> +		if (xm <=3D ym)
> +			return y;
> +		return x;
> +	} else {
> +		/* Inputs are both negative, with equal exponents */
> +		if (xm <=3D ym)
> +			return x;
>  		return y;
> -	return x;
> +	}
>  }
> =20
>  union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
> diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
> index 7069320..074a858 100644
> --- a/arch/mips/math-emu/dp_fmin.c
> +++ b/arch/mips/math-emu/dp_fmin.c
> @@ -106,16 +106,33 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, u=
nion ieee754dp y)
>  	else if (xs < ys)
>  		return y;
> =20
> -	/* Compare exponent */
> -	if (xe > ye)
> -		return y;
> -	else if (xe < ye)
> -		return x;
> +	/* Signs of inputs are the same, let's compare exponents */
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive */
> +		if (xe > ye)
> +			return y;
> +		else if (xe < ye)
> +			return x;
> +	} else {
> +		/* Inputs are both negative */
> +		if (xe > ye)
> +			return x;
> +		else if (xe < ye)
> +			return y;
> +	}
> =20
> -	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	/* Signs and exponents of inputs are the same, let's compare mantissas =
*/
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive, with equal exponents */
> +		if (xm <=3D ym)
> +			return x;
> +		return y;
> +	} else {
> +		/* Inputs are both negative, with equal exponents */
> +		if (xm <=3D ym)
> +			return y;
>  		return x;
> -	return y;
> +	}
>  }
> =20
>  union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
> diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
> index d72111a..15825db 100644
> --- a/arch/mips/math-emu/sp_fmax.c
> +++ b/arch/mips/math-emu/sp_fmax.c
> @@ -106,16 +106,33 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, u=
nion ieee754sp y)
>  	else if (xs < ys)
>  		return x;
> =20
> -	/* Compare exponent */
> -	if (xe > ye)
> -		return x;
> -	else if (xe < ye)
> -		return y;
> +	/* Signs of inputs are the same, let's compare exponents */
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive */
> +		if (xe > ye)
> +			return x;
> +		else if (xe < ye)
> +			return y;
> +	} else {
> +		/* Inputs are both negative */
> +		if (xe > ye)
> +			return y;
> +		else if (xe < ye)
> +			return x;
> +	}
> =20
> -	/* Compare mantissa */
> -	if (xm <=3D ym)
> +	/* Signs and exponents of inputs are the same, let's compare mantissas =
*/
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive, with equal exponents */
> +		if (xm <=3D ym)
> +			return y;
> +		return x;
> +	} else {
> +		/* Inputs are both negative, with equal exponents */
> +		if (xm <=3D ym)
> +			return x;
>  		return y;
> -	return x;
> +	}
>  }
> =20
>  union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
> diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
> index 61ff9c6..f1418f7 100644
> --- a/arch/mips/math-emu/sp_fmin.c
> +++ b/arch/mips/math-emu/sp_fmin.c
> @@ -106,16 +106,34 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, u=
nion ieee754sp y)
>  	else if (xs < ys)
>  		return y;
> =20
> -	/* Compare exponent */
> -	if (xe > ye)
> +	/* Signs of inputs are the same, let's compare exponents */
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive */
> +		if (xe > ye)
> +			return y;
> +		else if (xe < ye)
> +			return x;
> +	} else {
> +		/* Inputs are both negative */
> +		if (xe > ye)
> +			return x;
> +		else if (xe < ye)
> +			return y;
> +	}
> +
> +	/* Signs and exponents of inputs are the same, let's compare mantissas =
*/
> +	if (xs =3D=3D 0) {
> +		/* Inputs are both positive, with equal exponents */
> +		if (xm <=3D ym)
> +			return x;
>  		return y;
> -	else if (xe < ye)
> +	} else {
> +		/* Inputs are both negative, with equal exponents */
> +		if (xm <=3D ym)
> +			return y;
>  		return x;
> +	}
> =20
> -	/* Compare mantissa */
> -	if (xm <=3D ym)
> -		return x;
> -	return y;
>  }
> =20
>  union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
> --=20
> 2.7.4
>=20

--yFHZhmpl2995/sJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyGnwACgkQbAtpk944
dnpV8RAAqkJK4K2kl4kCXrsQEgDN00nYcR3omFP2ao00GLFDLpgU7zUmfuvKxa1X
RH2QzASkimPA/938TQdfFd8VLfic4/HqIkAp4TDM3TJjSi21IS74ICCVKjUyoSkB
W3qDqrYy82CncqYd3cUnBnpxyGa9CfQFDL6S6xLR3ekgWkigNAhP7ZsGOucLYP88
J5KgH7zI6Qn3jqRy4c2MCfA/fnwQjVw/Mm+Kyh3GaBAb4cqDrHSJMecM3A0QjLGZ
kS8nH1OXwJkOpf2fMWkDrs6q3mkZ/ieOwOH/RNUnl+5kbv5GJ7yHqDG5VTujPMQt
YqG8ukaAm2EbV5RPxkUWiAGrlGjEOSRV/cPFRBfsrlzVJ2m3uFturd3rppwPp91e
OncH5Y9WiSjzngam3eX1Dw1mGb+yMwAs8i6RFYVmk/LCFWsyJEaMj41vDEoEs/6i
6xvxPfLXqAhRyuRdUtRuIerHnqkTfM2O7409IDTmZ5+R8VfCDtQqm9yLDcRHM6on
pbaN5MFbv+OWzvX5Cv7IKrbihQ5xIY+DhmUNywTfKyZ2oTmtJyyWZdLViULRLcGz
cqM20f/NGqV05kK4njWy1lDMT2aPvMTAskkzzs4Qdp6sZ4pW04FvZ6zwHpWoVstu
tR7i7umG4SnNCrckW6JJ1wsm9mpRcX3NM0wVOhZf5GTzkjbTXfc=
=zVWw
-----END PGP SIGNATURE-----

--yFHZhmpl2995/sJc--

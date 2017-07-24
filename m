Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 13:47:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27134 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991087AbdGXLr2LjQ-g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 13:47:28 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 20AB241F8E18;
        Mon, 24 Jul 2017 13:58:36 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 24 Jul 2017 13:58:36 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 24 Jul 2017 13:58:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4E387A2B23E41;
        Mon, 24 Jul 2017 12:47:20 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 12:47:22 +0100
Date:   Mon, 24 Jul 2017 12:47:21 +0100
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
Subject: Re: [PATCH v3 13/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some
 cases of zero inputs
Message-ID: <20170724114721.GR6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-14-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+xUfOySV6ieGZheq"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-14-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59220
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

--+xUfOySV6ieGZheq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:11PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the cases of <MADDF|MSUBF>.<D|S> when any of two multiplicands is
> +0 or -0, and the third input is also +0 or -0. Depending on the signs
> of inputs, certain special cases must be handled.
>=20
> The relevant example:
>=20
> MADDF.S fd,fs,ft:
>   If fs contains +0.0, ft contains -0.0, and fd contains 0.0, fd is
>   going to contain +0.0 (without this patch, it used to contain -0.0).
>=20

Usual fixes/stable comments.

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Patch looks correct to me.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_maddf.c | 8 ++++++++
>  arch/mips/math-emu/sp_maddf.c | 8 ++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
> index 45f815d..b8b2c17 100644
> --- a/arch/mips/math-emu/dp_maddf.c
> +++ b/arch/mips/math-emu/dp_maddf.c
> @@ -113,6 +113,14 @@ static union ieee754dp _dp_maddf(union ieee754dp z, =
union ieee754dp x,
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
>  		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754dp_inf(zs);
> +		/* Handle cases +0 + (-0) and similar ones. */
> +		if (zc =3D=3D IEEE754_CLASS_ZERO) {
> +			if ((!(flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))) ||
> +			    ((flags & maddf_negate_product) && (zs !=3D (xs ^ ys))))
> +				return z;
> +			else
> +				return ieee754dp_zero(ieee754_csr.rm =3D=3D FPU_CSR_RD);
> +		}
>  		/* Multiplication is 0 so just return z */
>  		return z;
> =20
> diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
> index 76856d7..cb8597b 100644
> --- a/arch/mips/math-emu/sp_maddf.c
> +++ b/arch/mips/math-emu/sp_maddf.c
> @@ -114,6 +114,14 @@ static union ieee754sp _sp_maddf(union ieee754sp z, =
union ieee754sp x,
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
>  		if (zc =3D=3D IEEE754_CLASS_INF)
>  			return ieee754sp_inf(zs);
> +		/* Handle cases +0 + (-0) and similar ones. */
> +		if (zc =3D=3D IEEE754_CLASS_ZERO) {
> +			if ((!(flags & maddf_negate_product) && (zs =3D=3D (xs ^ ys))) ||
> +			    ((flags & maddf_negate_product) && (zs !=3D (xs ^ ys))))
> +				return z;
> +			else
> +				return ieee754sp_zero(ieee754_csr.rm =3D=3D FPU_CSR_RD);
> +		}
>  		/* Multiplication is 0 so just return z */
>  		return z;
> =20
> --=20
> 2.7.4
>=20

--+xUfOySV6ieGZheq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll13j4ACgkQbAtpk944
dnqZaw//Wtc2dO3V1MULHcdhxiuDmQZifq5BCyTfw720jS0bG3WC83t6rB3Vw2sQ
uO2jGzQWPx+AhkcnSAAiejMuTKTOFjUBWMtwc9VrAabTR2DtVx51Maef1yGxqAd+
mlEIBVUIhcOw9HuuQQAT/l3E7YwJ8Zs4UPX7u8IVQrJ0e6NEqZu7vhvIBtbeLCYp
LLwY54DngA157dW7VB1ypa9Bb9xJn1+qu17AuUJsIB3Dz9IkLYnLyHyrL3bEux6h
BAtD4BjZMbKLe/tza0nvbot/yiLNK1XG6G1xPjuqWcDIUTNEsA1S71qQjrYFb0lo
FHIvb7BnfT75DyLWmF/sx6l3mZJOphvPMJBuirxHGUIswLtZt2fBSwwbiBlE/ELI
WuU7ZughQXgMwjQfw41wNHWHavv1zhOxdDAt1aFSHgXj5Fk3VFkFRUxs5wl1Lq+A
J15TheNefxc+REj2B/AwsQLAUzf5k1CpohDr0uV1B5hNLZnvsxtY1EqIQXLSHexZ
HtWh2BXov07oqlPU5HW7CbtuFk/LQvp1btIVHEWHiZ8rm2AfBLy4viEPXer//SkE
LPlIDKutPuLEYHWy7w1Dq8YTO6xQFaYYx5Z1who7L57xC9KtcQUrYCPMO07zZsyU
G2avIjaLlLnlMo2td4SK5UqS5qp8IZiFm/0iWlBfVQKNXGh/7QY=
=kWm2
-----END PGP SIGNATURE-----

--+xUfOySV6ieGZheq--

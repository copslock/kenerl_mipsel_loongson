Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 17:47:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39639 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993122AbdGUPrATXGR9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 17:47:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AADBB41F8EBF;
        Fri, 21 Jul 2017 17:58:00 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 17:58:00 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 17:58:00 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A66711F6EFB71;
        Fri, 21 Jul 2017 16:46:50 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 16:46:54 +0100
Date:   Fri, 21 Jul 2017 16:46:54 +0100
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
Subject: Re: [PATCH v3 09/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of
 both infinite inputs
Message-ID: <20170721154653.GN6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-10-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GHIrBwbOfZrXhP0e"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-10-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59198
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

--GHIrBwbOfZrXhP0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:07PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the value returned by <MAXA|MINA>.<D|S> fd,fs,ft, if both inputs
> are infinite. The previous implementation returned always the value
> contained in ft in such cases. The correct behavior is specified
> in Mips instruction set manual and is as follows:
>=20
>     fs    ft        MAXA     MINA
>   ---------------------------------
>     inf   inf        inf      inf
>     inf  -inf        inf     -inf
>    -inf   inf        inf     -inf
>    -inf  -inf       -inf     -inf
>=20
> The relevant example:
>=20
> MAXA.S fd,fs,ft:
>   If fs contains +inf, and ft contains -inf, fd is going to contain
>   +inf (without this patch, it used to contain -inf).
>=20

Same Fixes/stable thing

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_fmax.c | 4 +++-
>  arch/mips/math-emu/dp_fmin.c | 4 +++-
>  arch/mips/math-emu/sp_fmax.c | 4 +++-
>  arch/mips/math-emu/sp_fmin.c | 4 +++-
>  4 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
> index 860b43f9..5459643 100644
> --- a/arch/mips/math-emu/dp_fmax.c
> +++ b/arch/mips/math-emu/dp_fmax.c
> @@ -183,6 +183,9 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, un=
ion ieee754dp y)
>  	/*
>  	 * Infinity and zero handling
>  	 */
> +	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> +		return ieee754dp_inf(xs & ys);
> +
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
> @@ -190,7 +193,6 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, un=
ion ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
> diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
> index 73d85e4..d4cd243 100644
> --- a/arch/mips/math-emu/dp_fmin.c
> +++ b/arch/mips/math-emu/dp_fmin.c
> @@ -183,6 +183,9 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, un=
ion ieee754dp y)
>  	/*
>  	 * Infinity and zero handling
>  	 */
> +	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> +		return ieee754dp_inf(xs | ys);
> +
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
> @@ -190,7 +193,6 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, un=
ion ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
> diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
> index fec7f64..528a90b 100644
> --- a/arch/mips/math-emu/sp_fmax.c
> +++ b/arch/mips/math-emu/sp_fmax.c
> @@ -183,6 +183,9 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, un=
ion ieee754sp y)
>  	/*
>  	 * Infinity and zero handling
>  	 */
> +	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> +		return ieee754sp_inf(xs & ys);
> +
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
> @@ -190,7 +193,6 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, un=
ion ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
> diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
> index 74780bc..5f1d650 100644
> --- a/arch/mips/math-emu/sp_fmin.c
> +++ b/arch/mips/math-emu/sp_fmin.c
> @@ -184,6 +184,9 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, un=
ion ieee754sp y)
>  	/*
>  	 * Infinity and zero handling
>  	 */
> +	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
> +		return ieee754sp_inf(xs | ys);
> +
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
> @@ -191,7 +194,6 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, un=
ion ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
> --=20
> 2.7.4
>=20

--GHIrBwbOfZrXhP0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyIewACgkQbAtpk944
dnqsDQ//TbHqniBwy94iO1wGid0NYtd2paIZZN2NsB/837Qldt+hiQpJT/PvXnJr
1MGqMruH6W34ArWhJzkkUSfcZtJTxq94GaRNfja/0f8jliq9xehIwXat41SD1FRd
lV/Qcsbtcg8o1lV9M/BlmWgl+fJMnSV2OKtTWcE/sEMZT2uRGtoqWMTZ7S/pvGXK
2wom0+8nsrFMdn/eRWDDBMm0mMBdfLehV15NZtVlhU4DiBElrEMxEc5usv2iPDz6
Cqa9R7afW58EVnTvHHCGtM+a0VFk6G88W77gg2okE/qFx3WXb4dnwN4QzsRthQ+T
2isQPYSKOqjfyYgPuDMB7uV9Eelrzd0jO75Eolp6a1LRTbBiYL0CX5peTg3bUbTe
lZQPfF5zUDScT95KZVOW1KZYJblPKKX07qM5N8S2WkR3/JsVq2F2S9XCz0xMe4wU
i1+CtJlOYNayL+G2H4jSknf8fj7x9rIcP+yZUI8zusGKWpNd3eChjT3nAc5byMLL
WTX1QQJRJvKSgcHK7ABGOTaccVGbX4q6l/AEuzyC+1rhKC/uHYvm/TM7IT3Ahb/c
42Teu9KOlmYhq+R8NZZQgz/Ks9zahLP6dNRbZObpjKutAJKhAzZi8ToA7+COGHjS
5tPJKcuLsyMtjekV1tgCWW9rC3oCzrbYXModEjv4cciTPJ1AwYs=
=fpkj
-----END PGP SIGNATURE-----

--GHIrBwbOfZrXhP0e--

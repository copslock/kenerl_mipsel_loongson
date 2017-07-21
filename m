Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:45:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55079 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992800AbdGUOpLJ93ym (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 16:45:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D59E841F8EBE;
        Fri, 21 Jul 2017 16:56:10 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 16:56:10 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 16:56:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1A902B4F7487A;
        Fri, 21 Jul 2017 15:45:01 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 15:45:04 +0100
Date:   Fri, 21 Jul 2017 15:45:04 +0100
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
Subject: Re: [PATCH v3 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix
 quiet NaN propagation
Message-ID: <20170721144504.GJ6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-6-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z1DcCokeeMRSrces"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-6-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59194
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

--z1DcCokeeMRSrces
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:03PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix the value returned by <MAX|MAXA|MIN|MINA>.<D|S>, if both inputs
> are quiet NaNs. The specifications of <MAX|MAXA|MIN|MINA>.<D|S> state
> that the returned value in such cases should be the quiet NaN
> contained in register fs.
>=20
> The relevant example:
>=20
> MAX.S fd,fs,ft:
>   If fs contains qNaN1, and ft contains qNaN2, fd is going to contain
>   qNaN1 (without this patch, it used to contain qNaN2).
>=20

Consider adding:

Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} =
FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} =
FPU instruction")

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Consider adding:

Cc: <stable@vger.kernel.org> # 4.3+

> ---
>  arch/mips/math-emu/dp_fmax.c | 8 ++++++--
>  arch/mips/math-emu/dp_fmin.c | 8 ++++++--
>  arch/mips/math-emu/sp_fmax.c | 8 ++++++--
>  arch/mips/math-emu/sp_fmin.c | 8 ++++++--
>  4 files changed, 24 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
> index fd71b8d..567fc33 100644
> --- a/arch/mips/math-emu/dp_fmax.c
> +++ b/arch/mips/math-emu/dp_fmax.c
> @@ -47,6 +47,9 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union=
 ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754dp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;

couldn't the above...

> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -54,7 +57,6 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union=
 ieee754dp y)

=2E.. go somewhere around here and fall through to the existing return x
case?

and same below of course.

Otherwise:
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James



>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> @@ -147,6 +149,9 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, un=
ion ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754dp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -154,7 +159,6 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, un=
ion ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
> index c1072b0..77f7ca9 100644
> --- a/arch/mips/math-emu/dp_fmin.c
> +++ b/arch/mips/math-emu/dp_fmin.c
> @@ -47,6 +47,9 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union=
 ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754dp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -54,7 +57,6 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union=
 ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> @@ -147,6 +149,9 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, un=
ion ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754dp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -154,7 +159,6 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, un=
ion ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
> index 4d00084..d46e8e4 100644
> --- a/arch/mips/math-emu/sp_fmax.c
> +++ b/arch/mips/math-emu/sp_fmax.c
> @@ -47,6 +47,9 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union=
 ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754sp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -54,7 +57,6 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union=
 ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> @@ -147,6 +149,9 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, un=
ion ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754sp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -154,7 +159,6 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, un=
ion ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
> index 4eb1bb9..b528c4b 100644
> --- a/arch/mips/math-emu/sp_fmin.c
> +++ b/arch/mips/math-emu/sp_fmin.c
> @@ -47,6 +47,9 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union=
 ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754sp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -54,7 +57,6 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union=
 ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> @@ -147,6 +149,9 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, un=
ion ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
>  		return ieee754sp_nanxcpt(x);
> =20
> +	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> +		return x;
> +
>  	/* numbers are preferred to NaNs */
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> @@ -154,7 +159,6 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, un=
ion ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_QNAN):
>  		return x;
> =20
> -	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_DNORM):
> --=20
> 2.7.4
>=20

--z1DcCokeeMRSrces
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyE28ACgkQbAtpk944
dnpcew/9FowZa3Yc9uj0VY7zavGM4qX0TWRI5LORGcKF/l05ROSDcOhD0a7Gmm0g
RRa6PChHY8Ep9nlzK9L9o/dP+rHt2OXJqEQaG/qZcRpycUFY8I//+pGsE3JrhEtR
iZJk+gETRDSSxS+Rwn7QFRY5IT0X30EFqC958TkLJjJRAkvN/cPBmzgz+Vq0TXD9
XlGOTCkpjL0BjMgGK74W18c0UkxOwTB9G/2gCbon5uLxJ/dejqutBVpdOyOpXl2a
eLBST8JZ87f2nolp0dAzAaIokLlz3CpajkrpRy6YAtcmfZdfcyGKfLvm+krFWP+B
ZnEQF9PYQVZJy3X9kMQ1DtVBV1rNBxqc9hAxvGOXwWKZsEHApfm2l82hQII6f3FF
Moexf1TG7MUxQSYjdkfeRL5sgHoCP6ivuOGioS04KczrdaJEGhBayf3OYV+FvDJb
+hsY3eVYtPVjBtD1rJrhvh/ZXURkB/unzg0aRLathXFObAQll01n0CL7p06kAKKA
FJCIDXQLPE+f/dSwXWcinszcZuLlR0dzQMmTEZJ4Ih2Pk28AcfW17pHQARv4fB5j
fcGriW5PSHry6g+RUrB5gxBCncrm04JeVLwX17b0PwufWrVAEBS1iwTSDacIXTRA
7saUoKSnKtRnFAiF8w2TQxO0XtffdNWeDajln31+YNHEVha8Epk=
=HC7r
-----END PGP SIGNATURE-----

--z1DcCokeeMRSrces--

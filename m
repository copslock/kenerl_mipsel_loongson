Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:02:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20403 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993947AbdGUQBxHUdz9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 18:01:53 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 746B541F8EBF;
        Fri, 21 Jul 2017 18:12:53 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 18:12:53 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 18:12:53 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5687CE9F5EF99;
        Fri, 21 Jul 2017 17:01:43 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 17:01:47 +0100
Date:   Fri, 21 Jul 2017 17:01:46 +0100
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
Subject: Re: [PATCH v3 10/16] MIPS: math-emu: MINA.<D|S>: Fix some cases of
 infinity and zero inputs
Message-ID: <20170721160146.GO6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-11-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VKWlozvtPHRkOTl7"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-11-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59199
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

--VKWlozvtPHRkOTl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:08PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>=20
> Fix following special cases for MINA>.<D|S>:
>=20
>   - if one of the inputs is zero, and the other is subnormal, normal,
>     or infinity, the  value of the former should be returned (that is,
>     a zero).
>   - if one of the inputs is infinity, and the other input is normal,
>     or subnormal, the value of the latter should be returned.
>=20
> The previous implementation's logic for such cases was incorrect - it
> appears as if it implements MAXA, and not MINA instruction.
>=20
> The relevant example:
>=20
> MINA.S fd,fs,ft:
>   If fs contains 100.0, and ft contains 0.0, fd is going to contain
>   0.0 (without this patch, it used to contain 100.0).

Another ouch!

>=20

Fixes/stable

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/math-emu/dp_fmin.c | 4 ++--
>  arch/mips/math-emu/sp_fmin.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
> index d4cd243..1e9ee3d 100644
> --- a/arch/mips/math-emu/dp_fmin.c
> +++ b/arch/mips/math-emu/dp_fmin.c
> @@ -191,14 +191,14 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, =
union ieee754dp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
> -		return x;
> +		return y;
> =20
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
> -		return y;
> +		return x;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
>  		return ieee754dp_zero(xs | ys);
> diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
> index 5f1d650..685ce75 100644
> --- a/arch/mips/math-emu/sp_fmin.c
> +++ b/arch/mips/math-emu/sp_fmin.c
> @@ -192,14 +192,14 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, =
union ieee754sp y)
>  	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_ZERO):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_ZERO):
> -		return x;
> +		return y;
> =20
>  	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_DNORM):
> -		return y;
> +		return x;
> =20
>  	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
>  		return ieee754sp_zero(xs | ys);
> --=20
> 2.7.4
>=20

--VKWlozvtPHRkOTl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyJWkACgkQbAtpk944
dnrxqA//YUywNkRclY070jn86CEElnUkieLVJJJpgmsTpaO7Ltn/2WPKmzK3W9Lw
CvIrUXsvMgQs/UwPfoU4baGvikeNaYAZWwLhvbFDyCiEekaRrbsWM7jJHY1j0WPz
gTm2hWRadUor8uDPu1Gbxaf8zUIA5o7/YavvZ4T/3DNGRB32RPjOwYn3Tw6ojdCy
JU2wtpdoVt0E/gdma9bCAa/dD4x+qP98kbYrB4pfKkA8ZGKMelBa04vQZ6eCXL8c
Ixi4NMWLB3eTgQVpSDxpjSCQQDRDkEMKHq6Q/IHp1vhMFvWQ2CE5U4t3NGsKHmOE
WwR5zTMoI5Cx+pmnzOh7Eoj1b2PpWz3zlh+HQOOFiASv1eZfrNQYM8X13nMNwKEy
YbpHlf/62WXknksj2oG82+1FYQCy9PFKEPYxvQAjT2RO2IhC3y/9+4XMBbQD2u+p
vc/0HHvrGBcZ7F+WBXnL5MQsTD8H6kX2F5mQKm0JKuiFMMkfggjyn/l7ULf6TaIg
yCA5L2/nJ74IdJwL1ShdDca1OJHgECDlfZk6g0RZt7buJah3NTngkV1rls+EcW+K
5F2DK8xWCLH1zIBeKeyl6oe2uxUb2iRs4aG87N+DEoSGA4nhGmZAe4/sY7XtQJOX
70oH6g7NELq3bHsz0s3HF5Phqezl7Sb0tvLDmlnWz1ZkLne++u8=
=Kw6B
-----END PGP SIGNATURE-----

--VKWlozvtPHRkOTl7--

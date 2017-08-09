Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 10:14:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33462 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995198AbdHIIOat4p5f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 10:14:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 71A6326383833;
        Wed,  9 Aug 2017 09:14:22 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 9 Aug
 2017 09:14:24 +0100
Date:   Wed, 9 Aug 2017 09:14:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: Re: [PATCH 3/7] MIPS: NI 169445: Only include in 32r2el kernels
Message-ID: <20170809081424.GB31455@jhogan-linux.le.imgtec.org>
References: <20170807230119.10629-1-paul.burton@imgtec.com>
 <20170807230119.10629-4-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t8N2qprAjL+0GVly"
Content-Disposition: inline
In-Reply-To: <20170807230119.10629-4-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59451
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

--t8N2qprAjL+0GVly
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 04:01:14PM -0700, Paul Burton wrote:
> The NI 169445 board uses a little endian MIPS32r2 CPU, and therefore
> including board support in kernels that are unable to run on such a CPU
> is pointless.
>=20
> Specify requirements in the board config fragment that cause the NI
> 169445 board support to only be included in generic kernels that target
> little endian MIPS32r2 CPUs.
>=20
> For example, NI 169445 support will be included when configuring using
> 32r2el_defconfig but not when using 64r6_defconfig.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Nathan Sullivan <nathan.sullivan@ni.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
>=20
> ---
> I'm basing this upon the Kconfig entries that were present in the
> initial upstream submission of NI 169445 board support[1]. If this is
> wrong at all please let me know :)
>=20
> [1] https://www.linux-mips.org/archives/linux-mips/2016-12/msg00016.html
>=20
>  arch/mips/configs/generic/board-ni169445.config | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/=
configs/generic/board-ni169445.config
> index 0bae1f861a5b..f72223b366ca 100644
> --- a/arch/mips/configs/generic/board-ni169445.config
> +++ b/arch/mips/configs/generic/board-ni169445.config
> @@ -1,3 +1,6 @@
> +# require CONFIG_CPU_MIPS32_R2=3Dy

Technically, won't this unnecessarily prevent it being included in r1
configs?

I suppose the only better suggestion I have at the moment is
# require CONFIG_32BIT=3Dy
# require CONFIG_CPU_MIPS32_R6=3Dn

I suppose being specific about exclusions is probably inevitable (e.g.
for boards which can't support micromips).

Cheers
James

> +# require CONFIG_CPU_LITTLE_ENDIAN=3Dy
> +
>  CONFIG_FIT_IMAGE_FDT_NI169445=3Dy
> =20
>  CONFIG_SERIAL_8250=3Dy
> --=20
> 2.14.0
>=20
>=20

--t8N2qprAjL+0GVly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlmKxF4ACgkQbAtpk944
dnr8FRAAh3B2TgbiziDycrv52lQKpBLGMk/UGKA7AHZVaugjn4VU0BAnJoRIQTSk
w256f1/IKA8CIWjvuAg3zcskkETMEJDBMk0vdfqorIBfw0zqnsQ4FvRVX2Uy3Gqc
f/x3zM16CkSi+wg1EAnUKI2kb9zlumrkP/GE16RTFocvQqO1j3/JKOP378FWZVCa
C+EIcyiK5mJfo3ty9qni0KcykmbKOCxKSlnHbc5jTzCMoPJJwVgdlzDtOGjTipYB
3m4/S89xOG+o00gkUSaRMCmDj1Xy34HanzAy3rweFbxVCtxCqB4IFJAcSZGJFX4d
EgH9SFQAQyocZR3GnQwjX8m1Nu3dVnYlARhqkVW3NpY03L/hTUD2X2oh3p2jFQqX
9KZHeeMDe090EIxIaOOl7xBWJHzRbqohmYLbUXNzBshvqgXpZ6MCIbDEPQgtFpSf
DwUXerEesXPQM6SEjoPz5uo9jLPDNqRiqTDCIV3UKHIQDfQ/BoUO1qVncYyo8Dug
tMflZM7QCTojhMuL7P9lgdu7x2XCmW+6WglYWndxr87aXMNvZDBp5w5PQ5iMiLnR
cRV4CrDlIOLsZ8+korSY7GrrT/xMFZ6apJb8Uv3ON8q/D/pBecE7NBP42ZcxKeXP
CtTmWoJ77dC2j56bDYDkTpEZEhc/F+aKTYTKS2TJ4JfwPeRTHWc=
=FRWi
-----END PGP SIGNATURE-----

--t8N2qprAjL+0GVly--

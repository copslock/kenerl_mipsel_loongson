Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 14:16:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23534 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991087AbdBNNQkBch4e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 14:16:40 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 70F3541F8EBB;
        Tue, 14 Feb 2017 14:20:30 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Feb 2017 14:20:30 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Feb 2017 14:20:30 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F13B5BEA5AEDC;
        Tue, 14 Feb 2017 13:16:29 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 13:16:32 +0000
Date:   Tue, 14 Feb 2017 13:16:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] MIPS: Xtalk: Clean-up xtalk.h macros
Message-ID: <20170214131632.GU24226@jhogan-linux.le.imgtec.org>
References: <20170207055751.8134-1-kumba@gentoo.org>
 <20170207055751.8134-3-kumba@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8KmZJhJMEENkOiL3"
Content-Disposition: inline
In-Reply-To: <20170207055751.8134-3-kumba@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56810
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

--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Tue, Feb 07, 2017 at 12:57:50AM -0500, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
>=20
> Clean-up several macros in arch/mips/include/asm/xtalk/xtalk.h:
>  - Hex addresses are lowercased.
>  - Added whitespace around several operators.
>  - Removed bridge_probe declaration.
>=20
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/include/asm/xtalk/xtalk.h | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/xtalk/xtalk.h b/arch/mips/include/asm/=
xtalk/xtalk.h
> index 9125bd85514d..627ed91b2880 100644
> --- a/arch/mips/include/asm/xtalk/xtalk.h
> +++ b/arch/mips/include/asm/xtalk/xtalk.h
> @@ -21,24 +21,15 @@
>  #define XWIDGET_MFG_NUM_NONE	-1
> =20
>  /* It is often convenient to fold the XIO target port */
> -#define XIO_NOWHERE	(0xFFFFFFFFFFFFFFFFull)
> -#define XIO_ADDR_BITS	(0x0000FFFFFFFFFFFFull)
> -#define XIO_PORT_BITS	(0xF000000000000000ull)
> +#define XIO_NOWHERE	(0xffffffffffffffffULL)
> +#define XIO_ADDR_BITS	(0x0000ffffffffffffULL)
> +#define XIO_PORT_BITS	(0xf000000000000000ULL)
>  #define XIO_PORT_SHIFT	(60)
> =20
> -#define XIO_PACKED(x)	(((x)&XIO_PORT_BITS) !=3D 0)
> -#define XIO_ADDR(x)	((x)&XIO_ADDR_BITS)
> -#define XIO_PORT(x)	((s8)(((x)&XIO_PORT_BITS) >> XIO_PORT_SHIFT))
> -#define XIO_PACK(p, o)	((((uint64_t)(p))<<XIO_PORT_SHIFT) | ((o)&XIO_ADD=
R_BITS))
> -
> -#ifdef CONFIG_PCI
> -extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
> -#else
> -static inline int bridge_probe(nasid_t nasid, int widget, int masterwid)
> -{
> -	return 0;
> -}
> -#endif

Won't this break the build when CONFIG_PCI=3Dn?

Cheers
James

> +#define XIO_PACKED(x)	(((x) & XIO_PORT_BITS) !=3D 0)
> +#define XIO_ADDR(x)	((x) & XIO_ADDR_BITS)
> +#define XIO_PORT(x)	((s8)(((x) & XIO_PORT_BITS) >> XIO_PORT_SHIFT))
> +#define XIO_PACK(p, o)	((((u64)(p)) << XIO_PORT_SHIFT) | ((o) & XIO_ADDR=
_BITS))
> =20
>  #endif /* !__ASSEMBLY__ */
> =20
> --=20
> 2.11.1
>=20
>=20

--8KmZJhJMEENkOiL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYowMpAAoJEGwLaZPeOHZ6eMsP/1XhmoeyMRtnIdXLuMZq4rlA
NdY/nrnYCrjFQU6n6mtzV6mpRFNtnBpH+Y4vTZ5PzAQBmyT2evoYQS5XUAMV51dX
OFxDh2IZ8MNVdc1PR0RmB48MO0s315Z4DP5ItNLbzjHB2Pn53lHoGMhFra8G3aFF
KFMQ1/K7avqPAnH4rFpM5ik7eUsX3Km4jSseLflIEA8dDH51Wc4HjBZFLWS6hkjJ
Y4OGWrfB0XzR0MmmDLbq4IO+CWEcvOcDEVGz4/b4rqUDW+YEXq0n/dtfWD6Jt9gb
QyUROSdN4q7Wns3Y4gfbkG4lyRjwwL+Q5dSE6zdFMamgmfsxctvs7AfYUmMInTYV
ctRZQIGYh9osUStfcAdeGmFrNNRaxlOUL28bXCPIMWYp01YnYBxe8su8IVaoeCso
OQc2f4YdW15fAIPd9pIuZhV118qXxFc61RreevVVGfQ542nHgYmhvfdplJ1dYEpD
zlC56E3SEtHR/EjOQ7/yAwXAqZWfSMU9LjtoK3OEjw/n4IOXC1Ovgq1smcBhUnhm
gug7GO+El6ieLhILQnj3fys9u+//M3lpfXr9X4J1anTNle4Adn4aemWe3dNOTj1a
5bYDKDUaXCs5mv/p5QczlKwk7XdohxMqLVmDA97oNGMx2d+tJxL3M0rYwhBfCXCj
r4+zw1NPFqnxGS0mrJb8
=zzrT
-----END PGP SIGNATURE-----

--8KmZJhJMEENkOiL3--

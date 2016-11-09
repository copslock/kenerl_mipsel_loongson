Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 10:54:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14119 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992309AbcKIJx7dQJOp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 10:53:59 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2801041F8DFE;
        Wed,  9 Nov 2016 09:52:46 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 09 Nov 2016 09:52:46 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 09 Nov 2016 09:52:46 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 88F41F6EFA0;
        Wed,  9 Nov 2016 09:53:51 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 9 Nov
 2016 09:53:53 +0000
Date:   Wed, 9 Nov 2016 09:53:53 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix duplicate define
Message-ID: <20161109095352.GD9443@jhogan-linux.le.imgtec.org>
References: <1478641415-6986-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <1478641415-6986-1-git-send-email-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55732
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

--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2016 at 09:43:35PM +0000, Sudip Mukherjee wrote:
> The mips build of ip27_defconfig is failing with the error:
> In file included from ../arch/mips/include/asm/mach-ip27/spaces.h:29:0,
>                  from ../arch/mips/include/asm/page.h:12,
>                  from ../arch/mips/vdso/vdso.h:26,
>                  from ../arch/mips/vdso/gettimeofday.c:11:
> ../arch/mips/include/asm/mach-generic/spaces.h:28:0:
> 	error: "CAC_BASE" redefined [-Werror]
>  #define CAC_BASE  _AC(0x80000000, UL)
> =20
> In file included from ../arch/mips/include/asm/page.h:12:0,
>                  from ../arch/mips/vdso/vdso.h:26,
>                  from ../arch/mips/vdso/gettimeofday.c:11:
> ../arch/mips/include/asm/mach-ip27/spaces.h:22:0:
> 	note: this is the location of the previous definition
>  #define CAC_BASE  0xa800000000000000
>=20
> Add a condition to check if CAC_BASE is already defined, and define it
> only if it is not yet defined.
>=20
> Fixes: 3ffc17d8768b ("MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>=20
> Build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/174134289
>=20
>  arch/mips/include/asm/mach-generic/spaces.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/incl=
ude/asm/mach-generic/spaces.h
> index 952b0fd..61b75da 100644
> --- a/arch/mips/include/asm/mach-generic/spaces.h
> +++ b/arch/mips/include/asm/mach-generic/spaces.h
> @@ -23,10 +23,12 @@
> =20
>  #ifdef CONFIG_32BIT
>  #ifdef CONFIG_KVM_GUEST
> +#ifndef CAC_BASE

This is wrong. Should it be one line up? Note the else...

>  #define CAC_BASE		_AC(0x40000000, UL)
>  #else

here ^^^

i.e. you appear to be changing
CONFIG_KVM_GUEST:
	CAC_BASE=3D0x40000000
!CONFIG_KVM_GUEST:
	CAC_BASE=3D0x80000000

to:

CONFIG_KVM_GUEST:
	!CAC_BASE:
		CAC_BASE=3D0x40000000
	CAC_BASE:
		CAC_BASE=3D0x80000000
!CONFIG_KVM_GUEST:
	(nothing)

Cheers
James

>  #define CAC_BASE		_AC(0x80000000, UL)
>  #endif
> +#endif
>  #ifndef IO_BASE
>  #define IO_BASE			_AC(0xa0000000, UL)
>  #endif
> --=20
> 1.9.1
>=20
>=20

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYIvIwAAoJEGwLaZPeOHZ6KmwP/jhZZtDGqHFHYJjbchpGQkYv
6tDZNyCa2jkQnlx+KEcEWEO2z1qprMIy9xjDxs+2HIQn2+8EzMXwCrNVH5ueTmT3
LM7WZaHVGhcApMyE1wrzSdBlkJDiaE9y5eKefszj8AcP1tFsjqmRgA3wXxHMLikN
gKUXZKLO9iCAWnZwH4s8xhPt2NfwnGRHCvSrDFRDvsC9oihBPdkdw92uKs6VifUQ
ktK8JHL0WXTPywQqVZf2tml5qNEIbW3MTapUW+jEfCrZCKvgR/cdemW3N13b+3Vg
AiHI1B+w7xEG2pGTXXv5673mu+yQpu3IYCLXZW5giDHnEXe3bJDk8OsUPKagzbKb
RayoioHBJuhwdCkFNaiDoaw4Q4W53T6+tiIRkI+Ci/FQoTGSCRR5Yun3DOArYIqL
IjyRkAYX4cP0b9Ixha6vVKivAXxWKvChGv4K4ViY4VXDMNOBOCJZuaZ37qq+RSE9
DnHQR+lfwYkqbTTdthEtvrenxmMkFlnlnQQgl8S3TyLPlk+JloM7IPC2TjBoBOGK
wq6JVEhQBArzB9mJDJLBgJ+ECHIAVLrAHRli03Gcp/OpMYXDVcOW8uNbCViE8/Pe
wSIowukaeqkabWnvOiUY6w3fb4aWcJYAzV3gA47WoGl/DSAireu3zPYbEINGacLd
6R+iyr0ioHw/3qh7i1Fw
=XIBl
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--

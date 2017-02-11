Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 22:28:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55806 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992213AbdBKV1vlmzE6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 22:27:51 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4344B41F8DDF;
        Sat, 11 Feb 2017 22:31:36 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 11 Feb 2017 22:31:36 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 11 Feb 2017 22:31:36 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 451C6792DDB3F;
        Sat, 11 Feb 2017 21:27:41 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 11 Feb
 2017 21:27:45 +0000
Date:   Sat, 11 Feb 2017 21:27:45 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix distclean with Makefile.postlink
Message-ID: <20170211212745.GE24226@jhogan-linux.le.imgtec.org>
References: <1485770314-29891-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <1485770314-29891-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56772
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

--//IivP0gvsAy3Can
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 09:58:34AM +0000, Matt Redfearn wrote:
> The postlink Makefile must include include/config/auto.conf to get the
> kernel configuration variables. But in a clean kernel directory this
> file does not exist, causing make to bail with the error:
>=20
> arch/mips/Makefile.postlink:10:
> include/config/auto.conf: No such file or directory
> make[1]: *** No rule to make target
> 'include/config/auto.conf'.  Stop.
> Makefile:1290: recipe for target 'vmlinuxclean' failed
>=20
> Fix this by using "-include" to not cause a Make error when the file
> does not exist.
>=20
> Fixes: 44079d3509ae ("MIPS: Use Makefile.postlink to insert relocations i=
nto vmlinux")
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Applied

Thanks
James

> ---
>=20
>  arch/mips/Makefile.postlink | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
> index b0ddf0701a31..4b7f5a648c79 100644
> --- a/arch/mips/Makefile.postlink
> +++ b/arch/mips/Makefile.postlink
> @@ -7,7 +7,7 @@
>  PHONY :=3D __archpost
>  __archpost:
> =20
> -include include/config/auto.conf
> +-include include/config/auto.conf
>  include scripts/Kbuild.include
> =20
>  CMD_RELOCS =3D arch/mips/boot/tools/relocs
> --=20
> 2.7.4
>=20
>=20

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYn4HKAAoJEGwLaZPeOHZ6ClEP/A2OA6Ilc65ApLvpBzwRjndZ
Ux/rkY62f3JonBUwFPdX1ogmYdfbe61w6uFR/fPZEVPkJ51qqUZujFANhrvs++aM
SImT6aupFdiBi9iVszccqL1VDZgZSV5eBfbhtjBiKLajIfyzr4qIpZKhZspxzWi1
qYFqgPEmTOylZLL5BjFdR2GC/3CIKJgD8mqmJyWUPHLKhJPamMKw5zTTA/RJVSeK
NjkjWFcvUY3gEEXz+l1UJ9j+/cXOFnoi0HkPXZ8ZQDnmK5NWOpL08o9n4WgYVAU6
FPZrZvJTzGaGEKzk4thaJ5+3pK4zTavGjsV7JK5766eWYyN6C82jjxDbmK6S+i5D
2JhXv2KPZtga0oVEMx7PP4ugAXBgieoGx94ocWCnbrru1B2SPPD60aZcm410J9+u
U5zdDRkqwYXIyRkQbUofxcOCvXO3lSTgAOXMO7fIAqUcuKfmBWeZmPmd+EeY9MQ1
ZkeO7cFMC67NqiBdtqfk+4YSbdwTntMQGu5mDMhyDHbGkKBDt8REqZ2chV1AQ5f/
E6mwL8zNA1YVNMaZ4Hjr1bE2kuBH4S+3TbCpo1Bx4FC3k44hcnWkET8uiEUcYT1b
/egJFxZf18QVOMGLkFsdtpG0F5cu03T7SMmkA6o7Qtged/2/ejnNlghTP1llk5St
pjcue+Y8yNh3Iokv3kzo
=R99h
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--

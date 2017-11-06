Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 20:08:36 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59523 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdKFTIX2bx0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2017 20:08:23 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBmkt-00014N-M0; Mon, 06 Nov 2017 19:08:19 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBmko-0001t1-EO; Mon, 06 Nov 2017 19:08:14 +0000
Message-ID: <1509995293.2748.112.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16-stable 82/87] MIPS: ip27: Disable qlge driver in
 defconfig
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>
Date:   Mon, 06 Nov 2017 19:08:13 +0000
In-Reply-To: <20170505194745.3627137-83-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
         <20170505194745.3627137-83-arnd@arndb.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-JqrZOf+q83NcIoavuK4r"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-JqrZOf+q83NcIoavuK4r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-05-05 at 21:47 +0200, Arnd Bergmann wrote:
> Commit c64ebe32d3fc90c52277257d6c9fa7d589877cc2 upstream.
>=20
> One of the last remaining failures in kernelci.org is for a gcc bug:
>=20
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not=
 satisfy its constraints:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler er=
ror: in extract_constrain_insn, at recog.c:2190
>=20
> This is apparently broken in gcc-6 but fixed in gcc-7, and I cannot
> reproduce the problem here. However, it is clear that ip27_defconfig
> does not actually need this driver as the platform has only PCI-X but
> not PCIe, and the qlge adapter in turn is PCIe-only.

You could disable CONFIG_SFC here as well, since it only supports PCIe
devices.

Ben.

> The driver was originally enabled in 2010 along with lots of other
> drivers.
>=20
> Fixes: 59d302b342e5 ("MIPS: IP27: Make defconfig useful again.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> Patchwork: https://patchwork.linux-mips.org/patch/15197/
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/configs/ip27_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_de=
fconfig
> index 0e36abcd39cc..7446284dd7b3 100644
> --- a/arch/mips/configs/ip27_defconfig
> +++ b/arch/mips/configs/ip27_defconfig
> @@ -206,7 +206,6 @@ CONFIG_MLX4_EN=3Dm
>  # CONFIG_MLX4_DEBUG is not set
>  CONFIG_TEHUTI=3Dm
>  CONFIG_BNX2X=3Dm
> -CONFIG_QLGE=3Dm
>  CONFIG_SFC=3Dm
>  CONFIG_BE2NET=3Dm
>  CONFIG_LIBERTAS_THINFIRM=3Dm
--=20
Ben Hutchings
It is a miracle that curiosity survives formal education. - Albert
Einstein


--=-JqrZOf+q83NcIoavuK4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAloAsx4ACgkQ57/I7JWG
EQnldg//T6ad0VsqmYbE1pGk+jUGC5r6+WktPrH9xEjETfcSo2qTtP/94junBVh/
0+seOXn3FuKQWGqTReQhJX+aiCiWn06fqA6kLF97OtdEKSZrwPjHqIFopUMMhe+C
N5Bnxcz6GZ/R7UcMAosFs6p4IrAM90LgffhdjgZVCir94ZN2nbGJ+am57GkZfdj8
CMraO3uGyunp4NM7ZWMp5EfE8U66P3lyx8jB3kwNS04c9cfo/Bg4KQyTkfigUXqN
yX/xTUL9PY80spJGtq/F7qdJEZy/SP0di1Q8/v2B1Ti+YGZJOqsS9tD70tzlfCT4
abo7uTqvjE0LwJca9tt2LKzO+zlvnaWAuRS1IKo2fHJ6tUBZDGXpyTIPzwdeV+Nn
Wuod4Et6KTh3M0/MUBuTcIvqsAbCH25FpCGWDRolkN+0ZwJRsfPgVoYv5WioJcst
pDfSLINtv2aaf/clyqRoB3FHCG9LOZEj5mou1ZJnX1UkZnLXTsrAK0Luj8/tvc+v
88J9EnM8UDaCOcdwxezbgpxX96l10YcRjAV3OWiC2et/hSuNcvosHKI1ROwR20oT
9tQnVhmVLxLbyfd/dLJjtqsh2p1p0htIOoZoouu6dwqBFtvrW+DBREBtDELsPDU5
o+zZhGP2jiND6t1XsH/MowrFrvsiSVMMRobdnzvEVBEDdyzPWYM=
=rbT7
-----END PGP SIGNATURE-----

--=-JqrZOf+q83NcIoavuK4r--

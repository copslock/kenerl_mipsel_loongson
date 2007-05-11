Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 05:48:42 +0100 (BST)
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:27567 "EHLO
	smtp.drzeus.cx") by ftp.linux-mips.org with ESMTP id S20021850AbXEKEsl
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 05:48:41 +0100
Received: from poseidon.drzeus.cx (wlan152.drzeus.cx [::ffff:10.8.2.152])
  (AUTH: LOGIN drzeus)
  by smtp.drzeus.cx with esmtp; Fri, 11 May 2007 06:48:39 +0200
  id 00062A6D.4643F5A7.000039B8
Message-ID: <4643F57C.5060409@drzeus.cx>
Date:	Fri, 11 May 2007 06:47:56 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_hera.drzeus.cx-14776-1178858919-0001-2"
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mmc: add include <linux/mmc/mmc.h> to au1xmmc.c
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>
X-Enigmail-Version: 0.95.0
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-14776-1178858919-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yoichi Yuasa wrote:
> Hi,
>=20
> This patch has fixed the following error about au1xmmc.c .
>=20
> drivers/mmc/host/au1xmmc.c: In function 'au1xmmc_send_command':
> drivers/mmc/host/au1xmmc.c:217: error: 'MMC_READ_SINGLE_BLOCK' undeclar=
ed (first use in this function)
> drivers/mmc/host/au1xmmc.c:217: error: (Each undeclared identifier is r=
eported only once
> drivers/mmc/host/au1xmmc.c:217: error: for each function it appears in.=
)
> drivers/mmc/host/au1xmmc.c:218: error: 'SD_APP_SEND_SCR' undeclared (fi=
rst use in this function)
> drivers/mmc/host/au1xmmc.c:221: error: 'MMC_READ_MULTIPLE_BLOCK' undecl=
ared (first use in this function)
> drivers/mmc/host/au1xmmc.c:224: error: 'MMC_WRITE_BLOCK' undeclared (fi=
rst use in this function)
> drivers/mmc/host/au1xmmc.c:228: error: 'MMC_WRITE_MULTIPLE_BLOCK' undec=
lared (first use in this function)
> drivers/mmc/host/au1xmmc.c:231: error: 'MMC_STOP_TRANSMISSION' undeclar=
ed (first use in this function)
>=20
> Yoichi
>=20
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>=20

NAK for now. I want an explanation what those opcodes are doing in a host=
 driver.

Rgds
Pierre



--=_hera.drzeus.cx-14776-1178858919-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGQ/V87b8eESbyJLgRAvUfAKCIJG/eJxpsVPLJ19ZADHIOADoZygCg70PC
43u0h0c/z/k8FN8rAffCzlY=
=oxCE
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-14776-1178858919-0001-2--

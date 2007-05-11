Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 06:22:34 +0100 (BST)
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:31161 "EHLO
	smtp.drzeus.cx") by ftp.linux-mips.org with ESMTP id S20022132AbXEKFWd
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 06:22:33 +0100
Received: from poseidon.drzeus.cx (wlan152.drzeus.cx [::ffff:10.8.2.152])
  (AUTH: LOGIN drzeus)
  by smtp.drzeus.cx with esmtp; Fri, 11 May 2007 07:21:32 +0200
  id 00062A7A.4643FD5C.000039F7
Message-ID: <4643FD2B.8020103@drzeus.cx>
Date:	Fri, 11 May 2007 07:20:43 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_hera.drzeus.cx-14839-1178860892-0001-2"
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mmc: add include <linux/mmc/mmc.h> to au1xmmc.c
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>	<4643F57C.5060409@drzeus.cx> <200705110516.l4B5GMQJ053603@mbox33.po.2iij.net>
In-Reply-To: <200705110516.l4B5GMQJ053603@mbox33.po.2iij.net>
X-Enigmail-Version: 0.95.0
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-14839-1178860892-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yoichi Yuasa wrote:
>=20
> The commands of au1xmmc controller are different from standard commands=
=2E=20
> au1xmmc_send_command() convert standard commands to local commands for =
au1xmmc host controller,
> and send local commands to controller.
>=20

A quick glance at the code seems to suggest it's specifying the type of c=
ommand.
And it should be able to figure that out in a more generic way.

Rgds
Pierre



--=_hera.drzeus.cx-14839-1178860892-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGQ/0u7b8eESbyJLgRAkE4AKCo3ynl5bweMr4W+2EBNuw+UQ6U6QCfXYYC
A6+7Fa7xFeuOE73LMO/rpcE=
=1trZ
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-14839-1178860892-0001-2--

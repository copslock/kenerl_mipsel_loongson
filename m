Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 16:49:48 +0100 (BST)
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:27271 "EHLO
	smtp.drzeus.cx") by ftp.linux-mips.org with ESMTP id S28573710AbXEKPtq
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 16:49:46 +0100
Received: from poseidon.drzeus.cx (wlan152.drzeus.cx [::ffff:10.8.2.152])
  (AUTH: LOGIN drzeus)
  by smtp.drzeus.cx with esmtp; Fri, 11 May 2007 17:49:40 +0200
  id 00062A6C.46449095.00005936
Message-ID: <46449065.3050904@drzeus.cx>
Date:	Fri, 11 May 2007 17:48:53 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_hera.drzeus.cx-22838-1178898581-0001-2"
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mmc: au1xmmc command types check from data flags
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>	<4643F57C.5060409@drzeus.cx>	<200705110516.l4B5GMQJ053603@mbox33.po.2iij.net>	<4643FD2B.8020103@drzeus.cx> <20070511192948.38937fd0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070511192948.38937fd0.yoichi_yuasa@tripeaks.co.jp>
X-Enigmail-Version: 0.95.0
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-22838-1178898581-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yoichi Yuasa wrote:
>=20
> Ok, I updated the patch for au1xmmc.c .
>=20
> This patch has changed command types check from data flags.
>=20

Perfect. That's just the way things should be.

> MMC_STOP_TRANSMISSION is never passed to au1xmmc_send_command().
> SEND_STOP() is used for MMC_STOP_TRANSMISSION.
>=20

That SEND_STOP however is a long standing bug in this driver. Could I bot=
her you
with fixing the driver so that it respects mrq->data->stop?

Rgds
Pierre



--=_hera.drzeus.cx-22838-1178898581-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGRJBq7b8eESbyJLgRAmSNAJ98/CqDUmaa7wUjCm1fbqiSMM4NoACeMFCr
edfHrMO6cPRKi85SKPUwWVA=
=08FX
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-22838-1178898581-0001-2--

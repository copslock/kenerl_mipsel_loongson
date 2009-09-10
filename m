Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 13:08:02 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52623 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492223AbZIJLH4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 13:07:56 +0200
Received: from [2001:6f8:1178:2:221:70ff:fe71:1890] (helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>)
	id 1MlhV6-0000Kj-NT; Thu, 10 Sep 2009 13:07:40 +0200
Date:	Thu, 10 Sep 2009 13:07:40 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Jean Delvare <khali@linux-fr.org>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: Removing deprecated drivers from drivers/i2c/chips
Message-ID: <20090910110740.GB3266@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de> <20090910124937.7b3df062@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20090910124937.7b3df062@hyperion.delvare>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Not sure about the patch to drivers/gpio/pcf857x.c, as there is no gpio
> tree and no maintainer either AFAIK, I guess I shall pick it too?

I'd say so. An Ack from David Brownell would be nice, though.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqo3fwACgkQD27XaX1/VRubLQCfSgZNsCLqCMUHSTodsb+ADje7
8moAniKaGGL+YvVPQzmKGQiBL3LugOtg
=92rb
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

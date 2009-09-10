Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 08:26:38 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42449 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492256AbZIJG0b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 08:26:31 +0200
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>)
	id 1Mld6i-0007NT-MG; Thu, 10 Sep 2009 08:26:12 +0200
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <wsa@pengutronix.de>)
	id 1Mld6f-0001aX-FW; Thu, 10 Sep 2009 08:26:09 +0200
Date:	Thu, 10 Sep 2009 08:26:09 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Mike Frysinger <vapier.adi@gmail.com>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
Message-ID: <20090910062609.GA26454@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de> <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <wsa@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> the Blackfin defconfigs refer to an input driver for the PCF8574, not
> the I2C client driver

Yup, I am aware of that. With the exception of:

blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=3Dm

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqonAEACgkQD27XaX1/VRsuggCgvHIQBK0PDoMqr0mqllZhomK8
ym8An2/4gTJoai3W+CzOM659DgzCeQuK
=yoJc
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

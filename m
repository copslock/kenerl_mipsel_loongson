Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 13:04:40 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45416 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492233AbZIJLEe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 13:04:34 +0200
Received: from [2001:6f8:1178:2:221:70ff:fe71:1890] (helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>)
	id 1MlhRu-0000Fw-Kf; Thu, 10 Sep 2009 13:04:22 +0200
Date:	Thu, 10 Sep 2009 13:04:19 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Bart Van Assche <bart.vanassche@gmail.com>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
Message-ID: <20090910110419.GA3266@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de> <1252531371-14866-3-git-send-email-w.sang@pengutronix.de> <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This patch removes the documentation file
> Documentation/i2c/chips/pcf8575 while there is no documentation under
> Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
> documentation for the pcf857x driver be added to the kernel tree
> before the pcf8575 driver is removed ?

I considered moving the documentation, but realized:

1st part is URLs for datasheets. Well, URLs easily grow outdated and those
datasheets are easily to find using your favourite search engine.

2nd part is a short description of the chips which is IMHO sufficently cove=
red
in drivers/gpio/Kconfig.

3rd part (Detection) and 4th part (sysfs-interface) are obsolete for the new
drivers. The gpiolib interface again is covered in Documentation/gpio.txt

So I concluded to simply drop the documentation.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqo3TMACgkQD27XaX1/VRvFjQCgo1FvA+7ru2LhEIdbNdz63gq+
qZgAoKZE9Vl9Ut69l9xYkFnYk5zyLUA5
=pc+E
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

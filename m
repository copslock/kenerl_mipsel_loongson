Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 08:42:21 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491996Ab0CEHmO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 08:42:14 +0100
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
        by metis.ext.pengutronix.de with esmtp (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NnSAW-0000yI-Jh; Fri, 05 Mar 2010 08:41:56 +0100
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NnSAV-0001lv-VB; Fri, 05 Mar 2010 08:41:55 +0100
Date:   Fri, 5 Mar 2010 08:41:55 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     ddaney@caviumnetworks.com, ben-linux@fluff.org, khali@linux-fr.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100305074155.GD21925@pengutronix.de>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com> <20100305071130.GB21925@pengutronix.de> <4B90B341.9000601@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <4B90B341.9000601@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <wsa@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Is the use of 'eeprom' instead of 'at24' intentional?
> >  =20
>=20
> Unfortunately, at24 driver can't work on this board, I must use legacy
> eeprom.

Well, you are of course free to choose here :)

I'd just be interested if there is a software limitation which prevents you=
 from
using AT24. Because, it _should_ work with all kind of eeproms the legacy d=
river
deals with. Otherwise it is probably a bug which needs to be fixed.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuQtcMACgkQD27XaX1/VRvudwCcDh5SKi1uF8McyFVJphGbTzrw
DyQAn3VWHIc3yopV++1OvlM+2Ixe2e1+
=YLUF
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--

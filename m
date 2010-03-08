Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2010 07:02:28 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51823 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491143Ab0CHGCY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Mar 2010 07:02:24 +0100
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
        by metis.ext.pengutronix.de with esmtp (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NoW2Z-0004uI-In; Mon, 08 Mar 2010 07:02:07 +0100
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NoW2R-0008Nj-Ar; Mon, 08 Mar 2010 07:01:59 +0100
Date:   Mon, 8 Mar 2010 07:01:59 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     ddaney@caviumnetworks.com, ben-linux@fluff.org, khali@linux-fr.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100308060159.GA31209@pengutronix.de>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <wsa@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2010 at 01:29:50PM +0800, Yang Shi wrote:
> An SPD resides on 0x50 of the I2C bus on CN56xx/57xx board,
> register this device.
>=20
> Signed-off-by: Yang Shi <yang.shi@windriver.com>

Glad it worked with at24, after all.

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuUktcACgkQD27XaX1/VRv8vACeLbxiqll0Z1KOU+vt/poudlcv
6y4AnREPFYXDEnuY7Sa/Z1m63DA8Tx6e
=mFOa
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

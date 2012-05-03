Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2012 13:26:38 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56167 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903596Ab2ECL0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 May 2012 13:26:33 +0200
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <wsa@pengutronix.de>)
        id 1SPuB1-0001B6-SB; Thu, 03 May 2012 13:26:27 +0200
Received: from wsa by dude.hi.pengutronix.de with local (Exim 4.77)
        (envelope-from <wsa@pengutronix.de>)
        id 1SPuAx-0003en-EN; Thu, 03 May 2012 13:26:23 +0200
Date:   Thu, 3 May 2012 13:26:23 +0200
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 1/5] i2c: Convert i2c-octeon.c to use device tree.
Message-ID: <20120503112623.GF9574@pengutronix.de>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com>
 <1335489630-27017-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <1335489630-27017-2-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 33130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2012 at 06:20:26PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> There are three parts to this:
>=20
> 1) Remove the definitions of OCTEON_IRQ_TWSI and OCTEON_IRQ_TWSI2.
>    The interrupts are specified by the device tree and these hard
>    coded irq numbers block the used of the irq lines by the irq_domain
>    code.
>=20
> 2) Remove platform device setup code from octeon-platform.c, it is
>    now unused.
>=20
> 3) Convert i2c-octeon.c to use device tree.  Part of this includes
>    using the devm_* functions instead of the raw counterparts, thus
>    simplifying error handling.  No functionality is changed.
>=20
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
> Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
> Cc: linux-i2c@vger.kernel.org

I2C changes look okay. I'd think this goes in via MIPS-tree?

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ia18ACgkQD27XaX1/VRvy0QCgw45MhoPCDZwSKlGvSSUYtFT4
KqgAn0dIv9IJZIyeWi2K8dXNg2coKDbO
=pvhr
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--

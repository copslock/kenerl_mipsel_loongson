Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 17:16:42 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903614Ab2DRPQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 17:16:35 +0200
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <wsa@pengutronix.de>)
        id 1SKWcM-000147-67; Wed, 18 Apr 2012 17:16:26 +0200
Received: from wsa by dude.hi.pengutronix.de with local (Exim 4.77)
        (envelope-from <wsa@pengutronix.de>)
        id 1SKWcH-0008Hn-1A; Wed, 18 Apr 2012 17:16:21 +0200
Date:   Wed, 18 Apr 2012 17:16:21 +0200
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     David Daney <david.daney@cavium.com>
Cc:     Rob Herring <robherring2@gmail.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Subject: Re: [PATCH 1/5] i2c: Convert i2c-octeon.c to use device tree.
Message-ID: <20120418151621.GF19802@pengutronix.de>
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com>
 <1332808075-8333-2-git-send-email-ddaney.cavm@gmail.com>
 <4F7115FA.6080507@gmail.com>
 <4F7117FD.7000700@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <4F7117FD.7000700@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 32961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>-	if (i2c_data =3D=3D NULL) {
> >>-		dev_err(i2c->dev, "no I2C frequency data\n");
> >>+	/*
> >>+	 * "clock-rate" is a legacy binding, the official binding is
> >>+	 * "clock-frequency".  Try the official one first and then
> >>+	 * fall back if it doesn't exist.
> >>+	 */
> >>+	data =3D of_get_property(pdev->dev.of_node, "clock-frequency",&len);
> >>+	if (!data || len !=3D sizeof(*data))
> >>+		data =3D of_get_property(pdev->dev.of_node, "clock-rate",&len);
> >>+	if (data&&  len =3D=3D sizeof(*data)) {
> >>+		i2c->twsi_freq =3D be32_to_cpup(data);
> >
> >Can't you use of_property_read_u32?
>=20
> I will investigate, and use it if possible.

Any outcome?

And shouldn't the bindings be documented? Or are they only standard and
we hide the legacy one?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+O2sUACgkQD27XaX1/VRv/CQCgl1wkMkth8GAy711B8Qinp3Ke
rfsAoL2TfKfwpc5sEuiwNqyAxNWDIiS2
=Qn9J
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

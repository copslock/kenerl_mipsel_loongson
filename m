Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 22:27:21 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45659 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab1LGV1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2011 22:27:17 +0100
Received: from katana.hi.pengutronix.de ([2001:6f8:1178:2:221:70ff:fe71:1890] helo=pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <w.sang@pengutronix.de>)
        id 1RYP1D-0003B5-C3; Wed, 07 Dec 2011 22:27:11 +0100
Date:   Wed, 7 Dec 2011 22:27:10 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Shubhrajyoti Datta <omaplinuxkernel@gmail.com>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller
 driver
Message-ID: <20111207212710.GD3744@pengutronix.de>
References: <1321906615-11392-1-git-send-email-florian@openwrt.org>
 <CAM=Q2cudxgW-B_TEDgBrdk4CFB9LgZqE9db6vDH+MJEgJeCQcg@mail.gmail.com>
 <201111232041.18477.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <201111232041.18477.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 32054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6279


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Could we move to dev pm ops?
>=20
> Sure, I have fixed that in version 2 of the patch.

Have you sent that already?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7f2i4ACgkQD27XaX1/VRt0HgCgi4KsJr9qog+cdPc9JN7UC8T1
HtcAnjY1GMMe+lhyQlZfQYPph6wlvBhs
=+6TV
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--

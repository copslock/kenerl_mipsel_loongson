Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 18:28:50 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:46603 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994248AbeINQ2ppHzjm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 18:28:45 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 78D0520877; Fri, 14 Sep 2018 18:28:39 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 20F5D207D4;
        Fri, 14 Sep 2018 18:28:29 +0200 (CEST)
Date:   Fri, 14 Sep 2018 18:28:28 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20180914162828.5e75ffh5sig4om3d@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914131846.GG14865@lunn.ch>
 <20180914132930.fphdm3dm2incetbq@qschulz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrvuohlm2to6nryf"
Content-Disposition: inline
In-Reply-To: <20180914132930.fphdm3dm2incetbq@qschulz>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--lrvuohlm2to6nryf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 03:29:30PM +0200, Quentin Schulz wrote:
> Hi Andrew,
>=20
> On Fri, Sep 14, 2018 at 03:18:46PM +0200, Andrew Lunn wrote:
> > > Most of the init sequence of a PHY of the package is common to all PH=
Ys
> > > in the package, thus we use the SMI broadcast feature which enables us
> > > to propagate a write in one register of one PHY to all PHYs in the
> > > package.
> >=20
> > Hi Quinten
> >=20
> > Could you say a bit more about the broadcast. Does the SMI broadcast
> > go to all PHY everywhere on an MDIO bus, or only all PHYs within one
> > package? I'm just thinking about the case you need two of these
> > packages to cover 8 switch ports.
> >=20
>=20
> Ah sorry, that wasn't very explicit. That's a feature on the PHY side so
> my wildest guess is that it wouldn't impact any other PHY outside of
> this package. Affecting any other PHY on the bus is counter-intuitive to
> me but I'll ask the HW engineers for confirmation.
>=20

Confirmed by HW engineers, it only impacts PHYs in the same package.

Quentin

--lrvuohlm2to6nryf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlub4awACgkQhLiadT7g
8aP1fg//V+Mup3knhZdlR5JAs/en28BkBQ1Tc76y+7zpzgqSMjAyP2gfg4vMoKz2
3H1Y+jQcX0QopeLDwks0To8eyHwYcq//Wvlv6XSvl7W3/8qPYqIaTXlWZD+O4smK
d0+MP8u5silgh5hS9NKDBKdKheXirH7gdCDLbXDhY2TMCDYYTfrx6Xi3dwRfdivc
x+Zhhmp14p5qhyvEDE7IUSzMcqGo9tKKwR6VQPHtMCyJ3+Wfe4kmTm8nkTFwL1fF
T2l1V1U7ROEQXhyUni61JEH33CZzp8WwOwOkaUjvBIOsur8K+xb7LboHYvh5b0ni
szCdTBqtybkKxUT4FHLm2xWexBBDb5vWQYOQUxMxybe/xfsIsGLUX2MQt9g4PNMO
MTWW7H662G9H0lsqcp4/e05eyIkroBX8Qt547NuQ3dr+RjPn1C9ZbwEPz4C/14+T
GaXc+sncNluq2A+VaMGTx2ZjZOo/Y+coVdhm9nuup9kMibboAd10KqchPBvtBGS0
4IqacfOHH+oNzAkoq30s6Ta4uixULZls6Exfzrn0yKLffxwOeD3fPisCwLGsW2zV
DN1L0uubJWCkTFYuO5tilgZrl3HuF1f4cu/xhtl2kq0bMm3pgAVK/UXXQcqnZ/Rh
bFNMfRwHSSMhAnDHKIXzmLgNf9iGE2skB/QyNuvZr9Nc+7VxlO4=
=qNw+
-----END PGP SIGNATURE-----

--lrvuohlm2to6nryf--

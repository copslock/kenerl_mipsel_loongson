Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 15:29:51 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:39509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINN3s2xIVT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 15:29:48 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2B5F206FF; Fri, 14 Sep 2018 15:29:41 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7215B206EE;
        Fri, 14 Sep 2018 15:29:31 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:29:30 +0200
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
Message-ID: <20180914132930.fphdm3dm2incetbq@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914131846.GG14865@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2cfxpmyvzbuyq6t"
Content-Disposition: inline
In-Reply-To: <20180914131846.GG14865@lunn.ch>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66292
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


--w2cfxpmyvzbuyq6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 03:18:46PM +0200, Andrew Lunn wrote:
> > Most of the init sequence of a PHY of the package is common to all PHYs
> > in the package, thus we use the SMI broadcast feature which enables us
> > to propagate a write in one register of one PHY to all PHYs in the
> > package.
>=20
> Hi Quinten
>=20
> Could you say a bit more about the broadcast. Does the SMI broadcast
> go to all PHY everywhere on an MDIO bus, or only all PHYs within one
> package? I'm just thinking about the case you need two of these
> packages to cover 8 switch ports.
>=20

Ah sorry, that wasn't very explicit. That's a feature on the PHY side so
my wildest guess is that it wouldn't impact any other PHY outside of
this package. Affecting any other PHY on the bus is counter-intuitive to
me but I'll ask the HW engineers for confirmation.

Thanks,
Quentin

--w2cfxpmyvzbuyq6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlubt7oACgkQhLiadT7g
8aMP+g/+L2iC+PhfMSiTn/swWLrAkWxgR7/1NH4N7Kb5wIBJPN659JJnEUHtnQQd
HRu4vqlMEu9c6T6B6fo23w8xHvKSTtQdcPtKgX2AbtwvuNelfPTUtOVQYbdAzqKB
ZG0TKTL5BIFn49N9vwf9SpvVKFJ4e3+XU2/OMAO/PiG3hTwlcqH3JX5TXzDlBSUM
1w+MS/UMzqTRVNnXfCvyGk6/xtAcOIu/GCxCGQviP6iZWtewVrnowqY94FURE8h4
eF4Mc8udp3OLVUOh5Ki3DtWY42oRTG9KPqwDXzxKIgZ4V91n1USVOE8kPIZrvbW8
6N61KHuJTlwZfdcpl5VdUqkOfVfpclnCkJOQkmySZcn9OEGHNxAa/IHN+1eX6wOX
zbD0i7IccvHdjIfoAmQwpO5kO72x3XFaJhcZEq87LBpdcY6QodUJddqjlUdyeSae
BmJN4RhgNi+l3IFFYbOTAQY0o6dTdvSO1W2RzA0//IDeUSXBSirf+dow6vockwf6
cPOjUaq82xJlFzyucsGH1G4Xp6G/sZN1ML3ETnRKLRBIy34dREcfgOE2k5FAtcN4
hzv322g8YR+tuQ7EIXWwxQwM/osiCniaz8Zi7IzJ/aksFJBITLP24rLHEb/xEknL
nIOZfQaVOkE02pxyW/qPU7nUe66hnJUAwdcgr/TIk/hoIeKRVUs=
=Rb1D
-----END PGP SIGNATURE-----

--w2cfxpmyvzbuyq6t--

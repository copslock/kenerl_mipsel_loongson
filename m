Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 11:46:26 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:48203 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990757AbeJDJqXKCDZL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2018 11:46:23 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7986F20DDB; Thu,  4 Oct 2018 11:46:16 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F33F20DCD;
        Thu,  4 Oct 2018 11:45:51 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:45:51 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 4/7] net: phy: mscc: add support for VSC8574 PHY
Message-ID: <20181004094551.wizlpc6udhkqufgo@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <236ef7815c0bec6048e79ef06868719b65c63892.1536916714.git-series.quentin.schulz@bootlin.com>
 <bc95fae7-cf2f-5cf1-4e24-59fcc231fd64@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xoljisyeyscb6hrd"
Content-Disposition: inline
In-Reply-To: <bc95fae7-cf2f-5cf1-4e24-59fcc231fd64@gmail.com>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66670
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


--xoljisyeyscb6hrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Fri, Sep 14, 2018 at 01:26:06PM -0700, Florian Fainelli wrote:
> On 09/14/2018 02:44 AM, Quentin Schulz wrote:
> > The VSC8574 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
> > 1000BASE-X and triple-speed copper SFP capable, can communicate with
> > the MAC via SGMII, QSGMII or 1000BASE-X, supports WOL, downshifting and
> > can set the blinking pattern of each of its 4 LEDs, supports SyncE as
> > well as HP Auto-MDIX detection.
> >=20
> > This adds support for 10/100/1000BASE-T, SGMII/QSGMII link with the MAC,
> > WOL, downshifting, HP Auto-MDIX detection and blinking pattern for its 4
> > LEDs.
> >=20
> > The VSC8574 has also an internal Intel 8051 microcontroller whose
> > firmware needs to be patched when the PHY is reset. If the 8051's
> > firmware has the expected CRC, its patching can be skipped. The
> > microcontroller can be accessed from any port of the PHY, though the CRC
> > function can only be done through the PHY that is the base PHY of the
> > package (internal address 0) due to a limitation of the firmware.
> >=20
> > The GPIO register bank is a set of registers that are common to all PHYs
> > in the package. So any modification in any register of this bank affects
> > all PHYs of the package.
> >=20
> > If the PHYs haven't been reset before booting the Linux kernel and were
> > configured to use interrupts for e.g. link status updates, it is
> > required to clear the interrupts mask register of all PHYs before being
> > able to use interrupts with any PHY. The first PHY of the package that
> > will be init will take care of clearing all PHYs interrupts mask
> > registers. Thus, we need to keep track of the init sequence in the
> > package, if it's already been done or if it's to be done.
> >=20
> > Most of the init sequence of a PHY of the package is common to all PHYs
> > in the package, thus we use the SMI broadcast feature which enables us
> > to propagate a write in one register of one PHY to all PHYs in the
> > package.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
>=20
> [snip]
>=20
> > +	reg =3D __mdiobus_read(bus, phy, MSCC_PHY_TEST_PAGE_8);
> > +	reg |=3D 0x8000;
>=20
> Having a define would be nice here? This looks like a write enable?
>=20

I had asked for the meaning of this bit in this register before but we
couldn't find documentation for it. I'll ask again and let you know.

> > +	__mdiobus_write(bus, phy, MSCC_PHY_TEST_PAGE_8, reg);
> > +
> > +	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
> > +
> > +	vsc8584_csr_write(bus, phy, 0x8fae, 0x000401bd);
>=20
> Just make this an array of address + value pairs and blast it to the
> PHY, having them be inlined here is both error prone and does not scale
> well at all.

Right. Turned out it was a great idea as the below values were
mistakenly adding 0x8000 to the register (which was fine since in
vsc8584_csr_write does a 0x8000 | reg).

Thanks,
Quentin

--xoljisyeyscb6hrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu14U4ACgkQhLiadT7g
8aP6tBAAnZRGhR2pqANoJY0A0EERdxFa7jATOs7/nIPLSOl7sX+28IWh1mVWAq5A
KNujB7KQ9SeWnTYsnrRcwEjvBQPjRkd1mxYPZ+2sGC/BiCzLeutDr/LrniK9trr8
+SsU9O05+rmoIb+Re1vJ9jSealvKo+ruMi1IPOlonFruTWN44H35vHQCIf0bFzNk
+CtHBO8xzwWYkqHOTEPUIoY1r3IKgnplWAHx09JEYhMJKZCWGlKyLuW5EdnbQa2N
c81InLG1a88GM/taY9wcVkcEdwBAANqTHMidexdOT1q7lOVlQ4gsPtzXQu1j2THF
5SUAykPXPoTLTcUykycb0WRnYWb6vb/u0I3OY45+B0NFMCdYjWHlWrzRIzM5+iPw
A1TwUlPL8P0g+Zo0FyCe8WzJ+vzM04oRwVXQqgJO/aiH9ubdBfCvT2LaTILWHwpC
1Uk8GcwrEvGMhZwVeVvCgSOzzDruxHJDRp7rOc8go1qGi/o44Il/7Xpk0BxPHdMp
kKx7ZYkIs31tCLS3A8sYUR7n9tucuHBdk/xD/q6Vv7+2wlHmUo8Dxrmf7efWwYGv
nxKYW8D1PVfOOQt+OhXFwjNivfXEU42P+DBdz5XYWOkElmOYDJetJmmn6R/sUgZG
cUY8NvP85T21T5xvsFmkipGBc7LrC2IkJ1+6uf0zdYghM1qgBcg=
=lcii
-----END PGP SIGNATURE-----

--xoljisyeyscb6hrd--

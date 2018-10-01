Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 11:15:53 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:46642 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992925AbeJAJPuIgJED (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 11:15:50 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7D95E20828; Mon,  1 Oct 2018 11:15:43 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 23851206A2;
        Mon,  1 Oct 2018 11:15:43 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:15:43 +0200
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
Message-ID: <20181001091543.q4mshrpmbn7tlkdn@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914172754.GC3811@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgwqmmf3egdwz2lm"
Content-Disposition: inline
In-Reply-To: <20180914172754.GC3811@lunn.ch>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66633
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


--hgwqmmf3egdwz2lm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 07:27:54PM +0200, Andrew Lunn wrote:
>=20
> >  struct vsc8531_private {
> >  	int rate_magic;
> >  	u16 supp_led_modes;
> > @@ -181,6 +354,7 @@ struct vsc8531_private {
> >  	struct vsc85xx_hw_stat *hw_stats;
> >  	u64 *stats;
> >  	int nstats;
> > +	bool pkg_init;
>=20
> > +/* bus->mdio_lock should be locked when using this function */
> > +static int vsc8584_cmd(struct mii_bus *bus, int phy, u16 val)
> > +{
> > +	unsigned long deadline;
> > +	u16 reg_val;
> > +
> > +	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
> > +			MSCC_PHY_PAGE_EXTENDED_GPIO);
> > +
> > +	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD, PROC_CMD_NCOMPLETED | va=
l);
>=20
> Hi Quentin
>=20
> All the __mdiobus_write() look a bit ugly.

I agree :)

> Maybe add bus and base_addr
> to the vsc8531_private structure. Then add helpers
> phy_write_base_phy(priv, reg, val) and phy_read_base_phy(priv, reg).
>=20

ACK.

> You could also add in:
>=20
>         if (unlikely(!mutex_is_locked(&priv->bus->mdio_lock))) {
>                 dev_err(bus->dev, "MDIO bus lock not held!\n");
>                 dump_stack();
>         }
>=20
> Having such code in the mv88e6xxx driver has found a few bugs for me.
>=20

ACK.

Thanks,
Quentin

--hgwqmmf3egdwz2lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux5b4ACgkQhLiadT7g
8aM6XBAAptT581qBE7XY42MTueijWuoRMYjMOlA7VzybiZ80bMxZtrhQMHZIvWiq
GMOU26VIK+N253/u3oQMKIO8eSX3lRRuG2Tp7UN44LNtIfeFX2LhTfeuvVkyAjvJ
JY/ZXxq4r9Vkos1QEHoJOR91/289iDB2JYdf1JZ01nXfmA677FSrIzbCm8iGO4aF
muMuW2i9X2gEaTZargBfM6JNsIwWZJlRimzPlOuzhQQB3R8o8DK2XABHrB8AoiTn
Q1r54EsLPlL2i4V7zUlRyybrU+O+6q0uYA+0Q2SGhBmX8SlTMwF7B1VZHZVyrITm
df1EMiOlnwqprzao36mClnOnvREz2/j/oh6nbxS2LD6tBR+hEa4cTL3TdZuAky6i
Omr400D3nedo9QMG9l2iHaVdHbaW3xWZINnA46SzmO+CcO0E0KQBwXgimoGRHkgE
Zlj/eD2hPVu1zZgeAtwiBjTl76nM6vo37OmVaOgiJaovz74VW/dzpOfICiAU5hza
jWdxHRyYcWJuRWCoYk9hiKP6pt2MkRaUHrANGlq+4X0Bfjw/E9yzo4qSlikN0INi
8RrfNCK61mSxZhjPzjs0iW/3jVIYUTi3xJ2iIAa7Il8tiNAp2ofTqA9xldfpKm6T
JeAAKcSgLZvRqpvNEAtgFsyOadGzzF7yu0xys5h5op9VKHDKHHk=
=xTTz
-----END PGP SIGNATURE-----

--hgwqmmf3egdwz2lm--

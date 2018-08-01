Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 09:52:09 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:40356 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990947AbeHAHwChuPEP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 09:52:02 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D0F720799; Wed,  1 Aug 2018 09:51:55 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5BD62206D8;
        Wed,  1 Aug 2018 09:51:44 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:51:44 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 10/10] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
Message-ID: <20180801075143.s3fthewteu3n3evf@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <0ce1b3e8466064741dc6e484f87bbe48542cb978.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730135018.GF13198@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zs5rv4pdrmnxsur6"
Content-Disposition: inline
In-Reply-To: <20180730135018.GF13198@lunn.ch>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65340
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


--zs5rv4pdrmnxsur6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 30, 2018 at 03:50:18PM +0200, Andrew Lunn wrote:
>  On Mon, Jul 30, 2018 at 02:43:55PM +0200, Quentin Schulz wrote:
>=20
> > +		err =3D of_get_phy_mode(portnp);
> > +		if (err < 0)
> > +			ocelot->ports[port]->phy_mode =3D PHY_INTERFACE_MODE_NA;
> > +		else
> > +			ocelot->ports[port]->phy_mode =3D err;
> > +
> > +		if (ocelot->ports[port]->phy_mode =3D=3D PHY_INTERFACE_MODE_NA)
> > +			continue;
> > +
> > +		if (ocelot->ports[port]->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII)
> > +			phy_mode =3D PHY_MODE_SGMII;
> > +		else
> > +			phy_mode =3D PHY_MODE_QSGMII;
>=20
> Hi Quentin
>=20
> Say somebody puts RGMII as the phy-mode? It would be better to verify
> it is only SGMII or QSGMII and return -EINVAL otherwise.
>=20

I'll replace this with a switch case to handle other cases.

> > +
> > +		serdes =3D devm_of_phy_get(ocelot->dev, portnp, NULL);
> > +		if (IS_ERR(serdes)) {
> > +			if (PTR_ERR(serdes) =3D=3D -EPROBE_DEFER) {
> > +				dev_err(ocelot->dev, "deferring probe\n");
>=20
> dev_dbg() ? It is not really an error.
>=20

Ack.

> > +				err =3D -EPROBE_DEFER;
> > +				goto err_probe_ports;
> > +			}
> > +
> > +			dev_err(ocelot->dev, "missing SerDes phys for port%d\n",
> > +				port);
> > +			err =3D -ENODEV;
>=20
> err =3D PTR_ERR(serdes) so we get the actual error?
>=20

Ack.

Thanks,
Quentin

--zs5rv4pdrmnxsur6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlthZo8ACgkQhLiadT7g
8aPbkRAAlZG/slUFYQUoRGChoRoiIBCl+L+pqmXc587iGWF0D42nkgIqjNZ7ahHb
8IqFYGSINc8iYWkvDKXJeR0OtktOreUrldWSXaegihEc3mwnd++TXcyfzhPzTZuX
dFJk0Epc89hVisiOWrVZfbId7sVlGJYc+w7QXLX3yhJGZ9riycMhzmRvM5Vk8s/y
tDrXHe+3/lkv89H1Sk8+hKMm9ruNoN9kWxd4IAbArTcxFNDHvK53OtKAyGWaiQ6Q
AbwhHgkkEiiniS0johMTI15ouf+EHu6XXB/mj69FoOgkGqoXw9pg0gg+ocCIkBUI
NmyODHe9XT7aTnwFIZa+BYJQCjITGe00xAVAwUFRHw3DTiRaCaEC4dF8NxLRuhEX
nuiZjRJ+Tlu/WIUBpNktKCZLywRYqsq2OXrZaUCZwozibVF8Mg+bUgH+J4MlNBxb
tQ+Hh/P5fKpLknBhsvbeYnz4SSqlWIXpCO4ImmyC87iS8NIoZmdOGTtnvRj6DY+u
gah04QVxoBc4ja9PnBkAbZw+P1sSRHJjss+CClijHfdJZF6o+jYS1ys0hIsl/qDw
MG0buoT10ZdqKOc9vBhATw/EjnmEJqC7ox0pi9x6FgkPPyCdFy32NEkjbUu04tf2
mJLvQNy05E1pWGTg4WXq+uUAI/PdCazxzoltt5lyI8H1Jf1CMrk=
=3Ulf
-----END PGP SIGNATURE-----

--zs5rv4pdrmnxsur6--

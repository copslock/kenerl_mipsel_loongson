Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 11:43:06 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:47569 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992925AbeJAJnCCJgte (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 11:43:02 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6A4B5208F4; Mon,  1 Oct 2018 11:42:55 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 05FD3206FF;
        Mon,  1 Oct 2018 11:42:45 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:42:45 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v3 11/11] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
Message-ID: <20181001094245.cr4hdcechrqkjymq@qschulz>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
 <0f762d63-a392-d2fe-a121-a013a13a8584@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qj7oqpfzhozt23v"
Content-Disposition: inline
In-Reply-To: <0f762d63-a392-d2fe-a121-a013a13a8584@gmail.com>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66636
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


--7qj7oqpfzhozt23v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Sat, Sep 15, 2018 at 02:25:05PM -0700, Florian Fainelli wrote:
>=20
>=20
> On 09/14/18 01:16, Quentin Schulz wrote:
> > Previously, the SerDes muxing was hardcoded to a given mode in the MAC
> > controller driver. Now, the SerDes muxing is configured within the
> > Device Tree and is enforced in the MAC controller driver so we can have
> > a lot of different SerDes configurations.
> >=20
> > Make use of the SerDes PHYs in the MAC controller to set up the SerDes
> > according to the SerDes<->switch port mapping and the communication mode
> > with the Ethernet PHY.
>=20
> This looks good, just a few comments below:
>=20
> [snip]
>=20
> > +		err =3D of_get_phy_mode(portnp);
> > +		if (err < 0)
> > +			ocelot->ports[port]->phy_mode =3D PHY_INTERFACE_MODE_NA;
> > +		else
> > +			ocelot->ports[port]->phy_mode =3D err;
> > +
> > +		switch (ocelot->ports[port]->phy_mode) {
> > +		case PHY_INTERFACE_MODE_NA:
> > +			continue;
>=20
> Would not you want to issue a message indicating that the Device Tree
> must be updated here? AFAICT with your patch series, this should no
> longer be a condition that you will hit unless you kept the old DTB
> around, right?
>=20

It'll occur for internal PHYs. On the PCB123[1], there are four of them,
so we need to be able to give no mode in the DT for those. For the
upcoming PCB120, there'll be 4 external PHYs that require a mode in the
DT and 4 internal PHYs that do not require any mode. I could put a debug
message that says this or that PHY is configured as an internal PHY but
I wouldn't put a message that is printed with the default log level.

So I think we should keep it, shouldn't we?

[1] https://elixir.bootlin.com/linux/latest/source/arch/mips/boot/dts/mscc/=
ocelot_pcb123.dts

> > +		case PHY_INTERFACE_MODE_SGMII:
> > +			phy_mode =3D PHY_MODE_SGMII;
> > +			break;
> > +		case PHY_INTERFACE_MODE_QSGMII:
> > +			phy_mode =3D PHY_MODE_QSGMII;
> > +			break;
> > +		default:
> > +			dev_err(ocelot->dev,
> > +				"invalid phy mode for port%d, (Q)SGMII only\n",
> > +				port);
> > +			return -EINVAL;
> > +		}
> > +
> > +		serdes =3D devm_of_phy_get(ocelot->dev, portnp, NULL);
> > +		if (IS_ERR(serdes)) {
> > +			err =3D PTR_ERR(serdes);
> > +			if (err =3D=3D -EPROBE_DEFER) {
>=20
> This can be simplified into:
>=20
> 			if (err =3D=3D -EPROBE_DEFER)
> 				dev_dbg();
> 			else
> 				dev_err();
> 			goto err_probe_ports;
>=20

Indeed, good catch.

Thanks,
Quentin

--7qj7oqpfzhozt23v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux7BQACgkQhLiadT7g
8aPvNw//VDHvFuh5HkcKrjXm3ZNai+qsn4woktOqsrFvbcgzLUqpIs6Ha51RPcQi
tFzDmQcIm8YExKYWyLZbGCWruA6sAPVz520gQW/ezRoXyRdnlfmtyAsVsSfQmy+Y
dg2KPBFSicM7BA7sDy841H0qGqhsWZpEm3b1ks+T+APCd124FpFcc7bakJeuEWuu
hkSso9320Aw4BNwu23p4qGOd3RvoGj0Yqrw+7gCWmsk6+N7qzDmx+msDJZdsgjNp
5pxX8myoIHqiSA2dB7fx3hwmxYB+ds4m02YI0QqmsFWzsUqSMDnMklswKXq/6qEp
AZm/nJXXFZPlFIAx4N0jDDH7bI7Wvqrpbl/Nrc6NuEuBklt2UKSJ1aqkt5WGuJ+w
L7cC1abHEHREa2asWMqbyQtL7KwTdRRDEPK0ndjX0gjx4ngZNloI4FYzx/fe+Uzz
9Fo1NL+WYY5wSy9MDRUKc91ivbXCf/F75R+P5BFAblWW/RUsfYZXbacjDXC0y02N
S0Eu1gsVeyns0Jun5KKZE+biZrs3mf+3QiDX11LesNTu1eSSCZphIojX1ZiMR9jP
+9d7i8HPbCiPbIcj1cQhnOy1VdgxNFTngF0SPXpm9UpiEI+I30V84CG1QxeiOODt
qNRlZnxG5B6WnVB3+DbPKPUim9hqqu8P8gWeMrGBbQtPOMs3MYg=
=8aU4
-----END PGP SIGNATURE-----

--7qj7oqpfzhozt23v--

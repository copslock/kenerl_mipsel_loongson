Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 14:46:16 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:52727 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994558AbeJAMqMR3dCo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 14:46:12 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 67C9020725; Mon,  1 Oct 2018 14:46:05 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0BE29206A2;
        Mon,  1 Oct 2018 14:46:05 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:46:05 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v3 07/11] dt-bindings: phy: add DT binding for
 Microsemi Ocelot SerDes muxing
Message-ID: <20181001124605.jxiechvp6ztvh77p@qschulz>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
 <20180926213509.GA7454@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4hoevmel2quxjye3"
Content-Disposition: inline
In-Reply-To: <20180926213509.GA7454@bogus>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66647
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


--4hoevmel2quxjye3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

I'm not sure I've understood the way you wanted me to so let me know if
I'm not on the right path.

On Wed, Sep 26, 2018 at 04:35:09PM -0500, Rob Herring wrote:
> On Fri, Sep 14, 2018 at 10:16:05AM +0200, Quentin Schulz wrote:
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 40 +++++=
++-
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-se=
rdes.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.tx=
t b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > new file mode 100644
> > index 0000000..2a88cc3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > @@ -0,0 +1,40 @@
> > +Microsemi Ocelot SerDes muxing driver
> > +-------------------------------------
> > +
> > +On Microsemi Ocelot, there is a handful of registers in HSIO address
> > +space for setting up the SerDes to switch port muxing.
> > +
> > +A SerDes X can be "muxed" to work with switch port Y or Z for example.
> > +One specific SerDes can also be used as a PCIe interface.
> > +
> > +Hence, a SerDes represents an interface, be it an Ethernet or a PCIe o=
ne.
> > +
> > +There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> > +half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G suppo=
rts
> > +10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> > +
> > +Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> > +QSGMII.
> > +
> > +Required properties:
> > +
> > +- compatible: should be "mscc,vsc7514-serdes"
> > +- #phy-cells : from the generic phy bindings, must be 2.
> > +	       The first number defines the input port to use for a given
> > +	       SerDes macro. The second defines the macro to use. They are
> > +	       defined in dt-bindings/phy/phy-ocelot-serdes.h
>=20
> You need to define what this is a child of.
>=20

This is a child of the HSIO syscon on the Microsemi Ocelot. I don't
expect all Microsemi SoCs that could use this driver to have the SerDes
node in the HSIO syscon.

Among the latest additions in Documentation/devicetree/bindings/phy I
couldn't find anything close to my understanding of "define what this is
a child of", could you elaborate on what you want exactly?

> > +
> > +Example:
> > +
> > +	serdes: serdes {
> > +		compatible =3D "mscc,vsc7514-serdes";
> > +		#phy-cells =3D <2>;
>=20
> However, if there are no other resources associated with this, then you=
=20
> don't even need this child node. The parent can be a phy provider and=20
> provider of other functions too.
>=20

The parent is a syscon with multiple features (SerDes, PLL
configuration, temp sensor, SyncE, ...) so I'm not sure it's possible to
do what you're asking me to. For now, there is only a SerDes node but
ultimately there'll be more than one I guess.

Thanks,
Quentin

--4hoevmel2quxjye3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluyFwwACgkQhLiadT7g
8aOHrw//emXaFPG2jxUdu2NUdXCh79WYloOxKpbDEEbAW5Lfs4GZLCRy3NeEBqhU
2WxS6RuY9FonPdgZKx5OkFA5iL+KeOS/sVz22xN3IOSZPFZlc9hzBt9gUC/vvbM1
eFrkPDmXtIfCCpDdZ0L4ogzNdr6F7JSUwMUmds3mYWrjPORyyILutLTxgleuZryN
lM1N7Rb5u4ASDn4KhMIla9UcFEhRPVOwfJPydqPRsboc4UknbpdRkEljzfAkBkjr
DvhGjoAW6tWTKIk+UK0L0pJmILwFOt0+Iwptu/ZSAHHA8nnvnP/vGXIpvHrwHa4A
MLQVHGMScSQYnpVqcrjXYOHrClt7QhUujZIU8ZqH07CQhsU3HuoMHm8uICigbKfI
u9KvNSzkG2C1Otfb6j3cGSEWf71R4RzqVHnFxAQtwS3U1PLRb5zCj+TwyMZqxI2I
vnvokFgGugyK7stymZQ2zWYjtIVDMvEebN9JxR1gak5gRb8PjDi0KHifCC6oJcZm
c4ulWoEtsT+8GwTxiTfetyT4YIM0WjtzXq/19pcMd20tHoXka5BeD7pyA4DiuxhU
Awh1ecgZ44OVjl9rK7J2yvX/wLF6toD4eeQl9S8oVNtODwZkWj45xnL+6V4HTCRw
WGA2gcxnvteaFkGs5jnOAlBGoqzDDMf/r00jyDr1EdWd3SRIigY=
=vZEA
-----END PGP SIGNATURE-----

--4hoevmel2quxjye3--

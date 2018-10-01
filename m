Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 11:02:51 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:46283 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbeJAJCoXlQlD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 11:02:44 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EAA1620A2E; Mon,  1 Oct 2018 11:02:37 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8A9F9206A2;
        Mon,  1 Oct 2018 11:02:27 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:02:27 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20181001090227.mmcnstxcdfocx3zd@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914145446.GQ14988@piout.net>
 <20180914162638.fgzzjin2bzgx74de@qschulz>
 <20180914180222.GT14988@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ysacw7np3q4ncps4"
Content-Disposition: inline
In-Reply-To: <20180914180222.GT14988@piout.net>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66630
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


--ysacw7np3q4ncps4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Fri, Sep 14, 2018 at 08:02:22PM +0200, Alexandre Belloni wrote:
> On 14/09/2018 18:26:38+0200, Quentin Schulz wrote:
> > Hi Alexandre,
> >=20
> > On Fri, Sep 14, 2018 at 04:54:46PM +0200, Alexandre Belloni wrote:
> > > Hi,
> > >=20
> > > On 14/09/2018 11:44:26+0200, Quentin Schulz wrote:
> > > > In order to use GPIO4 as a GPIO, we need to mux it in this mode so =
let's
> > > > declare a new pinctrl DT node for it.
> > > >=20
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > > ---
> > > >  arch/mips/boot/dts/mscc/ocelot.dtsi | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/d=
ts/mscc/ocelot.dtsi
> > > > index 8ce317c..b5c4c74 100644
> > > > --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > > @@ -182,6 +182,11 @@
> > > >  			interrupts =3D <13>;
> > > >  			#interrupt-cells =3D <2>;
> > > > =20
> > > > +			gpio4: gpio4 {
> > > > +				pins =3D "GPIO_4";
> > > > +				function =3D "gpio";
> > > > +			};
> > > > +
> > >=20
> > > For a GPIO, I would do that in the board dts because it is not used
> > > directly in the dtsi.
> > >=20
> >=20
> > And the day we've two boards using this pinctrl we move it to a dtsi. Is
> > that the plan?
> >=20
>=20
> Not really, at least not for gpios. I've included the pinctrl for the
> uart, i2c and spi because they are the only option if you are to use
> those peripherals. Else, I've would have left the pinctrl to the board
> file. From my point of view, the gpios are too board specific to be in a
> soc dtsi.
>=20

Understood, will move it to the board file.

Thanks,
Quentin

--ysacw7np3q4ncps4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux4qMACgkQhLiadT7g
8aPhvg/+KCAqXI08qVQU87ghlaA+BByGeMMOIg1WhPtdA6gSQDR6iF/UgzTsGzk9
4R6noEjVGm0nF4FPESZg5wjzD7vyVK57Yhht8xc4iztNGul61+n66F6mQywOl+He
6ehEUyMP9HXTznVt2NPMHeYr0q5DhV3HC1c+giRT+zG5+BlIplpFWFDhB+IXsL/t
E987QydR/4lX7YNNmUc/VNYnJwTuEJH7xhVnYiGmqhBK+j9K2iMAsbKUEYwR2EOX
FCAH85ktMIwVi64oJYIZZjBT2ntIlKl9ayIR0i2Titjf8dnOUBys0gChxquShWYn
AzrotXStMrq7CBSR7GpFu2+XT4DkH3m6qnnbjI/wrKUFJ2V1bUOyeZZSmjueUMdx
zypW4P8L8MHXCJ6dR8p6bgWedBLqXyOIKVnziajs67N4layeE4pU954BYKKoM9vM
PAsjZdIVbk83S5iYLDkX6ItHKC9VoyLiCYZpsL8mp2crG2he2nlsFg60NshDs5xn
iQ13jy9iwyI5aFduvPAWoBYCig0NLhRl+45nqYuNhov0IJ/wUSsm1ucgyzukLFDg
cxgnPBdEShCchrtSy5kPRgje9mh64warP7iZuzH/JFo5f8T7hKPAuBTQ56Egi3nb
mW7lvUDugTcjnwZ8ALaN+/XlU1LVPsQAd2kkIzYdNPS5Z+KaHWI=
=FfTb
-----END PGP SIGNATURE-----

--ysacw7np3q4ncps4--

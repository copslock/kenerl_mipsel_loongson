Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 10:24:24 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:42368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991623AbeHAIYVBij52 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 10:24:21 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7BFBD2074F; Wed,  1 Aug 2018 10:24:14 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id A985020740;
        Wed,  1 Aug 2018 10:24:13 +0200 (CEST)
Date:   Wed, 1 Aug 2018 10:24:13 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180801082413.2mjm52vwxw3anun6@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730133448.GD13198@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aipy2f7xx2epmgoe"
Content-Disposition: inline
In-Reply-To: <20180730133448.GD13198@lunn.ch>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65343
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


--aipy2f7xx2epmgoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 30, 2018 at 03:34:48PM +0200, Andrew Lunn wrote:
> > +Required properties:
> > +
> > +- compatible: should be "mscc,vsc7514-serdes"
> > +- #phy-cells : from the generic phy bindings, must be 3. The first num=
ber
> > +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> > +	       SERDES6G_X), the second defines the macros in the specified
> > +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> > +	       last one defines the input port to use for a given SerDes
> > +	       macro,
>=20
> It looks like there are some space vs tab issues here.
>=20

Yup.

> > +
> > +Example:
> > +
> > +	serdes: serdes {
>=20
> Maybe this should be serdes-mux? The SERDES itself should have some
> registers somewhere. If you ever decide to make use of phylink,
> e.g. to support SFP, you are going to need to know if the SERDES is
> up. So you might need to add the actual SERDES device, in addition to
> the mux for the SERDES.
>=20

I'm not sure to follow.

To be honest, I might have mislead you. The whole configuration of the
serdes is in the hsio register address space. For now, muxing is the
only reason there is a driver for the serdes but there are other things
that can be configured (though not used yet): de/serializer, input/output
buffers, PLL, ... configuration registers for the SerDes.

So I think I should remove the mention to muxing and just say in the
cover letter and commit log it's for muxing the SerDes among other
configurations.

So I think we're good with the current driver and DT, just poor wording
on my side for the commit log/cover letter. Do you agree?

Quentin

--aipy2f7xx2epmgoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlthbi0ACgkQhLiadT7g
8aOyLA/9HtLbvOJgwUIZRSo5DLUGfIBcDAtRbCl1SaO8iLbCWTxaIoBuNXuNO8XI
yUjneskEuXEAf0cuKpvrCmc34rK/ccezT1FoI7GSZ1avKosbpBo7CexZNoIPlp5S
ABoiNORwbiTeZgth+ppgT1rSYB7RkxH0Rn3PeArX6jOdxUQz2iSZVfDK/6WmoHaA
tWwfivFI428uVRq+dD5PRUW+eOF4EA+wnvGGL0I/Dl1Tsp6Z93hxdKLrkT6d6pxn
n/JR5d9r/U7uyTJ20/oK+202y2/dG+5Iy6+UIUFH+Y5CuxeOroJJbLAfhk2yC2sI
BgKLVqrH5i6UI1dWmdyC1YGKOyQE8WZ3oJ2Nht1VvYs92OKfEF8RIn9v788RdkgI
bB7s4KM5hT9qnon+t2iw7q1UKmyTCcV1Mcdm1j/yNDWE4grK3DkeOQXBhBhpeZhf
jFdKmNUkrTCrxtoOLlm7NYNGJLlY9gAmOJiXeGRmQZYnzpJvZ8vbPx0MzSSdoqqR
wxuNrOC2pzv5zc5Vv33WDtC62Nz5IkZMdVqm4tDlI/HVgcdLgyf/UOuJIqhWd3Zy
oSLPrS0OrWac72jJ3MYORq+EqxDcdHEqbUl6kaDNlXTwonZ7mHyS92IKdtUIrhdx
jvHh8+OmPTht1cRXtWpoIvPyOIrEF/H3DV7b5Ikp1eHEDCnjsAg=
=0DPF
-----END PGP SIGNATURE-----

--aipy2f7xx2epmgoe--

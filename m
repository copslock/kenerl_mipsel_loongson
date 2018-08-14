Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 08:50:07 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54666 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992482AbeHNGuCM6D9e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 08:50:02 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B6D9B207CD; Tue, 14 Aug 2018 08:49:53 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-43-114.w90-88.abo.wanadoo.fr [90.88.161.114])
        by mail.bootlin.com (Postfix) with ESMTPSA id 579C8206F6;
        Tue, 14 Aug 2018 08:49:53 +0200 (CEST)
Date:   Tue, 14 Aug 2018 08:49:53 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180814064953.vboz2gryq4jff34n@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180813223103.GA16669@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kwtbog5c7ae7sk2x"
Content-Disposition: inline
In-Reply-To: <20180813223103.GA16669@rob-hp-laptop>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65584
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


--kwtbog5c7ae7sk2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, Aug 13, 2018 at 04:31:03PM -0600, Rob Herring wrote:
> On Mon, Jul 30, 2018 at 02:43:47PM +0200, Quentin Schulz wrote:
> > HSIO register address space should be handled outside of the MAC
> > controller as there are some registers for PLL5 configuring,
> > SerDes/switch port muxing and a thermal sensor IP, so let's remove it.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/mips/mscc.txt       | 16 +++++++++++=
+-
> >  Documentation/devicetree/bindings/net/mscc-ocelot.txt |  9 ++-----
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Document=
ation/devicetree/bindings/mips/mscc.txt
> > index ae15ec3..bc817e9 100644
> > --- a/Documentation/devicetree/bindings/mips/mscc.txt
> > +++ b/Documentation/devicetree/bindings/mips/mscc.txt
> > @@ -41,3 +41,19 @@ Example:
> >  		compatible =3D "mscc,ocelot-cpu-syscon", "syscon";
> >  		reg =3D <0x70000000 0x2c>;
> >  	};
> > +
> > +o HSIO regs:
> > +
> > +The SoC has a few registers (HSIO) handling miscellaneous functionalit=
ies:
> > +configuration and status of PLL5, RCOMP, SyncE, SerDes configurations =
and
> > +status, SerDes muxing and a thermal sensor.
> > +
> > +Required properties:
> > +- compatible: Should be "mscc,ocelot-hsio", "syscon", "simple-mfd"
> > +- reg : Should contain registers location and length
> > +
> > +Example:
> > +	syscon@10d0000 {
> > +		compatible =3D "mscc,ocelot-hsio", "syscon", "simple-mfd";
>=20
> simple-mfd is not appropriate without child nodes, so drop it.
>=20

Understood but it's an intermediate patch. Later (patch 8), the SerDes
muxing "controller" is added as a child to this node. There most likely
will be some others in the future (temperature sensor for example).

Furthermore, there's already a simple-mfd without children in this file:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/mips/mscc.txt#L19

How should we handle this case?

Thanks,
Quentin

> > +		reg =3D <0x10d0000 0x10000>;
> > +	};
> > diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Do=
cumentation/devicetree/bindings/net/mscc-ocelot.txt
> > index 0a84711..9e5c17d 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> > @@ -12,7 +12,6 @@ Required properties:
> >    - "sys"
> >    - "rew"
> >    - "qs"
> > -  - "hsio"
> >    - "qsys"
> >    - "ana"
> >    - "portX" with X from 0 to the number of last port index available o=
n that
> > @@ -45,7 +44,6 @@ Example:
> >  		reg =3D <0x1010000 0x10000>,
> >  		      <0x1030000 0x10000>,
> >  		      <0x1080000 0x100>,
> > -		      <0x10d0000 0x10000>,
> >  		      <0x11e0000 0x100>,
> >  		      <0x11f0000 0x100>,
> >  		      <0x1200000 0x100>,
> > @@ -59,10 +57,9 @@ Example:
> >  		      <0x1280000 0x100>,
> >  		      <0x1800000 0x80000>,
> >  		      <0x1880000 0x10000>;
> > -		reg-names =3D "sys", "rew", "qs", "hsio", "port0",
> > -			    "port1", "port2", "port3", "port4", "port5",
> > -			    "port6", "port7", "port8", "port9", "port10",
> > -			    "qsys", "ana";
> > +		reg-names =3D "sys", "rew", "qs", "port0", "port1", "port2",
> > +			    "port3", "port4", "port5", "port6", "port7",
> > +			    "port8", "port9", "port10", "qsys", "ana";
> >  		interrupts =3D <21 22>;
> >  		interrupt-names =3D "xtr", "inj";
> > =20
> > --=20
> > git-series 0.9.1

--kwtbog5c7ae7sk2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAltye5EACgkQhLiadT7g
8aMjFA/7B6gmPueCPI1qNqQWD2y8yRqcNRU3jfGNLXuvlv8x6OmkgDc9ipMoCVJT
yOSBVvVM1MIr0dLFxPuniI14wDTtGLNTQtb22DkivUbof1wm1c3kTAVHadut1Hsz
L+SpopdvdOVh8Hc9MzWArjSOoa9xUezrCQdFNwznMFxuEwHS6cs88iU1WhzPw/HB
o+kHRLUynb/Rmgx+PLYIhDwikvCxE9p3a13DGXP9S3SZEix19SRwbDMfJM3ygSel
Q6sYnlU3AmglkP7aD/mNLUGdOV1QlphH2RljrpYxhpcyF3nhUGPW5NBqJ+rFFtkB
3YyUJUSPtrGGn2zYccLQ4NgnhPTSyVTvpfdeXAgmDjhm0NMaahTq2bs11eT2fFM2
aHky007kGfzPdW6U+Fb567z2DSqJDur8oNDEJI1IC2/EZ18IOWBEBIhhEgPdNOX/
xMp5KRvBJn1mcYrHlVRNtFMldMwka7BVkrXx8r0M5YuH8/gSK/aimoiLxnv7mjEe
pgAOFhOpeQpJjTLlokLUF896cBNOMBaBPNG24D0xYn6IOmvKdSSDtk9PVayTCEFR
inhUcj38ooQBRUsoXzru/71hiYHg3P111eXY27bz18mTGR3+Vdq128AMaNdSGwdK
KxjJI1e3kZtq0SuAXLnjOCTJildF3u1rFhf3fnU5biqijm2BaBc=
=mcfF
-----END PGP SIGNATURE-----

--kwtbog5c7ae7sk2x--

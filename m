Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 20:00:31 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:39543 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994564AbeIDSAXV1vCZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Sep 2018 20:00:23 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59C20207B4; Tue,  4 Sep 2018 20:00:18 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id F202020797;
        Tue,  4 Sep 2018 20:00:07 +0200 (CEST)
Date:   Tue, 4 Sep 2018 20:00:06 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Miller <davem@davemloft.net>, andrew@lunn.ch,
        ralf@linux-mips.org, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180904180006.d5th3jrbhr4vtahi@qschulz>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
 <20180904151653.GI13888@piout.net>
 <20180904161028.nh5ejrtj22r5az5e@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qty3jkgtvzdnxwmw"
Content-Disposition: inline
In-Reply-To: <20180904161028.nh5ejrtj22r5az5e@pburton-laptop>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65931
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


--qty3jkgtvzdnxwmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Sep 04, 2018 at 09:10:28AM -0700, Paul Burton wrote:
> Hi Alexandre, Quentin, all,
>=20
> On Tue, Sep 04, 2018 at 05:16:53PM +0200, Alexandre Belloni wrote:
> > On 03/09/2018 22:09:10-0700, David Miller wrote:
> > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Date: Mon, 3 Sep 2018 15:45:22 +0200
> > >=20
> > > > On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
> > > >> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go=
 through
> > > >> > net while the others (6, 7, 9 and 10) go through the generic PHY=
 subsystem.
> > > >>=20
> > > >> Hi Quentin
> > > >>=20
> > > >> Are you expecting merge conflicts? If not, it might be simpler to =
gets
> > > >> ACKs from each maintainer, and then merge it though one tree.
> > > >=20
> > > > There are some other DT changes for this cycle so those should prob=
ably
> > > > go through MIPS.
> > >=20
> > > No objection for this going through the MIPS tree, and from me:
> > >
> > > Acked-by: David S. Miller <davem@davemloft.net>
> >=20
> > What I meant was that 1/11 and 8/11 should go through MIPS because of
> > the potential conflicts. The other patches can go through net-next as
> > that will make more sense. Maybe Quentin can split the series in two,
> > one for MIPS and one for net if that makes it easier for you to apply.
>=20
> I'd be happy to take the .dts changes through the MIPS tree, though
> looking at them won't patch 1 break bisection?
>=20
> Since you remove the hsio reg entry it looks to me like
> mscc_ocelot_probe() will fail with -EINVAL (which comes from
> devm_ioremap_resource() with res=3DNULL) until patch 3.
>=20

That's correct.

> I'd feel more comfortable merging this piecemeal if it doesn't result in
> us breaking bisection for however long it takes for both the trees
> involved to be merged.
>=20

How do you want to proceed then?

Quentin

--qty3jkgtvzdnxwmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluOyCUACgkQhLiadT7g
8aOibQ//UvQN9zay1FXgxSH02hzxDKqfxo0TcV3EqxSH7mOk+HYywPj1pMUzY3Ly
/0HNP9W7kGRfpNecAYmq2jWLu254KZyeNM5d/edOuU4ji0/qSgUIMhPrbS+kEmDo
loYBKMgnLHOvyg2e/u/HvWRLOxYClZ4BDGMYq4a6h+K81x2pKvbTw4fLuYjKQmX8
TZ7VJScDkaNyYLoraau5w9/44LIzAP5kaSC0CuAufKMw9bB7hWr7vfIoOS5kuVfI
TtV+af8pwkNQPacHFJyfPNqFYTu5UJxGHqtsZWx8NPdmwnCVAkOObPsg0VP8UoGN
ErA1mdkZZXdT+QxH71tJSqvndNiYaXcDdbr1JzGe9WeeNEQ9lP+26fHmHccWdJGI
xAXuSlHgUrDm+WIAHCuitz8uIUsCTTKQUGdnxPjCVz2qrTwQ//qv7xSnP/TuqJzy
2EtixuohyVfqm388ufgguX61u8Aby0t8OGptRJn6SmMm8vP3iNER+wkHeOChLtIG
ILC7XnInm22lMxT7Iign0uW5lF+7v4PODU2EvIBmNfqEjxJfpl5ChYDmwdgq/nVR
ROukkX69kvjHXPZa9kNKT26k+u8OJhW66/aQL9xpfkdNA8Q42zCtfZ4mZtn5greg
C7NBy6Is1CsksscZm7yD9v8HnVbcLdHU180OyIcvjkIG6NhRqA8=
=7YjH
-----END PGP SIGNATURE-----

--qty3jkgtvzdnxwmw--

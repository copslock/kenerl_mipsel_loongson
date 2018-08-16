Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2018 16:25:25 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:56857 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994601AbeHPOZVkjY0- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2018 16:25:21 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DA1A8207F3; Thu, 16 Aug 2018 16:25:14 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-43-114.w90-88.abo.wanadoo.fr [90.88.161.114])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8787C20703;
        Thu, 16 Aug 2018 16:25:14 +0200 (CEST)
Date:   Thu, 16 Aug 2018 16:25:14 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180816142514.pf4eiqeditoy4uei@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180813223103.GA16669@rob-hp-laptop>
 <20180814064953.vboz2gryq4jff34n@qschulz>
 <20180814124135.GK943@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqdqbjx2wofggoxf"
Content-Disposition: inline
In-Reply-To: <20180814124135.GK943@piout.net>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65603
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


--aqdqbjx2wofggoxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Tue, Aug 14, 2018 at 02:41:35PM +0200, Alexandre Belloni wrote:
> On 14/08/2018 08:49:53+0200, Quentin Schulz wrote:
> > Understood but it's an intermediate patch. Later (patch 8), the SerDes
> > muxing "controller" is added as a child to this node. There most likely
> > will be some others in the future (temperature sensor for example).
> >=20
> > Furthermore, there's already a simple-mfd without children in this file:
> > https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree=
/bindings/mips/mscc.txt#L19
> >=20
> > How should we handle this case?
> >=20
>=20
> There were child nodes in previous version of the binding. You can
> remove simple-mfd now. The useful registers that are not used by any
> drivers are gpr and chipid.
>=20

And what about the use case I'm facing? I've got child nodes defined in
it but with a later patch (but they actually haven't made it to the
DT binding documentation, so that's for the next version of the patch
series).

OK, for removing simple-mfd from CPU chip regs documentation.

Thanks,
Quentin

--aqdqbjx2wofggoxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlt1iUkACgkQhLiadT7g
8aMS4Q/+OD8XkRtfVO/sHnbGEJXJShU19E8I7jLuwgrlSuxKKY2yoUIv/KOVCnrv
hwM4A3Jo63fuWFwrcTSJxos4GirvwFFFKwRufzSoLB8q/WvUk6oxDso5zmPZirem
GJ8H6jVFQCYPOKOD1RLEmY2UhAhM/u6nI0Fq5BFY3ONLfXoGnIwmVDRm6+r1R7MS
YPO7il+4YkHXCxFauTepBGVPH4KoQCLZzCBqShg52PP8pa7/VF6lgc1QXeLPRYkj
jzZrQnsIYosDRaAK/5fGvSQ93E0swboIzjrP3wVx7iiZFk7i566/CIOtoeLfLB9S
bHf34VdoT+xdkmJFVkZq6n8rovF/ly9uMcUQ/nfIMq0nr6ZRgblUfDuSnrdhH+Xj
RMR5DlEmDVuuxffm6MBmw+SHC/eIUF+u4J7CN2qQ4nZthqgN3o0Gs5Y2RC/vehUe
J/XUV/ak89lQ7ouNF2HjZvhPCYKYSGtnVeYr4af0bFJ8N+8hFyXYm/Q9GacrVnQk
8wIp6kP7U3kghjaYJ9denBc8NP9VoiwXl2lj38mXz/ubiGuA65Yz0MeKoIB7HnP8
BoFBEWfoK3QR+fYyWmq5CNWLkBZaX9O6xhLaZ0uCx4pEMwP5a4ZT3/R2xROUE8UH
NtEArLELWMHs6MXfLsTMRMlk/Yfh4hGDydFKNPfGDlc6c6ZlRLk=
=MYiC
-----END PGP SIGNATURE-----

--aqdqbjx2wofggoxf--

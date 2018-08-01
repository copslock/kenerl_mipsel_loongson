Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 09:54:32 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:40483 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991623AbeHAHy3R31HP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 09:54:29 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 034C420740; Wed,  1 Aug 2018 09:54:20 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1657E207BD;
        Wed,  1 Aug 2018 09:54:00 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:54:00 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 00/10] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180801075400.cvvasvi2g2m56xp4@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730132441.GC13198@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u35ohko4nfagn3ww"
Content-Disposition: inline
In-Reply-To: <20180730132441.GC13198@lunn.ch>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65341
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


--u35ohko4nfagn3ww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 30, 2018 at 03:24:41PM +0200, Andrew Lunn wrote:
> > The SerDes configuration is in the middle of an address space (HSIO) th=
at
> > is used to configure some parts in the MAC controller driver, that is w=
hy
> > we need to use a syscon so that we can write to the same address space =
=66rom
> > different drivers safely using regmap.
>=20
> Hi Quentin
>=20
> I assume breaking backwards compatibility is not an issue here, since
> there currently is only one board using the DT binding. But it would
> be good to give a warning in the cover notes. git bisect will also
> break for this one particular board. And since these changes are going
> through different trees, it could be quite a big break.
>=20

Yes sorry, I should have mentioned it in the cover letter, will do
if/when there is a v2.

Thanks,
Quentin

--u35ohko4nfagn3ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlthZxcACgkQhLiadT7g
8aPTNw/+IVukDr3iYoXQ4ry2nF4nPhV12+CSQJn1pKAQFUYs3p4DGzfQPXKgXLPR
27hCz+QoYZSJwvyYwCLeh7/DC39p9jKwWZJymUPunuhsExrloLxUwH7XuT386p9O
Ym8bHhtsF2hyicESpNsTc+yQZpslNM0fN6iW87NN3Me5zRXGKr4aUjS4SN73EPyB
JiVT8lF31Whph0mWcCv94sR02u0gU8fqm+EtguJpPj3o6USceNvGo/plgrm6IKam
u2b1qd97AKw3jlFdPIimOJ9fu0vy/L5aj/6/dQqXSwE+Qd4o8lsh5rgOqsJTg322
JBN78zFlng0RcHbWoEoAF/SpYZb5kyMIPU0b5y7xHkPaIiu19AtHMhqfuN85tNt9
kt+77KdcVuDj73HWw3FnhT1f3V8DKtKWWN0bJW5OKO4TdP5RtA9/bU0vcMkcY2mJ
TgXqZCHijh5i0DltePNDqR+RIXeBJ358Dwi5QBdJmnWvsZMV8ZJOHQFJMqCaFHw0
LFo9q1H+u20AhC3jt7iFKDvkddadFcDHQfjT8S7Vh6bnYhVepIuorNVkJRdqp0pI
qzoWbXIRZuuUjBBagA8RwEpxboIwwJ7teAI8YDWUSnM3WTbGtYclVSGSyEdOA7WX
an+3naqXa4/g0/n1XcGs8ksgtskb6ciL/BX8jdYTz9XkHu69aKo=
=LSYK
-----END PGP SIGNATURE-----

--u35ohko4nfagn3ww--

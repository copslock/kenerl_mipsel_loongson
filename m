Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 15:01:25 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:39689 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993047AbeG3NBSVIvTl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 15:01:18 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EFB3C207AC; Mon, 30 Jul 2018 15:01:10 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 933ED20712;
        Mon, 30 Jul 2018 15:01:10 +0200 (CEST)
Date:   Mon, 30 Jul 2018 15:01:10 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net
Cc:     kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 00/10] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180730130110.eyyegxxkxbpzx3fz@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ldprstlc3p4e3hrl"
Content-Disposition: inline
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65251
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


--ldprstlc3p4e3hrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Mon, Jul 30, 2018 at 02:43:45PM +0200, Quentin Schulz wrote:
> The Ocelot switch has currently a hardcoded SerDes muxing that suits only
> a particular use case. Any other board setup will fail to work.
>=20
> To prepare for upcoming boards' support that do not have the same muxing,
> create a PHY driver that will handle all possible cases.
>=20
> A SerDes can work in SGMII, QSGMII or PCIe and is also muxed to use a
> given port depending on the selected mode or board design.
>=20
> The SerDes configuration is in the middle of an address space (HSIO) that
> is used to configure some parts in the MAC controller driver, that is why
> we need to use a syscon so that we can write to the same address space fr=
om
> different drivers safely using regmap.
>=20
> Patches from generic PHY and net should be safe to be merged separately.
>=20
> I suggest patches 1 to 5 and 10 go through net while the others (6 to 9)
> go through the generic PHY subsystem.
>=20

Actually more like the following:
1 and 8 through MIPS tree, 2 to 5 and 10 through net, 6, 7 and 9 through
PHY.

Quentin

> Thanks,
> Quentin
>=20
> Quentin Schulz (10):
>   MIPS: mscc: ocelot: make HSIO registers address range a syscon
>   dt-bindings: net: ocelot: remove hsio from the list of register address=
 spaces
>   net: mscc: ocelot: get HSIO regmap from syscon
>   net: mscc: ocelot: move the HSIO header to include/soc
>   net: mscc: ocelot: simplify register access for PLL5 configuration
>   phy: add QSGMII and PCIE modes
>   dt-bindings: phy: add DT binding for Microsemi Ocelot SerDes muxing
>   MIPS: mscc: ocelot: add SerDes mux DT node
>   phy: add driver for Microsemi Ocelot SerDes muxing
>   net: mscc: ocelot: make use of SerDes PHYs for handling their configura=
tion
>=20
>  Documentation/devicetree/bindings/mips/mscc.txt             |  16 +-
>  Documentation/devicetree/bindings/net/mscc-ocelot.txt       |   9 +-
>  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt |  42 +-
>  arch/mips/boot/dts/mscc/ocelot.dtsi                         |  19 +-
>  drivers/net/ethernet/mscc/Kconfig                           |   2 +-
>  drivers/net/ethernet/mscc/ocelot.c                          |  16 +-
>  drivers/net/ethernet/mscc/ocelot.h                          |  79 +-
>  drivers/net/ethernet/mscc/ocelot_board.c                    |  54 +-
>  drivers/net/ethernet/mscc/ocelot_hsio.h                     | 785 +------
>  drivers/net/ethernet/mscc/ocelot_regs.c                     |  93 +-
>  drivers/phy/Kconfig                                         |   1 +-
>  drivers/phy/Makefile                                        |   1 +-
>  drivers/phy/mscc/Kconfig                                    |  11 +-
>  drivers/phy/mscc/Makefile                                   |   5 +-
>  drivers/phy/mscc/phy-ocelot-serdes.c                        | 314 +++-
>  include/linux/phy/phy.h                                     |   2 +-
>  include/soc/mscc/ocelot_hsio.h                              | 859 ++++++=
+-
>  17 files changed, 1343 insertions(+), 965 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serd=
es.txt
>  delete mode 100644 drivers/net/ethernet/mscc/ocelot_hsio.h
>  create mode 100644 drivers/phy/mscc/Kconfig
>  create mode 100644 drivers/phy/mscc/Makefile
>  create mode 100644 drivers/phy/mscc/phy-ocelot-serdes.c
>  create mode 100644 include/soc/mscc/ocelot_hsio.h
>=20
> base-commit: d6e74c71c4de5222f147b64bf747e8a3c523c690
> --=20
> git-series 0.9.1

--ldprstlc3p4e3hrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAltfDBYACgkQhLiadT7g
8aMxHQ/+PPE/fK7CA51pMkW8CKUXuRFyIRBTul4o/vVrIqyIOdLuJd67WRQ0yyzT
+BnPbTY0RRlm3+lUN2BKIXdvZUzubfUcN/UCqp0i8eqoiKfqCkxqscH3K+Uun0wK
25+nfTrn2taDcvVBkT8kx0gLj07aEt1cf7mEhqrZzXPDihfMn/UzxeGhZPspmEu5
ylr/IdzBjHldSBG4jau+GiMiWPUDJDitnW0TaGoMXMwkvRFaTkboCBMXr44dR1Vv
KtUn77zOz5zh+4T8a7fgfEBvmvA1TnMxRBsv2tkKb3LLQNmuytFFCFvEI6FnhN1S
05nG1dM1xspND5yY3D7+SUFuZZBr/ASMmsOlJe/W3WV7y24RSOiFziwAB0jCz6ap
Yz9DBrmm/Z2bI1cU4nZXIsPnzhk6iIZYljhG2UiWLX9d6519/8rBECw8l/56d0AL
gfk6o0F29D2A8XTQAinnE0VkY+fMao+jvRdvQy2sNRQieBx1nFX5NGJ6GMYrPSmO
Z0WVbGIGoCnLwzbbPFKumur0uIaDL8b3cWaZxVGvCCPRU5FA8SRRyVEunruDSGKE
17+2fe8IoJl5noU+VW+SXEZO4rR9AuXFzVvqzOiIaFO2Xl1uH8zW7B/tyYLx3n03
3rlZvk35oUZfW0gtp42v6lIqo4Cl3D5xfgchLPx6ARhl52P7wow=
=Eyzn
-----END PGP SIGNATURE-----

--ldprstlc3p4e3hrl--

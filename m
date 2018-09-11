Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:01:30 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:32876 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990945AbeIKVBYH10he (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:01:24 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BB98642B17;
        Tue, 11 Sep 2018 23:01:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id jkAWS7gC_Q2p; Tue, 11 Sep 2018 23:01:17 +0200 (CEST)
Subject: Re: [PATCH v3 net-next 5/6] dt-bindings: net: dsa: Add
 lantiq,xrx200-gswip DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
References: <20180909201647.32727-1-hauke@hauke-m.d>
 <20180909202027.411-1-hauke@hauke-m.de> <20180910220119.GA32582@bogus>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <6ba09412-e801-0a5c-03ee-20813a9d7b27@hauke-m.de>
Date:   Tue, 11 Sep 2018 23:01:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180910220119.GA32582@bogus>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4WnIr7sTAoGLvsWN03G8tmxZUdXteV065"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4WnIr7sTAoGLvsWN03G8tmxZUdXteV065
Content-Type: multipart/mixed; boundary="aIWsEDcI2rzvSBmmZaYMdcKNF2YFAI5pF";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Rob Herring <robh@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
 vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com, john@phrozen.org,
 linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
 devicetree@vger.kernel.org
Message-ID: <6ba09412-e801-0a5c-03ee-20813a9d7b27@hauke-m.de>
Subject: Re: [PATCH v3 net-next 5/6] dt-bindings: net: dsa: Add
 lantiq,xrx200-gswip DT bindings
References: <20180909201647.32727-1-hauke@hauke-m.d>
 <20180909202027.411-1-hauke@hauke-m.de> <20180910220119.GA32582@bogus>
In-Reply-To: <20180910220119.GA32582@bogus>

--aIWsEDcI2rzvSBmmZaYMdcKNF2YFAI5pF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/11/2018 12:01 AM, Rob Herring wrote:
> On Sun, Sep 09, 2018 at 10:20:27PM +0200, Hauke Mehrtens wrote:
>> This adds the binding for the GSWIP (Gigabit switch) core found in the=

>> xrx200 / VR9 Lantiq / Intel SoC.
>>
>> This part takes care of the switch, MDIO bus, and loading the FW into
>> the embedded GPHYs.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  .../devicetree/bindings/net/dsa/lantiq-gswip.txt   | 141 ++++++++++++=
+++++++++
>>  1 file changed, 141 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-g=
swip.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.tx=
t b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
>> new file mode 100644
>> index 000000000000..a089f5856778
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
>> @@ -0,0 +1,141 @@
>> +Lantiq GSWIP Ethernet switches
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties for GSWIP core:
>> +
>> +- compatible	: "lantiq,xrx200-gswip" for the embedded GSWIP in the
>> +		  xRX200 SoC
>> +- reg		: memory range of the GSWIP core registers
>> +		: memory range of the GSWIP MDIO registers
>> +		: memory range of the GSWIP MII registers
>> +
>> +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of
>> +additional required and optional properties.
>> +
>> +
>> +Required properties for MDIO bus:
>> +- compatible	: "lantiq,xrx200-mdio" for the MDIO bus inside the GSWIP=

>> +		  core of the xRX200 SoC and the PHYs connected to it.
>> +
>> +See Documentation/devicetree/bindings/net/mdio.txt for a list of addi=
tional
>> +required and optional properties.
>> +
>> +
>> +Required properties for GPHY firmware loading:
>> +- compatible	: "lantiq,gphy-fw" and "lantiq,xrx200-gphy-fw",
>> +		  "lantiq,xrx200a1x-gphy-fw", "lantiq,xrx200a2x-gphy-fw",
>> +		  "lantiq,xrx300-gphy-fw", or "lantiq,xrx330-gphy-fw"
>> +		  for the loading of the firmware into the embedded
>> +		  GPHY core of the SoC.
>=20
> One valid combination of compatibles per line please.

Ok, I will update this.

>=20
>> +- lantiq,rcu	: reference to the rcu syscon
>> +
>> +The GPHY firmware loader has a list of GPHY entries, one for each
>> +embedded GPHY
>> +
>> +- reg		: Offset of the GPHY firmware register in the RCU
>> +		  register range
>=20
> This use of reg is strange. This node should probably be a child of=20
> the RCU.

The SoC Designers put all registers for which they didn't want to create
a new register block into the RCU (Reset controller unit) range. The
switch itself is on the main crossbar, and has his own memory range, but
the registers to load the GPHY FW are in the RCU register. We have to
load the GPHY firmware before we can assess the GPHY, after the FW is
loaded we control the GPHY through the MDIO bus of the switch.

The GPHY is now part of the switch driver, so we moved the GPHY node
also as a sub node to the switch, when it would be under the RCU we
somehow have to make sure it gets loaded before the switch gets loaded,
which is more complicated. The GPHY itself is also part of the switch IP
block and not the reset controller unit.

>> +- resets	: list of resets of the embedded GPHY
>> +- reset-names	: list of names of the resets
>> +
>> +Example:
>> +
>> +Ethernet switch on the VRX200 SoC:
>> +
>> +gswip: gswip@E108000 {
>=20
> switch@... or ethernet-switch@...
>=20
> We need a standard name here and add it to the DT spec.

Ok, I will change this.

>=20
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <0>;
>> +	compatible =3D "lantiq,xrx200-gswip";
>> +	reg =3D <	0xE108000 0x3000 /* switch */
>> +		0xE10B100 0x70 /* mdio */
>> +		0xE10B1D8 0x30 /* mii */
>> +		>;
>> +	dsa,member =3D <0 0>;
>=20
> Not documented.

This is part of the general dsa binding.

>=20
>> +
>> +	ports {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		port@0 {
>> +			reg =3D <0>;
>> +			label =3D "lan3";
>> +			phy-mode =3D "rgmii";
>> +			phy-handle =3D <&phy0>;
>> +		};
>> +
>> +		port@1 {
>> +			reg =3D <1>;
>> +			label =3D "lan4";
>> +			phy-mode =3D "rgmii";
>> +			phy-handle =3D <&phy1>;
>> +		};
>> +
>> +		port@2 {
>> +			reg =3D <2>;
>> +			label =3D "lan2";
>> +			phy-mode =3D "internal";
>> +			phy-handle =3D <&phy11>;
>> +		};
>> +
>> +		port@4 {
>> +			reg =3D <4>;
>> +			label =3D "lan1";
>> +			phy-mode =3D "internal";
>> +			phy-handle =3D <&phy13>;
>> +		};
>> +
>> +		port@5 {
>> +			reg =3D <5>;
>> +			label =3D "wan";
>> +			phy-mode =3D "rgmii";
>> +			phy-handle =3D <&phy5>;
>> +		};
>> +
>> +		port@6 {
>> +			reg =3D <0x6>;
>> +			label =3D "cpu";
>> +			ethernet =3D <&eth0>;
>> +		};
>> +	};
>> +
>> +	mdio@0 {
>=20
> What's the address 0 here?

I will remove this, there is only one MDIO bus under the switch.

>=20
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		compatible =3D "lantiq,xrx200-mdio";
>> +		reg =3D <0>;
>> +
>> +		phy0: ethernet-phy@0 {
>> +			reg =3D <0x0>;
>> +		};
>> +		phy1: ethernet-phy@1 {
>> +			reg =3D <0x1>;
>> +		};
>> +		phy5: ethernet-phy@5 {
>> +			reg =3D <0x5>;
>> +		};
>> +		phy11: ethernet-phy@11 {
>> +			reg =3D <0x11>;
>> +		};
>> +		phy13: ethernet-phy@13 {
>> +			reg =3D <0x13>;
>> +		};
>> +	};
>> +
>> +	gphy-fw {
>> +		compatible =3D "lantiq,xrx200-gphy-fw", "lantiq,gphy-fw";
>> +		lantiq,rcu =3D <&rcu0>;
>=20
> Missing #size-cells and #address-cells, but this should change as I sai=
d=20
> above.

Ok, I will change this.

>=20
>> +
>> +		gphy@20 {
>> +			reg =3D <0x20>;
>> +
>> +			resets =3D <&reset0 31 30>;
>> +			reset-names =3D "gphy";
>> +		};
>> +
>> +		gphy@68 {
>> +			reg =3D <0x68>;
>> +
>> +			resets =3D <&reset0 29 28>;
>> +			reset-names =3D "gphy";
>> +		};
>> +	};
>> +};
>> --=20
>> 2.11.0
>>



--aIWsEDcI2rzvSBmmZaYMdcKNF2YFAI5pF--

--4WnIr7sTAoGLvsWN03G8tmxZUdXteV065
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluYLRoACgkQ8bdnhZyy
68czXAgAmZYkeIoir2eLM38adoasy6ROv+j9NNWfnKbmP6InFS5J3qVOchv+mIYm
LCdQFSLzZmquyy6I3MqWDR2H7w9/2kOfDwbpOYlneHdnxTw19Zdd/WsZYPzy3A1V
BIGley+czvrkodUCdlEHHTPm7qN7KOFVLJ6iH4HU88HIHBKJPYfd+rSlj6j/xyQR
k6aVOH5Niz/30vUfALcTdN7EczCnPce3auJA1A5w0emEgsO8Ti3O0HWHNDLMtsBF
a9XN8759GilBc0zKgy+Qy/QTx6LewCXiHVmBOYNgyuHI7kffiVsLlktm9BJm1MT1
NhEcgJR8vfu0oy4qzBMVz2ZDovA3/w==
=Vjf7
-----END PGP SIGNATURE-----

--4WnIr7sTAoGLvsWN03G8tmxZUdXteV065--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:11:59 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:23278 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994644AbeIFVL4DkrKQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 23:11:56 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 538E9489EA;
        Thu,  6 Sep 2018 23:11:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id TlgnV2lCU3Lv; Thu,  6 Sep 2018 23:11:49 +0200 (CEST)
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
To:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120511.10112-1-hauke@hauke-m.de>
 <eb5c0815-e80c-7fd7-a14a-ccc3f28a7c93@gmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <d0da3eb2-8adb-677a-0f88-b6fe7989ae45@hauke-m.de>
Date:   Thu, 6 Sep 2018 23:11:44 +0200
MIME-Version: 1.0
In-Reply-To: <eb5c0815-e80c-7fd7-a14a-ccc3f28a7c93@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f8zxV6bgqOCHeUJRH1PDQ9Dq0YLtECOiw"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66090
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
--f8zxV6bgqOCHeUJRH1PDQ9Dq0YLtECOiw
Content-Type: multipart/mixed; boundary="JxGgAqcZ6lc0NM66VWueg5G2cOJXSCE7d";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
 vivien.didelot@savoirfairelinux.com, john@phrozen.org,
 linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
 devicetree@vger.kernel.org
Message-ID: <d0da3eb2-8adb-677a-0f88-b6fe7989ae45@hauke-m.de>
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120511.10112-1-hauke@hauke-m.de>
 <eb5c0815-e80c-7fd7-a14a-ccc3f28a7c93@gmail.com>
In-Reply-To: <eb5c0815-e80c-7fd7-a14a-ccc3f28a7c93@gmail.com>

--JxGgAqcZ6lc0NM66VWueg5G2cOJXSCE7d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/03/2018 09:54 PM, Florian Fainelli wrote:
>=20
>=20
> On 9/1/2018 5:05 AM, Hauke Mehrtens wrote:
>> This adds the DSA driver for the GSWIP Switch found in the VRX200 SoC.=

>> This switch is integrated in the DSL SoC, this SoC uses a GSWIP versio=
n
>> 2.1, there are other SoCs using different versions of this IP block, b=
ut
>> this driver was only tested with the version found in the VRX200.
>> Currently only the basic features are implemented which will forward a=
ll
>> packages to the CPU and let the CPU do the forwarding. The hardware al=
so
>> support Layer 2 offloading which is not yet implemented in this driver=
=2E
>>
>> The GPHY FW loaded is now done by this driver and not any more by the
>> separate driver in drivers/soc/lantiq/gphy.c, I will remove this drive=
r
>> is a separate patch. to make use of the GPHY this switch driver is
>> needed anyway. Other SoCs have more embedded GPHYs so this driver shou=
ld
>> support a variable number of GPHYs. After the firmware was loaded the
>> GPHY can be probed on the MDIO bus and it behaves like an external GPH=
Y,
>> without the firmware it can not be probed on the MDIO bus.
>>
>> Currently this depends on SOC_TYPE_XWAY because the SoC revision
>> detection function ltq_soc_type() is used to load the correct GPHY
>> firmware on the VRX200 SoCs.
>>
>> The clock names in the sysctrl.c file have to be changed because the
>> clocks are now used by a different driver. This should be cleaned up a=
nd
>> a real common clock driver should provide the clocks instead.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>=20
> Looks great, just a few suggestions below
>=20
> [snip]
>=20
>> +static void gswip_adjust_link(struct dsa_switch *ds, int port,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct phy_device *phydev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct gswip_priv *priv =3D ds->priv;
>> +=C2=A0=C2=A0=C2=A0 u16 macconf =3D phydev->mdio.addr & GSWIP_MDIO_PHY=
_ADDR_MASK;
>> +=C2=A0=C2=A0=C2=A0 u16 miirate =3D 0;
>> +=C2=A0=C2=A0=C2=A0 u16 miimode;
>> +=C2=A0=C2=A0=C2=A0 u16 lcl_adv =3D 0, rmt_adv =3D 0;
>> +=C2=A0=C2=A0=C2=A0 u8 flowctrl;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* do not run this for the CPU port */
>> +=C2=A0=C2=A0=C2=A0 if (dsa_is_cpu_port(ds, port))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> Typically we expect the adjust_link callback to run for fixed link
> ports, that is inter-switch links (between switches) or between the CPU=

> port and the Ethernet MAC attached to the switch. Here you are running
> this for the user facing ports (IIRC), which should really not be
> necessary, most Ethernet switches will be able to look at their built-i=
n
> PHY's state and configure the switch's port automatically. Maybe this i=
s
> not possible here because you had to disable polling?

I deactivated the PHY auto polling, I can activate it again. Some PHYs
could also be external on the same MDIO bus as the internal PHYs.

The CPU facing fixed link is a special MAC in the switch, at least in
this version of the switch IP which is embedded in the networking SoCs.
The MAC is more or less integrated in the switch and the driver can not
configure the link between the MAC and the switch.

> Can you consider implementing PHYLINK operations which would make the
> driver more future proof, should you consider newer generations of
> switches that support 10G PHY, SGMII, SFP/SFF and so on?

I will have a look at this later. I just saw that you pushed some
branches adding SFP support to b53. ;-)

The next step will be adding layer 2 offload. This is planned for the
next patch series after this was merged. The switch uses internal VLANs
for the offloading, so you configure a VLAN in the hardware and then add
ports to it. I saw that multiple switches use this model, but converting
the not VLAN aware layer 2 offloading to it looks a little bit strange,
is there a good practice?

> [snip]
>=20
>> +=C2=A0=C2=A0=C2=A0 if (priv->ds->dst->cpu_dp->index !=3D priv->hw_inf=
o->cpu_port) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "wrong CPU po=
rt defined, HW only supports port:
>> %i",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
iv->hw_info->cpu_port);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto mdio_bus;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> There are a number of switches (b53, qca8k, mt7530) that have this
> requirement, we should probably be moving this check down into the core=

> DSA layer and allow either to continue but disable switch tagging, if i=
t
> was requested. Andrew what do you think?

As the CPU port is a special port many registers are only available for
the normal front facing Ethernet ports and not for the CPU port so I
have to make sure the correct port was selected as CPU port, otherwise
the driver will write to the wrong register offsets.

Hauke


--JxGgAqcZ6lc0NM66VWueg5G2cOJXSCE7d--

--f8zxV6bgqOCHeUJRH1PDQ9Dq0YLtECOiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluRmBMACgkQ8bdnhZyy
68d5OQf/V/uZJ04P/wNYovxsP0LUDgSZqS2ESHD6JWn/TI23gSWik9Y1S4ZrtRui
7gJk0vgfWUvYZHpvmI7YYohVhqbcasbK9Mh7kZUQMXnzw64L9ePeu59P++1xGR/8
p4Au1+J7wFc/CstnysBfOVLDmuWObCa6tL9lRT/7ugE0UmbJD2nsrJszQAPaep/g
xGv2CMkyRaLlAXCS7T6p2gb02+cbeDs8TLNKK0dbU0HYb5tq7DYY0BOAOhYMgIbj
zTYgw1R/B4Iov1+YRUF5qVJx73+T9fBmSrdLO741lS9yTUCdaD7fOi+fSREaML8F
yDR5UUv9tUxHkDwk5CxKbbgkMqc5eg==
=oRXS
-----END PGP SIGNATURE-----

--f8zxV6bgqOCHeUJRH1PDQ9Dq0YLtECOiw--

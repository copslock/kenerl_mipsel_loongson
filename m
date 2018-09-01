Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 23:45:03 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:8304 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992747AbeIAVozPX4iV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 23:44:55 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9D19349104;
        Sat,  1 Sep 2018 23:44:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id fTrpZQkV3Imo; Sat,  1 Sep 2018 23:44:48 +0200 (CEST)
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120511.10112-1-hauke@hauke-m.de>
Message-ID: <fa114b61-afc6-b65a-5848-0e9b9632f618@hauke-m.de>
Date:   Sat, 1 Sep 2018 23:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180901120511.10112-1-hauke@hauke-m.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k10Q65HRwGK1g8tkXqa2dE40NMgOlUT4H"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65848
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
--k10Q65HRwGK1g8tkXqa2dE40NMgOlUT4H
Content-Type: multipart/mixed; boundary="dsSEzVGmrOlw175TkhrES96de6HI7HzuW";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
 vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com, john@phrozen.org,
 linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
 devicetree@vger.kernel.org
Message-ID: <fa114b61-afc6-b65a-5848-0e9b9632f618@hauke-m.de>
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120511.10112-1-hauke@hauke-m.de>
In-Reply-To: <20180901120511.10112-1-hauke@hauke-m.de>

--dsSEzVGmrOlw175TkhrES96de6HI7HzuW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/01/2018 02:05 PM, Hauke Mehrtens wrote:
> This adds the DSA driver for the GSWIP Switch found in the VRX200 SoC.
> This switch is integrated in the DSL SoC, this SoC uses a GSWIP version=

> 2.1, there are other SoCs using different versions of this IP block, bu=
t
> this driver was only tested with the version found in the VRX200.
> Currently only the basic features are implemented which will forward al=
l
> packages to the CPU and let the CPU do the forwarding. The hardware als=
o
> support Layer 2 offloading which is not yet implemented in this driver.=

>=20
> The GPHY FW loaded is now done by this driver and not any more by the
> separate driver in drivers/soc/lantiq/gphy.c, I will remove this driver=

> is a separate patch. to make use of the GPHY this switch driver is
> needed anyway. Other SoCs have more embedded GPHYs so this driver shoul=
d
> support a variable number of GPHYs. After the firmware was loaded the
> GPHY can be probed on the MDIO bus and it behaves like an external GPHY=
,
> without the firmware it can not be probed on the MDIO bus.
>=20
> Currently this depends on SOC_TYPE_XWAY because the SoC revision
> detection function ltq_soc_type() is used to load the correct GPHY
> firmware on the VRX200 SoCs.
>=20
> The clock names in the sysctrl.c file have to be changed because the
> clocks are now used by a different driver. This should be cleaned up an=
d
> a real common clock driver should provide the clocks instead.
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  MAINTAINERS                     |    2 +
>  arch/mips/lantiq/xway/sysctrl.c |    8 +-
>  drivers/net/dsa/Kconfig         |    8 +
>  drivers/net/dsa/Makefile        |    1 +
>  drivers/net/dsa/lantiq_gswip.c  | 1018 +++++++++++++++++++++++++++++++=
++++++++
>  drivers/net/dsa/lantiq_pce.h    |  153 ++++++
>  6 files changed, 1186 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/net/dsa/lantiq_gswip.c
>  create mode 100644 drivers/net/dsa/lantiq_pce.h
>=20

=2E....

> +
> +static int gswip_gphy_fw_list(struct gswip_priv *priv,
> +			      struct device_node *gphy_fw_list_np)
> +{
> +	struct device *dev =3D priv->dev;
> +	struct device_node *gphy_fw_np;
> +	const struct of_device_id *match;
> +	int err;
> +	int i =3D 0;
> +
> +	if (of_device_is_compatible(dev->of_node, "lantiq,xrx200-gphy-fw")) {=

> +		switch (ltq_soc_type()) {

I just found out that the older revision of the xrx200 SoC uses also an
older GSWIP version, so we do not have to call ltq_soc_type() here, but
can use the GSWIP version register.
xRX200 rev 1.1 uses GSWIP 2.0, xrx200 rev 1.2 uses GSWIP 2.1.
1e10804c: 00000100 on xRX200 rev 1.1
1e10804c: 00000021 on xRX200 rev 1.2

Then I can also remove the compile dependency on the Lantiq arch code.

> +		case SOC_TYPE_VR9:
> +			priv->gphy_fw_name_cfg =3D &xrx200a1x_gphy_data;
> +			break;
> +		case SOC_TYPE_VR9_2:
> +			priv->gphy_fw_name_cfg =3D &xrx200a2x_gphy_data;
> +			break;
> +		}
> +	}
> +

=2E....

> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	version =3D gswip_switch_r(priv, GSWIP_VERSION);
> +	dev_info(dev, "probed GSWIP version %lx mod %lx\n",
> +		 (version & GSWIP_VERSION_REV_MASK) >> GSWIP_VERSION_REV_SHIFT,
> +		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
> +	return 0;
> +


--dsSEzVGmrOlw175TkhrES96de6HI7HzuW--

--k10Q65HRwGK1g8tkXqa2dE40NMgOlUT4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluLCEgACgkQ8bdnhZyy
68f5sggAhePqUuqo4NFDsCbMLROM1LHsPYndkXWZt5UbhF8J0ProHF8FvLr+Smaa
TNAO5BAytxeG4UGXxq817hlLht6qFdSh8qYQbR3qTXrgnGrz3qJJ3Ygs4iZ5iida
c3OHc0WiNH0BKbJIdGQJoxk7IgxkIDh9klRNtaQjRJW/kgvztDrtGI6yXs9TBGrO
mc0Q1Bfmma8HdXBUFtpyjGEwsBfmjHivGvrTUpRCc7GHkGKyUX7TohuEjKpBNaZJ
xiPTxRwOiASyoNMLP2S6bcQ4vcnQt+2qLOVhrTD5y+04t/MhtUHSp1u2mQyHQSZF
5teDhrw6b638CFnGfOBpmqzFhQ8e/g==
=Hz0T
-----END PGP SIGNATURE-----

--k10Q65HRwGK1g8tkXqa2dE40NMgOlUT4H--

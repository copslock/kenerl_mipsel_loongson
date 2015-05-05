Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 00:01:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62105 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012476AbbEEWBVgkQ3J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 00:01:21 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 141D641F8E5F;
        Tue,  5 May 2015 23:01:18 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 05 May 2015 23:01:18 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 05 May 2015 23:01:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 938DA3484F38;
        Tue,  5 May 2015 23:01:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 5 May 2015 23:01:17 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 5 May
 2015 23:01:17 +0100
Date:   Tue, 5 May 2015 23:01:17 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH V2 1/3] phy: Add binding document for Pistachio USB2.0 PHY
Message-ID: <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
 <1428444258-25852-2-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <1428444258-25852-2-git-send-email-abrestic@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Apr 07, 2015 at 03:04:16PM -0700, Andrew Bresticker wrote:
> Add a binding document for the USB2.0 PHY found on the IMG Pistachio SoC.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> ---
> No changes from v1.
> ---
>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 ++++++++++++++++=
++++++
>  include/dt-bindings/phy/phy-pistachio-usb.h        | 16 ++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-p=
hy.txt
>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
>=20
> diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt =
b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
> new file mode 100644
> index 0000000..afbc7e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
> @@ -0,0 +1,29 @@
> +IMG Pistachio USB PHY
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> +--------------------
> + - compatible: Must be "img,pistachio-usb-phy".
> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
> + - clocks: Must contain an entry for each entry in clock-names.
> +   See ../clock/clock-bindings.txt for details.
> + - clock-names: Must include "usb_phy".
> + - img,cr-top: Must constain a phandle to the CR_TOP syscon node.
> + - img,refclk: Indicates the reference clock source for the USB PHY.
> +   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of valid values.

Possibly dumb question: why isn't the reference clock source specified
in the normal ways like the "usb_phy" clock is?

Does the value required here depend on what usb_phy clock gets muxed
=66rom or something?

Cheers
James

> +
> +Optional properties:
> +--------------------
> + - phy-supply: USB VBUS supply.  Must supply 5.0V.
> +
> +Example:
> +--------
> +usb_phy: usb-phy {
> +	compatible =3D "img,pistachio-usb-phy";
> +	clocks =3D <&clk_core CLK_USB_PHY>;
> +	clock-names =3D "usb_phy";
> +	phy-supply =3D <&usb_vbus>;
> +	img,refclk =3D <REFCLK_CLK_CORE>;
> +	img,cr-top =3D <&cr_top>;
> +	#phy-cells =3D <0>;
> +};
> diff --git a/include/dt-bindings/phy/phy-pistachio-usb.h b/include/dt-bin=
dings/phy/phy-pistachio-usb.h
> new file mode 100644
> index 0000000..d1877aa
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-pistachio-usb.h
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright (C) 2015 Google, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#ifndef _DT_BINDINGS_PHY_PISTACHIO
> +#define _DT_BINDINGS_PHY_PISTACHIO
> +
> +#define REFCLK_XO_CRYSTAL	0x0
> +#define REFCLK_X0_EXT_CLK	0x1
> +#define REFCLK_CLK_CORE		0x2
> +
> +#endif /* _DT_BINDINGS_PHY_PISTACHIO */
> --=20
> 2.2.0.rc0.207.ga3a616c
>=20
>=20

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVST2sAAoJEGwLaZPeOHZ6h3EQAIWL5SPjeM4XQVqS8syp5m45
9pAnlu3nfqJorWzkH5JMfe8bSRRoQ+HKCzGVZ3YoqUKT9ZeTM3cvBCu0OaK/dfWZ
+HFLDwukaibdOyIfvfk7527uOUwtwTnbX3bett6ECeXS0Ar3AxI54ibln936n9sW
3XbSBY1YId+EE06uvuVFgib+mGRJQU9o8FqjhIGL/507CHsXfEzcaiT9rY/fs5FA
3pAaoTNL7SODk9fnW+gXFt2gSC40yZ89qoIjwSjkjkYeojtX4+ZiloxlrJddK2sk
2VtYLuXxK+4lnS4EB1X2DXyEe1utpy5JEo5vGsBXV5SYFbmDemxMIpKD7Llx/E9p
P7hybOPpAr5yDx4xzQqMbS5wYf8IzlsJVLMYj9wyqSPPHzz+78YpF9Zi0kKrYsL5
lRE3ejHYjBA8x3zQcihXf4Z0vD0mTT+l+VL7IOPVnQl78KSVUNNNU7DVrd7J+ewF
Gnx4p1ZCvKKYGYNXH2wMubMs8p+pM+7DU+WEowCYWTRi1iaSVoonZ90XWV1oHiNJ
VQ+v/Y5jdHgsfNZ/sGRWHhxl/dW3kwyYAKlEfu1juCnFrBw1/t1Ap2HrpgDaOJwJ
otT/kWJHyE+f4iDtnD6Q52QdgC4+8Fov4kNpputOijQIuowV27jopYuUa0xU29+i
5nj2MeKORszfDYANiOKb
=lJGl
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

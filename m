Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 23:01:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2208 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992942AbdBKWBfivsU6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 23:01:35 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4546041F8DDF;
        Sat, 11 Feb 2017 23:05:20 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 11 Feb 2017 23:05:20 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 11 Feb 2017 23:05:20 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 244C311C25B54;
        Sat, 11 Feb 2017 22:01:25 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 11 Feb
 2017 22:01:29 +0000
Date:   Sat, 11 Feb 2017 22:01:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Alban <albeu@free.fr>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 3/3] MIPS: ath79: Fix the USB PHY reset names
Message-ID: <20170211220129.GG24226@jhogan-linux.le.imgtec.org>
References: <1486324352-15188-1-git-send-email-albeu@free.fr>
 <1486324352-15188-3-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <1486324352-15188-3-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56775
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

--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Sun, Feb 05, 2017 at 08:52:32PM +0100, Alban wrote:
> From: Alban Bedel <albeu@free.fr>
>=20
> The binding for the USB PHY went thru before the driver. However the
> new version of the driver now use the PHY core support for reset, and
> this expect the reset to be named "phy". So remove the "usb-" prefix
> from the the reset names.
>=20
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  Documentation/devicetree/bindings/phy/phy-ath79-usb.txt | 4 ++--
>  arch/mips/boot/dts/qca/ar9132.dtsi                      | 2 +-

<snip>

> diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/=
ar9132.dtsi
> index 302f0a8..808c2bb 100644
> --- a/arch/mips/boot/dts/qca/ar9132.dtsi
> +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> @@ -160,7 +160,7 @@
>  	usb_phy: usb-phy {
>  		compatible =3D "qca,ar7100-usb-phy";
> =20
> -		reset-names =3D "usb-phy", "usb-suspend-override";
> +		reset-names =3D "phy", "suspend-override";

Does arch/mips/boot/dts/qca/ar9331.dtsi need updating too?

Cheers
James

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYn4m5AAoJEGwLaZPeOHZ6XkYP/3a3EJjcO6KRWAcUXp4vm5wR
yCmBsyBfzKJUWqbHO/XmHir5ERVrySuE5iDDEHzqWjgD9E/o1VF0m9N4/BlHdiy+
OUhGm5j88wN6S99tXUrIaJGy93kIrMnQT1gxrYqIcDB+/kywfKUUH5exWAlFfXW0
mcN6YWrPSkw8At65pml2an5JmJRX0ROIhwTonBO+18WX6UyUg3CyoxESNcnkb6Hi
fWUi6em8cOYFTZF3jgSvBMe/PGIBxDGHvzJsre4TzzguP6a4OSe28lC+IJda08d7
jIek8Tcc1Nyvu64Lc4uomdcBMzHPrThW35DfuvtjEDf/fYgSGH5/7qpt2FXvDOVN
ofPAgzB7eRzayi8HjDx1F1CUbEkkjK7G90xN72onDMBhVYlxQUvOW8lKJevVMA5U
Dq2L0eHfVzkZVrJNbz8lE18d4BtsMCfwCYpeIdmaVEUTfU6e+H9U22j/2NagnaiK
8mvhFOZISDWukUnxoxgbpwFp4i1TSCAmx97FaGeakO8lNwrX77ltH9mODf2gmThh
V7qZDcLE/e3M0g9S7vuN+/IK+ERQlx6qWA3WIbGKC236CPRHvpv4Hbl6iWoDs6T4
3sZ88YRsKwio4ONQKqY4cbrlzXVt6cFjdSHdw2Mm0c5LTPVQ51WQlIsce1yowMDT
JqM7QnZznw/MPUU5Wbtf
=RsVl
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--

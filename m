Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 09:30:46 +0100 (CET)
Received: from smtp5-g21.free.fr ([IPv6:2a01:e0c:1:1599::14]:59212 "EHLO
        smtp5-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993331AbdBMIaiztOVQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2017 09:30:38 +0100
Received: from tock (unknown [2.247.253.223])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 1AD565FFD9;
        Mon, 13 Feb 2017 09:30:18 +0100 (CET)
Date:   Mon, 13 Feb 2017 09:30:07 +0100
From:   Alban <albeu@free.fr>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Aban Bedel <albeu@free.fr>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 3/3] MIPS: ath79: Fix the USB PHY reset names
Message-ID: <20170213093007.7b76fd7c@tock>
In-Reply-To: <20170211220129.GG24226@jhogan-linux.le.imgtec.org>
References: <1486324352-15188-1-git-send-email-albeu@free.fr>
        <1486324352-15188-3-git-send-email-albeu@free.fr>
        <20170211220129.GG24226@jhogan-linux.le.imgtec.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3VoXh3x+sdCmcgfQ3sw6haQ"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/3VoXh3x+sdCmcgfQ3sw6haQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Feb 2017 22:01:29 +0000
James Hogan <james.hogan@imgtec.com> wrote:

> Hi Alban,
>=20
> On Sun, Feb 05, 2017 at 08:52:32PM +0100, Alban wrote:
> > From: Alban Bedel <albeu@free.fr>
> >=20
> > The binding for the USB PHY went thru before the driver. However the
> > new version of the driver now use the PHY core support for reset, and
> > this expect the reset to be named "phy". So remove the "usb-" prefix
> > from the the reset names.
> >=20
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  Documentation/devicetree/bindings/phy/phy-ath79-usb.txt | 4 ++--
> >  arch/mips/boot/dts/qca/ar9132.dtsi                      | 2 +- =20
>=20
> <snip>
>=20
> > diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qc=
a/ar9132.dtsi
> > index 302f0a8..808c2bb 100644
> > --- a/arch/mips/boot/dts/qca/ar9132.dtsi
> > +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> > @@ -160,7 +160,7 @@
> >  	usb_phy: usb-phy {
> >  		compatible =3D "qca,ar7100-usb-phy";
> > =20
> > -		reset-names =3D "usb-phy", "usb-suspend-override";
> > +		reset-names =3D "phy", "suspend-override"; =20
>=20
> Does arch/mips/boot/dts/qca/ar9331.dtsi need updating too?

Right, I forgot the AR9331 had been added since then, I'll send a new
series.

Alban


--Sig_/3VoXh3x+sdCmcgfQ3sw6haQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoW6PAAoJEHSUmkuduC280acQAIT2+u5HojN3Bw2JIrqUp3XZ
49QEccjGIhhHpO30tp0qhqa0C6fLWoF0SQ7Vb2i0ECPGpEjezUMg5ri2FWUMTcyi
oDA92ZG9AA0jBG0U58TgolECPGlommEi5Qr+2dWHuoNdKgleXel8v72KKVRfIgqZ
zBfHjGyG4yRZQ6EoXg/fcSFAcy2BlkJgOX3ez88sedAQNGcPFjZV8216LsHWKiMM
yiuiHegxXsultB0O8GHc9lp2Vqb16O2zfCyk5eMTryeiIdpW+yzEYaC5rejDDVE2
tY/03adHFWZG7msU3/ZfYMs9DaKhsG4u+Pzrq33W9zrZGe45EhypHNVXVSY8YB4g
2nRddep4srCufKfHC5yfBq1XFAentMxqMwu1/+WEgVJPZu70yO9JlCBkmb2s4tD/
ZxRR3qtf66BlhomYJftwxEU5p1YOE8QNDcB/mv9prqVfm5n/B5ro4jhkOo3JQaxI
vOudSdIYHr2px+TGs3+TUzKBC7ee143261c/zQ2gEdtAxIXjS1tiW/SD/vuP71dz
4AtyEdKj1A8MXCnauiqnkppk+SGkVOoTJHW2g7bVSsQzcJqLF4DzVo7xjd2j48p2
1qoGkQB8nd9r+18Dc4qEt+HMFue13YcqaFEGOA8BmkOvfEc7O3x5YPibauYL0avT
/4D2ZpAiHeMbYsD5yFB/
=0uzD
-----END PGP SIGNATURE-----

--Sig_/3VoXh3x+sdCmcgfQ3sw6haQ--

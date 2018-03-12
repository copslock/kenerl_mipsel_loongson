Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:45:33 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbeCLVp0Fgypf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 22:45:26 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E666204EF;
        Mon, 12 Mar 2018 21:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E666204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 12 Mar 2018 21:44:55 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        ralf@linux-mips.org, john@phrozen.org, dev@kresin.me,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: lantiq: enable AHB Bus for USB
Message-ID: <20180312214454.GD21642@saruman>
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-2-hauke@hauke-m.de>
 <20180312211702.GB21642@saruman>
 <CAFBinCA3-AOVwxAofBtEAEK1+n=Txgf14KanEW6YYV+Rr6mvGA@mail.gmail.com>
 <4aaf0fa8-ee7c-c01d-b1a2-73665df45f4e@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <4aaf0fa8-ee7c-c01d-b1a2-73665df45f4e@hauke-m.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 10:38:17PM +0100, Hauke Mehrtens wrote:
> Hi James,
>=20
> On 03/12/2018 10:29 PM, Martin Blumenstingl wrote:
> > Hi James,
> >=20
> > On Mon, Mar 12, 2018 at 10:17 PM, James Hogan <jhogan@kernel.org> wrote:
> >> Hi,
> >>
> >> On Sun, Mar 11, 2018 at 06:41:22PM +0100, Hauke Mehrtens wrote:
> >>> From: Mathias Kresin <dev@kresin.me>
> >>>
> >>> On Danube and AR9 the USB core is connected to the AHB bus, hence we =
need
> >>> to enable the AHB Bus as well.
> >>>
> >>> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs =
using the RCU module")
> >>> Signed-off-by: Mathias Kresin <dev@kresin.me>
> >>
> >> Hauke: I think this needs your SoB line too (same for other 2 patches
> >> too).
>=20
> Sorry, I forgot this before sending the patches, I send it now.

Thanks, I can add them if there are no other changes to make.

>=20
> >>
> >>> ---
> >>>  arch/mips/lantiq/xway/sysctrl.c | 6 +++---
> >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/=
sysctrl.c
> >>> index f11f1dd10493..e0af39b33e28 100644
> >>> --- a/arch/mips/lantiq/xway/sysctrl.c
> >>> +++ b/arch/mips/lantiq/xway/sysctrl.c
> >>> @@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
> >>>               clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
> >>>                               ltq_ar9_fpi_hz(), CLOCK_250M);
> >>>               clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_US=
B0_P);
> >>> -             clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> >>> +             clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | =
PMU_AHBM);
> >>
> >> Checkpatch complains about these changed lines all being >80 columns,
> >> though there are admittedly other violations nearby too.
> > I suggest to keep it as suggested by Mathias/Hauke.
> > our (Hauke and my) plan is to remove the whole file and replace it
> > with a driver based on the common clock framework (in drivers/clk/)
> > mid-term. in my opinion this is better than just fixing the 80 column
> > limit
>=20
> I agree with Martin. I think this code is better readable when we do not
> break it

Find by me.

Thanks
James

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqm9NYACgkQbAtpk944
dnpl+A//dPbbY478mRCXP23wmPviDt6tSN/DmF8YNLvjkbttngbkVddS8sxwZPKL
6S1uw9lafimxNneIN4+u4WIdmMoLJFHsnmb+l3c1STUsiABBtMnfmkk6H5caTBjf
pgGo26CRvdhB1c572H/bB7naOfTo0rTgEWE+P4vDzuVZjED/gaw/el1OB+BPLxbo
LO631jyGSYHUM1efssZsTIAdgMMvq/cc/J3/2h211V8h76qJGGPDsXIj+2a/gAK5
NgNwNEuGymoC8j0weO7WoMvp2gryAeYbgm0v3SEMgNykZmXX8+LB3L5Q6spSqPAJ
CPvaiReD6/JAFBHanr/bmxYGhM0NB3wnYzDoz9gNa25sfR4VuBnwaxk1L+tb0gxL
MTOL6QSRH+TEHZ+XFplYXMh8uRFEZdeK8XPRv5Sd+4O92Jv8kaGnv1pFnDs1NEjj
RAkIdez+AQUJT97Lv0CKTj/aHNmmD1jHpQ8bopxnLQQz5xOV5sEdYcgRHtP8fXvJ
22xGN5RlRqElx4b15iiMgyUR748yEdyrMamuCKIJUioSJa546bIQY/YSv2Cr/viA
ZwPlQFUvIMzp0b9Btdp/LOjqhHKm6ZZU5Un5+gjMfC0fsIH2yF/Y/Jr7g5zxutE1
lXvxYLjpoCxjpEGl3i5yB0yMjK6jyDq/2bufbUc1kDyGQt5zCGc=
=2R8S
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

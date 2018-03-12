Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:17:44 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990421AbeCLVRephbZ9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 22:17:34 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFAA2173F;
        Mon, 12 Mar 2018 21:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFAA2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 12 Mar 2018 21:17:03 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, john@phrozen.org, dev@kresin.me,
        linux-mips@linux-mips.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 2/3] MIPS: lantiq: enable AHB Bus for USB
Message-ID: <20180312211702.GB21642@saruman>
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-2-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20180311174123.2578-2-hauke@hauke-m.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62923
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


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 11, 2018 at 06:41:22PM +0100, Hauke Mehrtens wrote:
> From: Mathias Kresin <dev@kresin.me>
>=20
> On Danube and AR9 the USB core is connected to the AHB bus, hence we need
> to enable the AHB Bus as well.
>=20
> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs usin=
g the RCU module")
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Hauke: I think this needs your SoB line too (same for other 2 patches
too).

> ---
>  arch/mips/lantiq/xway/sysctrl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysc=
trl.c
> index f11f1dd10493..e0af39b33e28 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
>  		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>  				ltq_ar9_fpi_hz(), CLOCK_250M);
>  		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
> -		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);

Checkpatch complains about these changed lines all being >80 columns,
though there are admittedly other violations nearby too.

Cheers
James

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqm7k4ACgkQbAtpk944
dnqTuQ/+JlmyPbRfhxUV6YAYrgaFfEtvYBaHzJgINkAyB6jEnLL0FweDn4Himu1K
ohBl9bmuNWqfiHIveSpyZejqnBcHwde7mLlEM7eRLkRwfQ0UswGGKI65slS8FlBk
g8W8WTcTxCieXy9rSMMIWFba68WZAvBHNdTAFCFpa1pyR/0A6JL9hslhExMWUEQO
qKYvI0OHA0pEsZECvpVQZ8KTFKAwtNx6IGkR1+iVZk3lMFvtkJM7K9L+Fcdj4ez/
HOLATVtqMVbe7YBhDnLY8xqKseh0T+r2xvccEw5HUJKHascvG467MOo0rDG3xdQ+
srcVQQW+1qLLK76uBstuMbVZhDPqN4FkJA5wyups4WbDVmYirlZdZTlxTQyuoAc3
FjRhXDkcvdqWDgSV9th+1BJQM8MkYd5/305we/B0dSAvjTY6QuuQFEfFSSjmFfix
tGXHqu6+2zeiz3OB5NJaIzExuj8xc9hkG0JaZsR0ry5avMtfVBMrNuGo6yFGHHwj
wj7eZyvLWb5Eacv1SglOuRpWsxijLE5FVeDx/QZkizARE07HsYcTdmcyasY8MUjn
BYpv0um0+/Q1mPWPsXwBVUZz6kgcFBxRsjtiXO+V4GKN6FhcUgoU2Ljk9kyuUe3y
iVYZiXEOLKRM5RzYez0ZFRn4xFEWfzIEHa83MXDpVV080TDN2mg=
=+7qJ
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

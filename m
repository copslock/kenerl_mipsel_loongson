Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 23:14:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:57386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeBOWOXPrSVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 23:14:23 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E878A217B6;
        Thu, 15 Feb 2018 22:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E878A217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 22:14:12 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BMIPS: Fix section mismatch warning
Message-ID: <20180215221412.GN3986@saruman>
References: <20180206031321.34599-1-jaedon.shin@gmail.com>
 <20180206173525.GE8479@saruman>
 <8e34b651-165e-5a07-2764-337cbe7b9ffb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline
In-Reply-To: <8e34b651-165e-5a07-2764-337cbe7b9ffb@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62567
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


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 12:09:48PM -0800, Florian Fainelli wrote:
> On 02/06/2018 09:35 AM, James Hogan wrote:
> > On Tue, Feb 06, 2018 at 12:13:21PM +0900, Jaedon Shin wrote:
> >> Remove the __init annotation from bmips_cpu_setup() to avoid the
> >> following warning.
> >>
> >> WARNING: vmlinux.o(.text+0x35c950): Section mismatch in reference from=
 the function brcmstb_pm_s3() to the function .init.text:bmips_cpu_setup()
> >> The function brcmstb_pm_s3() references
> >> the function __init bmips_cpu_setup().
> >> This is often because brcmstb_pm_s3 lacks a __init
> >> annotation or the annotation of bmips_cpu_setup is wrong.
> >>
> >> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> >=20
> > Reviewed-by: James Hogan <jhogan@kernel.org>
> >=20
> > Should CONFIG_BRCMSTB_PM=3Dy be in any of the bmips defconfigs to get s=
ome
> > build coverage of this?
>=20
> That would be a good idea, Jaedon, do you want to submit a patch doing
> that or should I?
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Applied for 4.16,

Thanks
James

--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqGBjMACgkQbAtpk944
dnoitQ//UBW3mYcWG2HrxwabgfVDDuj/fhf/47qToEEmw7RqxZnUz+FwbZIWLagt
mRdkmEDyuv2qcZVkuvdr2Bul2N4/6ros6/rb6ZRvk5vtl6sf+1QuCfouimzfpvSZ
ZEql9Rzje0R/OJEC/zl2NGwrjGv6tlSJ596eKhhFtw3JdowGiygb60F0xkxJXOZ1
gjuKCv7fIbRjiC8Kn6yyKAxUtkrxoBR0jUYMhDji9z3EVZXR5N8A2m2w1Y0Z25JX
iMES0KhnE2HO3gq50gwXVRllAoYhfAOJoYBsd29qzPlWCTPV3g6h/QKHU8ieJhTX
fUmUvyF5fQ5RFWlZb5mI4bzHU1VOevV3Pq81P2SO3BCDE/aCWQJhryCo7pw5yK3D
0HGz3CFWUXiFSEEfGCbUqb2Y9b3P8B4hmOXcGW3W/nYFo2zyUoIbhQjaueGH9hmU
bOxHtIRhxRyx9Vnpl2mFZlX0UDpJozjJRb7MvB3bs2G4Wx2fWW1fq3kLfFVwMnSi
nwvsrGErZAdz+V4+mZ/3QeBzmzfcfQs7kKKENBl5yPqQ0YVUdaoe1zAoHthGUXlp
Jzi5brPhdZy0vBLIzlAmNEmYjNVZENKaedpM5mjWKooqkbdmt/VDIyN2edCZ1+gA
9K+NvV1uDNpPVB7ucUf0Wdin2OGVaJcmPntPeb8mwl0gavW/8v4=
=0VAA
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--

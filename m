Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 12:10:40 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeBGLKcgOs2A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 12:10:32 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F34521789;
        Wed,  7 Feb 2018 11:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F34521789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Feb 2018 11:10:20 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BMIPS: Enable CONFIG_SOC_BRCMSTB
Message-ID: <20180207111020.GF8479@saruman>
References: <20180207023627.7898-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <20180207023627.7898-1-jaedon.shin@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62450
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


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 11:36:27AM +0900, Jaedon Shin wrote:
> Enable CONFIG_SOC_BRCMSTB in bmips_stb_defconfig. CONFIG_BRCMSTB_PM is
> also enabled by default option in Kconfig.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Thanks Jaedon,

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>  arch/mips/configs/bmips_stb_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bm=
ips_stb_defconfig
> index 3cefa6bc01dd..47aecb8750e6 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -72,6 +72,7 @@ CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
>  CONFIG_USB_STORAGE=3Dy
> +CONFIG_SOC_BRCMSTB=3Dy
>  CONFIG_EXT4_FS=3Dy
>  CONFIG_EXT4_FS_POSIX_ACL=3Dy
>  CONFIG_EXT4_FS_SECURITY=3Dy
> --=20
> 2.16.1
>=20

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp63pwACgkQbAtpk944
dnqEjhAAvVNvq0SbcDgekJ5uwRHJyrERkY7/yJO+fkkn6k6CbkyWOcBsACZKjAGH
Hni4/nAdBZBpYRQ8z2OXCLHsYPk2l4G01Qc/lbVg7AUWw0fknuVuObPszpR50c/g
21KzfMfvAdNWZdry9x+jFL9lfOicQsEmo1qvjxuSeNM3+8CaMhDCn3CueuY4tnhL
I6XOS3Yy4wza8ZWRpfT7W5SIspruNlp4rb3RXnlldQo2GB1y06AzR9sxBk3kFECp
pII7xrS+B3hHEc9erpCIXqXX5UBNo0U93qoWdysFJMElJAH9Dpcf/F19ISp+69oJ
JPfZzQuBxsYRbVL+1TIE7zRPux4RswRqhBejn077z1GTULieQmxNcx1JNBZOdMTX
nl2ngkgfCdktvH4NSt1sOLOiVwpr5b1h5odph/7F9RpfVqr9CTzZqWJg5RNDAUbq
p9FPKMZHPgFwmOhIPYLZQ1csBojhEMwA0dQ3oMtnkFYtYdZaJZ8wfGT4/dG5VAOQ
KoKzQsF6DB5DrGVlMMRPSIgMPSwf1Qiz7W6w/AcVIBbe8Z5XrkfrVKnw9/u3AxXy
IvGZZ0HNrkQRPv4poG+a3upxaPkLdJx+wGsZeCN6InkjlcdFnqUpWkPOPymr7aZX
38w2pTOHFB5P5mJmjKK3djorxVI18RKeDQWx88sEM4plKETLFMY=
=sZLO
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--

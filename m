Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2018 18:35:43 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeBFRfgq0Rep (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Feb 2018 18:35:36 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6568020684;
        Tue,  6 Feb 2018 17:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6568020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 6 Feb 2018 17:35:25 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BMIPS: Fix section mismatch warning
Message-ID: <20180206173525.GE8479@saruman>
References: <20180206031321.34599-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <20180206031321.34599-1-jaedon.shin@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62443
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


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 12:13:21PM +0900, Jaedon Shin wrote:
> Remove the __init annotation from bmips_cpu_setup() to avoid the
> following warning.
>=20
> WARNING: vmlinux.o(.text+0x35c950): Section mismatch in reference from th=
e function brcmstb_pm_s3() to the function .init.text:bmips_cpu_setup()
> The function brcmstb_pm_s3() references
> the function __init bmips_cpu_setup().
> This is often because brcmstb_pm_s3 lacks a __init
> annotation or the annotation of bmips_cpu_setup is wrong.
>=20
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Reviewed-by: James Hogan <jhogan@kernel.org>

Should CONFIG_BRCMSTB_PM=3Dy be in any of the bmips defconfigs to get some
build coverage of this?

Thanks
James

> ---
>  arch/mips/kernel/smp-bmips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index 87dcac2447c8..9d41732a9146 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -572,7 +572,7 @@ asmlinkage void __weak plat_wired_tlb_setup(void)
>  	 */
>  }
> =20
> -void __init bmips_cpu_setup(void)
> +void bmips_cpu_setup(void)
>  {
>  	void __iomem __maybe_unused *cbr =3D BMIPS_GET_CBR();
>  	u32 __maybe_unused cfg;
> --=20
> 2.16.1
>=20

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp551wACgkQbAtpk944
dnqVeRAArAh3wBBnioNmk/kR3t/cDVP87YqSP4oqZ5ktUaLQdcuHf0Ox+2n2PdIk
5P5rAClD668UWfTUVfm6aO+x7cxgdY0X0nKhWkbtw89z+YvGRx8GWRUf84ZEsa1o
DkpImiyZ3nMtXQVpHWZuswJBGX0Jnk1EmycZqSUzxEU7lrb1WrfOuIvx/2vTMrEa
rqVcOWufFTShOljfw+TNMI9+pDQ8TsZtLNS7UPTmL+8DKCJTXYW6Ps1+yeWsTkNZ
17GZ5mu62j4OplCi0FeP82SrBc0hAv2sSovXGGec3rbzg2oLkujh0SqOKXQ5hVCA
roYE4s3VomOkg5EY0/WbQqFsaXa1l+MDH5qR6x7dF1HG6bEur0zoe2If9VUmQrcU
QmyQBx+x2rxIOxZ9JGeMzMhu6MnRqaNfQ1byoBAOLH1NMeuZ1R4K5LVjgzUin1hF
g3DVK+7w5tMIULVfcKGsJtzyGG7LUljiMJcC8uSSuxg6dkOM3qG/rbySRsA8eA89
6AXeuaBE6hzwcfGPCnfMYCz1f0rjX7nZtuo6d/0JPmiNyAfuxBwVVNfXQSDHyruJ
tAugtLBQd6jcqfFbffVngE73HHuFNcRrdMOn1Q7XcWZYZ2qdS2OkNfRCvqpBhHLx
QtirUZevCU9QetfOY6nwc9RqYzeL3sWWcYeKklKG+1aYMBWZGFw=
=yDw5
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

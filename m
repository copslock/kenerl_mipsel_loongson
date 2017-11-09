Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 13:58:32 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:38605 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdKIM6ZmwWZH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 13:58:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 12:58:00 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 04:58:00 -0800
Date:   Thu, 9 Nov 2017 12:57:58 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [1/2] MIPS: Kconfig: Set default MIPS system type as generic
Message-ID: <20171109125758.GA7939@jhogan-linux.mipstec.com>
References: <1481728183-16776-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <1481728183-16776-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510232280-321457-5697-59214-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186752
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains 
        popular marketing words 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 03:09:42PM +0000, Matt Redfearn wrote:
> The generic MIPS system type allows building a board agnostic kernel and
> should be the default starting point for users, so set it as the default
> system type in Kconfig.
> Since ip22 is no longer the default, update ip22_defconfig to select
> CONFIG_SGI_IP22.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Thanks, both patches applied for 4.15.

Cheers
James

> ---
>=20
> This patch "fixes" the build errors reported by kernelci.org for the
> allnoconfig, generic_defconfig and tinyconfig targets.
>=20
> There is another workaround for the actual build failure in patchwork
> here https://patchwork.linux-mips.org/patch/14397/, but since that patch
> just works around a toolchain bug it is not ideal either. Since
> toolchains that produce failures here are out in the wild, banning
> binutils 2.25 & 2.26 doesn't seem helpful as that will just trigger more
> problems.
>=20
> So perhaps the best thing to do is to update the default system to
> something which does not suffer the issue and is additionally more modern
> and actively maintained.
>=20
> ---
>  arch/mips/Kconfig                | 2 +-
>  arch/mips/configs/ip22_defconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde43d34..005085e75a66 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -71,7 +71,7 @@ menu "Machine selection"
> =20
>  choice
>  	prompt "System type"
> -	default SGI_IP22
> +	default MIPS_GENERIC
> =20
>  config MIPS_GENERIC
>  	bool "Generic board-agnostic MIPS kernel"
> diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_de=
fconfig
> index 5d83ff755547..4b9e759d8b87 100644
> --- a/arch/mips/configs/ip22_defconfig
> +++ b/arch/mips/configs/ip22_defconfig
> @@ -1,3 +1,4 @@
> +CONFIG_SGI_IP22=3Dy
>  CONFIG_ARC_CONSOLE=3Dy
>  CONFIG_CPU_R5000=3Dy
>  CONFIG_NO_HZ=3Dy

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEUNYACgkQbAtpk944
dnofGw/+IIi6AEnTG/z3HpPRr47jh0JwmTfqXhq6r9TZs9tOmDDdJba+nQNvjSP5
l7lBr/RdXpAs0TKatjA6BHdKmdqRncneMe+9w9o0xxMAhnXrug5FgYpeB5ljAkbn
GRgdXkybgbK1DaG2hT5ohFzCWNUk/7/gCjDpBi6fQgRi0XTonscPBxa3UWG1fx7n
aqNEaxgyxgEnURMtTzbP6MD6DOE79tSYyt9b1l+v1mN8CcYicM78YZYfDDHxsW9N
fWjFVtmCBeIozyPLTIywduoVGel44xkiOZujkQ4dDAqxoN/86Ugog8/FQ6ZxyoiX
P3+IlgVz1ySr0T7biPfQ9ks9enknz2oxUKuXVMhL/Sp41dqRcA3S2zhhCWk9fX80
wtCfoPnReFTkQmVVx1D4Fc6FAvbh4hGR3q6nHWizFPuX9vlvTK2dqLbKHWE+uff0
Dh2xkkcC2hYd92V+TO5ql6SzyTTO34esmmXMxUlet4wTnpWg97jthG5++oLAveFo
pRkIgE4GySmLG0mv0hAfzVDBu/RvWRW89y9Mh4wvE3370IR+aEg6IJEUO1fl5uPv
lAjiAXPIir86sRFF653fvd8u26X0X+pokAdGja9AsftwhuKxtnjzv1xEnBDPnezd
/N9pSoeRqSCAB2OM8hYGblpIdBQhPhmJ/f9r0jdEqm0D+fdnU7s=
=Kymy
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

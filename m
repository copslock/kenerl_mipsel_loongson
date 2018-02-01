Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 13:01:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994833AbeBAMBGzUMFN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 13:01:06 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1903421748;
        Thu,  1 Feb 2018 12:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1903421748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 12:00:29 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Message-ID: <20180201120028.GG7637@saruman>
References: <20180117185638.22426-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <20180117185638.22426-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62393
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


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 07:56:38PM +0100, Corentin Labbe wrote:
> MIPS_GENERIC select some options with condition on BIG_ENDIAN which do
> not exists.
> Replace BIG_ENDIAN by CPU_BIG_ENDIAN which is the correct kconfig name.
> Note that BMIP_GENERIC do the same which confirm that this patch is
> needed.
>=20
> Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board su=
pport")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

I've already applied this to my 4.16 branch, with minor commit message
tweaks.

Thanks
James

> ---
>  arch/mips/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 13c6e5cb6055..504e78ff0b00 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -119,12 +119,12 @@ config MIPS_GENERIC
>  	select SYS_SUPPORTS_MULTITHREADING
>  	select SYS_SUPPORTS_RELOCATABLE
>  	select SYS_SUPPORTS_SMARTMIPS
> -	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> -	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> -	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> -	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> -	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> -	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> +	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USE_OF
>  	help
>  	  Select this to build a kernel which aims to support multiple boards,
> --=20
> 2.13.6
>=20
>=20

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzAVwACgkQbAtpk944
dnrH7Q/+Lp4UzuPKR6f5I35cJB+hJGjkAepslzexB7fXOUptOsMr7R5ufxkDrntF
TGIB/OHDlmgvDF5gU2J3pBa4EdulLi+Pe/zU63qSZy2eug+1qzcqcvYGQMJ2V5uZ
X7R50fZ0XfvRCgmQkXcVkY74uzeL3CZR16jHtZqlELOorEPtPN/qBgebLNWwRL2p
IVoWIgio6h2ajeNAi5QUQHyNCi3iaQhovDEgfJsZ/6ShZKA/dP1DnUjBGnxDqzE3
+oPPRc368hPDIglwogM4pqCI7a+v2sdIYiCH2TioW9qSk4SdxtsKTld49s+c9lci
F/II4s4N9MjIiev0AkeAy+JfuZyqEPo7FJzhLSW87LZBaSEPdepeFCLZ6DIfHHo0
UwgReUlaegaWvtwH0CBnnLGOCN3uNlqqgYn13sBME8/y+Fo9Dj5KK/5/LWygo11b
MAj2aR9Oaetp9kS9ZZbaHb+qCMbToFOA+J/xVC/ssnF1yqW3BfsW2qEfuPs4yuda
HDB4BhSn4ih0nnqNsthZNqA/RTpUN0+Lt004zFJY+C5g4HVg6LSpBhoOsfHfmKey
NmpZPgtSxFPEbD+ZVEjQPPTiMgKOQuk75ZSosGwuXSxc9tc8CSMgXEVLEnjkCeD/
yGhqQa35Ljd7arUim8/iRrgKvJDv7M9N1HBDBKZpO2QHd2fwVIc=
=yxLU
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--

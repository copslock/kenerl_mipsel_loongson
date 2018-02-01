Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 17:17:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994845AbeBAQQ70KaNz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 17:16:59 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8836720835;
        Thu,  1 Feb 2018 16:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8836720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 16:16:44 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: bcm47xx: enable ZBOOT support
Message-ID: <20180201161642.GO7637@saruman>
References: <20180116222144.20359-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tpyx7gKuSYt+mjHM"
Content-Disposition: inline
In-Reply-To: <20180116222144.20359-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62402
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


--tpyx7gKuSYt+mjHM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 12:21:44AM +0200, Aaro Koskinen wrote:
> Enable ZBOOT support. The WRT54GL router's bootloader limits kernel
> size to 3 MB with the normal load address, which is a bit challenging
> vmlinux size with modern Linux. A compressed kernel allows booting
> much bigger kernels.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to my 4.16 branch

Thanks
James

> ---
>  arch/mips/Kconfig          | 1 +
>  arch/mips/bcm47xx/Platform | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990..1a8cd3b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -253,6 +253,7 @@ config BCM47XX
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_SUPPORTS_MIPS16
> +	select SYS_SUPPORTS_ZBOOT
>  	select SYS_HAS_EARLY_PRINTK
>  	select USE_GENERIC_EARLY_PRINTK_8250
>  	select GPIOLIB
> diff --git a/arch/mips/bcm47xx/Platform b/arch/mips/bcm47xx/Platform
> index 874b7ca..70783b7 100644
> --- a/arch/mips/bcm47xx/Platform
> +++ b/arch/mips/bcm47xx/Platform
> @@ -5,3 +5,4 @@ platform-$(CONFIG_BCM47XX)	+=3D bcm47xx/
>  cflags-$(CONFIG_BCM47XX)	+=3D					\
>  		-I$(srctree)/arch/mips/include/asm/mach-bcm47xx
>  load-$(CONFIG_BCM47XX)		:=3D 0xffffffff80001000
> +zload-$(CONFIG_BCM47XX)		+=3D 0xffffffff80400000
> --=20
> 2.9.2
>=20

--tpyx7gKuSYt+mjHM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzPWkACgkQbAtpk944
dnpBiRAAmuwsaYOUfhb9jHEBA+e5VziH/WKzVXKRU7XudRpCVOERi0BQoLS62SeL
tMMYxTiBuv4wh5mY/a6RZCP5d7jt+2m+A0Z2fZhiNFrb+OzEwp+MXSWbqBA1baN0
WJ/k9jB/EMcWVCoMNljGbnyX/y6TSOpw10K89X7VzscGcYoJHY726Kkz/DPCqfcq
2VKeI7A8II/H/KcMuHOgEzGWwcqb3NaITl7yRDeioR32CvkTjB82+NX0tTm2Y1kB
OfLt9WqZAQly5BQelb3jYNUCWEcVJ+5nMolb+ir07QoABIH9GuFCDZZx9lDgmvC5
HESdUc1tDE5vsFKuiWI2jFDaT94zZtt4CbRnY5MWGco2aI/1Seqezp+7TLYOuviA
VWrE3X8EhYB2/nN71hdbFSrvPmbNfGtoUgUWOONQEAFYiAojRevJcvyygCLYL5ms
EfMFi5USmuOGSQ9jq7FFYclUZSj9mIu1iM4FzM/3GJ5WajFFIRGlEdXicJ5pR7uM
7vTPGkOWvLgkiNfLzYCjmZ/ldqij+E8CFgztAL9k/Baqolp9K/Vn3w8fPDGVQWOz
KNWnD9Qb1kKx2yjdmcm69/cJVKMjv29scskeqFYF3vvLdb2geOJ/xgIDcgLAengf
LD9YF2MuXTjHPqUmEgYR4JzhIuvSvzRY5JiMlhF1TYp4UsOt2IY=
=NORn
-----END PGP SIGNATURE-----

--tpyx7gKuSYt+mjHM--

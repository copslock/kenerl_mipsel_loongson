Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 17:02:28 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994833AbeBAQCTmut2z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 17:02:19 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2111E20835;
        Thu,  1 Feb 2018 16:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2111E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 16:02:06 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Loongson64: Drop 32-bit support for Loongson
 2E/2F devices
Message-ID: <20180201160205.GJ7637@saruman>
References: <20180102153917.4563-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <20180102153917.4563-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62397
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


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 11:39:17PM +0800, Jiaxun Yang wrote:
> The 32-bit support was broken at runtime, it doesn't boot anymore,
> witch is hard to debug because even early printk isn't working, also
> there are some build warnings. Some newer bootloader may not support
> 32-bit ELF. So we decide to drop 32-bit support.
>=20
> Make loongson64 a pure 64-bit arch.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to my 4.16 branch,

Thanks
James

> ---
>  arch/mips/loongson64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> index 0d249fc3cfe9..a7d9a9241ac4 100644
> --- a/arch/mips/loongson64/Kconfig
> +++ b/arch/mips/loongson64/Kconfig
> @@ -17,7 +17,6 @@ config LEMOTE_FULOONG2E
>  	select I8259
>  	select ISA
>  	select IRQ_MIPS_CPU
> -	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_SUPPORTS_HIGHMEM
> @@ -49,7 +48,6 @@ config LEMOTE_MACH2F
>  	select ISA
>  	select SYS_HAS_CPU_LOONGSON2F
>  	select SYS_HAS_EARLY_PRINTK
> -	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_HIGHMEM
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> --=20
> 2.15.1
>=20

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzOf0ACgkQbAtpk944
dnrN9g//R1Ef1pZ1T+Ru8tRJJWUXaB8RtykHv39FB5c+2TjxZ6Nfceh5rD4HUO3m
jtbMcgoESmkGwIQSJF5RMDJp2Bj8XVD4HVTlm282/ElQw0iaJDjGCdu7MGmk84hF
PviNfGA8CtvG8X4MWVcOG2c07cKUjqiUUJGCeKUaCBfWns3Cd04w1uwF2oGfnTcp
F0mnecK86j/8oKLn6JjcHksxJ5N4vhz68Ax0VilSyeZu9QmB9zL3UGq3KkNwVJyt
e6KlJZlCaoXFnUqKOuAasO7g42zKxJNtK1EK+F09AbPvxPu0TIeeXYD17qZhHwrX
MqT6oE8PGszjw5++fHMh+AKgBzs7qMcN+l9plzXbAfbp8wu8u+vAxtkzWZJOZkc9
Iz5BujoYUmjPO96+x3n41t5sRDgGmQ/ShmEQY3l1rVswaHr/pQL4JbkR9/JKEWay
P2H8uGnB64UWB5vLDaUCPVOW3hBjQKWFT3t7STjMIJZ8Ep9BRpxqR4/+bR9kAAU5
BqggaE/PYWzMuCQ6QUhbE5QPhb3CQcaPYvU+6ZoRKIv7lK9K+Yh4+iPBbUR/bNRS
amx1p3vip9w+kxM/Bt+xkmyaOb+mj2rhmUz9nimlBWpSieLyqQlhaz3l//I82WoX
/0/Ro30mFKc1j2kHtG++tjbq8bF+yyJSxxOsfMvf5ZDOUo9ieN8=
=uZ0o
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--

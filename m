Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 14:19:27 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeAXNTVBqxaf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 14:19:21 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF0020B80;
        Wed, 24 Jan 2018 13:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF0020B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 13:18:49 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] MIPS: Loongson64: Load platform device during boot
Message-ID: <20180124131848.GD5446@saruman>
References: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
 <20171226032602.11417-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <20171226032602.11417-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62312
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


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 11:26:01AM +0800, Jiaxun Yang wrote:
> This patch just add pdev during boot to load the platform driver
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/loongson64/lemote-2f/Makefile   |  2 +-
>  arch/mips/loongson64/lemote-2f/platform.c | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/loongson64/lemote-2f/platform.c
>=20
> diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson=
64/lemote-2f/Makefile
> index 08b8abcbfef5..31c90737b98c 100644
> --- a/arch/mips/loongson64/lemote-2f/Makefile
> +++ b/arch/mips/loongson64/lemote-2f/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for lemote loongson2f family machines
>  #
> =20
> -obj-y +=3D clock.o machtype.o irq.o reset.o ec_kb3310b.o
> +obj-y +=3D clock.o machtype.o irq.o reset.o ec_kb3310b.o platform.o
> =20
>  #
>  # Suspend Support
> diff --git a/arch/mips/loongson64/lemote-2f/platform.c b/arch/mips/loongs=
on64/lemote-2f/platform.c
> new file mode 100644
> index 000000000000..e0007f6c456a
> --- /dev/null
> +++ b/arch/mips/loongson64/lemote-2f/platform.c
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*=20

Trailing whitespace

> +* Copyright (C) 2017 Jiaxun Yang <jiaxun.yang@flygoat.com>
> +*
> +*/

Checkpatch complains about missing spaces to align the '*' on each line
of this block comment.

Cheers
James

> +
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/bootinfo.h>
> +
> +static struct platform_device yeeloong_pdev =3D {
> +	.name =3D "yeeloong_laptop",
> +	.id =3D -1,
> +};
> +
> +static int __init lemote2f_platform_init(void)
> +{
> +	if (mips_machtype !=3D MACH_LEMOTE_YL2F89)
> +		return -ENODEV;
> +
> +	return platform_device_register(&yeeloong_pdev);
> +}
> +
> +arch_initcall(lemote2f_platform_init);
> --=20
> 2.15.1
>=20

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpoh7IACgkQbAtpk944
dnq8NA/+OfLE3rYTZuiHGYcabBMAXWLaoBZzCHH5mXtkLB93f+yRS2hl3blKSD/8
wNPmxcoHgIchI8LfJDNnPEkaKp7sb+5OX/NcuyryMP80HQn0H5t/j+MGUSwIhCh8
179DNk1ZHJN0VrOYrggHrormhPz6Kw/SpJzHamoN4g33aTj512pokhRjz6DFnR2X
sN1lMdEeZvgjSRqagkyQ9QPdy7FD7Bqvs6BC4YnltPFlcLhjuixAYP4W1E40TVEU
+vt8i5p8VfswRL+XlQrIXdntM/YHw4gs75hGUmASLCwGazRQY7bqlFz9fNlwuPH5
kQb52goBT3ri2+QDbSwPF1NARf3hB2H9LTrjaadjY7GPM6l1LLjdD2zE0dPplNeI
/KMmuxUyVKd4hkodprmOl2GPw8YhZzTHqRgjMrT13om37v5s/aNVHdSWk71pm529
BjKlOv4S8Fqy1fc8Fz1EtlX6SZsbE6FNPRdnbvGfNGylIP7RpHmfoU6oS4fWr/bv
CVooxtbrnoO5CJleTZqh5JwH29+rDCOMG0N9YoemW4GIRN8JAkujmaQvcpLlUclF
s1KhjzoqEu338i8Zg+gVBgVEr/I1DsUtLaTu+NuMfj8zbPPOj7NSGNDdCvSsiggH
1XxBIUY2L017tJDxkxWjiEOjR10xq6thISngqZSCu9qi66IiCPY=
=7gFH
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--

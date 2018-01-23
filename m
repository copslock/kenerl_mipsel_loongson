Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 15:18:21 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:52204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992821AbeAWOSLeCKCj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jan 2018 15:18:11 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AC32178B;
        Tue, 23 Jan 2018 14:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AC32178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 23 Jan 2018 14:17:57 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        "# v4 . 11" <stable@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: fix incorrect mem=X@Y handling
Message-ID: <20180123141756.GE22211@saruman>
References: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
 <20171221210100.12002-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <20171221210100.12002-1-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62284
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


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 10:00:59PM +0100, Mathieu Malaterre wrote:
> From: Marcin Nowakowski <marcin.nowakowski@mips.com>
>=20
> Change 73fbc1eba7ff added a fix to ensure that the memory range between

Please refer to commits with e.g. commit 73fbc1eba7ff ("MIPS: fix
mem=3DX@Y commandline processing").

> PHYS_OFFSET and low memory address specified by mem=3D cmdline argument is
> not later processed by free_all_bootmem.
> This change was incorrect for systems where the commandline specifies
> more than 1 mem argument, as it will cause all memory between
> PHYS_OFFSET and each of the memory offsets to be marked as reserved,
> which results in parts of the RAM marked as reserved (Creator CI20's
> u-boot has a default commandline argument 'mem=3D256M@0x0
> mem=3D768M@0x30000000').
>=20
> Change the behaviour to ensure that only the range between PHYS_OFFSET
> and the lowest start address of the memories is marked as protected.
>=20
> This change also ensures that the range is marked protected even if it's
> only defined through the devicetree and not only via commandline
> arguments.
>=20
> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
> Fixes: 73fbc1eba7ff ("MIPS: fix mem=3DX@Y commandline processing")
> Cc: <stable@vger.kernel.org> # v4.11

I'm guessing that should technically be v4.11+

> ---
> v2: Use updated email adress, add tag for stable.
>  arch/mips/kernel/setup.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 702c678de116..f19d61224c71 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
>  	unsigned long reserved_end;
>  	unsigned long mapstart =3D ~0UL;
>  	unsigned long bootmap_size;
> +	phys_addr_t ramstart =3D ~0UL;

Although practically it might not matter, technically phys_addr_t may be
64-bits (CONFIG_PHYS_ADDR_T_64BIT) even on a 32-bit kernels, in which
case ~0UL may not be sufficiently large.

Maybe that should be ~(phys_addr_t)0, or perhaps (phys_addr_t)ULLONG_MAX
to match add_memory_region().

>  	bool bootmap_valid =3D false;
>  	int i;
> =20
> @@ -395,6 +396,21 @@ static void __init bootmem_init(void)
>  	max_low_pfn =3D 0;
> =20
>  	/*
> +	 * Reserve any memory between the start of RAM and PHYS_OFFSET
> +	 */
> +	for (i =3D 0; i < boot_mem_map.nr_map; i++) {
> +		if (boot_mem_map.map[i].type !=3D BOOT_MEM_RAM)
> +			continue;
> +
> +		ramstart =3D min(ramstart, boot_mem_map.map[i].addr);

Is it worth incorporating this into the existing loop below ...

> +	}
> +
> +	if (ramstart > PHYS_OFFSET)
> +		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
> +				  BOOT_MEM_RESERVED);

=2E.. and this then placed below that loop?

Otherwise I can't find fault with this patch, though i'm not intimately
familiar with bootmem.

Cheers
James

> +
> +
> +	/*
>  	 * Find the highest page frame number we have available.
>  	 */
>  	for (i =3D 0; i < boot_mem_map.nr_map; i++) {
> @@ -664,9 +680,6 @@ static int __init early_parse_mem(char *p)
> =20
>  	add_memory_region(start, size, BOOT_MEM_RAM);
> =20
> -	if (start && start > PHYS_OFFSET)
> -		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
> -				BOOT_MEM_RESERVED);
>  	return 0;
>  }
>  early_param("mem", early_parse_mem);
> --=20
> 2.11.0
>=20

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpnRA4ACgkQbAtpk944
dnp22Q/8De+B5OeBDSwCcBMxj10ZQK8NplvIZyNvT4eo/V0myFjVitdj33gWUyAI
zSeI1wPi+XwpTbc9ODPTOh9troPXCt4RQ3AjFL28A+L/fCDmsMGpKcWQeT2n4p+H
2pfN9zW4/viVyQoAKdpNYdTW5llMbxiI9n4Hu9y0UgWaSR/2tx9pNDUX2jYVuidM
Vu9Ruw4TpPPoxSlGzp3KHwC281UqqNAxq/gV+SM1LW5PxRjln/ZnMlmlyX/kVauS
/8qre8JgAPb3gXH1B2GJ9xAnfPK+SnpnaEqTKKzLzs71EjhDoBDuPzrUj1zdJ97q
h1f9vdN6ZsuhzSGQt8y4g3RuqQtf5e+NhEdNJwuKnmJomb/5/nCPEKRWPiylH9S/
aPOS7zX0ijdEgg95X6YH/ryNLE/W4RfUl0unxq+qU7A0jWJ9CC8D2bGA0xsEqCeI
7Un0fhF5MmIxXLN2CtnUyKqjpJCr1ocvPPxX5velCja0jxWfZf5eBSFG1hOl/uMP
ju/IPPQHacA9C7pGY8Xhhoh8vII2ZvpTXGT07VvZ3xgBWaBZdv0igwptxNIZpeym
YaF3tTNfBwPKitpCDLvVa6Yekm3ZWSPAERpNtejtrCGW4nrTHZb3ZKMS8Vknk2XV
D5anqso1+FyMhYsyeaom/CgTZQSmC59Nt44Wq2ZNW3IXhHEMEkE=
=D+jJ
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

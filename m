Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2018 00:21:38 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:34551 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAJXV33dQyI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Jan 2018 00:21:29 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 23:21:01 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 15:20:47 -0800
Date:   Wed, 10 Jan 2018 23:20:45 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 13/15] MIPS: JZ4770: Workaround for corrupted DMA
 transfers
Message-ID: <20180110232045.GX27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3a/Z8KDuKqDOIvAo"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-14-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515626459-321457-6967-12859-6
X-BESS-VER: 2017.17-r1801091856
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188856
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62059
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

--3a/Z8KDuKqDOIvAo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 07:25:11PM +0100, Paul Cercueil wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
>=20
> We have seen MMC DMA transfers read corrupted data from SDRAM when
> a burst interval ends at physical address 0x10000000. To avoid this
> problem, we remove the final page of low memory from the memory map.
>=20
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  arch/mips/jz4740/setup.c | 24 ++++++++++++++++++++++++
>  arch/mips/kernel/setup.c |  8 ++++++++
>  2 files changed, 32 insertions(+)
>=20
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: No change
>  v6: No change
>=20
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index cd89536fbba1..18c57c4bf47e 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_fdt.h>
> =20
>  #include <asm/bootinfo.h>
> +#include <asm/page.h>
>  #include <asm/prom.h>
> =20
>  #include <asm/mach-jz4740/base.h>
> @@ -103,3 +104,26 @@ void __init arch_init_irq(void)
>  {
>  	irqchip_init();
>  }
> +
> +/*
> + * We have seen MMC DMA transfers read corrupted data from SDRAM when a =
burst
> + * interval ends at physical address 0x10000000. To avoid this problem, =
we
> + * remove the final page of low memory from the memory map.
> + */
> +void __init jz4770_reserve_unsafe_for_dma(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < boot_mem_map.nr_map; i++) {
> +		struct boot_mem_map_entry *entry =3D boot_mem_map.map + i;
> +
> +		if (entry->type !=3D BOOT_MEM_RAM)
> +			continue;
> +
> +		if (entry->addr + entry->size !=3D 0x10000000)
> +			continue;
> +
> +		entry->size -=3D PAGE_SIZE;
> +		break;
> +	}
> +}
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 85bc601e9a0d..5a2c20145aee 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -879,6 +879,14 @@ static void __init arch_mem_init(char **cmdline_p)
> =20
>  	parse_early_param();
> =20
> +#ifdef CONFIG_MACH_JZ4770
> +	if (current_cpu_type() =3D=3D CPU_JZRISC &&
> +				mips_machtype =3D=3D MACH_INGENIC_JZ4770) {
> +		extern void __init jz4770_reserve_unsafe_for_dma(void);
> +		jz4770_reserve_unsafe_for_dma();
> +	}
> +#endif

Hmm, a little bit ugly. I'm guessing the plat_mem_setup() callback is
too early since mem=3D parameters won't have been taken into account yet
=66rom parse_early_param().

Is /memreserve/ in FDT of any value here or is it all too late due to
old DTs?

Cheers
James

> +
>  	if (usermem) {
>  		pr_info("User-defined physical RAM map:\n");
>  		print_memory_map();
> --=20
> 2.11.0
>=20
>=20

--3a/Z8KDuKqDOIvAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWn80ACgkQbAtpk944
dnq+xRAAr/Cp+9CEwAzShn3Rp1AIyPrzeort8Me/PN20nImRnv1zdmrJniNs92RH
+x/U+w+4dj6lr30HY71aOJPywEU4YuWpQMph+9M4pGfJesPxavcZyttQFbG2C74j
pFUbxHjAYqyEkg19+pKmLiKz/tY6ZQYR6iGIj4vm/p09jQC+oQ7UyiLuDsonk6NB
f20OUd2WGxGAy1bTGOZlfGeXvEETa6Jz67WurQB7coH64QtiwL71RJLs1NikpyP/
FtrkEh9ODxgxjXxx1w+rhy1A9mmfvMlUhavOm5b2Um26skWCVWX6MZiB/gMA9ZG1
NVQwpI8AHpJsZPvvW/+KRPCVATFjQj1Ftzh2+WsnA7ywUHVOYh4ref099z3fKcq+
DxwDSMadzUHxpYGkJAzeQlfSVkdKQWHYs8ilKbIY7hzAENXPGe3aAs7yWzijJhXG
VOLBRfuU0K867S/dghmgVLTqc+jlj9PcOMPSmcZfTWZzE9bNvAPZBFERRTex+ACV
KXLvP4T+FnTAd415QTYQWVdmGcz2TeS/Di8i8P4uDbqLr+YcJikXuxsT/LSqyNXS
AbbPxaSKxkjgO1E4tNb6JnN+MNIwRKqLAIZYxft78Ry5Vid5htDs2UgsZMU9Yzlr
NF78hRSWyxCVeN9VJ8Kc9JS5PfU7BtwiB7GHIgE7CELu0JRaphE=
=+zQE
-----END PGP SIGNATURE-----

--3a/Z8KDuKqDOIvAo--

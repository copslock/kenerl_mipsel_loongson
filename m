Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 14:33:13 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbeAXNdBl8YF8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 14:33:01 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CF2214EE;
        Wed, 24 Jan 2018 13:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CF2214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 13:32:29 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        YunQiang Su <yunqiang.su@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson fix name confict - MEM_RESERVED
Message-ID: <20180124133228.GE5446@saruman>
References: <1510821304-24626-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <1510821304-24626-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62313
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


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 04:35:04PM +0800, Huacai Chen wrote:
> MEM_RESERVED is used as a value of enum mem_type in include/linux/
> edac.h. This will make failure to build for Loongson in some case:
> for example with CONFIG_RAS enabled.
>=20
> So here rename MEM_RESERVED to SYSTEM_RAM_RESERVED in Loongson code.
>=20
> Signed-off-by: YunQiang Su <yunqiang.su@imgtec.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>  arch/mips/include/asm/mach-loongson64/boot_param.h | 2 +-
>  arch/mips/loongson64/common/mem.c                  | 2 +-
>  arch/mips/loongson64/loongson-3/numa.c             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mi=
ps/include/asm/mach-loongson64/boot_param.h
> index 4f69f08..8c286be 100644
> --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
> +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
> @@ -4,7 +4,7 @@
> =20
>  #define SYSTEM_RAM_LOW		1
>  #define SYSTEM_RAM_HIGH		2
> -#define MEM_RESERVED		3
> +#define SYSTEM_RAM_RESERVED	3
>  #define PCI_IO			4
>  #define PCI_MEM			5
>  #define LOONGSON_CFG_REG	6
> diff --git a/arch/mips/loongson64/common/mem.c b/arch/mips/loongson64/com=
mon/mem.c
> index b01d524..c549e52 100644
> --- a/arch/mips/loongson64/common/mem.c
> +++ b/arch/mips/loongson64/common/mem.c
> @@ -79,7 +79,7 @@ void __init prom_init_memory(void)
>  					(u64)loongson_memmap->map[i].mem_size << 20,
>  					BOOT_MEM_RAM);
>  				break;
> -			case MEM_RESERVED:
> +			case SYSTEM_RAM_RESERVED:
>  				add_memory_region(loongson_memmap->map[i].mem_start,
>  					(u64)loongson_memmap->map[i].mem_size << 20,
>  					BOOT_MEM_RESERVED);
> diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson6=
4/loongson-3/numa.c
> index f17ef52..9717106 100644
> --- a/arch/mips/loongson64/loongson-3/numa.c
> +++ b/arch/mips/loongson64/loongson-3/numa.c
> @@ -166,7 +166,7 @@ static void __init szmem(unsigned int node)
>  			memblock_add_node(PFN_PHYS(start_pfn),
>  				PFN_PHYS(end_pfn - start_pfn), node);
>  			break;
> -		case MEM_RESERVED:
> +		case SYSTEM_RAM_RESERVED:
>  			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
>  				(u32)node_id, mem_type, mem_start, mem_size);
>  			add_memory_region((node_id << 44) + mem_start,
> --=20
> 2.7.0
>=20

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpoiuwACgkQbAtpk944
dnpfiBAApnIlXTFrZYPBHSLJAElbkMQNVo09f9nsASIrLLdqist6jLm8mn5+ycbD
MoyXW3n2QrLZP38WxwJUFrNk2mHAkSF5W6uJK8RXNRcQivFjZqZCNr/5+kgIw1TT
BJECapQ50kgjH0isHF/fGCEKg9ftXwTf4d0mu3ysBxUeT0Er/GHWmosUFyCXrV68
aCwm12idGb6OsIIdvLOuHWb/vAxBgsu8kE+Ayx8y2miHm+fKti5MlHalcebkxJ2d
xwdaFxDxYq4YlJQCIb44wKCGq9USUKQGX1upI3qC2aIx9AJ8BZNS7JwrVNz9c3Jm
QAk3BH8GP1Yqw/2gWMOhUgAC8j6uelyHyp5oyB79RMUPtC+Otq1cN5eCm1oswNdN
aR1E99bhZk8BgzqOKbYMcXtDWtyhTbxL7DOVRA5dVQkfnyGBigTBs7LP9l4Hu1VQ
Hzgfz5h6GEcRJGFY8NCyXnHrbdcxRCGc1gaGnm6CH5mLCDNMBmIUWP8OTfig8qd2
b8nvaoeVxJwhS2UwMOGn3+zsP+Mf0p1DWdshzuHc2HJWX4Mlo+dpd4SK0rMbtJrv
hJc9euFWQQCYHaiGAVRlkTpMnqBBTsINs/41245fk9uocyoz4H1pBFohoeZqDoeg
+JJD5WWjcHuKNg2GkogOBlbjn4XP3UHVsPNPWbHrkqma2EvZABc=
=gnL8
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--

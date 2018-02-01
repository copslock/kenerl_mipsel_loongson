Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 17:21:21 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994845AbeBAQVOXav4z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 17:21:14 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612FA21748;
        Thu,  1 Feb 2018 16:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612FA21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 16:20:58 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        YunQiang Su <yunqiang.su@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson fix name confict - MEM_RESERVED
Message-ID: <20180201162057.GP7637@saruman>
References: <1510821304-24626-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V7BlxAaPrdhzdIM1"
Content-Disposition: inline
In-Reply-To: <1510821304-24626-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62403
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


--V7BlxAaPrdhzdIM1
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

Applied to my 4.16 branch.

Thanks
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

--V7BlxAaPrdhzdIM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzPmkACgkQbAtpk944
dnoOww//cOSeQo2a1ojUc7EsO35I8e3FGJyyjBVzXtgWQUuVAzzV5yxY4nttSceH
4PeyTTLirZDuxlbXOiekqctL7z70Z4a7qEeqa6kAwXmptwM7pgJ+K4mZA9EAs3+R
0I3K5utjJhdsc+1o6bCPzQamasQ0E6g68MD1761N+Un5/as9OaTzWsTreSzS5rK3
LpT3u2amV9bt0piGiwuwRBK1s7Id5o9zhcKJP2gNUXQwjrsuAmJttsBVkq9D+cyq
djG3WGee71wNWm48aTZyofPi9+2KQVeheXkPXRxs22oisOo5vzJp9r9B43bnetsn
E78z3CLVIJ5gzU8qQiJux6jGeI7gpb5ETGU11WUteoffL/x74ZSNFhw2lwuSibU7
hnnd0Bj0jLOolMfFa0t1oeanjAgPh1sSfVBOSjgsYBRi1Q5o7e0l+7glbLUQnrqq
TPhu6/b+jfjqnq5S0ymK/0z1UC5xAx0P6BTyMoSGGgn3a8Ijal9eocq09KPk2GQF
qhiSymu0p0NxCnaZMQtcRG1hS7tjF0G1Biv4nsHrCx9URN6xklU485SZvHg+77qw
SekmQLZtfjXo4IGMnBxbqhUsk/z5SyMltGMZ1hxsv+1BbeOBxft2riLpxNAIr3Yf
5PSC4+twWfSxMLI9RbEGEoyD8wg/uIJTXvOrQiKwWfFmnDJOkVc=
=LjVK
-----END PGP SIGNATURE-----

--V7BlxAaPrdhzdIM1--

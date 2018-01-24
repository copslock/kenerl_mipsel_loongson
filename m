Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 15:03:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeAXODHjUd58 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 15:03:07 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F74420B80;
        Wed, 24 Jan 2018 14:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F74420B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 14:02:35 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
 loongson_dma_map_ops
Message-ID: <20180124140234.GF5446@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62314
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


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 04:35:55PM +0800, Huacai Chen wrote:
> To support coherent & non-coherent DMA co-exsistance, we should add
> cache_sync to loongson_dma_map_ops.
>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

I presume this was broken by commit c9eb6172c328 ("dma-mapping: turn
dma_cache_sync into a dma_map_ops method") in 4.15-rc1? (Christoph Cc'd)

In that case:

1) we should have a fixes tag:
Fixes: c9eb6172c328 ("dma-mapping: turn dma_cache_sync into a dma_map_ops m=
ethod")

2) we should get this into 4.15 final (though its probably pushing it a
bit now).

3) Loongson might not be the only MIPS platform that was broken by that
commit. Octeon appears to be coherent, so thats fine. However Netlogic
appears not to be (Jayachandran Cc'd).

Should the following be added?

diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/commo=
n/nlm-dma.c
index 0ec9d9da6d51..58049da72c82 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -79,7 +79,8 @@ const struct dma_map_ops nlm_swiotlb_dma_ops =3D {
 	.sync_sg_for_cpu =3D swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device =3D swiotlb_sync_sg_for_device,
 	.mapping_error =3D swiotlb_dma_mapping_error,
-	.dma_supported =3D swiotlb_dma_supported
+	.dma_supported =3D swiotlb_dma_supported,
+	.cache_sync =3D mips_dma_cache_sync,
 };
=20
 void __init plat_swiotlb_setup(void)

Cheers
James

> ---
>  arch/mips/include/asm/dma-mapping.h       | 3 +++
>  arch/mips/loongson64/common/dma-swiotlb.c | 1 +
>  arch/mips/mm/dma-default.c                | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/=
dma-mapping.h
> index 0d9418d..5544276 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -37,4 +37,7 @@ static inline void arch_setup_dma_ops(struct device *de=
v, u64 dma_base,
>  #endif
>  }
> =20
> +void mips_dma_cache_sync(struct device *dev, void *vaddr,
> +		size_t size, enum dma_data_direction direction);
> +
>  #endif /* _ASM_DMA_MAPPING_H */
> diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongs=
on64/common/dma-swiotlb.c
> index ef07740..17956f2 100644
> --- a/arch/mips/loongson64/common/dma-swiotlb.c
> +++ b/arch/mips/loongson64/common/dma-swiotlb.c
> @@ -120,6 +120,7 @@ static const struct dma_map_ops loongson_dma_map_ops =
=3D {
>  	.sync_sg_for_device =3D loongson_dma_sync_sg_for_device,
>  	.mapping_error =3D swiotlb_dma_mapping_error,
>  	.dma_supported =3D loongson_dma_supported,
> +	.cache_sync =3D mips_dma_cache_sync,
>  };
> =20
>  void __init plat_swiotlb_setup(void)
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index e3e94d0..e86bf5d 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -383,7 +383,7 @@ static int mips_dma_supported(struct device *dev, u64=
 mask)
>  	return plat_dma_supported(dev, mask);
>  }
> =20
> -static void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t =
size,
> +void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>  			 enum dma_data_direction direction)
>  {
>  	BUG_ON(direction =3D=3D DMA_NONE);
> --=20
> 2.7.0
>=20

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpokfoACgkQbAtpk944
dnps3hAArlwhRcAOu6RIxL9kI5EuW/dFEuu4ecgENvN+XVcAVgmhxb+T68YAoxrT
Cqy8hlyjYm8twFtMnv4LuTQ1HuL8vlLjkfFXsSlRXUxOEvTzalIw/9pYqLqxYxCF
9iftxkGPKVNdMw6W8b0hkEYSC1bqhCcyjYlH9dVIIT5Zy5HupfAXARzD6nBvvk88
oztAQLElc7RFOnVvjmJkNiNYfgU1/iUDsoxWfkiwbPQ9Ako6kcMu14PqoF2v0A9d
Afe+fRwvPgWBlsI7Mj7pogCTTwbo4ag6h60am4RUuZSIZZUPGAovW5FW0Vja9rql
boqXjQ2x5sV/Wpu8wVKFEsinwPSR+I10wm/SYi97ZTOTnYvRNSgdCtSuyAlcaXDz
tR5So6v7sUN4pvCFkCZo8Rvrkb+F1RxFxrcMdP9EcdfCNwfimMVGXzS8STZZByoi
29xf9O6H473Ff4o0HZfgjy6Wr2H1GHjto+SDe6WT3evn6ymg4y1CDDm6+dree9g9
shs94puP4OjXP6MeI5yPTJX5DjTTvuCI+NAj6KLsEqDlrcROYihtKBML6b9LEKGr
AoGVRNTqro954oOflxgfKRQTskgmz+E4a8ekjOVut6/NzTyEAPJ41ym4h+42/ZY9
67x82wXaKMeenYc+FyhMnr1KZJ1su7Lh8fd36ILDpyu2vGYa+Ps=
=rptS
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 12:57:05 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994828AbeBAL46UzSvN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 12:56:58 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6443421799;
        Thu,  1 Feb 2018 11:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6443421799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 11:56:22 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: mm: remove mips_dma_mapping_error
Message-ID: <20180201115621.GE7637@saruman>
References: <20171205115034.15078-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20171205115034.15078-1-nbd@nbd.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62391
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


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 12:50:33PM +0100, Felix Fietkau wrote:
> dma_mapping_error() already checks if ops->mapping_error is a null
> pointer
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Thanks, I've already applied this to my 4.16 branch.

Cheers
James

> ---
>  arch/mips/mm/dma-default.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index e3e94d05f0fd..1af0cd90cc34 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -373,11 +373,6 @@ static void mips_dma_sync_sg_for_device(struct devic=
e *dev,
>  	}
>  }
> =20
> -static int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_add=
r)
> -{
> -	return 0;
> -}
> -
>  static int mips_dma_supported(struct device *dev, u64 mask)
>  {
>  	return plat_dma_supported(dev, mask);
> @@ -404,7 +399,6 @@ static const struct dma_map_ops mips_default_dma_map_=
ops =3D {
>  	.sync_single_for_device =3D mips_dma_sync_single_for_device,
>  	.sync_sg_for_cpu =3D mips_dma_sync_sg_for_cpu,
>  	.sync_sg_for_device =3D mips_dma_sync_sg_for_device,
> -	.mapping_error =3D mips_dma_mapping_error,
>  	.dma_supported =3D mips_dma_supported,
>  	.cache_sync =3D mips_dma_cache_sync,
>  };
> --=20
> 2.14.2
>=20
>=20

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzAGUACgkQbAtpk944
dnqbdhAAmV6Y7gy4c66SugMUVnRfWaG8cZ17lmvLV2B+iBhCyfTtngYo4oh1hZHP
t1dt42JYviV728ZYrJBZF3Cwfy/25pHuYzbJ2QZBvLwXTh8zykqsv1tCDyNE+s/m
gq79W2pdONEoGAYn4UiU8DzpLXUMalKfeiafi18aQBMuYg6/nxws1ViqNAgYoZDg
UofyEwdih3GCcH+likIIcwV5TMvydy7orMoFKDCGF5bEzFaVqjglrFDMBbhHlYQS
uoN6WGGCyAuSXLL6kjFuZQexcLVyD+6/VRsAODfA7C+mep/YrE6gyVg2INp+B/8W
A2Ztoq8PosWH6yaQ35WESjyqLDxlpsg2B7ZZPSv55dZz563DuoVYllY/XMNvXOsR
f0WYo5INApViSAZeL/bXaerHpX1hms4hipEDLN7y8wumNd3uhwZf7aijv7x8BTDa
9AzAN5g6VbhJ4dj64/k/3RhBFLe8Dbqz8lN8NHVirp9IoLjoSJqP04AQqyq0IHux
AsLHLixQkVRHlQqxP4sp/eBy+CuEbLvm6gy/zzE0pmzSERjSLnwVIlxfr6yQCraN
CxrsviUGn4YpUCGBL9nTFeavu2Zw1coYynaU9uH63IOnUJTKPxX/Pgp/K5NuymdY
bfOdyOh6l4S9KPA19jND4Bk0h4j1kmNO/qYHBqOosPR5hv3DNiI=
=VJUx
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--

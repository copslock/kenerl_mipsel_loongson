Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 08:55:42 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990474AbeAYHzdoiqKm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Jan 2018 08:55:33 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F53521781;
        Thu, 25 Jan 2018 07:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F53521781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 25 Jan 2018 07:55:21 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
 loongson_dma_map_ops
Message-ID: <20180125075520.GA3270@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman>
 <20180124141144.GB25393@lst.de>
 <20180124150304.GG5446@saruman>
 <20180124152904.GA29244@lst.de>
 <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62324
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


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Huacai,

On Thu, Jan 25, 2018 at 03:09:33PM +0800, Huacai Chen wrote:
> Hi, James and Christoph,
>=20
> We have modified arch/mips/loongson64/common/dma-swiotlb.c to make
> Loongson support coherent&non-coherent devices co-exist. You can see
> code here:
> https://github.com/linux-loongson/linux-loongson/commit/3f212e36b2432a7c4=
a843649e4b79c9c0837d1d2
> When device is non-coherent, we will call dma_cache_sync().
>=20
> Then, if dma_cache_sync() is only designed for
> DMA_ATTR_NON_CONSISTENT, what can I use?

How did you allocate the memory? The appropriate generic API for the
type of memory should always be used in drivers over arch specific
stuff.

AFAIK (see e.g. Documentation/DMA-API.txt):
- dma_alloc_coherent() shouldn't require syncing, though it may require
  flushing of write combiners
- dma_alloc_attrs() only requires syncing when DMA_ATTR_NON_CONSISTENT
  is used, otherwise is the same as dma_alloc_coherent()
- guaranteed contiguous memory within PA range (e.g. kmalloc()'d memory
  with the appropriate GFP_DMA flags) can be synced using the
  dma_map_*() and dma_unmap_*() functions.

Cheers
James

> 1, __dma_sync_virtual() and __dma_sync() are both static functions, so
> can't be called in other files.
> 2, mips_dma_cache_sync() is not static, but I think it isn't designed
> to be called directly (So it should be static).
> 3, dma_cache_wback(), dma_cache_inv() and dma_cache_wback_inv() does't
> take a "direction" argument, so I should determine the direction first
> (then I will reimplement __dma_cache_sync for myself).
> So, It seems that I can only use dma_cache_sync().
>=20
> Huacai
>=20
> On Wed, Jan 24, 2018 at 11:29 PM, Christoph Hellwig <hch@lst.de> wrote:
> > On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
> >> I see, that makes sense. Thanks Christoph. I'll assume this patch isn't
> >> applicable then unless Huacai adds some explanation.
> >
> > In addition there also is no driver that can be used on loongsoon
> > that actually calls dma_cache_sync either.
> >

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlppjWEACgkQbAtpk944
dnqchg/8DEr9H03MIUF3crNZil+EXa5b71DDLLLQI9JfJX+UqAKzEst13vYUsOn5
PvZk/RGjhLkQ1zQo9yzXOUQxK/ExBRllTul6fj2tBn03HtnUuweLYxvi1dlirV6t
Tz9hg16ZPSJTvQ1bhXNrPwq6dL1bIDmTTTXaSoEoetVTVui6uWyMpZmT5uOibgte
ksExTHUzlHaTh1wQnumtCCc3LXkjlEMI3BhIk6cMNxWUF9AvQTqP/j+PVgYIcJJC
dtzRE0EmKdQ3fqwyfnLf+GFB9ZfaFllBFm8blsvrm10RoqJ9hZOEBgETkhKj69F0
X4KhECUjkcUopvjwNS/QKLOIDrPa/F4MzKVaks69rz7e1Jyg0ISwRza+GD16Sqcn
dGMg+KXSyWjRV8Wm0iGlYLdClSHzyyq0GNvHkPKY1znIm0JjFuTBgSAxNq5JJ5Xc
iR3f86lUFp3Pc/9KQjaL78A5VGB9FeD40+OSowCuHJ8tZ3PXLxfdUQR51EW5WFez
4kNVfjYruCNiSisr4kVbJEwm9tSaVWAqVjBzKZwgQ2eTRa1diTMpeB4Z8MdsjsSY
DnGDOoBTVN/zrkNWYVxRDGX9QZ4G5wPA7/JMhrHhud5JoqIG/PlNEAkxnhyVwQ19
L5AKsHQJwihZjXQAesouGXH5z1VLROTOfrYzqCosqG/Y78j1ixE=
=+cvk
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 11:55:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992827AbeAYKzWkywPS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Jan 2018 11:55:22 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404D721781;
        Thu, 25 Jan 2018 10:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404D721781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 25 Jan 2018 10:54:49 +0000
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
Message-ID: <20180125105449.GL5446@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman>
 <20180124141144.GB25393@lst.de>
 <20180124150304.GG5446@saruman>
 <20180124152904.GA29244@lst.de>
 <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com>
 <20180125075520.GA3270@saruman>
 <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Content-Disposition: inline
In-Reply-To: <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62326
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


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 04:44:36PM +0800, Huacai Chen wrote:
> On Thu, Jan 25, 2018 at 3:55 PM, James Hogan <jhogan@kernel.org> wrote:
> > Hi Huacai,
> >
> > On Thu, Jan 25, 2018 at 03:09:33PM +0800, Huacai Chen wrote:
> >> Hi, James and Christoph,
> >>
> >> We have modified arch/mips/loongson64/common/dma-swiotlb.c to make
> >> Loongson support coherent&non-coherent devices co-exist. You can see
> >> code here:
> >> https://github.com/linux-loongson/linux-loongson/commit/3f212e36b2432a=
7c4a843649e4b79c9c0837d1d2
> >> When device is non-coherent, we will call dma_cache_sync().
> >>
> >> Then, if dma_cache_sync() is only designed for
> >> DMA_ATTR_NON_CONSISTENT, what can I use?
> >
> > How did you allocate the memory? The appropriate generic API for the
> > type of memory should always be used in drivers over arch specific
> > stuff.
> >
> > AFAIK (see e.g. Documentation/DMA-API.txt):
> > - dma_alloc_coherent() shouldn't require syncing, though it may require
> >   flushing of write combiners
> > - dma_alloc_attrs() only requires syncing when DMA_ATTR_NON_CONSISTENT
> >   is used, otherwise is the same as dma_alloc_coherent()
> > - guaranteed contiguous memory within PA range (e.g. kmalloc()'d memory
> >   with the appropriate GFP_DMA flags) can be synced using the
> >   dma_map_*() and dma_unmap_*() functions.

I also see there is a dma_sync_*_for_{cpu,device} to avoid "mapping" and
"unmapping" the same area repeatedly if it is reused.

> Yes, kmalloc()'d memory with the appropriate GFP_DMA flags can be
> synced using the dma_map_*() and dma_unmap_*() functions. So,
> loongson_dma_map_page()/loongson_dma_unmap_page() (which is the
> backend of dma_map_*() and dma_unmap_*()) should call dma_cache_sync()
> for non-coherent devices, right?

Yeh, I suppose thats effectively what it should do (though probably via
an arch specific function rather than dma_cache_sync() itself). Also the
sync_*_for_{cpu,device} callbacks should probably do it too. See all the
calls to __dma_sync() in the MIPS dma-default.c implementation.

Cheers
James

>=20
> Huacai
>=20
> >
> > Cheers
> > James
> >
> >> 1, __dma_sync_virtual() and __dma_sync() are both static functions, so
> >> can't be called in other files.
> >> 2, mips_dma_cache_sync() is not static, but I think it isn't designed
> >> to be called directly (So it should be static).
> >> 3, dma_cache_wback(), dma_cache_inv() and dma_cache_wback_inv() does't
> >> take a "direction" argument, so I should determine the direction first
> >> (then I will reimplement __dma_cache_sync for myself).
> >> So, It seems that I can only use dma_cache_sync().
> >>
> >> Huacai
> >>
> >> On Wed, Jan 24, 2018 at 11:29 PM, Christoph Hellwig <hch@lst.de> wrote:
> >> > On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
> >> >> I see, that makes sense. Thanks Christoph. I'll assume this patch i=
sn't
> >> >> applicable then unless Huacai adds some explanation.
> >> >
> >> > In addition there also is no driver that can be used on loongsoon
> >> > that actually calls dma_cache_sync either.
> >> >

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlppt3IACgkQbAtpk944
dnrYHw/+N44bCGUlKc5EEoSQC4aKMixJdHHCu045w1dS2PpAtFJ9Ct6sD2nZyXAY
Mu+ozXLNDQbRSGRphGfYmxNzma3ThzMWi+kUkE/tgl1yEW1lAEgJmS6EGIc0+mkM
KjNGq3RBdhyuDlXBWq366J5Men5pa3oiFdz+HVt3sGPY0+mmEthGdlSrw5MpGsvT
ihhIM4cUhPTp33bTCG2izPLhvS4rtwY+mZFxwwmpPB6ZwdQ0JkpQn3kYb0GzWmH0
6PYZ+oFczMv/Y8Q0tadb6YggWXv7Xcp9mlXIl25wL8MDGiMfOaQvFZFgTxWl2hqE
clsc3ONMJHvX44iocBzQfnbQnyV6zmk1hhhZi2kOb2L56o8gYrTIzR71r0b4hR7X
lYk8E3qFnrHwx92Omus6KT1VZTmzmajqGUm+jn6M/S2AgxB0KYww/HrDdQkHhN3W
oF8+qpUDWl+oX7kEd7v962bW9bJNI/2Z+Vwmi17LFHT+eRDWE79JcPmxuN37RsIp
PKsKt5bZjZIT2/itt6Y0n6Q5NHjsEMlE82ZP0iuxVynu98UYLMos744w7qSuJ5Kw
u6XyrEqKKn1Z5oWao9Wk928wzjh0YZ02WS3q0QgWkFuOzPz9foe6OGV5ucP5XENx
jjgNHgbQ3c/+dP7BiFzm+9RuIQmiEMEV8tnRocmbBYHJjLbCHi4=
=CuV9
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--

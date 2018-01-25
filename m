Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 13:32:03 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992821AbeAYMb4abefS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Jan 2018 13:31:56 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0C321778;
        Thu, 25 Jan 2018 12:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0C321778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 25 Jan 2018 12:31:22 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
 loongson_dma_map_ops
Message-ID: <20180125123122.GM5446@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman>
 <20180124141144.GB25393@lst.de>
 <20180124150304.GG5446@saruman>
 <20180124152904.GA29244@lst.de>
 <CAAhV-H7YgzqwLPS4SrhGbqdHmLTaHV9mgwXYdY-MU_=yw8HDdA@mail.gmail.com>
 <20180125075520.GA3270@saruman>
 <CAAhV-H7i8PZtn7JMgzCW3nseH-rwtcc_H6_9n+pOE4DU5i1KAg@mail.gmail.com>
 <20180125105449.GL5446@saruman>
 <CAAhV-H5F3tzezN1BJ=NzYpfVPi3UCFpzQ=48mOS5ZFjVBcGyKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EE8jvUPYYQjJtG7J"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5F3tzezN1BJ=NzYpfVPi3UCFpzQ=48mOS5ZFjVBcGyKA@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62328
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


--EE8jvUPYYQjJtG7J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 07:04:37PM +0800, Huacai Chen wrote:
> If call dma_cache_sync() is incorrect,

(it wouldn't work since the cache_sync callback wouldn't be set).

> then which is the correct way?
> 1, call mips_dma_cache_sync()?
> 2, remove static of __dma_sync_virtual() and call it?

Both take a virtual address, which is obviously not directly usable for
functions which get a DMA handle, so __dma_sync() may be better.

Cheers
James

>=20
> Huacai
>=20
> On Thu, Jan 25, 2018 at 6:54 PM, James Hogan <jhogan@kernel.org> wrote:
> > On Thu, Jan 25, 2018 at 04:44:36PM +0800, Huacai Chen wrote:
> >> On Thu, Jan 25, 2018 at 3:55 PM, James Hogan <jhogan@kernel.org> wrote:
> >> > Hi Huacai,
> >> >
> >> > On Thu, Jan 25, 2018 at 03:09:33PM +0800, Huacai Chen wrote:
> >> >> Hi, James and Christoph,
> >> >>
> >> >> We have modified arch/mips/loongson64/common/dma-swiotlb.c to make
> >> >> Loongson support coherent&non-coherent devices co-exist. You can see
> >> >> code here:
> >> >> https://github.com/linux-loongson/linux-loongson/commit/3f212e36b24=
32a7c4a843649e4b79c9c0837d1d2
> >> >> When device is non-coherent, we will call dma_cache_sync().
> >> >>
> >> >> Then, if dma_cache_sync() is only designed for
> >> >> DMA_ATTR_NON_CONSISTENT, what can I use?
> >> >
> >> > How did you allocate the memory? The appropriate generic API for the
> >> > type of memory should always be used in drivers over arch specific
> >> > stuff.
> >> >
> >> > AFAIK (see e.g. Documentation/DMA-API.txt):
> >> > - dma_alloc_coherent() shouldn't require syncing, though it may requ=
ire
> >> >   flushing of write combiners
> >> > - dma_alloc_attrs() only requires syncing when DMA_ATTR_NON_CONSISTE=
NT
> >> >   is used, otherwise is the same as dma_alloc_coherent()
> >> > - guaranteed contiguous memory within PA range (e.g. kmalloc()'d mem=
ory
> >> >   with the appropriate GFP_DMA flags) can be synced using the
> >> >   dma_map_*() and dma_unmap_*() functions.
> >
> > I also see there is a dma_sync_*_for_{cpu,device} to avoid "mapping" and
> > "unmapping" the same area repeatedly if it is reused.
> >
> >> Yes, kmalloc()'d memory with the appropriate GFP_DMA flags can be
> >> synced using the dma_map_*() and dma_unmap_*() functions. So,
> >> loongson_dma_map_page()/loongson_dma_unmap_page() (which is the
> >> backend of dma_map_*() and dma_unmap_*()) should call dma_cache_sync()
> >> for non-coherent devices, right?
> >
> > Yeh, I suppose thats effectively what it should do (though probably via
> > an arch specific function rather than dma_cache_sync() itself). Also the
> > sync_*_for_{cpu,device} callbacks should probably do it too. See all the
> > calls to __dma_sync() in the MIPS dma-default.c implementation.
> >
> > Cheers
> > James
> >
> >>
> >> Huacai
> >>
> >> >
> >> > Cheers
> >> > James
> >> >
> >> >> 1, __dma_sync_virtual() and __dma_sync() are both static functions,=
 so
> >> >> can't be called in other files.
> >> >> 2, mips_dma_cache_sync() is not static, but I think it isn't design=
ed
> >> >> to be called directly (So it should be static).
> >> >> 3, dma_cache_wback(), dma_cache_inv() and dma_cache_wback_inv() doe=
s't
> >> >> take a "direction" argument, so I should determine the direction fi=
rst
> >> >> (then I will reimplement __dma_cache_sync for myself).
> >> >> So, It seems that I can only use dma_cache_sync().
> >> >>
> >> >> Huacai
> >> >>
> >> >> On Wed, Jan 24, 2018 at 11:29 PM, Christoph Hellwig <hch@lst.de> wr=
ote:
> >> >> > On Wed, Jan 24, 2018 at 03:03:05PM +0000, James Hogan wrote:
> >> >> >> I see, that makes sense. Thanks Christoph. I'll assume this patc=
h isn't
> >> >> >> applicable then unless Huacai adds some explanation.
> >> >> >
> >> >> > In addition there also is no driver that can be used on loongsoon
> >> >> > that actually calls dma_cache_sync either.
> >> >> >

--EE8jvUPYYQjJtG7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlppzfwACgkQbAtpk944
dnry+A/+NcdwLrVi1vBgfCHa6huzg/ldu5m89UeOdftX164bpG8v1eyAqmPnlgTT
R+Hi6vmnF42hAK+GlpslNlzMBLnT4jqtPYM7Ot628kBIiTMR6hUiZmL+gCiSZcWa
GBLfhXpHtygtMt6sEJdp9DwHcvgkJldHWNtHhPJ74TWzsOrZx/Ob+4xJ6/eTz+tW
eEeHVR3xhgQe76sUz5cxH37OJraqv5uDb48XlHhNevIOTpW4xaOBIcl2SZzvBMW7
efR0CaJkNSsRYNeg7vaj1ysmwNnB4kGcPHjEyan2ABhupiYpID0pEt/57V47PA/2
hRzXiNEeyxt6ORirL0Dqsb0Ly0ddNGMc7HSPBNPaW5FHUyV+h0F8il4VjKuPpWM2
9BEuMFn+hqCdOnM3dCrMnMo0PV+6jNBQzc+pUWL8gn0gy9ku9DrK10A/3MbfuGD4
JEofK7Qw3b/1WuOEGRNLR1lyqjnF7qv/5RIGh6HNQ90Bj85YcCA14Datx1WE3RoK
ROpVuCmFSSTdEefPm/wB+byA/yWOg7Z6tfe+avxnxgWO4PC20jpx0RUdOry2Psml
wgT87pDAAaJKBVTnF7sPXBmEsuioRajzudwnicBUzXS4xSFr0k5+QD3Q4lvGAKMW
0wkfutkEwlgB0Ih7NRx7XvfIGXLN6v1CDOIe1Z+ORnNh49+AWTc=
=LI/I
-----END PGP SIGNATURE-----

--EE8jvUPYYQjJtG7J--

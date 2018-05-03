Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2018 08:47:52 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbeECGroSY57k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2018 08:47:44 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2520821716;
        Thu,  3 May 2018 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525330057;
        bh=atUrz8JUYCggP1NJYmyJMoLiPTm/wANtoMPVwmC4fvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+RUWaOi+hItKxrkImLMwnXzXs765MbU08JTZD2AD4FV/Ow4QNOPoDRbnQi76U73p
         4mGC7x+eZSK2oTHu1jyf4wre8uFOgOCsZVWFZ47LvlCVi9Dm7Sw9Is7fHX4lphpLZz
         l+prII8mUldICU7/XZr8PNi7RvKHySXrfU3SNB74=
Date:   Thu, 3 May 2018 07:47:32 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, sstabellini@kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/13] mips,unicore32: swiotlb doesn't need sg->dma_length
Message-ID: <20180503064731.GA3971@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de>
 <20180502222017.GC20766@jamesdev>
 <20180503035643.GA9781@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20180503035643.GA9781@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63855
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


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 05:56:43AM +0200, Christoph Hellwig wrote:
> On Wed, May 02, 2018 at 11:20:18PM +0100, James Hogan wrote:
> > On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> > > Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> > > swiotlb.  swiotlb itself never merges segements and doesn't accesses =
the
> > > dma_length field directly, so drop the dependency.
> >=20
> > Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
> > suggest arch ports should enable it for IOMMUs?
>=20
> swiotlb isn't really an iommu..  That being said iommus don't have to
> merge segments either if they don't want to, and we have various
> implementations that don't.  The whole dma api documentation needs
> a major overhaul, including merging the various files and dropping a lot
> of dead wood.  It has been on my todo list for a while, with an inner
> hope that someone else would do it before me.

Okay, for MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuqwggAKCRA1zuSGKxAj
8jJ0AQDBwGZ2k1NphYwyh6OgPS7IN3FDLAFiO2iFddGI2zSf4AEA9hgbj9kgtHKd
8c/TTL4ZMY/xIMHoCb/jXAC1q13gig8=
=IGGZ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

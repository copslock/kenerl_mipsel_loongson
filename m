Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2018 00:20:39 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993070AbeEBWUc4vihN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2018 00:20:32 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D9121720;
        Wed,  2 May 2018 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525299626;
        bh=u/YhuJ4aMtoGi5atRYjyCDrOuyNMqLJOf09Ogfhx+A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3F9NK0h9tc/Kja/VAhEnkYZGvjuKzyTD8U1a2JPkJjQKwlk3E0HsDu1SUuqXKbzy
         cE36pU/qgAbvzbyHY/6+vScBeI8t+C3Hbng5ObZgRoO54ewXUHweFgiqivxu9crLz2
         L6oOITwIb1+gGL8yvHmI2C+6o+ySPPL2Gq+OfjyY=
Date:   Wed, 2 May 2018 23:20:18 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, sstabellini@kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/13] mips,unicore32: swiotlb doesn't need sg->dma_length
Message-ID: <20180502222017.GC20766@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20180425051539.1989-12-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63851
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


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> swiotlb.  swiotlb itself never merges segements and doesn't accesses the
> dma_length field directly, so drop the dependency.

Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
suggest arch ports should enable it for IOMMUs?

Cheers
James

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuo5nwAKCRA1zuSGKxAj
8toFAQDILXOi2KhP1yoO3zabIiof3I/tmRomgzUgGA3ESVm5lgEA4elhmn7zDXhX
YG33reqJ7xyPenaOF8AX63cB5eqjOQ8=
=UDV2
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

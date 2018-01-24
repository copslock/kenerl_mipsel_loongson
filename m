Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 16:03:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbeAXPDjmDLap (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 16:03:39 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0016420835;
        Wed, 24 Jan 2018 15:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0016420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 15:03:05 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to
 loongson_dma_map_ops
Message-ID: <20180124150304.GG5446@saruman>
References: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
 <20180124140234.GF5446@saruman>
 <20180124141144.GB25393@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <20180124141144.GB25393@lst.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62316
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


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 03:11:44PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 24, 2018 at 02:02:35PM +0000, James Hogan wrote:
> > On Thu, Nov 16, 2017 at 04:35:55PM +0800, Huacai Chen wrote:
> > > To support coherent & non-coherent DMA co-exsistance, we should add
> > > cache_sync to loongson_dma_map_ops.
> > >=20
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >=20
> > I presume this was broken by commit c9eb6172c328 ("dma-mapping: turn
> > dma_cache_sync into a dma_map_ops method") in 4.15-rc1? (Christoph Cc'd)
>=20
> I don't think that is the case.
>=20
> In mips only mips_default_dma_map_ops supports DMA_ATTR_NON_CONSISTENT,
> and mips_default_dma_map_ops grew support for the dma_cache_sync
> operation.
>=20
> Neither Octeon nor longsoon respect the DMA_ATTR_NON_CONSISTENT argument
> to dma_alloc_attrs, so there is no point in implementing dma_cache_sync
> for them.

I see, that makes sense. Thanks Christoph. I'll assume this patch isn't
applicable then unless Huacai adds some explanation.

Cheers
James

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpooCIACgkQbAtpk944
dnqpCQ/+P2ekJnaH35YcxyoxU6mYJ3JFWhcBrEVsgtmyt8TRUL4+FVGqHYQOhoP6
a8VjDrVSGP2h8kVNrJjljPRnzg35BsOuwiscWO2PQzlsu8/gelt1dKtRdtBGLcpI
2LIFUPsNBZjMaUF3z5+TZyXdJ/v2yNLXlhJBMfl1gezLge0EIvTjdOsAieeqQIPC
vCg/9qp/ZzZadqkR2ibdsevCwsPkhT/TAUaOdsW91PbtqNnaKc4Md67KYTnjjVyh
CBEZLWCwgHKKAwQRT68qw6DLvhpKoGt9ksGU+A3UcwPvqgAK/fl3EDvVy0UZAaoT
O+rT/Jt02crUGipFU7LvU7L4UEeVaGVTBrcqeWL2EfztzIDFbcJen/s9SAbv3CGs
H/jMcjgx8PM1hjN8TJ67z/sHhmCDCp43YvGGAZ/BnokorzGNSgobb+LgEql9i7tO
742ON+GTAEDLECWM8zLwNhzEm5QH7Qn/wSs7umrgjS9ZenuLT5CEGYEVSJze5yzq
8JQ8DzbNMuJFSwTMd8JN52BFQwzYcoPxk+U3Sl4xbDvUoT9Lq1fp3fHAPCSy/tK9
V97jijs8fM+JSBbvFCRh+GU0QcRI6ryeJrydDUlhwNzCJk2Ik5QXlxc9OsBViM2A
X+q/4XdLJG0RkjpIw9SkMxYduAQg9AD5QCBLiDOPQaWs2UrvxLA=
=nMVa
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--

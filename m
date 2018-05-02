Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2018 22:11:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeEBULigF13L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2018 22:11:38 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C53042172A;
        Wed,  2 May 2018 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525291890;
        bh=33rgbt5q+LUc/yf601as0z8Eu/5uXa+spW2gTZsfFNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBoh0rbutEEwEFMsHhqLIRq+mRoo82CGtOFuQP/nNumWSBSFTzntWurBBLbNuXQQP
         mgOhOE0AZkwg9ALRzYzMfZytnOq+8X6aYK0WX7HkjNRTAm0fTn0YYLl2T/i//GZa45
         mXZNxpbdKTAJWLZoH92LBi0L1k9irHTDPitAx3Q0=
Date:   Wed, 2 May 2018 21:11:25 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, sstabellini@kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/13] arch: remove the ARCH_PHYS_ADDR_T_64BIT config
 symbol
Message-ID: <20180502201123.GA20766@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20180425051539.1989-8-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63846
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


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:15:33AM +0200, Christoph Hellwig wrote:
> Instead select the PHYS_ADDR_T_64BIT for 32-bit architectures that need a
> 64-bit phys_addr_t type directly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/mips/Kconfig                      | 15 ++++++---------

For MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuobYAAKCRA1zuSGKxAj
8rcSAP9uo9v+ADH7S0A5ptU5zQJbehcDNcjsP+tV3mIWaMxo5AD9Fxc2fxERhWzk
sHBf3K14mN5e+PiMMLB9/hGD7t8eJAo=
=7djd
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

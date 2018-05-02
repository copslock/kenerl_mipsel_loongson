Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2018 00:09:53 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:56024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992971AbeEBWJqkS7kN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2018 00:09:46 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A5F20C48;
        Wed,  2 May 2018 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525298979;
        bh=V42ZWQ5zmARA1PfFScZJ9HNpia8G6YBasKwijfhsEKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxjEHLOyZO2RFDUT4+kWG1bqLX8L1c8kOI2g3Vyl+Gk0jNXrfotv3avjwpP4uQ5eZ
         Pf5UVDOa7bQHGnhbMg2vc0WDQJA5H6tZehw8+WbPTf1fJo5myoowTyn0X//d1yR+z6
         T9Pu/zSjPQE6pQyJGAjrRdCXJ6ibzkJceME4QoAU=
Date:   Wed, 2 May 2018 23:09:34 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, sstabellini@kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/13] arch: define the ARCH_DMA_ADDR_T_64BIT config
 symbol in lib/Kconfig
Message-ID: <20180502220933.GB20766@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20180425051539.1989-9-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63850
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


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:15:34AM +0200, Christoph Hellwig wrote:
> Define this symbol if the architecture either uses 64-bit pointers or the
> PHYS_ADDR_T_64BIT is set.  This covers 95% of the old arch magic.  We only
> need an additional select for Xen on ARM (why anyway?), and we now always
> set ARCH_DMA_ADDR_T_64BIT on mips boards with 64-bit physical addressing
> instead of only doing it when highmem is set.

I think this should be fine. It only affects alchemy and Netlogic, and
Netlogic supports highmem already.

So for MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 985388078872..e10cc5c7be69 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1101,9 +1101,6 @@ config GPIO_TXX9
>  config FW_CFE
>  	bool
> =20
> -config ARCH_DMA_ADDR_T_64BIT
> -	def_bool (HIGHMEM && PHYS_ADDR_T_64BIT) || 64BIT
> -
>  config ARCH_SUPPORTS_UPROBES
>  	bool

> diff --git a/lib/Kconfig b/lib/Kconfig
> index ce9fa962d59b..1f12faf03819 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -435,6 +435,9 @@ config NEED_SG_DMA_LENGTH
>  config NEED_DMA_MAP_STATE
>  	bool
> =20
> +config ARCH_DMA_ADDR_T_64BIT
> +	def_bool 64BIT || PHYS_ADDR_T_64BIT
> +
>  config IOMMU_HELPER
>  	bool

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuo3DwAKCRA1zuSGKxAj
8tikAQDi/ZUNjW7+epg5yVcHFsdN4zPqszjMfOoZb9Tw0/w5/QD+O0gHySriLqfv
vZwnsvl5Mx2kzMLvdMNqFC++weR4XwQ=
=H1g4
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 17:13:41 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:34116 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994611AbeHaPMdkiQIK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 17:12:33 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 3DDAC492C6;
        Fri, 31 Aug 2018 17:12:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id ccrVJ8sps-Wh; Fri, 31 Aug 2018 17:12:27 +0200 (CEST)
Subject: Re: [PATCH] MIPS: VDSO: Match data page cache colouring when D$
 aliases
To:     Paul Burton <paul.burton@mips.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rene Nielsen <rene.nielsen@microsemi.com>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        stable@vger.kernel.org
References: <20180828160254.GC16561@piout.net>
 <20180830180121.25363-1-paul.burton@mips.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <7f92c83f-3f23-8dd2-31ca-aaf268d52bed@hauke-m.de>
Date:   Fri, 31 Aug 2018 17:12:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180830180121.25363-1-paul.burton@mips.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5iC99q6WkDx4ZpJlEs64Pmjzpo9iVupJi"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5iC99q6WkDx4ZpJlEs64Pmjzpo9iVupJi
Content-Type: multipart/mixed; boundary="kjtjX3Kdmgnm580uF66lOQMUvo8fywno3";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Paul Burton <paul.burton@mips.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rene Nielsen <rene.nielsen@microsemi.com>
Cc: linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
 stable@vger.kernel.org
Message-ID: <7f92c83f-3f23-8dd2-31ca-aaf268d52bed@hauke-m.de>
Subject: Re: [PATCH] MIPS: VDSO: Match data page cache colouring when D$
 aliases
References: <20180828160254.GC16561@piout.net>
 <20180830180121.25363-1-paul.burton@mips.com>
In-Reply-To: <20180830180121.25363-1-paul.burton@mips.com>

--kjtjX3Kdmgnm580uF66lOQMUvo8fywno3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/30/2018 08:01 PM, Paul Burton wrote:
> When a system suffers from dcache aliasing a user program may observe
> stale VDSO data from an aliased cache line. Notably this can break the
> expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
> suggests, monotonic.
>=20
> In order to ensure that users observe updates to the VDSO data page as
> intended, align the user mappings of the VDSO data page such that their=

> cache colouring matches that of the virtual address range which the
> kernel will use to update the data page - typically its unmapped addres=
s
> within kseg0.
>=20
> This ensures that we don't introduce aliasing cache lines for the VDSO
> data page, and therefore that userland will observe updates without
> requiring cache invalidation.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org # v4.4+

Tested-by: Hauke Mehrtens <hauke@hauke-m.de>


Without this patch ping shows these results on kernel 4.19-rc1 on the
Lantiq VR9 SoC to a PC directly connected to the LAN port:

root@OpenWrt:~# ping 192.168.1.195
PING 192.168.1.195 (192.168.1.195): 56 data bytes
64 bytes from 192.168.1.195: seq=3D0 ttl=3D64 time=3D0.689 ms
64 bytes from 192.168.1.195: seq=3D1 ttl=3D64 time=3D236.527 ms
64 bytes from 192.168.1.195: seq=3D2 ttl=3D64 time=3D4294963.829 ms
64 bytes from 192.168.1.195: seq=3D3 ttl=3D64 time=3D4294423.824 ms
64 bytes from 192.168.1.195: seq=3D4 ttl=3D64 time=3D960.527 ms
64 bytes from 192.168.1.195: seq=3D5 ttl=3D64 time=3D472.530 ms
64 bytes from 192.168.1.195: seq=3D6 ttl=3D64 time=3D464.530 ms
64 bytes from 192.168.1.195: seq=3D7 ttl=3D64 time=3D452.530 ms

With this patch it looks like this:

root@OpenWrt:~# ping 192.168.1.195
PING 192.168.1.195 (192.168.1.195): 56 data bytes
64 bytes from 192.168.1.195: seq=3D0 ttl=3D64 time=3D0.638 ms
64 bytes from 192.168.1.195: seq=3D1 ttl=3D64 time=3D0.573 ms
64 bytes from 192.168.1.195: seq=3D2 ttl=3D64 time=3D0.605 ms
64 bytes from 192.168.1.195: seq=3D3 ttl=3D64 time=3D0.524 ms
64 bytes from 192.168.1.195: seq=3D4 ttl=3D64 time=3D0.534 ms
64 bytes from 192.168.1.195: seq=3D5 ttl=3D64 time=3D0.518 ms
64 bytes from 192.168.1.195: seq=3D6 ttl=3D64 time=3D0.485 ms
64 bytes from 192.168.1.195: seq=3D7 ttl=3D64 time=3D0.501 ms


> ---
> Hi Alexandre,
>=20
> Could you try this out on your Ocelot system? Hopefully it'll solve the=

> problem just as well as James' patch but doesn't need the questionable
> change to arch_get_unmapped_area_common().
>=20
> Thanks,
>     Paul
> ---
>  arch/mips/kernel/vdso.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 019035d7225c..5fb617a42335 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -20,6 +21,7 @@
> =20
>  #include <asm/abi.h>
>  #include <asm/mips-cps.h>
> +#include <asm/page.h>
>  #include <asm/vdso.h>
> =20
>  /* Kernel-provided data used by the VDSO. */
> @@ -128,12 +130,30 @@ int arch_setup_additional_pages(struct linux_binp=
rm *bprm, int uses_interp)
>  	vvar_size =3D gic_size + PAGE_SIZE;
>  	size =3D vvar_size + image->size;
> =20
> +	/*
> +	 * Find a region that's large enough for us to perform the
> +	 * colour-matching alignment below.
> +	 */
> +	if (cpu_has_dc_aliases)
> +		size +=3D shm_align_mask + 1;
> +
>  	base =3D get_unmapped_area(NULL, 0, size, 0, 0);
>  	if (IS_ERR_VALUE(base)) {
>  		ret =3D base;
>  		goto out;
>  	}
> =20
> +	/*
> +	 * If we suffer from dcache aliasing, ensure that the VDSO data page =
is
> +	 * coloured the same as the kernel's mapping of that memory. This
> +	 * ensures that when the kernel updates the VDSO data userland will s=
ee
> +	 * it without requiring cache invalidations.
> +	 */
> +	if (cpu_has_dc_aliases) {
> +		base =3D __ALIGN_MASK(base, shm_align_mask);
> +		base +=3D ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
> +	}
> +
>  	data_addr =3D base + gic_size;
>  	vdso_addr =3D data_addr + PAGE_SIZE;
> =20
>=20



--kjtjX3Kdmgnm580uF66lOQMUvo8fywno3--

--5iC99q6WkDx4ZpJlEs64Pmjzpo9iVupJi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluJWtgACgkQ8bdnhZyy
68do2gf/V2CsAsxi9e9jIkFPuGxRv4zVB0olAS+vc4ksGwn1Wzk2oVWfYcbGsbgY
xTUdB11D9DyQ3ybldeUUUNII9gkvakqDcn950JCqHgWJjQForAZG0KyK2/8Hqm3b
dhMmT1B/VOxtrYCgXsck4StIQqnujIEuz8HmrEp8MI3ZkMKiECUvExnmVQFkoq8X
Fq9cJDcVtQY+VHhaYwHq9Asksz9+Px2uD3l0hoNSKAimXD49mrZoLyoujzqbhYX7
c4GatoFaqYGsG7zVJ+IWl4vPsC6weLPiKWuupSeI6Vz74nHqos8WUhVrpS/3Ad18
nR5JZlMYayTIp9HueO7ZTuWg/sAj4g==
=wCJB
-----END PGP SIGNATURE-----

--5iC99q6WkDx4ZpJlEs64Pmjzpo9iVupJi--

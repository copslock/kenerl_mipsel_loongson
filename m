Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2016 16:28:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16342 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992241AbcIEO2E504Td (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Sep 2016 16:28:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0C25441F8E58;
        Mon,  5 Sep 2016 15:27:58 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 05 Sep 2016 15:27:58 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 05 Sep 2016 15:27:58 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8AF33F80A33ED;
        Mon,  5 Sep 2016 15:27:54 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Sep
 2016 15:27:57 +0100
Date:   Mon, 5 Sep 2016 15:27:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] MIPS: c-r4k: Fix size calc when avoiding IPIs for small
 icache flushes
Message-ID: <20160905142757.GD25853@jhogan-linux.le.imgtec.org>
References: <20160905142454.30530-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20160905142454.30530-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 03:24:54PM +0100, Paul Burton wrote:
> Commit f70ddc07b637 ("MIPS: c-r4k: Avoid small flush_icache_range SMP
> calls") adds checks to force use of hit-type cache ops for small icache
> flushes where they are globalised & index-type cache ops aren't, in
> order to avoid the overhead of IPIs in those cases. However it
> calculated the size of the region being flushed incorrectly, subtracting
> the end address from the start address rather than the reverse. This
> would have led to an overflow with size wrapping round to some large
> value, and likely to the special case for avoiding IPIs not actually
> being hit.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Fixes: f70ddc07b637 ("MIPS: c-r4k: Avoid small flush_icache_range SMP cal=
ls")

Good catch Paul! I've no idea how that happened.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Ralf: It'd be great to get this into v4.8 if possible.

Thanks
James

> ---
>=20
>  arch/mips/mm/c-r4k.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 1af381f..69b1f10 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -811,7 +811,7 @@ static void __r4k_flush_icache_range(unsigned long st=
art, unsigned long end,
>  		 * If address-based cache ops don't require an SMP call, then
>  		 * use them exclusively for small flushes.
>  		 */
> -		size =3D start - end;
> +		size =3D end - start;
>  		cache_size =3D icache_size;
>  		if (!cpu_has_ic_fills_f_dc) {
>  			size *=3D 2;
> --=20
> 2.9.3
>=20

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXzYDtAAoJEGwLaZPeOHZ6tgQP/2b+USXMoZ75g8B6JLe5TYyu
M3Y7x00sKwwLQVTjMO7gas9igqiwbaL6kUwSJOOiSe2UTh4MzOlzRLcI+pDmrH/j
cgpm4hMEpim+Ev7uGzSs/8EDj4Pa/79SJqRdHcDm3CSlG1MluGAXbSNFZV3wgQRU
5CqyupYnfLIUTVviJkgPBEa+ycGTy1r3LDzTX0D/7kr+8C86EwyMndx4bRNYWzeJ
RIr8AO30Ur5IKdNGwHBWeEGXYXOcuofQ5tAzo8YGPycwtaPSNB8eWq7qo8q0HSma
PNJjPLhxkAz9TYsd7V6PNtQoU7RUvEoBUX5Fw6bkJ5M8yTVGpHghYbeotA/NeRSj
AZNrnVE277d8v9Z+N5+hmmoQJyuezjG9TSbapwB0bIvaJg/6AA+1ckewLZVATqJi
VqHUuZiReZ8VxgRGascTl/e5J4ba9jGV/k9Gm5AnaHpdTdg2oSgegNPyfN7wddR1
ALWsd39hY0eXW1Wr+kT7KgFsT/pyNtLYaGtMbisq1SA0KywIfPyV3HxWjuJ9d5cM
rO+FJeSdP7xnNwxbmI8u7TbER1xp3y3LUTuId+wJKTIKhGY5ohXJZF4ekAzr0mQa
JZX9jDw1ARnfquvn4Aa9M3ZrCg4Dk6+wcwFd+91pu7vcnM0fL/quZOwmi86OtDXN
hOrrR13PXxc8MkIBh9fZ
=jz90
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--

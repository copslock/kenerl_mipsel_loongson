Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 23:19:34 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994664AbeBSWTVcqtDR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Feb 2018 23:19:21 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC7A2177E;
        Mon, 19 Feb 2018 22:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC7A2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 19 Feb 2018 22:19:06 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "# 3 . 15+" <stable@vger.kernel.org>
Subject: Re: [PATCH V2 04/12] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Message-ID: <20180219221906.GB6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023145-14293-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1517023145-14293-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62626
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


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:19:05AM +0800, Huacai Chen wrote:
> For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
> only flush Node-0's scache. So we add r4k_blast_scache_node() by using
> (CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
> start address.
>=20
> Cc: <stable@vger.kernel.org> # 3.15+
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/r4kcache.h | 34 ++++++++++++++++++++++++++++++++
>  arch/mips/mm/c-r4k.c             | 42 +++++++++++++++++++++++++++++++++-=
------
>  2 files changed, 69 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4k=
cache.h
> index 7f12d7e..c1f2806 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -747,4 +747,38 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_I=
nv_SD, , )
>  __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
>  __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
> =20
> +#ifndef pa_to_nid
> +#define pa_to_nid(addr) 0
> +#endif
> +
> +#ifndef NODE_ADDRSPACE_SHIFT

To be sure you get the right definition of both of these if they exist,
and wherever this header is included, we should explicitly #include the
appropriate header (asm/mmzone.h?) from this header.

> +#define nid_to_addrbase(nid) 0
> +#else
> +#define nid_to_addrbase(nid) (nid << NODE_ADDRSPACE_SHIFT)

Technically this should have parentheses around nid.

It seems slightly inconsistent to have pa_to_nid() defined in mmzone.h,
but not the reverse nid_to_addrbase(). NODE_ADDRSPACE_SHIFT is very
loongson specific afterall.

Would it make sense to move it into
arch/mips/include/asm/mach-loongson64/mmzone.h and put the 0 definition
in #ifndef nid_to_addrbase?

> +#endif
> +
> +#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)	\

I think this is worthy of a quick comment to explain that this is very
specific to Loongson3.

>  #endif /* _ASM_R4KCACHE_H */
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 6f534b20..155f5f5 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c

=2E..

> @@ -480,6 +497,10 @@ static inline void local_r4k___flush_cache_all(void =
* args)
>  		r4k_blast_scache();
>  		break;
> =20
> +	case CPU_LOONGSON3:
> +		r4k_blast_scache_node(get_ebase_cpunum() >> 2);

I assume this can't use cpu_to_node() because it needs to work even when
NUMA=3Dn? If so, I think it deserves a brief comment to explain that.

> +		break;
> +
>  	case CPU_BMIPS5000:
>  		r4k_blast_scache();
>  		__sync();
> @@ -839,9 +860,12 @@ static void r4k_dma_cache_wback_inv(unsigned long ad=
dr, unsigned long size)
> =20
>  	preempt_disable();
>  	if (cpu_has_inclusive_pcaches) {
> -		if (size >=3D scache_size)
> -			r4k_blast_scache();
> -		else
> +		if (size >=3D scache_size) {
> +			if (current_cpu_type() !=3D CPU_LOONGSON3)
> +				r4k_blast_scache();
> +			else
> +				r4k_blast_scache_node(pa_to_nid(addr));

If I read this right, addr is a virtual address so this feels a bit
hacky, but I suppose its harmless since it'll probably always be memory
in xkphys space where pa_to_nid() will do the right thing. Perhaps a
comment along the lines of:
/* This assumes that addr is in XKPhys */

> +		} else

Please keep braces consistent, i.e. add to the trailing else statement
too.

Other than those niggles, the actual mechanism looks reasonable to me.

Thanks
James

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqLTVQACgkQbAtpk944
dno60w/7BVWyDh7C6Ta3WbzQ7sRDj+/TySq0AuMWiK5Ii+vs4HLET/As3t2EqOTC
z1qVyvT9hdXz5zEQ0anxw6z/r2k21b75GzQmmSY0antZ/BNw/wJQyv7/io1Zcwli
RMy0e00SB6YerbTBJMeCft9T2UtzB9WF8aDOaUgaQjXtPd2KX3tmpsfKf3S9A7Sk
GAbp1NvpI1hGvV1skhslIhe6g8eATY+lxz7BeDLWYfKEI7oWugPH8tqY4a5za1mN
0iAeRWwbaZmUmLGw1Y2wB/W7tIlLgjK3XBWWt9wmB0qPEDsG1IYETzGfvQj+kzWG
VpMuKigTFIYCbIq8Byb1xPjZsbfzJLMtZlx9t8Hb+zUWyZfpV+vF/+eREnOHSnhc
4ARNJOuefILi/RC24lrdd90huH/El7R0Af9kZW9/z7ZUjfVC4OAJfapFTt5vYlRM
hNPladJ4wx2t4sJPmVgCHympDX/D2ByIBl7hl86aL9HJVhaRwwquDKWa/U+MiVXq
9yB06fCMLhCCizUyJaZwF+Zr3Dv6aJiWfaLe1CJYAZw/vK0dDFETm9FFMNi+2Gf2
ySwnWvutvb7P9HTDZvMZo1QKg7GDiYy41KR2+Jiy+FG4POC6aqU9xtcHKfk3VV84
7CvyInzCboUkTFl/aZPFpwjT8UYPiDUA/Z8sHQxPt0BLRqOnmAc=
=oxtR
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

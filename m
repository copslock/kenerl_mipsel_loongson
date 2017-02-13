Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 23:39:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5072 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993543AbdBMWjfAAHR7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2017 23:39:35 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D8C0F41F8EBB;
        Mon, 13 Feb 2017 23:43:24 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Feb 2017 23:43:24 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Feb 2017 23:43:24 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E51D7EB5D5003;
        Mon, 13 Feb 2017 22:39:24 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 13 Feb
 2017 22:39:28 +0000
Date:   Mon, 13 Feb 2017 22:39:28 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] IP27: Fix spaces.h to prevent a build error
Message-ID: <20170213223928.GN24226@jhogan-linux.le.imgtec.org>
References: <a6e09082-643a-b8f6-8a48-0783309f482a@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sy9WyBOsCRoUO165"
Content-Disposition: inline
In-Reply-To: <a6e09082-643a-b8f6-8a48-0783309f482a@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56796
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

--sy9WyBOsCRoUO165
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Sat, Jan 28, 2017 at 11:32:10PM -0500, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
>=20
> Fix IP27's spaces.h file to avoid the below build error:
>=20
>     CC      arch/mips/vdso/gettimeofday-o32.o
>   In file included from ./arch/mips/include/asm/mach-ip27/spaces.h:29:0,
>                    from ./arch/mips/include/asm/page.h:12,
>                    from arch/mips/vdso/vdso.h:26,
>                    from arch/mips/vdso/gettimeofday.c:11:
>   ./arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" r=
edefined [-Werror]
>    #define CAC_BASE  _AC(0x80000000, UL)
>  =20
>   In file included from ./arch/mips/include/asm/page.h:12:0,
>                    from arch/mips/vdso/vdso.h:26,
>                    from arch/mips/vdso/gettimeofday.c:11:
>   ./arch/mips/include/asm/mach-ip27/spaces.h:22:0: note: this is the loca=
tion of the previous definition
>    #define CAC_BASE  0xa800000000000000
>  =20
>   cc1: all warnings being treated as errors
>   make[2]: *** [arch/mips/vdso/Makefile:117: arch/mips/vdso/gettimeofday-=
o32.o] Error 1
>   make[1]: *** [scripts/Makefile.build:551: arch/mips/vdso] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>=20
> Fixes include using the _AC() constant to protect addresses if used in
> assembly and wrapping the addresses with a CONFIG_64BIT ifdef.
>=20
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>

FYI, this similar patch is already applied:

https://patchwork.linux-mips.org/patch/15039/

If you need _AC around them for assembly use, please submit a new patch.

Thanks
James

> ---
>  arch/mips/include/asm/mach-ip27/spaces.h |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> linux-mips-4.10-ip27-fix-spaces_h.patch
> diff --git a/arch/mips/include/asm/mach-ip27/spaces.h b/arch/mips/include=
/asm/mach-ip27/spaces.h
> index 4775a1136a5b..27d32da8442c 100644
> --- a/arch/mips/include/asm/mach-ip27/spaces.h
> +++ b/arch/mips/include/asm/mach-ip27/spaces.h
> @@ -10,21 +10,24 @@
>  #ifndef _ASM_MACH_IP27_SPACES_H
>  #define _ASM_MACH_IP27_SPACES_H
> =20
> +#include <linux/const.h>
> +
>  /*
>   * IP27 uses the R10000's uncached attribute feature.  Attribute 3 selec=
ts
>   * uncached memory addressing.
>   */
> -
> -#define HSPEC_BASE		0x9000000000000000
> -#define IO_BASE			0x9200000000000000
> -#define MSPEC_BASE		0x9400000000000000
> -#define UNCAC_BASE		0x9600000000000000
> -#define CAC_BASE		0xa800000000000000
> +#ifdef CONFIG_64BIT
> +#define HSPEC_BASE		_AC(0x9000000000000000, UL)
> +#define IO_BASE			_AC(0x9200000000000000, UL)
> +#define MSPEC_BASE		_AC(0x9400000000000000, UL)
> +#define UNCAC_BASE		_AC(0x9600000000000000, UL)
> +#define CAC_BASE		_AC(0xa800000000000000, UL)
> =20
>  #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
>  #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))
> =20
>  #define HIGHMEM_START		(~0UL)
> +#endif /* CONFIG_64BIT */
> =20
>  #include <asm/mach-generic/spaces.h>
> =20
>=20

--sy9WyBOsCRoUO165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYojWgAAoJEGwLaZPeOHZ6PiwP/A0+BKu46TYohzW9WIge+1uh
yrbkP5bT16sMwRMSQWYMmx4VrafJ82IrOWscQaopsvGUFw+0V/NZNDg4EzUNc0g3
9ZdQs3s9w5nis6ArxnTRER9vh9PFAyZqTyilDlnZdXNYEa362xkD3Bj+pfac6oFd
3z8LskNy/qNhMKU7SYeU7MGvPq/RZegI7+YWnRLGMZyB5Tlwq670ZGeaUBfF2EXJ
TNdN79OQlxlFgiDHSRcphwVXNiuOhIcQBePThgfGPCMbdALF8DjA3+llygEU72GW
c5YQiroi8x8m6QHoiKzzr7n3fSCrq0Lymzmil3TV9+70nRTVwlKHRYlbNXJQnZUq
ZLK9VKC+XkzSFRd1Ny1RvVPjplMs0cmlQ/rf3GvOZnvf++NW2SH8I+5GHXbHaWF7
+2aFt4ZQwbOZTTbec+Ctc+kyI5UgUIHNOitFtzNsEsgwlPi7xuyaJG+3fxY4VeAv
8MNVLp3LiRMzrAiDJFMoGT+yQnP/b2lDeAdGFzmj4P9wNkZVl9jxqaJDKAAG1JwI
krAJIFAsDRG1gaFfQZkKplwwY4MtPO2nGyo+IRR3NoOnOwtsMMFnBcjgmn6CTr5+
vnHSJoBa9dRxsUYL0Nm+MaczaTO/n8fJlbdfElCK3j1NcmMdMcY0r9i7kGeEXf9O
KJ16N+yYBGw6vtoxawcr
=g2so
-----END PGP SIGNATURE-----

--sy9WyBOsCRoUO165--

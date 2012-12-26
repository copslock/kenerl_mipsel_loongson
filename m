Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 01:34:00 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:33923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823111Ab2LZAd4OTJPN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Dec 2012 01:33:56 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 25 Dec 2012 16:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,354,1355126400"; 
   d="asc'?scan'208";a="266912831"
Received: from blue.fi.intel.com ([10.237.72.156])
  by fmsmga001.fm.intel.com with ESMTP; 25 Dec 2012 16:33:46 -0800
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 21770E0073; Wed, 26 Dec 2012 02:34:35 +0200 (EET)
Date:   Wed, 26 Dec 2012 02:34:35 +0200
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org
Subject: Re: 3.8-rc1 build failure with MIPS/SPARSEMEM
Message-ID: <20121226003434.GA27760@otc-wbsnb-06>
References: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 22, 2012 at 02:27:57PM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> It looks like commit 816422ad76474fed8052b6f7b905a054d082e59a
> (asm-generic, mm: pgtable: consolidate zero page helpers) broke
> MIPS/SPARSEMEM build in 3.8-rc1:
>=20
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   Checking missing-syscalls for N32
>   CC      arch/mips/kernel/asm-offsets.s
> In file included from /home/aaro/git/linux/arch/mips/include/asm/pgtable.=
h:388:0,
>                  from include/linux/mm.h:44,
>                  from arch/mips/kernel/asm-offsets.c:14:
> include/asm-generic/pgtable.h: In function 'my_zero_pfn':
> include/asm-generic/pgtable.h:462:9: error: implicit declaration of funct=
ion 'page_to_section' [-Werror=3Dimplicit-function-declaration]
> In file included from arch/mips/kernel/asm-offsets.c:14:0:
> include/linux/mm.h: At top level:
> include/linux/mm.h:708:29: error: conflicting types for 'page_to_section'
> In file included from /home/aaro/git/linux/arch/mips/include/asm/pgtable.=
h:388:0,
>                  from include/linux/mm.h:44,
>                  from arch/mips/kernel/asm-offsets.c:14:
> include/asm-generic/pgtable.h:462:9: note: previous implicit declaration =
of 'page_to_section' was here
> cc1: some warnings being treated as errors
> make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
> make: *** [archprepare] Error 2

The patch below works for me. Could you try?

=46rom a123a406fdc3aee7ca0eae04b6b4a231872dbb51 Mon Sep 17 00:00:00 2001
=46rom: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 26 Dec 2012 03:19:55 +0300
Subject: [PATCH] asm-generic, mm: pgtable: convert my_zero_pfn() to macros =
to
 fix build
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

On MIPS if SPARSEMEM is enabled we've got this:

In file included from /home/kas/git/public/linux/arch/mips/include/asm/pgta=
ble.h:552,
                 from include/linux/mm.h:44,
                 from arch/mips/kernel/asm-offsets.c:14:
include/asm-generic/pgtable.h: In function =E2=80=98my_zero_pfn=E2=80=99:
include/asm-generic/pgtable.h:466: error: implicit declaration of function =
=E2=80=98page_to_section=E2=80=99
In file included from arch/mips/kernel/asm-offsets.c:14:
include/linux/mm.h: At top level:
include/linux/mm.h:738: error: conflicting types for =E2=80=98page_to_secti=
on=E2=80=99
include/asm-generic/pgtable.h:466: note: previous implicit declaration of =
=E2=80=98page_to_section=E2=80=99 was here

Due header files inter-dependencies, the only way I see to fix it is
convert my_zero_pfn() for __HAVE_COLOR_ZERO_PAGE to macros.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 include/asm-generic/pgtable.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 701beab..5cf680a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -461,10 +461,8 @@ static inline int is_zero_pfn(unsigned long pfn)
 	return offset_from_zero_pfn <=3D (zero_page_mask >> PAGE_SHIFT);
 }
=20
-static inline unsigned long my_zero_pfn(unsigned long addr)
-{
-	return page_to_pfn(ZERO_PAGE(addr));
-}
+#define my_zero_pfn(addr)	page_to_pfn(ZERO_PAGE(addr))
+
 #else
 static inline int is_zero_pfn(unsigned long pfn)
 {
--=20
1.8.0.2

--=20
 Kirill A. Shutemov

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2kYaAAoJEAd+omnVudOMDEgP/iUqZr7TalBS0Wz0s0kXnF6Q
fZkCIZInO98chygGuCZWo/3OggufeaLopnhDazJN4jSkxPwLDWTGlcIJCSZh4vNK
hc/ojg3UOb28u9gRDQDDoPxrzIFFIKZTZXb6NAE3nVsv/3xNy3lNRwnPxUIwmnjY
cGyV37H6Eofi4E5d/MEIvoO/DbfBy8Aa4ZJ2/aasbbJE2o0jnvaL9Wji1zJfCj+X
ZD3dUvchrddzSzkL0K7KJ4If2euCIy1xiiIm6hQgCio9BXHTNzgj2mwkBwWe0JSl
KMYXSGbwv5FrAa8r4wdWW/VxIQavXZtaO05zkGsLe1wdLStJ/Z4YKZoBbvX6YU4V
IbDd0Zg230pO7Rf0dsdCUfJE43kUFresPV88rTlYKjhM8nKqVUSpHeROTtePZUBX
fbgUT1QLXMWgGnCljiPWxQtm5tHunHIycZwIO7N8sq+f42IxSOMQG6j4Z3KCR/iG
MT0c4RYFpsSvdy5DPvSY75kdPzQDjK/VQta7SEMWp1URpISOQ8yZyAp0XrhhUwXu
4Kfiig+pp0QNkvtO7TNJCxHxQVkKn8u2YWj7+KS6P7IMp8bgY8FVdBSNf3VTH6d9
2/iL4Dblezjabc3esav4wW5Wirpe2/GZzEa3nK2dlJm7QTPlZbaM5P3FdFvGAIBK
wvYS/w1LURzEbwIEz/zT
=1Y63
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

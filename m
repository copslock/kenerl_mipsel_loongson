Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 14:23:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55177 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992215AbcIGMXjda0me (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 14:23:39 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 15E6E41F8DBB;
        Wed,  7 Sep 2016 13:23:34 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 07 Sep 2016 13:23:34 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 07 Sep 2016 13:23:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 39592BE973A0D;
        Wed,  7 Sep 2016 13:23:30 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 7 Sep
 2016 13:23:33 +0100
Date:   Wed, 7 Sep 2016 13:23:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: vDSO: Fix Malta EVA mapping to vDSO page structs
Message-ID: <20160907122332.GB1196@jhogan-linux.le.imgtec.org>
References: <49347b5b8c218600ffddb91e651274af476fe6e6.1472731205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <49347b5b8c218600ffddb91e651274af476fe6e6.1472731205.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55060
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

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On Thu, Sep 01, 2016 at 01:04:25PM +0100, James Hogan wrote:
> The page structures associated with the vDSO pages in the kernel image
> are calculated using virt_to_page(), which uses __pa() under the hood to
> find the pfn associated with the virtual address. The vDSO data pointers
> however point to kernel symbols, so __pa_symbol() should really be used
> instead.
>=20
> Since there is no equivalent to virt_to_page() which uses __pa_symbol(),
> fix init_vdso_image() to work directly with pfns, calculated with
> PHYS_PFN(__pa_symbol(...)).
>=20
> This issue broke the Malta Enhanced Virtual Addressing (EVA)
> configuration which has a non-default implementation of __pa_symbol().
> This is because it uses a physical alias so that the kernel executes
> from KSeg0 (VA 0x80000000 -> PA 0x00000000), while RAM is provided to
> the kernel in the KUSeg range (VA 0x00000000 -> PA 0x80000000) which
> uses the same underlying RAM.
>=20
> Since there are no page structures associated with the low physical
> address region, some arbitrary kernel memory would be interpreted as a
> page structure for the vDSO pages and badness ensues.
>=20
> Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.4.x-
> ---
>  arch/mips/kernel/vdso.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 9abe447a4b48..e4a8d8846eac 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -39,16 +39,16 @@ static struct vm_special_mapping vdso_vvar_mapping =
=3D {
>  static void __init init_vdso_image(struct mips_vdso_image *image)
>  {
>  	unsigned long num_pages, i;
> +	unsigned long data_pfn;
> =20
>  	BUG_ON(!PAGE_ALIGNED(image->data));
>  	BUG_ON(!PAGE_ALIGNED(image->size));
> =20
>  	num_pages =3D image->size / PAGE_SIZE;
> =20
> -	for (i =3D 0; i < num_pages; i++) {
> -		image->mapping.pages[i] =3D
> -			virt_to_page(image->data + (i * PAGE_SIZE));
> -	}
> +	data_pfn =3D PHYS_PFN(__pa_symbol(image->data));

Actually PHYS_PFN() was only added in v4.5, and we need this patch
applied as far back as v4.4, so I'll send a v2 using __phys_to_pfn()
instead.

Cheers
James

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0AbEAAoJEGwLaZPeOHZ6HykP/jx+Pmep1ZXGtc0dDpbyh8ML
+MhyhzwdeL4rJbCrdLkNgCTKzeRwYh8CCt3qJBm7bVydAztyb49mYcUTqCM2ptT8
eBKoub+mentuzKUzlAGKeugytntNeAcMqrzSSs9AnRjnKz/PdhbPiV+RMum4cvH5
vAqq4G7godwFEJAspGWknL1LJzxS1z+2hJwj/QN38+zD4lBMSiDjtOrXcJGwI6D0
lGlAI5zWqAeTLln1wXqT79EF4ZEbgP8ETrffEMgYuNtuMehF9uwyXh3/enIqq5Ed
u9CDbb0sLTtpEd8oQ7ecE4kpjyDy7L9xE9WD/9mZQFFWrihx7Ytt81vkA9CXCTyp
1C7eGVuJjZ1tGLNzsJpAx87fuZaaOOT677+9qyaPqmoBHmtYbYy0GMkXrseziiC1
WbBNOcS+a3fzSsaH9OzTuTb9IqRNx8HOEXqvyJb+qIDjemivV6iYB5CgaSoTiD1t
TqNRpUsqv6qWCbHxRT0C5v7h0OthI+Sq37hvLRT8dQSiUxZJ6IAOh58EcizGuRPK
uM/m8zPLvygDfJ+VmXzcpK0XgQKHsr4q0OMNIXcypH2cTC+i0bFVNucYCAV4vcvs
t9Q2QvGroTTHWB5M6dNg3cq05/wQYca7kEmEqumLVwoHiy0MTGNCV0iFSo4YE/x/
RUqaCxrcTeuoHGrkaAfw
=JoN5
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--

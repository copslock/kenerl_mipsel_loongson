Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 01:17:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58142 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026731AbcDOXQ7vVlP8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 01:16:59 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7859B41F8D89;
        Sat, 16 Apr 2016 00:16:54 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 16 Apr 2016 00:16:54 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 16 Apr 2016 00:16:54 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id B93616D73181E;
        Sat, 16 Apr 2016 00:16:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Sat, 16 Apr 2016 00:16:53 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Sat, 16 Apr
 2016 00:16:53 +0100
Date:   Sat, 16 Apr 2016 00:16:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] MIPS: mm: Unify pte_page definition
Message-ID: <20160415231653.GK7859@jhogan-linux.le.imgtec.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-7-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline
In-Reply-To: <1460716620-13382-7-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53019
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

--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:36:54AM +0100, Paul Burton wrote:
> The same definition for pte_page is duplicated for the MIPS32
> PHYS_ADDR_T_64BIT case & the generic case. Unify them by moving a single
> definition outside of preprocessor conditionals.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>=20
>  arch/mips/include/asm/pgtable-32.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/p=
gtable-32.h
> index 832e216..181bd8e 100644
> --- a/arch/mips/include/asm/pgtable-32.h
> +++ b/arch/mips/include/asm/pgtable-32.h
> @@ -104,7 +104,7 @@ static inline void pmd_clear(pmd_t *pmdp)
>  }
> =20
>  #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> -#define pte_page(x)		pfn_to_page(pte_pfn(x))
> +
>  #define pte_pfn(x)		(((unsigned long)((x).pte_high >> _PFN_SHIFT)) | (un=
signed long)((x).pte_low << _PAGE_PRESENT_SHIFT))
>  static inline pte_t
>  pfn_pte(unsigned long pfn, pgprot_t prot)
> @@ -120,8 +120,6 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
> =20
>  #else
> =20
> -#define pte_page(x)		pfn_to_page(pte_pfn(x))
> -
>  #ifdef CONFIG_CPU_VR41XX
>  #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
>  #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_va=
l(prot))
> @@ -131,6 +129,8 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
>  #endif
>  #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32=
) */
> =20
> +#define pte_page(x)		pfn_to_page(pte_pfn(x))
> +
>  #define __pgd_offset(address)	pgd_index(address)
>  #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-=
1))
>  #define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-=
1))
> --=20
> 2.8.0
>=20

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXEXZlAAoJEGwLaZPeOHZ6QRwP/j2/X9XM4Y48OY0n9w72iKBR
fqBkr2PT27dTmliEpTgEqgMi1KO1Zapq37iMlPLVVWlealHZ0TJFWg3jMvgWuX42
vVmiWyK8Ws/HrJcYw7To5uYkpP7lwVuKDDF6OW/3+j2mXi4eVp3cCYrofw+USE1V
fToS/HfpJE91Fuhp4VjIHVdpxTBw4sgWrHfR9nLUhSBxyJE3+kEYatHR85LzNQGE
xJoCpqpOIcCA6a5yunWxsnJeuMQrIni/q+JPXKxi8orYcDXjU4i17f3WFsl4AUNl
bDw8AVEQHUe88yVLTbFz8VJbKbk3hT34YfqQYpFV9L5N3KB2jtEjE9gIeCeEMnwH
ivob2Pp+vSjfzY93za55XvPOGJ5ht3FraohQoS3tBLYz7CMEcG5oJyQKxH8Y5KeX
F/A/oC3Tqu3Wel2GqjTxWyuNJOZ1YWXjCgz08SmHpHNaL7JdbIOkLqnj79Kgsrca
gmMlVblLhZu87lNAI4HFAJL5zXrL6BXIHJVwj4V1m1WnOq6785wy9YYPA7q2r0tD
CXHaONUbemt4mV/FWqfQT4WwcSAxizpzbwc08J2+ggKWTOTHlwkofRuX+yyQUoU0
DJmoPJeWXVjRqrKyLm1GIez8uK/LE/8ekvM5hbPUBccGfuxdNezwo2CPOIqk1/9D
FogaEx82SYrEyILbiwGI
=BBva
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--

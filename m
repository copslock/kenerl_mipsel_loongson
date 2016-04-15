Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 23:22:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24356 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026713AbcDOVWHFulab (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 23:22:07 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A4FD741F8D93;
        Fri, 15 Apr 2016 22:22:01 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 15 Apr 2016 22:22:01 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 15 Apr 2016 22:22:01 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id B7CAE57BC86E0;
        Fri, 15 Apr 2016 22:21:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 22:22:01 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 22:22:00 +0100
Date:   Fri, 15 Apr 2016 22:22:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, "Adam
 Buchbinder" <adam.buchbinder@gmail.com>, David Daney
        <david.daney@cavium.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul
 Gortmaker <paul.gortmaker@windriver.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Markos Chandras
        <markos.chandras@imgtec.com>, Alex Smith <alex.smith@imgtec.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 05/12] MIPS: mm: Standardise on _PAGE_NO_READ, drop
 _PAGE_READ
Message-ID: <20160415212200.GG7859@jhogan-linux.le.imgtec.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-6-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <1460716620-13382-6-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53015
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

--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:36:53AM +0100, Paul Burton wrote:
> Ever since support for RI/XI was implemented by commit 6dd9344cfc41
> ("MIPS: Implement Read Inhibit/eXecute Inhibit") we've had a mixture of
> _PAGE_READ & _PAGE_NO_READ bits. Rather than keep both around, switch
> away from using _PAGE_READ to determine page presence & instead invert
> the use to _PAGE_NO_READ. Wherever we formerly had no definition for
> _PAGE_NO_READ, change what was _PAGE_READ to _PAGE_NO_READ. The end
> result is that we consistently use _PAGE_NO_READ to determine whether a
> page is readable, regardless of whether RI/XI is implemented.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  arch/mips/include/asm/pgtable-bits.h | 19 ++++---------------
>  arch/mips/include/asm/pgtable.h      | 23 +++++++----------------
>  arch/mips/mm/tlbex.c                 | 13 ++++---------
>  3 files changed, 15 insertions(+), 40 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm=
/pgtable-bits.h
> index c81fc17..5bc663d 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -49,7 +49,6 @@ enum pgtable_bits {
> =20
>  	/* Used only by software (masked out before writing EntryLo*) */
>  	_PAGE_PRESENT_SHIFT =3D 24,
> -	_PAGE_READ_SHIFT,
>  	_PAGE_WRITE_SHIFT,
>  	_PAGE_ACCESSED_SHIFT,
>  	_PAGE_MODIFIED_SHIFT,
> @@ -66,7 +65,7 @@ enum pgtable_bits {
>  enum pgtable_bits {
>  	/* Used only by software (writes to EntryLo ignored) */
>  	_PAGE_PRESENT_SHIFT,
> -	_PAGE_READ_SHIFT,
> +	_PAGE_NO_READ_SHIFT,
>  	_PAGE_WRITE_SHIFT,
>  	_PAGE_ACCESSED_SHIFT,
>  	_PAGE_MODIFIED_SHIFT,
> @@ -85,7 +84,7 @@ enum pgtable_bits {
>  	/* Used only by software (masked out before writing EntryLo*) */
>  	_PAGE_PRESENT_SHIFT,
>  #if !defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_MIPSR6)
> -	_PAGE_READ_SHIFT,
> +	_PAGE_NO_READ_SHIFT,
>  #endif
>  	_PAGE_WRITE_SHIFT,
>  	_PAGE_ACCESSED_SHIFT,
> @@ -98,7 +97,6 @@ enum pgtable_bits {
>  #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
>  	_PAGE_NO_EXEC_SHIFT,
>  	_PAGE_NO_READ_SHIFT,
> -	_PAGE_READ_SHIFT =3D _PAGE_NO_READ_SHIFT,
>  #endif
>  	_PAGE_GLOBAL_SHIFT,
>  	_PAGE_VALID_SHIFT,
> @@ -110,11 +108,6 @@ enum pgtable_bits {
> =20
>  /* Used only by software */
>  #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
> -#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
> -# define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
> -#else
> -# define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
> -#endif
>  #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
>  #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
>  #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
> @@ -125,11 +118,10 @@ enum pgtable_bits {
>  /* Used by TLB hardware (placed in EntryLo*) */
>  #if (defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32))
>  # define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
> -# define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
>  #elif defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
>  # define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
> -# define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_NO_READ_SHIFT) : 0)
>  #endif
> +#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
>  #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
>  #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
>  #define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
> @@ -145,9 +137,6 @@ enum pgtable_bits {
>  #ifndef _PAGE_NO_EXEC
>  #define _PAGE_NO_EXEC		0
>  #endif
> -#ifndef _PAGE_NO_READ
> -#define _PAGE_NO_READ		0
> -#endif
> =20
>  #define _PAGE_SILENT_READ	_PAGE_VALID
>  #define _PAGE_SILENT_WRITE	_PAGE_DIRTY
> @@ -245,7 +234,7 @@ static inline uint64_t pte_to_entrylo(unsigned long p=
te_val)
>  #define _CACHE_UNCACHED_ACCELERATED	(7<<_CACHE_SHIFT)
>  #endif
> =20
> -#define __READABLE	(_PAGE_SILENT_READ | _PAGE_READ | _PAGE_ACCESSED)
> +#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED)
>  #define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
> =20
>  #define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgta=
ble.h
> index 9a4fe01..1459ee9 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -23,18 +23,19 @@
>  struct mm_struct;
>  struct vm_area_struct;
> =20
> -#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
> -#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | \
> +#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
> +				 _CACHE_CACHABLE_NONCOHERENT)
> +#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
>  				 _page_cachable_default)
> -#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_NO_EXEC | \
> +#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
>  				 _page_cachable_default)
> -#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_READ | \
> +#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
>  				 _page_cachable_default)
>  #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
>  				 _PAGE_GLOBAL | _page_cachable_default)
>  #define PAGE_KERNEL_NC	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE=
 | \
>  				 _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
> -#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> +#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
>  				 _page_cachable_default)
>  #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
>  			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
> @@ -307,7 +308,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
>  static inline pte_t pte_mkyoung(pte_t pte)
>  {
>  	pte.pte_low |=3D _PAGE_ACCESSED;
> -	if (pte.pte_low & _PAGE_READ)
> +	if (!(pte.pte_low & _PAGE_NO_READ))
>  		pte.pte_high |=3D _PAGE_SILENT_READ;
>  	return pte;
>  }
> @@ -353,13 +354,8 @@ static inline pte_t pte_mkdirty(pte_t pte)
>  static inline pte_t pte_mkyoung(pte_t pte)
>  {
>  	pte_val(pte) |=3D _PAGE_ACCESSED;
> -#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
>  	if (!(pte_val(pte) & _PAGE_NO_READ))
>  		pte_val(pte) |=3D _PAGE_SILENT_READ;
> -	else
> -#endif
> -	if (pte_val(pte) & _PAGE_READ)
> -		pte_val(pte) |=3D _PAGE_SILENT_READ;
>  	return pte;
>  }
> =20
> @@ -542,13 +538,8 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
>  {
>  	pmd_val(pmd) |=3D _PAGE_ACCESSED;
> =20
> -#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
>  	if (!(pmd_val(pmd) & _PAGE_NO_READ))
>  		pmd_val(pmd) |=3D _PAGE_SILENT_READ;
> -	else
> -#endif
> -	if (pmd_val(pmd) & _PAGE_READ)
> -		pmd_val(pmd) |=3D _PAGE_SILENT_READ;
> =20
>  	return pmd;
>  }
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 86aa7c2..7e3272f 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -234,20 +234,16 @@ static void output_pgtable_bits_defines(void)
>  	pr_debug("\n");
> =20
>  	pr_define("_PAGE_PRESENT_SHIFT %d\n", _PAGE_PRESENT_SHIFT);
> -	pr_define("_PAGE_READ_SHIFT %d\n", _PAGE_READ_SHIFT);
> +	pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
>  	pr_define("_PAGE_WRITE_SHIFT %d\n", _PAGE_WRITE_SHIFT);
>  	pr_define("_PAGE_ACCESSED_SHIFT %d\n", _PAGE_ACCESSED_SHIFT);
>  	pr_define("_PAGE_MODIFIED_SHIFT %d\n", _PAGE_MODIFIED_SHIFT);
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
>  #endif
> -#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
> -	if (cpu_has_rixi) {
>  #ifdef _PAGE_NO_EXEC_SHIFT
> +	if (cpu_has_rixi)
>  		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
> -		pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
> -#endif
> -	}
>  #endif
>  	pr_define("_PAGE_GLOBAL_SHIFT %d\n", _PAGE_GLOBAL_SHIFT);
>  	pr_define("_PAGE_VALID_SHIFT %d\n", _PAGE_VALID_SHIFT);
> @@ -1615,9 +1611,8 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
>  			cur =3D t;
>  		}
>  		uasm_i_andi(p, t, cur,
> -			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
> -		uasm_i_xori(p, t, t,
> -			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
> +			(_PAGE_PRESENT | _PAGE_NO_READ) >> _PAGE_PRESENT_SHIFT);
> +		uasm_i_xori(p, t, t, _PAGE_PRESENT >> _PAGE_PRESENT_SHIFT);

This code makes the assumption that _PAGE_READ was always at a higher
bit number than _PAGE_PRESENT, however this isn't true for _PAGE_NO_READ
in the defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
case, where the no read bit will have been shifted off the end of the
register value.

Other than that, I can't fault this patch.

Cheers
James

>  		uasm_il_bnez(p, r, t, lid);
>  		if (pte =3D=3D t)
>  			/* You lose the SMP race :-(*/
> --=20
> 2.8.0
>=20

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXEVt4AAoJEGwLaZPeOHZ6Bp8QALnltkIXJtcKvw7iCMFSdrFm
ojhWPTAhLx077HtJuE/8glomPzKaWjE2MN9yatcD3d+HvRw8vOU7ZmptpNJRPbsJ
XrL9+mdtd2/geXCZEDi4ao8F4npPobl94zJz/UGASGFIme7o9cS1f0lJF9Q8Oysz
/aerYCYilzzvnlmBEatiTANtAx0NkiIgF7CoGMk8SR2x7/gOxlG+SnbL1IIqGGDN
lfNE4igUFeM/KlisbsiqzT6j6GoyrXDwPQghH+ENKlvVaii56ZbG1QpmzPyF1GTP
FsZ5XqjwTbsCchjS3WOplKpTDj1VeO6DK2BJewsF8xBTSaMdZPxiooHAJUaPXTYA
fhkPcqdACE0YRnFntx7iSZADGcccxzqaI0+F5046gONV/PFDPoxy3ZVd5iqPA5AQ
4ZMosqNOp0ipQxpRQPQl6wagIB+IBbPROJVfbZI9JuYzgUXJ6X5h67LuhNIK6vqg
NWPtJHCFADdYgatvBk38KXtGsmx02ivt3YbJWwZTvFKmhce9Gi+eNq8bOCCVZy6X
Fs0+/78Jxm69eCdZNBhgyxa5XrvBXugJjMzVV93fuq7+2DvGLWfVgN+zxTEsxTIL
Jvs3jG9F8mrY7Zu5axROZ1keD4WDnRDPc752qE8qd4oaP+bYMmpA/mo/as3CziuC
8Svai5kog9gG0obidfTp
=CYC5
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 00:29:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13177 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026634AbcDOW3AtAzs8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 00:29:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6E04741F8EF3;
        Fri, 15 Apr 2016 23:28:55 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 15 Apr 2016 23:28:55 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 15 Apr 2016 23:28:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 592CD787F8D90;
        Fri, 15 Apr 2016 23:28:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 23:28:54 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 23:28:54 +0100
Date:   Fri, 15 Apr 2016 23:28:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Adam Buchbinder" <adam.buchbinder@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 09/12] MIPS: mm: Pass scratch register through to iPTE_SW
Message-ID: <20160415222854.GI7859@jhogan-linux.le.imgtec.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-10-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline
In-Reply-To: <1460716620-13382-10-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53017
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

--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:36:57AM +0100, Paul Burton wrote:
> Rather than hardcode a scratch register for the XPA case in iPTE_SW,
> pass one through from the work registers allocated by the caller. This
> allows for the XPA path to function correctly regardless of the work
> registers in use.

Looks good to me, although probably worth mentioning that the current
behaviour uses the $1 register, so this fixes another case of $1
clobbering.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  arch/mips/mm/tlbex.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 004cd9f..d7a7b3d 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1526,14 +1526,12 @@ iPTE_LW(u32 **p, unsigned int pte, unsigned int p=
tr)
> =20
>  static void
>  iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int p=
tr,
> -	unsigned int mode)
> +	unsigned int mode, unsigned int scratch)
>  {
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  	unsigned int hwmode =3D mode & (_PAGE_VALID | _PAGE_DIRTY);
> =20
>  	if (config_enabled(CONFIG_XPA) && !cpu_has_64bits) {
> -		const int scratch =3D 1; /* Our extra working register */
> -
>  		uasm_i_lui(p, scratch, (mode >> 16));
>  		uasm_i_or(p, pte, pte, scratch);
>  	} else
> @@ -1630,11 +1628,11 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
>  /* Make PTE valid, store result in PTR. */
>  static void
>  build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
> -		 unsigned int ptr)
> +		 unsigned int ptr, unsigned int scratch)
>  {
>  	unsigned int mode =3D _PAGE_VALID | _PAGE_ACCESSED;
> =20
> -	iPTE_SW(p, r, pte, ptr, mode);
> +	iPTE_SW(p, r, pte, ptr, mode, scratch);
>  }
> =20
>  /*
> @@ -1670,12 +1668,12 @@ build_pte_writable(u32 **p, struct uasm_reloc **r,
>   */
>  static void
>  build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
> -		 unsigned int ptr)
> +		 unsigned int ptr, unsigned int scratch)
>  {
>  	unsigned int mode =3D (_PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID
>  			     | _PAGE_DIRTY);
> =20
> -	iPTE_SW(p, r, pte, ptr, mode);
> +	iPTE_SW(p, r, pte, ptr, mode, scratch);
>  }
> =20
>  /*
> @@ -1780,7 +1778,7 @@ static void build_r3000_tlb_load_handler(void)
>  	build_r3000_tlbchange_handler_head(&p, K0, K1);
>  	build_pte_present(&p, &r, K0, K1, -1, label_nopage_tlbl);
>  	uasm_i_nop(&p); /* load delay */
> -	build_make_valid(&p, &r, K0, K1);
> +	build_make_valid(&p, &r, K0, K1, -1);
>  	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
> =20
>  	uasm_l_nopage_tlbl(&l, p);
> @@ -1811,7 +1809,7 @@ static void build_r3000_tlb_store_handler(void)
>  	build_r3000_tlbchange_handler_head(&p, K0, K1);
>  	build_pte_writable(&p, &r, K0, K1, -1, label_nopage_tlbs);
>  	uasm_i_nop(&p); /* load delay */
> -	build_make_write(&p, &r, K0, K1);
> +	build_make_write(&p, &r, K0, K1, -1);
>  	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
> =20
>  	uasm_l_nopage_tlbs(&l, p);
> @@ -1842,7 +1840,7 @@ static void build_r3000_tlb_modify_handler(void)
>  	build_r3000_tlbchange_handler_head(&p, K0, K1);
>  	build_pte_modifiable(&p, &r, K0, K1,  -1, label_nopage_tlbm);
>  	uasm_i_nop(&p); /* load delay */
> -	build_make_write(&p, &r, K0, K1);
> +	build_make_write(&p, &r, K0, K1, -1);
>  	build_r3000_pte_reload_tlbwi(&p, K0, K1);
> =20
>  	uasm_l_nopage_tlbm(&l, p);
> @@ -2010,7 +2008,7 @@ static void build_r4000_tlb_load_handler(void)
>  		}
>  		uasm_l_tlbl_goaround1(&l, p);
>  	}
> -	build_make_valid(&p, &r, wr.r1, wr.r2);
> +	build_make_valid(&p, &r, wr.r1, wr.r2, wr.r3);
>  	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
> =20
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> @@ -2124,7 +2122,7 @@ static void build_r4000_tlb_store_handler(void)
>  	build_pte_writable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbs);
>  	if (m4kc_tlbp_war())
>  		build_tlb_probe_entry(&p);
> -	build_make_write(&p, &r, wr.r1, wr.r2);
> +	build_make_write(&p, &r, wr.r1, wr.r2, wr.r3);
>  	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
> =20
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> @@ -2180,7 +2178,7 @@ static void build_r4000_tlb_modify_handler(void)
>  	if (m4kc_tlbp_war())
>  		build_tlb_probe_entry(&p);
>  	/* Present and writable bits set, set accessed and dirty bits. */
> -	build_make_write(&p, &r, wr.r1, wr.r2);
> +	build_make_write(&p, &r, wr.r1, wr.r2, wr.r3);
>  	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
> =20
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> --=20
> 2.8.0
>=20

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXEWsmAAoJEGwLaZPeOHZ6mrMP/166GJNDpDE3ZRDboyMfjPQX
eUCbcSKqQnpctwMvPSSpiJHVkQCFDVofBKrhr3qmCbRCUk9ODQjCIqn69dJ4/8TR
ThtduVh9793ziz38msGH3B+IPK8SusQwZJnSQFSTIhvhaEfG/ZYFbKTKl12dRTI4
+0xQMKFyCzRUtK05I1syYU+g+boOsOq8evx1Lmtu8hisHEs1mGh6ZaYGuAXYTryQ
qkvhJK+eZ5Dqid8WqVc7aP68Hw+92wch2bOHvXO8hcD1cHKrMDjdA4xSeqhB3G8S
bYYHv/UrF/Skobql0iLt4KlrLwuPrgQn8x7g1l3Hsx/QkIi9YxBUzi1IvQ0V0XxJ
LO6fiESxw+Gl4NeZ/uJ0apj8i0Tg3z15W03ZxysgSWvS3GJRqS0kPCb855SQ82OD
SnSA9CwzV7Ju7mRzJPeUJQTl1O0ZWpbvq85B9J4Wm7xJfH0uoGyxB4KQUNG5Wy9J
eHaZaTa5aDHvOlpw47z0NCPKdAJaSTob2pl18AYsiWza+wIeERH2mmcBf47JhlXw
41KuUBfG3rIE4fgb8qYSC9FdqC1xRutd3MYuFIlyxdI71mUvMdkNXfAKNMQ5sTEp
BuSHTeATn6adzl8fMPCK+STzQZiih9hJ69yGuGzzuss99ESSSWAtM7Qg7euJf3Ic
Wk4E86+RXy7aqBp1IZLW
=/ycd
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

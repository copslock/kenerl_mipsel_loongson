Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 01:10:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54104 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27026716AbcDOXJ4r4ZF8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 01:09:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7B2A641F8D89;
        Sat, 16 Apr 2016 00:09:51 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 16 Apr 2016 00:09:51 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 16 Apr 2016 00:09:51 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4BD4788734C17;
        Sat, 16 Apr 2016 00:09:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Sat, 16 Apr 2016 00:09:50 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Sat, 16 Apr
 2016 00:09:50 +0100
Date:   Sat, 16 Apr 2016 00:09:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Huacai Chen" <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 11/12] MIPS: mm: Simplify build_update_entries
Message-ID: <20160415230950.GJ7859@jhogan-linux.le.imgtec.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-12-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline
In-Reply-To: <1460716620-13382-12-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53018
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

--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:36:59AM +0100, Paul Burton wrote:
> We can simplify build_update_entries by unifying the code for the 36 bit
> physical addressing with MIPS32 case with the general case, by using
> pte_off_ variables in all cases & handling the trivial
> _PAGE_GLOBAL_SHIFT =3D=3D 0 case in build_convert_pte_to_entrylo. This
> leaves XPA as the only special case.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  arch/mips/mm/tlbex.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 0bd3755..45234ad 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -626,6 +626,11 @@ static void build_tlb_write_entry(u32 **p, struct ua=
sm_label **l,
>  static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
>  							unsigned int reg)
>  {
> +	if (_PAGE_GLOBAL_SHIFT =3D=3D 0) {
> +		/* pte_t is already in EntryLo format */
> +		return;
> +	}
> +
>  	if (cpu_has_rixi && _PAGE_NO_EXEC) {
>  		if (fill_includes_sw_bits) {
>  			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
> @@ -1003,10 +1008,17 @@ static void build_get_ptep(u32 **p, unsigned int =
tmp, unsigned int ptr)
> =20
>  static void build_update_entries(u32 **p, unsigned int tmp, unsigned int=
 ptep)
>  {
> -	if (config_enabled(CONFIG_XPA)) {
> -		int pte_off_even =3D sizeof(pte_t) / 2;
> -		int pte_off_odd =3D pte_off_even + sizeof(pte_t);
> +	int pte_off_even =3D 0;
> +	int pte_off_odd =3D sizeof(pte_t);
> +
> +	if (config_enabled(CONFIG_PHYS_ADDR_T_64BIT) &&
> +	    config_enabled(CONFIG_32BIT)) {
> +		/* The low 32 bits of EntryLo is stored in pte_high */
> +		pte_off_even +=3D offsetof(pte_t, pte_high);
> +		pte_off_odd +=3D offsetof(pte_t, pte_high);

pte_high doesn't exist unless CONFIG_CPU_MIPS32=3Dy (e.g. you
can set CONFIG_CPU_MIPS64=3Dy, CONFIG_CPU_MIPS32=3Dn and CONFIG_32BIT=3Dy).

With that fixed it looks good to me.
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> +	}
> =20
> +	if (config_enabled(CONFIG_XPA)) {
>  		uasm_i_lw(p, tmp, pte_off_even, ptep); /* even pte */
>  		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
>  		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
> @@ -1025,24 +1037,8 @@ static void build_update_entries(u32 **p, unsigned=
 int tmp, unsigned int ptep)
>  		return;
>  	}
> =20
> -	/*
> -	 * 64bit address support (36bit on a 32bit CPU) in a 32bit
> -	 * Kernel is a special case. Only a few CPUs use it.
> -	 */
> -	if (config_enabled(CONFIG_PHYS_ADDR_T_64BIT) && !cpu_has_64bits) {
> -		int pte_off_even =3D sizeof(pte_t) / 2;
> -		int pte_off_odd =3D pte_off_even + sizeof(pte_t);
> -
> -		uasm_i_lw(p, tmp, pte_off_even, ptep); /* even pte */
> -		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
> -
> -		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* odd pte */
> -		UASM_i_MTC0(p, ptep, C0_ENTRYLO1);
> -		return;
> -	}
> -
> -	UASM_i_LW(p, tmp, 0, ptep); /* get even pte */
> -	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
> +	UASM_i_LW(p, tmp, pte_off_even, ptep); /* get even pte */
> +	UASM_i_LW(p, ptep, pte_off_odd, ptep); /* get odd pte */
>  	if (r45k_bvahwbug())
>  		build_tlb_probe_entry(p);
>  	build_convert_pte_to_entrylo(p, tmp);
> --=20
> 2.8.0
>=20

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXEXS+AAoJEGwLaZPeOHZ6wD0P/3j/YslXTqVVC70QJtGR9Efe
x4C1544McdXvZhWqHBkQqJZ+UEu5iALMK5YksUtHLow9cigTUiSawukG6/yevsyi
WEhszgk96lPeKSBNgpoNP6wGSjP/3/kvhbOfbYnXWzEyQXqHibponFXxk6fG49A/
87+bZsKJYUSLjAgzVG7hdlb9KDGgk/SIGq7pnoJ8nIrOmGqBTw22xLQqVcHiJd0N
yhOFOP59W5GleizZbNVz34nmR2SwdfEHzxuHKQGhJL+cOgYet5VkQQ9qZOMoAOTc
/lMPZTuzH1GWbNLp7e2Ao9p/dcgfQGxCXotrry1qUawVlWOgiNi18VgCCC49z6Wb
OUkZxOtdM8SfpNBozryAB5UBPR/g9FWD5l6RzDD2TfGLUY8Z86GObNsd9rmZVrZn
h9boxm7HV36CJYPVr/1IP87hl4WP/zbM6YLZBOyTU4+EDLvXqOTQ3g9vB+hhHXZ0
87vVF6f3qFwg5Blk//L5+ZMVmdOiOJhAKLADHMJLFVGSOFPL1WkcJmEIn8yRMeMh
wJwjcocwkAWJ+HJwQSKLeVk6YnvZ8Pms2cWsn7ZytAZzztIn9/ycG98vY3o51/JA
yRbWPuWJnm5na/ZePdf8j2aqqV/rSM2hTTlK5ke7z0OvgbhWONY4LfyQJ6MQ/VdI
NRLMo879WwMYxilDaBKj
=JvNM
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--

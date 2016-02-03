Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:47:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44344 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011748AbcBCMr5VWmHE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 13:47:57 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 01C0F41F8E7D;
        Wed,  3 Feb 2016 12:47:52 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 12:47:52 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 12:47:52 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 274F1BB3DB1D3;
        Wed,  3 Feb 2016 12:47:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 12:47:51 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 12:47:50 +0000
Date:   Wed, 3 Feb 2016 12:47:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Andrey Konovalov" <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] MIPS: Implement MIPSr6 R_MIPS_PC2x rel-style relocs
Message-ID: <20160203124750.GD5464@jhogan-linux.le.imgtec.org>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-6-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <1454471085-20963-6-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51689
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

--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:44:45AM +0000, Paul Burton wrote:
> MIPS32r6 code makes use of rel-stye relocations & may contain the new
> relocations R_MIPS_PC21_S2 or R_MIPS_PC26_S2 which were introduced with
> MIPSr6. Implement support for those relocations such that we can load
> MIPS32r6 kernel modules.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Looks good to me,
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> ---
>=20
>  arch/mips/kernel/module.c | 52 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index f2de9b8..d62fd56 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -194,6 +194,56 @@ static int apply_r_mips_pc16_rel(struct module *me, =
u32 *location, Elf_Addr v)
>  	return 0;
>  }
> =20
> +static int apply_r_mips_pc21_rel(struct module *me, u32 *location, Elf_A=
ddr v)
> +{
> +	long offset;
> +
> +	if (v % 4) {
> +		pr_err("module %s: dangerous R_MIPS_PC21 REL relocation\n",
> +		       me->name);
> +		return -ENOEXEC;
> +	}
> +
> +	/* retrieve & sign extend implicit addend */
> +	offset =3D *location & 0x1fffff;
> +	offset |=3D (offset & BIT(20)) ? (~0l & ~0x1fffffl) : 0;
> +
> +	offset +=3D ((long)v - (long)location) >> 2;
> +	if ((offset >> 20) > 0 || (offset >> 20) < -1) {
> +		pr_err("module %s: relocation overflow\n", me->name);
> +		return -ENOEXEC;
> +	}
> +
> +	*location =3D (*location & ~0x001fffff) | (offset & 0x001fffff);
> +
> +	return 0;
> +}
> +
> +static int apply_r_mips_pc26_rel(struct module *me, u32 *location, Elf_A=
ddr v)
> +{
> +	long offset;
> +
> +	if (v % 4) {
> +		pr_err("module %s: dangerous R_MIPS_PC26 REL relocation\n",
> +		       me->name);
> +		return -ENOEXEC;
> +	}
> +
> +	/* retrieve & sign extend implicit addend */
> +	offset =3D *location & 0x3ffffff;
> +	offset |=3D (offset & BIT(25)) ? (~0l & ~0x3ffffffl) : 0;
> +
> +	offset +=3D ((long)v - (long)location) >> 2;
> +	if ((offset >> 25) > 0 || (offset >> 25) < -1) {
> +		pr_err("module %s: relocation overflow\n", me->name);
> +		return -ENOEXEC;
> +	}
> +
> +	*location =3D (*location & ~0x03ffffff) | (offset & 0x03ffffff);
> +
> +	return 0;
> +}
> +
>  static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
>  				Elf_Addr v) =3D {
>  	[R_MIPS_NONE]		=3D apply_r_mips_none,
> @@ -202,6 +252,8 @@ static int (*reloc_handlers_rel[]) (struct module *me=
, u32 *location,
>  	[R_MIPS_HI16]		=3D apply_r_mips_hi16_rel,
>  	[R_MIPS_LO16]		=3D apply_r_mips_lo16_rel,
>  	[R_MIPS_PC16]		=3D apply_r_mips_pc16_rel,
> +	[R_MIPS_PC21_S2]	=3D apply_r_mips_pc21_rel,
> +	[R_MIPS_PC26_S2]	=3D apply_r_mips_pc26_rel,
>  };
> =20
>  int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
> --=20
> 2.7.0
>=20
>=20

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsfb2AAoJEGwLaZPeOHZ6g9YP/AzcU/ebtiP3OKeRJvkLU3/Y
OEiwhHlXtifswhntPyc3RXwPKyfUoKJGnLWHk1gDoimdwHUHzUBZjPSFgCcccjWd
67eeOrbjWIBETv0vki37Sy6mkB/OCxUwCcb2tDSGLQDIl0vJ8aBUH3KYM3TZcAop
fLUktCVzNeAhBG7s2ycuGvP03pcJrZWNOxvLeXZcdKV12+RQjzEgGOxQCm9UBY1y
UDnFaRBfHajFlEb7N8Ogn9AULl7fDmuudt4BDrA4i9E6JkVAemtLxTHo/43u6fmI
JON0uQ9Zf/yUb730cqkmf4vEDvPWmJ8eLti/249viOH+LAnD3QQ0LA3/BGVNSWET
jJYFfz35NQjCfWatCG1G1ScYRfFqB0MTFQBy8hOvwluT3MJwm1chMZjdPkCm0Beg
bor1+B64krY8e1n3g/yIXO+49VPG8CdoEPPSooqGBItopKG2b3jPo90o+zHiekrU
qvVkMJ5wsiY8S5531a8jhwbdE1vIjfEck6T3DXITMyscLC9A/RvoE7sgyVCZpbvv
45WjB4zV5ndnHXb0Amlw2r7FFKQE/VFTxACGkFn6GV8XyGMPPqpjOEMK0vMAQ42t
RHbSbCX7EkArvlF2KROPlFv94cIF0nB2CH0pGtVY380+PBqwOCtWSxvwnz8eWPbu
cKOihhiAOBJe47eVq86K
=I13I
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

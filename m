Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:23:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61518 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012172AbcBCMXk5x3ay (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 13:23:40 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id F311041F8E7D;
        Wed,  3 Feb 2016 12:23:32 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 12:23:32 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 12:23:32 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 30EF48B35E555;
        Wed,  3 Feb 2016 12:23:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 12:23:32 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 12:23:31 +0000
Date:   Wed, 3 Feb 2016 12:23:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Andrey Konovalov" <adech.fo@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] MIPS: Bail on unsupported module relocs
Message-ID: <20160203122332.GG5038@jhogan-linux.le.imgtec.org>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-2-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <1454471085-20963-2-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51685
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

--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:44:41AM +0000, Paul Burton wrote:
> When an unsupported reloc is encountered in a module, we currently
> blindly branch to whatever would be at its entry in the reloc handler
> function pointer arrays. This may be NULL, or if the unsupported reloc
> has a type greater than that of the supported reloc with the highest
> type then we'll dereference some value after the function pointer array
> & branch to that. The result is at best a kernel oops.
>=20
> Fix this by checking that the reloc type has an entry in the function
> pointer array (ie. is less than the number of items in the array) and
> that the handler is non-NULL, returning an error code to fail the module
> load if no handler is found.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>=20
>  arch/mips/kernel/module-rela.c | 19 ++++++++++++++++---
>  arch/mips/kernel/module.c      | 19 ++++++++++++++++---
>  2 files changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/mips/kernel/module-rela.c b/arch/mips/kernel/module-rel=
a.c
> index 2b70723..769e316 100644
> --- a/arch/mips/kernel/module-rela.c
> +++ b/arch/mips/kernel/module-rela.c
> @@ -109,9 +109,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
>  		       struct module *me)
>  {
>  	Elf_Mips_Rela *rel =3D (void *) sechdrs[relsec].sh_addr;
> +	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
>  	Elf_Sym *sym;
>  	u32 *location;
> -	unsigned int i;
> +	unsigned int i, type;
>  	Elf_Addr v;
>  	int res;
> =20
> @@ -134,9 +135,21 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
>  			return -ENOENT;
>  		}
> =20
> -		v =3D sym->st_value + rel[i].r_addend;
> +		type =3D ELF_MIPS_R_TYPE(rel[i]);
> +
> +		if (type < ARRAY_SIZE(reloc_handlers_rela))
> +			handler =3D reloc_handlers_rela[type];
> +		else
> +			handler =3D NULL;
> =20
> -		res =3D reloc_handlers_rela[ELF_MIPS_R_TYPE(rel[i])](me, location, v);
> +		if (!handler) {
> +			pr_warn("%s: Unknown relocation type %u\n",
> +				me->name, type);
> +			return -EINVAL;
> +		}
> +
> +		v =3D sym->st_value + rel[i].r_addend;
> +		res =3D handler(me, location, v);
>  		if (res)
>  			return res;
>  	}
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 1833f51..2adf572 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -197,9 +197,10 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *st=
rtab,
>  		   struct module *me)
>  {
>  	Elf_Mips_Rel *rel =3D (void *) sechdrs[relsec].sh_addr;
> +	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
>  	Elf_Sym *sym;
>  	u32 *location;
> -	unsigned int i;
> +	unsigned int i, type;
>  	Elf_Addr v;
>  	int res;
> =20
> @@ -223,9 +224,21 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *st=
rtab,
>  			return -ENOENT;
>  		}
> =20
> -		v =3D sym->st_value;
> +		type =3D ELF_MIPS_R_TYPE(rel[i]);
> +
> +		if (type < ARRAY_SIZE(reloc_handlers_rel))
> +			handler =3D reloc_handlers_rel[type];
> +		else
> +			handler =3D NULL;
> =20
> -		res =3D reloc_handlers_rel[ELF_MIPS_R_TYPE(rel[i])](me, location, v);
> +		if (!handler) {
> +			pr_warn("%s: Unknown relocation type %u\n",
> +				me->name, type);
> +			return -EINVAL;
> +		}
> +
> +		v =3D sym->st_value;
> +		res =3D handler(me, location, v);
>  		if (res)
>  			return res;
>  	}
> --=20
> 2.7.0
>=20

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsfFDAAoJEGwLaZPeOHZ6VEQP/i7ImAtV5MiisQIvhXR1xvKi
NAlnHQFpMsp4uFwT+uj7j/SsYQiTII21fXNyZgcyKyHU/19fySllgPEPkqXpV6v9
eJ1V28VqxuT94An9ZG4cfm8IOMp0ZQiAfFTCvXNiC3QLqJge3uH3uWCw2pXK8iBs
r6MV9Rk89q91ggH+d/GnxDpYYlxWJDF5it6LzbxmAJvBZPQfquHDCZKnv2tiePBP
aatSSpW5ZhXC4iY/bWxspASTd3L0IM8PpsLxcrbP1M3yTbM8NGoLDRldqEG1LJnB
Ri7ZlYqa1jfdSD/Xu/sOpDjZWNpEExNtO/RCrK5dZoSjVhOsTbxigSvhGwGZOaOu
mYeuRBoPYdKgt7NyUqXn9NmbepQjWroRFBVDR6aGNNYypbteM5ubSOqAU9eq2+i8
3C1NJaTXklWeNUcIeKla315A3+KcY8XCSu4/ev39wswOqY1tRZHAQhhnE2E+xgsF
Y8nI8CGZzJ39M7AmzQFzScb7RUOXWStvCuHwVvcpBM0P82JDB9imbWJLAPTS7JVc
BvPFiZlxqu6xgp72EVTjP+ZiVfAPXHLSXxGVP5AHnZ0O2AtZdzG1s+DyvD4QS1jo
xvN7hdcFxLMhz3HqFMcCeUHspwbHeQdynKj7SZ0RCHF9D0NaEJYkci9UysQcECxp
qRgHb2OnET5C8lQ7K2YU
=wR1A
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--

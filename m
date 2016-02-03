Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:49:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23632 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011748AbcBCMtqMWk4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 13:49:46 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DDEAE41F8E7D;
        Wed,  3 Feb 2016 12:49:40 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 12:49:40 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 12:49:40 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C10EC2FBFAD6F;
        Wed,  3 Feb 2016 12:49:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 12:49:40 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 12:49:40 +0000
Date:   Wed, 3 Feb 2016 12:49:40 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Andrey Konovalov" <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] MIPS: Support R_MIPS_PC16 rel-style reloc
Message-ID: <20160203124940.GE5464@jhogan-linux.le.imgtec.org>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51690
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

--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:44:44AM +0000, Paul Burton wrote:
> MIPS32 code uses rel-style relocs, and MIPS32r6 modules may include the
> R_MIPS_PC16 relocation. We thus need to support R_MIPS_PC16 rel-style
> relocations in order to load MIPS32r6 kernel modules. This patch adds
> such support, which is similar to the rela-style R_MIPS_PC16 support but
> making use of the implicit addend from the instruction encoding.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  arch/mips/kernel/module.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 2adf572..f2de9b8 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -183,13 +183,25 @@ out_danger:
>  	return -ENOEXEC;
>  }
> =20
> +static int apply_r_mips_pc16_rel(struct module *me, u32 *location, Elf_A=
ddr v)
> +{
> +	u16 val;
> +
> +	val =3D *location;
> +	val +=3D (v - (Elf_Addr)location) >> 2;
> +	*location =3D (*location & 0xffff0000) | val;

Looks correct, but presumably this could benefit from some sanity
checking like the other patches.

Cheers
James

> +
> +	return 0;
> +}
> +
>  static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
>  				Elf_Addr v) =3D {
>  	[R_MIPS_NONE]		=3D apply_r_mips_none,
>  	[R_MIPS_32]		=3D apply_r_mips_32_rel,
>  	[R_MIPS_26]		=3D apply_r_mips_26_rel,
>  	[R_MIPS_HI16]		=3D apply_r_mips_hi16_rel,
> -	[R_MIPS_LO16]		=3D apply_r_mips_lo16_rel
> +	[R_MIPS_LO16]		=3D apply_r_mips_lo16_rel,
> +	[R_MIPS_PC16]		=3D apply_r_mips_pc16_rel,
>  };
> =20
>  int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
> --=20
> 2.7.0
>=20
>=20

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsfdkAAoJEGwLaZPeOHZ6hWwP/RGhH1om3OSI5yKUjfOy4y0f
n0cM78Olx5AS0uPJdQxbMmbbOd1yNzL9GbpjaTqxATR8UOpUecVqdxIxeZP470sU
zl/EMqh0+1GuXiH9UTjGSz7U6W2VVRYvfG04SYvmuRl7cT3fx9efF9vSM0Bz/OXR
3SkRBrRU0FLWrL5WBtu/RKF9X9ymuGGiDR3016KIE1WEJzzHu+MawlFnw3XHWoVN
oYEQigGz8FQd9ITcQNmEQlyCXPgEKznNVbAE9EemwrSIab+fmWUC2859x7CReJhc
UjgyXAwFWQSTSNUDNI92KWIyRK8V61amZ0amj13JklFS3c2jLICLKPF2JaquRrx7
QLw8MqYG0jwthXzTirFtwcudXyfJqjg92tg/P1N6PziYwFt1FYq16Xtjk+AEWE7N
HL6Db+bacDmPVh5PJBQWSU8jTdlHI0g7b9/VTJM9GVid0DT2UGi5kcjnl1jDjRaX
4WBb42keTR/W/gwdhBp7cwdOhdYsHNEThYb4bmWa1Wff45RLv+vWPBIvGge8sRkl
FyrY6Jnzk7ukNrls9FSYrOzRapeTAya6pY8Q+H0y3Oda8R2WTMMY9fWGDn0C4/pY
LmS7Nk6bGFqwGyR0JdiWMNNTq1s/cooiyqTY3bsab7cvSu8peQ2vEJz1aLuU+dEk
hSlGdpvzhBBrSrvRd5ZM
=JPNz
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

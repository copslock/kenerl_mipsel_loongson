Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 18:44:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16163 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995045AbdH2Qoev5wZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 18:44:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AB4FEE1062E0D;
        Tue, 29 Aug 2017 17:44:20 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 29 Aug
 2017 17:44:24 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 29 Aug
 2017 09:44:22 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <trivial@kernel.org>
Subject: Re: [PATCH 11/11] MIPS: Declare various variables & functions static
Date:   Tue, 29 Aug 2017 09:44:16 -0700
Message-ID: <5605804.ME68hyheDo@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <787b1a5b-2e77-41cc-235f-6dfd882b225a@imgtec.com>
References: <20170823181754.24044-1-paul.burton@imgtec.com> <20170823181754.24044-12-paul.burton@imgtec.com> <787b1a5b-2e77-41cc-235f-6dfd882b225a@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6469676.7gjBOIDVV2";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart6469676.7gjBOIDVV2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Marcin,

On Tuesday, 29 August 2017 03:05:55 PDT Marcin Nowakowski wrote:
> On 23.08.2017 20:17, Paul Burton wrote:
> > We currently have various variables & functions which are only used
> > within a single translation unit, but which we don't declare static.
> >=20
> > This causes various sparse warnings of the form:
> >    arch/mips/kernel/mips-r2-to-r6-emul.c:49:1: warning: symbol
> >   =20
> >      'mipsr2emustats' was not declared. Should it be static?
> >   =20
> >    arch/mips/kernel/unaligned.c:1381:11: warning: symbol 'reg16to32st'
> >   =20
> >      was not declared. Should it be static?
> >   =20
> >    arch/mips/mm/mmap.c:146:15: warning: symbol 'arch_mmap_rnd' was not
> >   =20
> >      declared. Should it be static?
> >=20
> > Fix these & others by declaring various affected variables & functions
> > static, avoiding the sparse warnings & redundant symbols.
> >=20
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> >=20
> > ---
> >=20
> >   arch/mips/kernel/cpu-probe.c          | 2 +-
> >   arch/mips/kernel/mips-r2-to-r6-emul.c | 6 +++---
> >   arch/mips/kernel/pm-cps.c             | 2 +-
> >   arch/mips/kernel/unaligned.c          | 2 +-
> >   arch/mips/mm/dma-default.c            | 4 ++--
> >   5 files changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c
> > b/arch/mips/kernel/mips-r2-to-r6-emul.c index ae64c8f56a8c..ac23b4f09f02
> > 100644
> > --- a/arch/mips/kernel/mips-r2-to-r6-emul.c
> > +++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
> > @@ -46,9 +46,9 @@
> >=20
> >   #define LL	"ll "
> >   #define SC	"sc "
> >=20
> > -DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
> > -DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
> > -DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats);
> > +static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
> > +static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
> > +static DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustat=
s);
>=20
> This leads to the following:
> ../arch/mips/kernel/mips-r2-to-r6-emul.c:51:56: error:
> =E2=80=98mipsr2bremustats=E2=80=99 defined but not used [-Werror=3Dunused=
=2Dvariable]
>   static DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats=
);
>                                                          ^
> ../include/linux/percpu-defs.h:105:19: note: in definition of macro
> =E2=80=98DEFINE_PER_CPU_SECTION=E2=80=99
>    __typeof__(type) name
>                     ^~~~
> ../arch/mips/kernel/mips-r2-to-r6-emul.c:51:8: note: in expansion of
> macro =E2=80=98DEFINE_PER_CPU=E2=80=99
>   static DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats=
);
>          ^~~~~~~~~~~~~~
> ../arch/mips/kernel/mips-r2-to-r6-emul.c:50:54: error:
> =E2=80=98mipsr2bdemustats=E2=80=99 defined but not used [-Werror=3Dunused=
=2Dvariable]
>   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
>                                                        ^
> ../include/linux/percpu-defs.h:105:19: note: in definition of macro
> =E2=80=98DEFINE_PER_CPU_SECTION=E2=80=99
>    __typeof__(type) name
>                     ^~~~
> ../arch/mips/kernel/mips-r2-to-r6-emul.c:50:8: note: in expansion of
> macro =E2=80=98DEFINE_PER_CPU=E2=80=99
>   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
>          ^~~~~~~~~~~~~~
> ../arch/mips/kernel/mips-r2-to-r6-emul.c:49:54: error: =E2=80=98mipsr2emu=
stats=E2=80=99
> defined but not used [-Werror=3Dunused-variable]
>   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
>                                                        ^
> ../include/linux/percpu-defs.h:105:19: note: in definition of macro
> =E2=80=98DEFINE_PER_CPU_SECTION=E2=80=99
>    __typeof__(type) name
>                     ^~~~
> ../arch/mips/kernel/mips-r2-to-r6-emul.c:49:8: note: in expansion of
> macro =E2=80=98DEFINE_PER_CPU=E2=80=99
>   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
>=20
>=20
> when CONFIG_DEBUG_FS=3Dn (eg. malta_qemu_32r6_defconfig)
>=20
> Since these are not used without DEBUG_FS then I guess the following
> patch should be ok:
>=20
> diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c
> b/arch/mips/kernel/mips-r2-to-r6-emul.c
> index 3bd721c..eb18b18 100644
> --- a/arch/mips/kernel/mips-r2-to-r6-emul.c
> +++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
> @@ -46,9 +46,11 @@
>   #define LL     "ll "
>   #define SC     "sc "
>=20
> +#ifdef CONFIG_DEBUG_FS
>   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2emustats);
>   static DEFINE_PER_CPU(struct mips_r2_emulator_stats, mipsr2bdemustats);
>   static DEFINE_PER_CPU(struct mips_r2br_emulator_stats, mipsr2bremustats=
);
> +#endif
>=20
> if you're OK with it then I guess it may be best for Ralf to fold this
> change into your patch?

D'oh! That looks like a reasonable fix to me - could you fold it in Ralf?

Thanks,
    Paul
--nextPart6469676.7gjBOIDVV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmlmeAACgkQgiDZ+mk8
HGWiGRAAoSy3SHIVEPBVr1M7ema/j75zOxxo0BWIOt3vUSESKs5zTrrMfrs07cYJ
N4xdZBcEsAAu03d1f219asw9D9LuSR9nt2oVULynDOow3kUVc1PnavE3KGRKjBhO
xCzZw8alZsDn44OgedyxeVKNRm59U/BVzhHrsZd/fJxlXiegkM56bDRW5QG+6acF
8RkWhEuuMPj+I8O8X3AduJeQqn+jRk5wVGzWNZaXpcF7YmCBu8raOP0jxc20J43P
n5SqoJDgJkxMS68L6bR4QgdqOhofhbke6zHf4qnNN75af8kRNcRf2CBRctM1XIbw
8Pe0Ab2LpniVD81l+CJXEdHbsawmzKX51ZKLpmJ0a6F/Ikje6MxPNPvLJfrPmY5N
wXT4afwZUDj9pM1e2SKo6esvGl89on8SGKPrrEnwmVOop34bhWtHMPgpxVtR+cCj
xKAqSsPmqdODIQDAaCkXuIVn5KmGIbOl8sY+Av5Qx831FCmyPd3gn9yBIpPtX+bN
FmNi8ybNVuCZYSnP6ce2Ffhtoz/TgGXgldFYB1f33eYZI4r1jakz0dyn+gMFLKul
p5AMBahMTd7IQh8MTGv1p+ZGEa8RYITQb9jbFjgyPKqo6TWGEVGjQfYYvUkYdoxC
Z0jrCNcSJ6lPSFA902whDL8lXwFLP8IcUdZ/k29zQ7mU7OBJGLQ=
=X/Jl
-----END PGP SIGNATURE-----

--nextPart6469676.7gjBOIDVV2--

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 20:49:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15103 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993009AbdDDSt3Gjc4g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 20:49:29 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 449CC41F8DA6;
        Tue,  4 Apr 2017 20:55:34 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 04 Apr 2017 20:55:34 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 04 Apr 2017 20:55:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 10AD31343849B;
        Tue,  4 Apr 2017 19:49:19 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 4 Apr
 2017 19:49:22 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 4 Apr 2017
 11:49:20 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Avoid warnings from use of dla in 32 bit kernels
Date:   Tue, 4 Apr 2017 11:49:14 -0700
Message-ID: <9459713.IbS6oA1Njj@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <alpine.DEB.2.00.1703310441420.5644@tp.orcam.me.uk>
References: <20170330214838.5828-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1703310441420.5644@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5443929.ld3Zyq5Vyr";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57562
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

--nextPart5443929.ld3Zyq5Vyr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Maciej,

On Friday, 31 March 2017 04:18:40 PDT Maciej W. Rozycki wrote:
> On Thu, 30 Mar 2017, Paul Burton wrote:
> > One seemingly straightforward fix would be to make use of the PTR_LA
> > macro to emit the appropriate pseudo-instruction, however this would
> > involve including asm.h which is intended solely for inclusion in
> > assembly code. When included by C code its definition of various generic
> > & non-namespaced macros such as LONG, PTR, CAT etc cause numerous build
> > failures.
>=20
>  This is however exactly what we do in several places, and I would
> recommend here as well.  Can you point me at the earlier review of your
> proposal?

The first 2 revisions of the patch, which did include asm/asm.h & use PTR_L=
A,=20
can be found in patchwork:

  https://patchwork.linux-mips.org/patch/12436/
  https://patchwork.linux-mips.org/patch/12443/

> > Instead fix this by adding a ".set gp=3D64" directive to inform the
> > assembler that general purpose registers are 64 bit for the dla
> > instruction. This is a lie, but no more so than using the dla
> > instruction to begin with.
>=20
>  I agree using DLA unconditionally is wrong, so if using <asm/asm.h> and
> its PTR_LA turns out infeasible indeed, then please define a local macro
> that expands to LA or DLA as appropriate and does not cause a namespace
> issue, and use it in `instruction_hazard' (all instances) rather than this
> horrible hack.

Horrible though the use of dla may be at first glance, I do wonder if it=20
actually makes sense to just keep it. Presumably Ralf thought it made sense=
=20
when he added it in 7043ad4f4c81 ("MIPS: R2: Try to bulletproof=20
instruction_hazard against miss-compilation."). The presumption is simply t=
hat=20
the dla pseudo-instruction won't result in any MIPS64 instructions being=20
emitted when used on a 32 bit canonical address, which might not be "nice" =
but=20
then neither is the #ifdef solution.

I had lost track of what the build failures were when including asm/asm.h, =
but=20
reverting to v2 of my patch & building all defconfigs shows a number of=20
issues.

=46or example, from mtx1_defconfig:

  CC [M]  drivers/net/ethernet/fealnx.o
In file included from ./arch/mips/include/asm/hazards.h:15:0,
                 from ./arch/mips/include/asm/mipsregs.h:18,
                 from ./arch/mips/include/asm/mach-generic/spaces.h:15,
                 from ./arch/mips/include/asm/addrspace.h:13,
                 from ./arch/mips/include/asm/barrier.h:11,
                 from ./arch/mips/include/asm/bitops.h:18,
                 from ./include/linux/bitops.h:36,
                 from ./include/linux/kernel.h:10,
                 from ./include/linux/list.h:8,
                 from ./include/linux/module.h:9,
                 from drivers/net/ethernet/fealnx.c:71:
=2E/arch/mips/include/asm/asm.h:318:15: error: expected identifier before =
=E2=80=98.=E2=80=99=20
token
 #define LONG  .word
               ^
drivers/net/ethernet/fealnx.c:261:2: note: in expansion of macro =E2=80=98L=
ONG=E2=80=99
  LONG =3D 0x20,  /* long packet received */
  ^

Or from rm200_defconfig:

  CC      arch/mips/sni/setup.o
In file included from ./arch/mips/include/asm/hazards.h:15:0,
                 from ./arch/mips/include/asm/mipsregs.h:18,
                 from ./arch/mips/include/asm/mach-generic/spaces.h:15,
                 from ./arch/mips/include/asm/addrspace.h:13,
                 from ./arch/mips/include/asm/barrier.h:11,
                 from ./arch/mips/include/asm/bitops.h:18,
                 from ./include/linux/bitops.h:36,
                 from ./include/linux/kernel.h:10,
                 from ./include/linux/list.h:8,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:17,
                 from ./include/linux/eisa.h:5,
                 from arch/mips/sni/setup.c:11:
=2E/arch/mips/include/asm/asm.h:318:15: error: expected identifier or =E2=
=80=98(=E2=80=99 before=20
=E2=80=98.=E2=80=99 token
 #define LONG  .word
               ^
=2E/arch/mips/include/asm/fw/arc/types.h:18:15: note: in expansion of macro=
=20
=E2=80=98LONG=E2=80=99
 typedef long  LONG __attribute__ ((__mode__ (__SI__)));

Other builds that include asm/fw/arc/types.h of course fail similarly, for=
=20
example ip22_defconfig, ip27_defconfig, ip28_defconfig, ip32_defconfig &=20
jazz_defconfig all fail to build when asm/hazards.h includes asm/asm.h.

Your point above that we already include asm/asm.h in various C files is a=
=20
good one, though given how generic some of the names of its preprocessor=20
definitions are it wouldn't surprise me to see that cause other build break=
age=20
in the future.

Thanks,
    Paul
--nextPart5443929.ld3Zyq5Vyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAljj6qoACgkQgiDZ+mk8
HGVSkw//aEmispOZ6R933wcg2iJjQmh4b4v9dbadKfus1yxLls6e1frA8HY6SRhC
I1y97nzOM3sUI1DhYk6UKJ6Fq1KUjXwbHNlNHMRSSLHJzn114onVf0CfqnAgxJId
6v6RC6JirLZLheryD+fWfvfuvSh/zF/F9IY2al3mt+57ibZCc+lbXbITvJLqGMM3
ASAwU4t1m9jBDaFhodG/3B45OnLt++CEB8UMl9YdLLfnpMvIY+1tfLvr73FCa22P
h/3hBkQdyZuTHAG6SdMPFTdJ6JUBB4lzGaCP5PLDTBHc2A4mJE7nbJrD0075KoSq
vep30nc0rtzOTlMAodZwznEgTqmdvimE+7gccUVGRzyRR0ZeOK0SGQLSGvKBW6+R
BJ2vzv4FGdDu3x8W0SQl1g9dMeOLq8I15KAx+m8FUEY+qj3ZLlAhvz3TcTZurXcF
//zYI+BXrteNvnueBEbjdIO45ZsqL3CcoJ73BN9XocNYLTHs6o7dP3gEVVNZfzhd
Wg/lDAk8DnitqGo1X6EJDMEE5fsxUyY0qqi4vIy8sSVuUK2+cUwKCCiM336y9UI7
thAGD47NQ/mlWQ9BgZzo/eM4vW1BW1LOizYX6XB4nLHbhtmZ414pdx982ALCTYhM
o1sLsyQG+S/+EhwCO2WDRCU4s200fSnhDxLh1N7krS3VkqWPL9k=
=aAge
-----END PGP SIGNATURE-----

--nextPart5443929.ld3Zyq5Vyr--

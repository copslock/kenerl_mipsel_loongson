Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 16:46:29 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:55125 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdKIPqVm9O1X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 16:46:21 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 15:45:27 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 07:45:19 -0800
Date:   Thu, 9 Nov 2017 15:45:17 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Djordje Todorovic <djordje.todorovic@rt-rk.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix an n32 core file generation regset support
 regression
Message-ID: <20171109154517.GY15260@jhogan-linux>
References: <alpine.DEB.2.00.1710272036270.3886@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kUoBhQsr7LsiFken"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1710272036270.3886@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510242326-298554-12052-53724-4
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186757
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--kUoBhQsr7LsiFken
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 07:09:20PM +0000, Maciej W. Rozycki wrote:
> Fix a commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")=20
> regression, then activated by commit 6a9c001b7ec3 ("MIPS: Switch ELF=20
> core dumper to use regsets.)", that caused n32 processes to dump o32=20
> core files by failing to set the EF_MIPS_ABI2 flag in the ELF core file=
=20
> header's `e_flags' member:
>=20
> $ file tls-core
> tls-core: ELF 32-bit MSB executable, MIPS, N32 MIPS64 rel2 version 1 (SYS=
V), [...]
> $ ./tls-core
> Aborted (core dumped)
> $ file core
> core: ELF 32-bit MSB core file MIPS, MIPS-I version 1 (SYSV), SVR4-style
> $=20
>=20
> Previously the flag was set as the result of a:
>=20
> #define ELF_CORE_EFLAGS EF_MIPS_ABI2
>=20
> statement placed in arch/mips/kernel/binfmt_elfn32.c, however in the=20
> regset case, i.e. when CORE_DUMP_USE_REGSET is set, ELF_CORE_EFLAGS is=20
> no longer used by `fill_note_info' in fs/binfmt_elf.c, and instead the=20
> `->e_flags' member of the regset view chosen is.  We have the views=20
> defined in arch/mips/kernel/ptrace.c, however only an o32 and an n64=20
> one, and the latter is used for n32 as well.  Consequently an o32 core=20
> file is incorrectly dumped from n32 processes (the ELF32 vs ELF64 class=
=20
> is chosen elsewhere, and the 32-bit one is correctly selected for n32).
>=20
> Correct the issue then by defining an n32 regset view and using it as=20
> appropriate.  Issue discovered in GDB testing.
>=20
> Cc: stable@vger.kernel.org # 3.13+
> Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Thanks, queued for 4.15.

Cheers
James

> ---
>  arch/mips/kernel/ptrace.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> linux-mips-regset-view-n32-e-flags-abi2-init.diff
> Index: linux-sfr/arch/mips/kernel/ptrace.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr.orig/arch/mips/kernel/ptrace.c	2017-10-27 04:55:34.00000000=
0 +0100
> +++ linux-sfr/arch/mips/kernel/ptrace.c	2017-10-27 20:07:14.933716000 +01=
00
> @@ -618,6 +618,19 @@ static const struct user_regset_view use
>  	.n		=3D ARRAY_SIZE(mips64_regsets),
>  };
> =20
> +#ifdef CONFIG_MIPS32_N32
> +
> +static const struct user_regset_view user_mipsn32_view =3D {
> +	.name		=3D "mipsn32",
> +	.e_flags	=3D EF_MIPS_ABI2,
> +	.e_machine	=3D ELF_ARCH,
> +	.ei_osabi	=3D ELF_OSABI,
> +	.regsets	=3D mips64_regsets,
> +	.n		=3D ARRAY_SIZE(mips64_regsets),
> +};
> +
> +#endif /* CONFIG_MIPS32_N32 */
> +
>  #endif /* CONFIG_64BIT */
> =20
>  const struct user_regset_view *task_user_regset_view(struct task_struct =
*task)
> @@ -629,6 +642,10 @@ const struct user_regset_view *task_user
>  	if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
>  		return &user_mips_view;
>  #endif
> +#ifdef CONFIG_MIPS32_N32
> +	if (test_tsk_thread_flag(task, TIF_32BIT_ADDR))
> +		return &user_mipsn32_view;
> +#endif
>  	return &user_mips64_view;
>  #endif
>  }

--kUoBhQsr7LsiFken
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEeA0ACgkQbAtpk944
dnppcBAArJdLPfDyMAjul83SIqnSmdyw+m5aspJQF9tkVRxYsTCBkoNtdqflIu0L
pDdkd7bkanGjXnyMJ74d+t9NnOX6wCu7UlH9X59teXnVKkpqeTCdYiUzUX8Bh1/Z
dU4GwL/iaH7+/8NegkjRFuyCVjKnnas1WaZkFI4KLpjfKfQ2wu/Ifz6uvCe8YExQ
qe7Cou7F/M8xedAAon8IJkJq2y5fIPhH8MaMOmozq0vunCvcNHTG02p5VWpvYcoF
UR6m9cJafwTvqd5XP0oz7TPhChA6c0ZjdvIRahnKM3IPHJuK1+9j7D9/FvpjPPIW
6JYEg/LQiNxpPGWMgEdnLEjpDsNiCOIUuAjt6kCzENnAu7leuVbrZW+MM09zCAGj
12KHPnhM+IT2AVAQbS1n9HdrN2hvWitnu+XIf6Nmi5kliHtvNOZvzY54FNEezE2K
xjGuHXssLYRed1HkceKqUv2FH2GFPZgaXG224bakq+72/njzksywbE9+z8dZhLfB
zw9zSiqg50w4d0qlH4rNrUixKJjQRhmhMylVotcqtkmSvUE063/aiNSUmg4gE4BI
PJFwW2+WfcsBZVX4BvWhreYdY592VUpSJtHzaaTEuGleFdMdLxsJpgBRdJKzQoZC
hTyOXKrQS1HgSEzGRwU+YJ4s9hRiiJD/LeYs1/9QvDb14GQXJao=
=xOU6
-----END PGP SIGNATURE-----

--kUoBhQsr7LsiFken--

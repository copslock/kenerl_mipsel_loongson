Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 11:08:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63608 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991087AbdBNKIJg8BAh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 11:08:09 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D4DAE41F8EB7;
        Tue, 14 Feb 2017 11:11:59 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Feb 2017 11:11:59 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Feb 2017 11:11:59 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 499A3B8327A9D;
        Tue, 14 Feb 2017 10:08:00 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 10:08:02 +0000
Date:   Tue, 14 Feb 2017 10:08:02 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Disable stack checks on MIPS kernels
Message-ID: <20170214100802.GQ24226@jhogan-linux.le.imgtec.org>
References: <8d0e3484-c8bd-2559-0809-2631474a11f8@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O7Os1+MGCLLi8F5z"
Content-Disposition: inline
In-Reply-To: <8d0e3484-c8bd-2559-0809-2631474a11f8@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56802
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

--O7Os1+MGCLLi8F5z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 28, 2017 at 10:24:16PM -0500, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
>=20
> Disable stack checking on MIPS kernels.  Some distribution toolchains
> might pass the -fstack-check option to gcc.  This results in a
> store-doubleword instruction being emitted at the top of all
> functions that checks the available stack space.  E.g.,
>=20
>   a80000000001d740 <per_cpu_init>:
>   a80000000001d740:       ffa0bfc0        sd      zero,-16448(sp)
>   a80000000001d744:       2405ffc9        li      a1,-55
>   a80000000001d748:       67bdffc0        daddiu  sp,sp,-64
>=20
> Generally, this is undesirable, and especially on the SGI IP27
> platform, it will trigger a NULL pointer dereference in
> '_raw_spin_lock_irq' during early init.
>=20
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> Suggested-by: James Hogan <james.hogan@imgtec.com>

Applied

Thanks
James

> ---
>  arch/mips/Makefile |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> linux-mips-4.10-disable-stack-check.patch
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 1a6bac7b076f..6b2a30442105 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -131,6 +131,21 @@ cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+=3D $(shell $(CC=
) -dumpmachine |grep -q 'mips.
> =20
>  cflags-$(CONFIG_SB1XXX_CORELIS)	+=3D $(call cc-option,-mno-sched-prolog)=
 \
>  				   -fno-omit-frame-pointer
> +
> +# Some distribution-specific toolchains might pass the -fstack-check
> +# option during the build, which adds a simple stack-probe at the beginn=
ing
> +# of every function.  This stack probe is to ensure that there is enough
> +# stack space, else a SEGV is generated.  This is not desirable for MIPS
> +# as kernel stacks are small, placed in unmapped virtual memory, and do =
not
> +# grow when overflowed.  Especially on SGI IP27 platforms, this check wi=
ll
> +# lead to a NULL pointer dereference in _raw_spin_lock_irq.
> +#
> +# In disassembly, this stack probe appears at the top of a function as:
> +#    sd		zero,<offset>(sp)
> +# Where <offset> is a negative value.
> +#
> +cflags-y +=3D -fno-stack-check
> +
>  #
>  # CPU-dependent compiler/assembler options for optimization.
>  #
>=20

--O7Os1+MGCLLi8F5z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYotcCAAoJEGwLaZPeOHZ6vDcQAJrfMAYbcwASoYwFEiZiEG9+
aDfqj60FQDiEL3DpVn1kwSK+zjv+AG1ah8e+Iss0asJjVsEijx/ZxTrULYriMBYu
A4pAUeMCNlllB1dDMz07Y8nbNDawRlw0ZJuAob8oeIHQn53+KFmUt67tYIJC916a
5tLGlYVbtBnhFZNo9zs4wwZymNUJh8yyxFRP4QR/TrZQJsX4JO7WngCkkjXdOTbz
V+SyNeARiJibablsgMXr2vnCqqVzpMEl//Nv6rEjA5z2QKg58wd8isE/gQkCMigP
16CtlwYb3T+0Bkf7vJ4RcgpcSxPAcztNI8k+sVdax8pMukk2ZFAL9DXO9gLflrlp
uLoPRf/VUkn+g19qsNkCZIYHTnpmovvAO28vV8FFoKkAWRRch0ztPTsC0hPEp8fU
fcdYLe33+ga6Ybzur6UYmAokipO9tFq4VXaJMvEN5u9iJNDiSHnc6H/PPSj3DTQi
W7Wf/A27VwtTPAN+qZkdldvQqEEtDXUroY1Ugoi+EsFK2IHYj3qfnpCrJfy90OQk
gdfcCnZpSNiQ4OPml730VzLqe3XLb88dtExuGOmMaV6+p0Zr86wGKePI/OSX5zs1
t4Oycn5lxe58XiVaAis108Jpb+Ds86InwHcz9XewwC1Cioa5ZJ7HViCET94M3k5P
6PR/elYdj6zS+WndhE0E
=kUn+
-----END PGP SIGNATURE-----

--O7Os1+MGCLLi8F5z--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 00:26:52 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:45183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007473AbbBZX0vZ7JAO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Feb 2015 00:26:51 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 5A08C140134;
        Fri, 27 Feb 2015 10:26:49 +1100 (AEDT)
Date:   Fri, 27 Feb 2015 10:26:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco Gisbert <hecmargi@upv.es>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-ID: <20150227102644.18a0ea5f@canb.auug.org.au>
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
        <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
        <20150223205436.15133mg1kpyojyik@webmail.upv.es>
        <20150224073906.GA16422@gmail.com>
        <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; i586-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JZsPtul0qHP.DyqOMy=3Buf"; protocol="application/pgp-signature"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

--Sig_/JZsPtul0qHP.DyqOMy=3Buf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

[Just resending to correct addresses - sorry for those who get a duplicate]

On Thu, 26 Feb 2015 14:38:15 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> diff -puN fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mi=
ps-fix fs/binfmt_elf.c
> --- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-f=
ix
> +++ a/fs/binfmt_elf.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/personality.h>
>  #include <linux/elfcore.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/init.h>
>  #include <linux/highuid.h>
>  #include <linux/compiler.h>
> @@ -2300,6 +2301,26 @@ out:
> =20
>  #endif		/* CONFIG_ELF_CORE */
> =20
> +/* Not all architectures implement mmap_rnd() */
> +unsigned long __weak mmap_rnd(void)
> +{
> +}
> +
> +/*
> + * Not all architectures use randomize_et_dyn(), so use __weak to let the
> + * linker omit it from vmlinux
> + */
> +unsigned long __weak randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret =3D base + mmap_rnd();
> +	return max(ret, base);
> +}
> + =20

Didn't we have some trouble with some compilers when the weak function
(mmap_rnd) was defined and used in the same file i.e. the wrong one was
used?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/JZsPtul0qHP.DyqOMy=3Buf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU76u5AAoJEMDTa8Ir7ZwV3OYP/R3kSXgU9faFjJ0kYa9gM6J3
tATiGk7Jp3DBzaNnBaUFeNESWTAcX2ETWYkuBeYMZ7ktPllIC0GTZU4SiuDbXGHu
Y6fWYgc1nvhb3hJrgLu2srWMUmf9uEByRKUD7wzTbwjiPLBprsF//eTnfKGOTQGW
vIDxGlG992REN6bblat+o1RX6+OBhuo2LtY/AAIdAbQIi3u9EWumalOqbosNOUno
BAQgtf3cM/xkVsJdBzVrig4k5AQUOfyYEzqcmgeQPmBB+RMMSAKQVQK00VTsgqeL
g9KnWswQCYJY1982rccL9ROutS1PLpZuXaWyAfXS3jmYXoVgQPKRqcP9Rul1T5FG
mI6xfAXgjImzSIIU0vk0qwZB2SFSg6uXmqSyI5NW0sm3tCy0ghhSpq7Y83Z9+CKl
iqTAhSojSsu4NatMTfD/Hf7dCvHbjRpvEFOPQT5Ad0+mr7aM5TxAPNgWxb6Uh0UF
WVHKHbCVPwHa8YTVHT2CyryvsgfJF4xqV69TErIyDv2kxlmvpK4gz0pCkSK2SYcE
S6BLWNvUVyf84k9i+3iQ63TVhRhf53aE0nuS+u80NGoL2dRTHC/Miwsw/mbf0dWY
B/T8G+1RufgoZLwDm1KTgYlNylYQniRGxxSaAqDgYfmrnoQcMYb3ZRPgD7VveClu
AIWKqXUFcrv+GfmC5aVT
=nDKw
-----END PGP SIGNATURE-----

--Sig_/JZsPtul0qHP.DyqOMy=3Buf--

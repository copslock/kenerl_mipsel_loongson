Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2017 21:59:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58695 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990474AbdI2T7ejJ0vf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2017 21:59:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 32734DEC9422F;
        Fri, 29 Sep 2017 20:59:22 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Sep
 2017 20:59:26 +0100
Date:   Fri, 29 Sep 2017 20:59:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use SLL by 0 for 32-bit truncation in
 `__read_64bit_c0_split'
Message-ID: <20170929195925.GF17077@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1709291502060.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709291502060.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60202
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

--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2017 at 04:26:31PM +0100, Maciej W. Rozycki wrote:
> Optimize `__read_64bit_c0_split' and reduce the instruction count by 1,=
=20
> observing that a DSLL/DSRA pair by 32, is equivalent to SLL by 0, which=
=20
> architecturally truncates the value requested to 32 bits on 64-bit MIPS=
=20
> hardware regardless of whether the input operand is or is not a properly=
=20
> sign-extended 32-bit value.
>=20
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  Tested by compilation only to verify syntax correctnes as I do not know=
=20
> if this execution path is actually used by any configuration (suggestions=
=20
> welcome).  I believe it to be technically correct though, being=20
> sufficiently straightforward to verify by proofreading, and an obvious=20
> improvement.

Agreed, I did something similar locally too but didn't bother to submit
it :).

>=20
>  Therefore, please apply.
>=20
>  NB if this turns out indeed used, then we might have to do something=20
> about DMFC0 hazard avoidance for the sake of MIPS III support, and also
> choose to use an MFC0/MFHC0 instruction pair instead on MIPS64r5+.

This would have to depend on MVH bit, but in practice I suspect it isn't
worthwhile doing it here instead of in a separate macro to use depending
on the register.

Using MVH would have the advantage of avoiding the potential window when
a 32-bit EJTAG or Cache error handler potentially canonicalises register
state I suppose.

That's another advantage of this patch actually, it reduces the size of
that window to a single instruction.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
>   Maciej
>=20
> ---
>  arch/mips/include/asm/mipsregs.h |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> linux-mips-read-64bit-c0-split-sll.diff
> Index: linux-sfr-test/arch/mips/include/asm/mipsregs.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mipsregs.h	2017-07-08 15:32=
:02.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mipsregs.h	2017-09-29 01:02:01.3=
90974000 +0100
> @@ -1344,19 +1344,17 @@ do {									\
>  	if (sel =3D=3D 0)							\
>  		__asm__ __volatile__(					\
>  			".set\tmips64\n\t"				\
> -			"dmfc0\t%M0, " #source "\n\t"			\
> -			"dsll\t%L0, %M0, 32\n\t"			\
> -			"dsra\t%M0, %M0, 32\n\t"			\
> -			"dsra\t%L0, %L0, 32\n\t"			\
> +			"dmfc0\t%L0, " #source "\n\t"			\
> +			"dsra\t%M0, %L0, 32\n\t"			\
> +			"sll\t%L0, %L0, 0\n\t"				\
>  			".set\tmips0"					\
>  			: "=3Dr" (__val));				\
>  	else								\
>  		__asm__ __volatile__(					\
>  			".set\tmips64\n\t"				\
> -			"dmfc0\t%M0, " #source ", " #sel "\n\t"		\
> -			"dsll\t%L0, %M0, 32\n\t"			\
> -			"dsra\t%M0, %M0, 32\n\t"			\
> -			"dsra\t%L0, %L0, 32\n\t"			\
> +			"dmfc0\t%L0, " #source ", " #sel "\n\t"		\
> +			"dsra\t%M0, %L0, 32\n\t"			\
> +			"sll\t%L0, %L0, 0\n\t"				\
>  			".set\tmips0"					\
>  			: "=3Dr" (__val));				\
>  	local_irq_restore(__flags);					\

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnOphQACgkQbAtpk944
dnoJ/w//Ss5jJD7GR/mU6OCOmZXI6XAShsm7SqkirD3ew20oAqx3cUJ2Fd+tGx3G
X8pgTL5MiwRvQ5faxtcB3+Paiq/HnSwTLEyvDNJHR9VSfZZcdAHpwsb82+efSIK7
MUzteh90XBKIV/spW4jSyh2SUmPtMjcrTan1Voq3xxBRrTKbyLodBwszXkd8J/sf
PT0qBZk/Yc+kxQ1RqRLKvzHqnfMw5P1acnlaZ/+ARWNXoWtjSR3MlPWZDiC/SRlZ
kl+BGIfEOYFEKFmDfLO5b2iPRx2jIHYAbQgbWBPYpdnlr9DssYJP46k1I6sFJxqB
VhOxiRYZJwIvUbSav8eh4Q0JM9ln/HUU89a0MhcYUIWIhJhgEWGZN+3Nr36JOA1C
MuR1yaQip+29TkVXO3fZLEA53lzAV1BuFLAU2wAM+aPu4yQ6G33mN5bHfHLOzmFz
VQHJDAoQkDqevJMPH0FYuChxccN4dppyKOzvs2fm2tPiOdjnA06PnykmkHHnk0Vx
d8df6hMOzGVJzebV/110m66MIfm6295UGSy6pRKZod76pkl0l0KtNv/R3RNF7qvk
LzvWOgmp0xaanE/V/HglQNOvkwqxLelfEb0zaik85YQvuq/BzspKytZbdgbYead3
ROJ2Y3lVjA8ujYtQ5liOA8ZU9oJU5/yZgG8w/nHtZyywaZmjbjE=
=H9IQ
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--

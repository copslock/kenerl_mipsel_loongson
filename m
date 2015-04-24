Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 09:49:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62807 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010821AbbDXHtCyLgB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 09:49:02 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E2C7641F8E14
        for <linux-mips@linux-mips.org>; Fri, 24 Apr 2015 08:48:58 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 24 Apr 2015 08:48:58 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 24 Apr 2015 08:48:58 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5473C279BFF21
        for <linux-mips@linux-mips.org>; Fri, 24 Apr 2015 08:48:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Apr 2015 08:48:58 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 24 Apr
 2015 08:48:58 +0100
Date:   Fri, 24 Apr 2015 08:48:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: asmmacro: Ensure 64-bit FP registers are used
 with MSA
Message-ID: <20150424074857.GH10157@jhogan-linux.le.imgtec.org>
References: <1429178759-20562-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
Content-Disposition: inline
In-Reply-To: <1429178759-20562-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47019
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

--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 11:05:59AM +0100, Markos Chandras wrote:
> This silences warnings like the following one when building with the
> latest binutils:

It may be helpful to refer to the versions of binutils which are
affected in the commit message.

>=20
> arch/mips/kernel/genex.S: Assembler messages:
> arch/mips/kernel/genex.S:438: Warning: the `msa' extension requires 64-bi=
t FPRs
>=20
> Cc: James Hogan <james.hogan@imgtec.com>

Other than that,

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> Cc: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/asmmacro.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asm=
macro.h
> index 6156ac8c4cfb..76317a70200d 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -211,9 +211,13 @@
>  	.endm
> =20
>  #ifdef TOOLCHAIN_SUPPORTS_MSA
> +/* preprocessor replaces the fp in ".set fp=3D64" with $30 otherwise */
> +#undef fp
> +
>  	.macro	_cfcmsa	rd, cs
>  	.set	push
>  	.set	mips32r2
> +	.set	fp=3D64
>  	.set	msa
>  	cfcmsa	\rd, $\cs
>  	.set	pop
> @@ -222,6 +226,7 @@
>  	.macro	_ctcmsa	cd, rs
>  	.set	push
>  	.set	mips32r2
> +	.set	fp=3D64
>  	.set	msa
>  	ctcmsa	$\cd, \rs
>  	.set	pop
> @@ -230,6 +235,7 @@
>  	.macro	ld_d	wd, off, base
>  	.set	push
>  	.set	mips32r2
> +	.set	fp=3D64
>  	.set	msa
>  	ld.d	$w\wd, \off(\base)
>  	.set	pop
> @@ -238,6 +244,7 @@
>  	.macro	st_d	wd, off, base
>  	.set	push
>  	.set	mips32r2
> +	.set	fp=3D64
>  	.set	msa
>  	st.d	$w\wd, \off(\base)
>  	.set	pop
> @@ -246,6 +253,7 @@
>  	.macro	copy_u_w	ws, n
>  	.set	push
>  	.set	mips32r2
> +	.set	fp=3D64
>  	.set	msa
>  	copy_u.w $1, $w\ws[\n]
>  	.set	pop
> @@ -254,6 +262,7 @@
>  	.macro	copy_u_d	ws, n
>  	.set	push
>  	.set	mips64r2
> +	.set	fp=3D64
>  	.set	msa
>  	copy_u.d $1, $w\ws[\n]
>  	.set	pop
> @@ -262,6 +271,7 @@
>  	.macro	insert_w	wd, n
>  	.set	push
>  	.set	mips32r2
> +	.set	fp=3D64
>  	.set	msa
>  	insert.w $w\wd[\n], $1
>  	.set	pop
> @@ -270,6 +280,7 @@
>  	.macro	insert_d	wd, n
>  	.set	push
>  	.set	mips64r2
> +	.set	fp=3D64
>  	.set	msa
>  	insert.d $w\wd[\n], $1
>  	.set	pop
> --=20
> 2.3.4
>=20

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVOfVpAAoJEGwLaZPeOHZ6Ln8QAK1lPoEBL02zCfdIRAZfz7Pl
xu9F8VbBD0YzmlsGhpU/UclbJh9NzXfzMgenV4ZB/ZklYXn1nRGgLluj9xBVE0EA
+eusu6tzoi64n+BbjV1pUS7bF6FBatZCxfPTVvyYjufoIJaUdgeBh1iOc4wdYMEY
X0/G9pWNAptH/V0+tvUApZs/piLPjlF5AgUcA1d1iBbLovskNqmDTf8ghwRdehLK
B+QV7PCWyqTPJI343uajz4k2lXlOXynyWHYKyymE/6fO4vmh0rRw87qD8nVTmqak
pHTFk75l44dDeIGp8lSc+ry3lDmSo+SvrGZtR92FLZISXhuH2EkfOSa9NazqugH8
bKh10N992FOcfftfIOrjEnvteBJDWLk8eM1WFZfi7h5U1+vX03HpQ8b/NPfhuXi/
hjtqevjmdpV4+CuVkd/eWRDygHgS0U5DwLNK9STCSuwviBgBvtuofBv3NXT35VX3
Qw+FGvMnQn/mQIDKvp0Yz6dJDebsTwGd3n+nouvFRWczEZf2aof4sAzjQuH8GxI4
YtaE7qLuUyOMjd/kIx3AvJJ7XMStkmH0ZL7wcGpnHKrgviITlB0aTjZqyBrB2wPp
B37gbReGh424Hk0gf3ZelJivoO2KHBF7Aq0OulMy3IgJ65p3y9DXyEa7a/LvVtHl
nHHWfa0yy/r2/8OHQ04v
=p/Jf
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--

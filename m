Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 16:22:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33160 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009186AbcAFPWIijcKa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 16:22:08 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D122441F8EB1;
        Wed,  6 Jan 2016 15:22:02 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 06 Jan 2016 15:22:02 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 06 Jan 2016 15:22:02 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 0B4F311571339;
        Wed,  6 Jan 2016 15:22:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 6 Jan 2016 15:22:02 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 6 Jan
 2016 15:22:01 +0000
Date:   Wed, 6 Jan 2016 15:22:01 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Tony Wu <tung7970@gmail.com>
CC:     <ralf@linux-mips.org>, Qais Yousef <qais.yousef@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: VDSO: Fix binutils version test
Message-ID: <20160106152201.GC17861@jhogan-linux.le.imgtec.org>
References: <20160105151705-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hmb9n29fjuiORm2l"
Content-Disposition: inline
In-Reply-To: <20160105151705-tung7970@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50941
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

--Hmb9n29fjuiORm2l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, Jan 05, 2016 at 03:21:01PM +0800, Tony Wu wrote:
> Commit 2a037f310bab ("MIPS: VDSO: Fix build error") fixed the logic
> for testing binutils version, but introduced another issue.
>=20
> The ld-ifversion macro is defined as follows:
>=20
>   $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) || echo $(4))
>=20
> This macro checks ld version to echo $(3) or echo $(4) based on
> the given condition.
>=20
> It is called as follows in arch/mips/vdso/Makefile:
>=20
>   ifeq ($(call ld-ifversion, -lt, 22500000, y),)
>     $(warning MIPS VDSO requires binutils >=3D 2.25)
>     obj-vdso-y :=3D $(filter-out gettimeofday.o, $(obj-vdso-y))
>     ccflags-vdso +=3D -DDISABLE_MIPS_VDSO
>   endif
>=20
> Since $(4) is empty, echo $(4) will evaluate to a simple 'echo'. So, in
> case binutils version is indeed greater than 2.25.0, ld-ifversion macro
> will return a newline, not the empty string as expected, and that makes
> the test fail.
>=20
> This patch fixes the test condition.

See:
- http://patchwork.linux-mips.org/patch/11926/
  (now merged into mainline)
- http://patchwork.linux-mips.org/patch/11931/
  (in mips-for-linux-next / linux-next for v4.4)

Thanks
James
 =20
>=20
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Alex Smith <alex@alex-smith.me.uk>
>=20
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index 018f8c7..a54a082 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -26,7 +26,7 @@ aflags-vdso :=3D $(ccflags-vdso) \
>  # the comments on that file.
>  #
>  ifndef CONFIG_CPU_MIPSR6
> -  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
> +  ifneq ($(call ld-ifversion,-ge,22500000,y),y)
>      $(warning MIPS VDSO requires binutils >=3D 2.25)
>      obj-vdso-y :=3D $(filter-out gettimeofday.o, $(obj-vdso-y))
>      ccflags-vdso +=3D -DDISABLE_MIPS_VDSO
>=20

--Hmb9n29fjuiORm2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWjTEZAAoJEGwLaZPeOHZ6rqIQAI84r0QL4TjF7Qqwj4YpGjF8
soDWPLIzZSltQV/qF+vxPB613vM9AEOqTe4hTU6axpH9PgTgI6FXzeRg00qvzTZi
iYIn7qOPvQupJmKpPsRcevIVRm8A/o4pHhgd+DfagTU/ZxKD22bc0yop8elAnYyX
ceicsKif6gVJDJ8RimEhIXm7e125uqoIDeIKQyrM2Tohcuztd4b5BqER66mK0M5g
TEU3OoG/VvgUvHCXAiWXkxg15n8/FHGlFFkmwFkD8GnHbwfJmHyzaDecC+2nJmjR
0p1srNG3ay7hzpP05iGMj6CuC9h65Y4/n+i3O3R/Nix3FtTbHjO0tEYgrGR7znAd
ENLe2MCp+FP/jTDu+pAUzPRoDN3ZZAG1H9BS1QFGxV6vQnxQTuRZY7RuLEgsRdQU
k56K1J5heFGQSC6k+8Qb6c0Jt1GlA65B7a/I15PfA2V8Y2wWi092YYQDKNf6T+SC
LCLDBL3R5TBE2z2uK2/nkk7VHk44HV/Wrn9bjH8QQrhfhsZwcrMrzvCuiSJrMp5w
QSZHZ/rAR+hgeop/TJUo9pfW54rsAzUNMcguVudJGUAfI4Dmf+n1BFxvqCvLRXgp
jQoEgX5cR6k3CN5cNflSyyc+hVQVpeMzhapZZqa0GbVJxmY8fO0+QrBcEAwA4TG0
BwHtofNgGWUWbbT1vaj4
=2IR+
-----END PGP SIGNATURE-----

--Hmb9n29fjuiORm2l--

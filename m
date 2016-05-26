Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 14:03:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53835 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27034540AbcEZMDoBQZnG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 14:03:44 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 940C441F8E1B;
        Thu, 26 May 2016 13:03:38 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 26 May 2016 13:03:38 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 26 May 2016 13:03:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 1C36A5BC69912;
        Thu, 26 May 2016 13:03:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 26 May 2016 13:03:38 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 26 May
 2016 13:03:37 +0100
Date:   Thu, 26 May 2016 13:03:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Tejun Heo <tj@kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: VDSO: Build with `-fno-strict-aliasing'
Message-ID: <20160526120337.GE1145@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1605261239340.9344@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605261239340.9344@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53663
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

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2016 at 12:55:45PM +0100, Maciej W. Rozycki wrote:
> Avoid an aliasing issue causing a build error in VDSO:
>=20
> In file included from include/linux/srcu.h:34:0,
>                  from include/linux/notifier.h:15,
>                  from ./arch/mips/include/asm/uprobes.h:9,
>                  from include/linux/uprobes.h:61,
>                  from include/linux/mm_types.h:13,
>                  from ./arch/mips/include/asm/vdso.h:14,
>                  from arch/mips/vdso/vdso.h:27,
>                  from arch/mips/vdso/gettimeofday.c:11:
> include/linux/workqueue.h: In function 'work_static':
> include/linux/workqueue.h:186:2: error: dereferencing type-punned pointer=
 will break strict-aliasing rules [-Werror=3Dstrict-aliasing]
>   return *work_data_bits(work) & WORK_STRUCT_STATIC;
>   ^
> cc1: all warnings being treated as errors
> make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
>=20
> with a CONFIG_DEBUG_OBJECTS_WORK configuration and GCC 5.2.0.  Include=20
> `-fno-strict-aliasing' along with compiler options used, as required for=
=20
> kernel code, fixing a problem present since the introduction of VDSO=20
> with commit ebb5e78cc634 ("MIPS: Initial implementation of a VDSO").
>=20
> Thanks to Tejun for diagnosing this properly!
>=20

May I suggest adding:
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")

Patch looks good to me,
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> Cc: stable@vger.kernel.org # v4.3+
> ---
> linux-vdso-strict-aliasing.diff
> Index: linux-sfr-test/arch/mips/vdso/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/vdso/Makefile	2016-01-29 14:11:03.00000=
0000 +0000
> +++ linux-sfr-test/arch/mips/vdso/Makefile	2016-05-26 12:37:55.327782000 =
+0100
> @@ -8,7 +8,8 @@ ccflags-vdso :=3D \
>  	$(filter -march=3D%,$(KBUILD_CFLAGS))
>  cflags-vdso :=3D $(ccflags-vdso) \
>  	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
> -	-O2 -g -fPIC -fno-common -fno-builtin -G 0 -DDISABLE_BRANCH_PROFILING \
> +	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
> +	-DDISABLE_BRANCH_PROFILING \
>  	$(call cc-option, -fno-stack-protector)
>  aflags-vdso :=3D $(ccflags-vdso) \
>  	$(filter -I%,$(KBUILD_CFLAGS)) \
>=20

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXRuYZAAoJEGwLaZPeOHZ6mE4QAL2eUbqzyn7OAk8p/ORpPAqz
Hj6kW82uOLGbo1VTWppakDGYc9pcEnlLCur7vB1KNzEDcPb0qlWXfiKtsW29uJ/s
kiNa/BhljXsR2v4FyU/uNOu7XZf/P99CeVxqN41Q7YGNikunswQpTGwGY4VjS/AS
QES7GvHABSH8dgisEfxjidFf19SBJD5b7nmK8tuJADGJiBY3RRhSmNjgnpwFBjkN
KUcCWi3pWTGivkUngPBbq+SnF+rPO7+IwYoqs748Za18+/tJLFe3Tb9Zn+6FkChy
dRhn3gprHrKM2X8JdzoyD0FLlrfRwgL5elrF+fma18Y5MeWGtm7qO1/3rRF10UOi
7vvy4qmrbah/0rhYhAiGGyhoqKkyih6qIRoTVwPbvJS+cHVOxCDhxzNDq4Epew19
un0xn0RYZK/UecpSYpXCb65Phqwzb/k/qemeczIN4m7VxqvzLsDWlfB4FbNZuyyr
mmNGMNJrmn7TTRsQh2ICioCjgQsU6FZyZs3u2Glz5ayp06feNMKz1khQaf0RU2rl
nOpwAQo95WcFO2VYixWAcZemHPMbhQ0Ld0yW4xqwao2c7y+JKaW/9u+Es5QH1I5p
m9LSzuSH2G6NL6Ku0XK52n2iGzyMcg3elyk+4bQywe6UuzZ4oQRWea1xT05oBQke
8mLyLoPkj6kENCUyE96Y
=7nFo
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

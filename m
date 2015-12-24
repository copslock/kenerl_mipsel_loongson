Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2015 13:57:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14892 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008444AbbLXM5dM0UHa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2015 13:57:33 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9937441F8E73;
        Thu, 24 Dec 2015 12:57:27 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 24 Dec 2015 12:57:27 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 24 Dec 2015 12:57:27 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 934A8118DFDE1;
        Thu, 24 Dec 2015 12:57:25 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 24 Dec 2015 12:57:27 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 24 Dec
 2015 12:57:26 +0000
Date:   Thu, 24 Dec 2015 12:57:26 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "Andi Kleen" <ak@linux.intel.com>, Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH -next] MIPS: VDSO: Fix build error with binutils 2.24 and
 earlier
Message-ID: <20151224125726.GB5376@jhogan-linux.le.imgtec.org>
References: <1450933471-7357-1-git-send-email-linux@roeck-us.net>
 <20151224124812.GA5376@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20151224124812.GA5376@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50750
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

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2015 at 12:48:12PM +0000, James Hogan wrote:
> Hi Guenter,
>=20
> On Wed, Dec 23, 2015 at 09:04:31PM -0800, Guenter Roeck wrote:
> > Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a build
> > error seen with binutils 2.24 and earlier. However, the fix does not wo=
rk,
> > and again results in the already known build errors if the kernel is bu=
ilt
> > with an earlier version of binutils.
> >=20
> > CC      arch/mips/vdso/gettimeofday.o
> > /tmp/ccnOVbHT.s: Assembler messages:
> > /tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `L0=
 {.text section}
> > /tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - `L=
0 {.text section}
> > scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettimeof=
day.o' failed
> > make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
> >=20
> > Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
> > Cc: Qais Yousef <qais.yousef@imgtec.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Tested with binutils 2.25 and 2.22.
> >=20
> >  arch/mips/vdso/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> > index 018f8c7b94f2..14568900fc1d 100644
> > --- a/arch/mips/vdso/Makefile
> > +++ b/arch/mips/vdso/Makefile
> > @@ -26,7 +26,7 @@ aflags-vdso :=3D $(ccflags-vdso) \
> >  # the comments on that file.
> >  #
> >  ifndef CONFIG_CPU_MIPSR6
> > -  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
> > +  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
>=20
> I agree this is semantically correct, but there is something more evil
> going on here.
>=20
> Originally the check was version <=3D 2.24
> Qais' patch changed it to version >=3D 2.25 (intending version < 2.25)
> Your patch changes it to version < 2.25
>=20
> I think the reason this fixed the problem for Qais is actually that he
> probably had a similar toolchain version to what I'm using:
>=20
> GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90
>=20
> ./scripts/ld-version.sh does this:
>=20
> print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
>=20
> which changes that version number into:
>  20000000
> + 2400000
> +  900000 =3D 23300000
>=20
> I.e. it doesn't expect a[3] to be >=3D 10.
>=20
> Should we do something like this (increase multipliers on a[1] and
> a[2])?:
>=20
> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> index 198580d245e0..0b67edc5bc6f 100755
> --- a/scripts/ld-version.sh
> +++ b/scripts/ld-version.sh
> @@ -3,6 +3,6 @@
>  	{
>  	gsub(".*)", "");
>  	split($1,a, ".");
> -	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> +	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
>  	exit
>  	}
>=20
> which gives 2.24.90 =3D> 224900000.
>=20
> All call sites would need updating too to add the extra 0, but a quick
> git grep isn't showing any other ones than this one.

Actually, linux-next includes this commit which uses ld-ifversion too:

19a3cc83353e3bb4bc28769f8606139a3d350d2d
"Kbuild, lto: Add Link Time Optimization support v3"

Cheers
James

>=20
> Cheers
> James
>=20
> >      $(warning MIPS VDSO requires binutils >=3D 2.25)
> >      obj-vdso-y :=3D $(filter-out gettimeofday.o, $(obj-vdso-y))
> >      ccflags-vdso +=3D -DDISABLE_MIPS_VDSO
> > --=20
> > 2.1.4
> >=20
> >=20



--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWe+u2AAoJEGwLaZPeOHZ67UMQAL3fFCv47WamYoayDlDM9lAu
HunjFnKsDN8mLccKS7XUn1cD+/7UdD2gm/g2+6ieGsisOK8NdznhM7c+lF+3NJJs
nmAk3pFVsZh5gbXweVxSCCiRrgnQq3DZ9StgJjJQaocx28wQ9vYMRrvsMgsuf1D4
H5wDzAGxOm8D1RWqEcW/BgVAIaXFd4GFW1cSxlDMd4aVRHftWOwbp/fbE/3Z42Zl
GAbaegTTFJXMOnEKhuOlCVgi8+MCisZMsmuLRx6dOl2Abnz6D3ZrW7COfs3MIWAa
gdQxSIPNMdaVnDWbi1yQIUkZGi+Ab7QjSOJqLQNMyochyFEA0+QSFUUpBSQagJjx
vG4GIdWwB4zORWyH/NM1o8lvIVnQKMurToeTV/Wg23I9HY5ESBKL9b87fMmKQsk7
hO9B+IOCTp85+4tDtZY336YYoiXLEhW/HmuQ+FQL1U+iwOs9UEnkTrQpQ4eJ2VjU
l7Jg93Rw4fPQyW11sYIgW+BAq9N7PmXHh8fvr4oFlj9sbjEn/0EreDyFeCbzgPd9
w4bmGQwP1H1FJ3fM3LmkHaUxKCRF/D309Riy5RPTeFtYEL6YAJCbzw2wY2GOWyOV
7a9J0lltvpVaNryv2/DxddYE99/PbogISNTJc5PcnR28bis2aQhPGQN34IsSDcgM
VFuodZgKA5m5ivlK0OAu
=dpML
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

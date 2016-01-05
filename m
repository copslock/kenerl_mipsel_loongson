Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 11:06:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17123 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009111AbcAEKGgtLhdh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 11:06:36 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6525D41F8E95;
        Tue,  5 Jan 2016 10:06:31 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 05 Jan 2016 10:06:31 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 05 Jan 2016 10:06:31 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 90967BCAC58A0;
        Tue,  5 Jan 2016 10:06:29 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 5 Jan 2016 10:06:31 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 5 Jan
 2016 10:06:30 +0000
Date:   Tue, 5 Jan 2016 10:06:30 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Michal Marek <mmarek@suse.cz>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH -next] MIPS: VDSO: Fix build error with binutils 2.24 and
 earlier
Message-ID: <20160105100630.GA26905@jhogan-linux.le.imgtec.org>
References: <1450933471-7357-1-git-send-email-linux@roeck-us.net>
 <20151224124812.GA5376@jhogan-linux.le.imgtec.org>
 <20151224125726.GB5376@jhogan-linux.le.imgtec.org>
 <568B8AFB.1020403@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <568B8AFB.1020403@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50911
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

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 10:20:59AM +0100, Michal Marek wrote:
> On 2015-12-24 13:57, James Hogan wrote:
> > On Thu, Dec 24, 2015 at 12:48:12PM +0000, James Hogan wrote:
> >> Hi Guenter,
> >>
> >> On Wed, Dec 23, 2015 at 09:04:31PM -0800, Guenter Roeck wrote:
> >>> Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a bu=
ild
> >>> error seen with binutils 2.24 and earlier. However, the fix does not =
work,
> >>> and again results in the already known build errors if the kernel is =
built
> >>> with an earlier version of binutils.
> >>>
> >>> CC      arch/mips/vdso/gettimeofday.o
> >>> /tmp/ccnOVbHT.s: Assembler messages:
> >>> /tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `=
L0 {.text section}
> >>> /tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - =
`L0 {.text section}
> >>> scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettime=
ofday.o' failed
> >>> make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
> >>>
> >>> Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
> >>> Cc: Qais Yousef <qais.yousef@imgtec.com>
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>> Tested with binutils 2.25 and 2.22.
> >>>
> >>>  arch/mips/vdso/Makefile | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> >>> index 018f8c7b94f2..14568900fc1d 100644
> >>> --- a/arch/mips/vdso/Makefile
> >>> +++ b/arch/mips/vdso/Makefile
> >>> @@ -26,7 +26,7 @@ aflags-vdso :=3D $(ccflags-vdso) \
> >>>  # the comments on that file.
> >>>  #
> >>>  ifndef CONFIG_CPU_MIPSR6
> >>> -  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
> >>> +  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
> >>
> >> I agree this is semantically correct, but there is something more evil
> >> going on here.
> >>
> >> Originally the check was version <=3D 2.24
> >> Qais' patch changed it to version >=3D 2.25 (intending version < 2.25)
> >> Your patch changes it to version < 2.25
> >>
> >> I think the reason this fixed the problem for Qais is actually that he
> >> probably had a similar toolchain version to what I'm using:
> >>
> >> GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90
> >>
> >> ./scripts/ld-version.sh does this:
> >>
> >> print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> >>
> >> which changes that version number into:
> >>  20000000
> >> + 2400000
> >> +  900000 =3D 23300000
> >>
> >> I.e. it doesn't expect a[3] to be >=3D 10.
> >>
> >> Should we do something like this (increase multipliers on a[1] and
> >> a[2])?:
> >>
> >> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> >> index 198580d245e0..0b67edc5bc6f 100755
> >> --- a/scripts/ld-version.sh
> >> +++ b/scripts/ld-version.sh
> >> @@ -3,6 +3,6 @@
> >>  	{
> >>  	gsub(".*)", "");
> >>  	split($1,a, ".");
> >> -	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> >> +	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
> >>  	exit
> >>  	}
> >>
> >> which gives 2.24.90 =3D> 224900000.
> >>
> >> All call sites would need updating too to add the extra 0, but a quick
> >> git grep isn't showing any other ones than this one.
> >=20
> > Actually, linux-next includes this commit which uses ld-ifversion too:
> >=20
> > 19a3cc83353e3bb4bc28769f8606139a3d350d2d
> > "Kbuild, lto: Add Link Time Optimization support v3"
>=20
> That commit needs updating for other reasons, so feel free to fix
> ld-ifversion and its usage in arch/mips.

Thanks. This change is now in linux-next, and will hopefully be included
in v4.4:
http://patchwork.linux-mips.org/patch/11931/

Cheers
James

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWi5WmAAoJEGwLaZPeOHZ6g9YQAKGIYRRg7QjX2ZzBAmKk2jyb
Jj056iLKQJKzqI4LCb/3TVGG7G7Rx2z/9XKqeQEj1R52eypXqC7LQpfx573EAT2E
x32Mx/VVID225Um+AIkz83IwJL37o97azmVlvm8J4jXPM3zfkkw1hxeEmgwH9dqA
2wGM1Gw6tMMXiwImatUoLcR78O/Ewp7bP8SLAzh8HZa4SRWZVC5gwdBTTPttBS5y
CwnQJ699isya+k9IFEtsrAHem+196/Z1TH9G1qe19J1OoQ9+dijhHJqxJs4hWMnv
3dXoxLQ9ksSYGLIed5F6y2LjBdC1yhw+vZCt+q8N5SqXg2F3TPO1OokmjBFEnwQZ
AQBgk73VRcJBum3/j5rVx68VPIPTgzEiIALpNEGmMAi24fJ0/UXBB12tTEcy3Uj6
XmJtsQEPKqQKlkKBWKdYBP9B12UsjbJ9ghCB0yk/TSfFbOnfhm41V7SJ6MNMpu66
aZNo6Js6bCIXFW+Xk8nTbPCcMX8zHOzttlYTMRBZuNeFheK8dSj3apG0/W/sdIlU
S1pc4aSnbHfjjHpFp7uJeVQK3JjV+k7xDjg+2u0sYCMrG0joVMjfdbHkm3qFwKZm
vkcRlWHRyMhKzJKudPrtFQmvEANbpksDBt9PWT4boHJ+Z2BhnNpwqmqBgZYeC/Le
0IJodBUlnV3nspg9fPhd
=sEW7
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

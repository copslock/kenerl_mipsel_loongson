Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 13:07:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7320 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993179AbdGKLG6op2Gp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 13:06:58 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 18DC741F8E67;
        Tue, 11 Jul 2017 13:17:31 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Jul 2017 13:17:31 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Jul 2017 13:17:31 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D98DA27579D0E;
        Tue, 11 Jul 2017 12:06:49 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Jul
 2017 12:06:52 +0100
Date:   Tue, 11 Jul 2017 12:06:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix MIPS I ISA /proc/cpuinfo reporting
Message-ID: <20170711110652.GO6973@jhogan-linux.le.imgtec.org>
References: <alpine.LFD.2.20.1707082259380.5208@eddie.linux-mips.org>
 <20170711101746.GQ31455@jhogan-linux.le.imgtec.org>
 <alpine.LFD.2.20.1707111149220.2054@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6PUEI5/nYziPl3wQ"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1707111149220.2054@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59093
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

--6PUEI5/nYziPl3wQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 11:56:08AM +0100, Maciej W. Rozycki wrote:
> On Tue, 11 Jul 2017, James Hogan wrote:
>=20
> > On Sat, Jul 08, 2017 at 11:24:44PM +0100, Maciej W. Rozycki wrote:
> > > Cc: stable@vger.kernel.org # 3.19+
> > > Fixes: 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support to /pro=
c/cpuinfo")
> >=20
> > That commit landed in v4.0-rc1, not 3.19.
>=20
>  Hmm:
>=20
> $ git show 515a6393dbac:Makefile | head -5
> VERSION =3D 3
> PATCHLEVEL =3D 19
> SUBLEVEL =3D 0
> EXTRAVERSION =3D -rc4
> NAME =3D Diseased Newt
> $=20
>=20
> I just trusted that.

Yeh, thats the release its based on, not the release it was first merged
into, usually the subsystem branch for the next release is based on one
of the rc's of the previous release.

I have this slow hack in my ~/.gitconfig:
[alias]
	tc =3D tag --contains
	vc =3D "!vc() { for i in `git tc \"$@\" | grep '^v'`; do echo \"$(git log =
-1 --pretty=3D'%ct' $i) $i\"; done | sort -n | head -n1 | sed 's/^[0-9]* //=
g'; }; vc"

Then:
$ git vc 515a6393dbac4f4492237c7b305bbf9c4c558a1c                          =
                                                                    =20
v4.0-rc1

You can do something sort of similar with git describe --contains:

$ git describe --contains 515a6393dbac4f4492237c7b305bbf9c4c558a1c
v4.0-rc1~4^2~26^2~34

But if you have other tags in your tree between the commit and an
upstream release it'll sometimes show that instead which isn't very
helpful.

>=20
> > Most stable tags with comments also have square brackets around the
> > email too, i.e.:
> > Cc: <stable@vger.kernel.org> # 4.0+
> >=20
> > (though maybe thats just not to confuse git-send-email).
>=20
>  It doesn't seem so obvious, it looks fairly random to me.  If you say=20
> it helps, then I can adjust -- any pointers to a previous discussion?

No idea, just a random observation.
Documentation/process/stable-kernel-rules.rst uses <>, but also has a
weird version comment format more like below which I'm not too keen on:

Cc: <stable@vger.kernel.org> # 4.0.y-

Cheers
James

>=20
> > Otherwise:
> > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> >=20
> > Nice catch!
>=20
>  Thanks for your review.  I actually spotted it visually in the course=20
> of the recent Octeon ISA level discussion, before verifying the fix with=
=20
> actual hardware.
>=20
>   Maciej

--6PUEI5/nYziPl3wQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllksUsACgkQbAtpk944
dnp89RAArx9XdNyTDbQXI5XOgNevfs6cu+/iA5GvhDMJJ0QSodQ2PwCvMuNSUS1a
6IKZWu/EWFSfASrv5S1XZdRu8qL8bmWTKdNSW8gl4JSCSUkEPDg1Qe4yiVkcxjx7
C/2T3lKzcVSTOCVjVFQXmLqmr92xLKH6pp3PPC2fssl2usjlzp3ncm/4MhSRbStL
LOE1XvAAJF0SPA0brXNQETBZybO964PNOI5fg3YSbIdK48Hh+NA7CCDpQdFhyc4X
EeWKyvJhYXqmhpAIsAuerq3HF/YRbz4MLcAjdazlK/FdYizsv46hwgvaAVC+tNAe
LtSSzan3+dCPiL2DWmPd+o4hgT93I0Hy5bzQJUI9gcEbtNWN1pJbUiIQe15Jv7jl
zBHSLWPd0T5wszeBkJYTZ67rM4yz/8d7FwbhjOw/4WKLoH0UQHKmHABx/9Dj6D9k
XhDsol2APJ5iMjbiHhNRdvAvR6zBlb6zbkSI5PH5PRunoN/OoyUQYDfF+I6khgG5
yfYwKB8VNN67QPRFjutmLtslJqUrUeHPScmN6IZMe94TW02d1JXH/+d37dSuMdnG
uyYY2BYeIvRJPo9lKgOyluQsbAeOJ96mpVtLzVLuPfvZfmlzNiivQzexII5uSIGp
qjqc4LzmYkGWEiHrE0sivytYcL19UDHwMY5xDcOGMx6pVnd2Vx8=
=oufJ
-----END PGP SIGNATURE-----

--6PUEI5/nYziPl3wQ--

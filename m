Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 09:14:35 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:54162 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007403AbbBZIOdrUJfu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Feb 2015 09:14:33 +0100
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 720113407A3;
        Thu, 26 Feb 2015 08:14:25 +0000 (UTC)
Date:   Thu, 26 Feb 2015 03:14:25 -0500
From:   Mike Frysinger <vapier@gentoo.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: custom kernel on lemote-3a-itx (Loongson-3A) crashes in userspace
Message-ID: <20150226081425.GR6655@vapier>
References: <20150219194617.GT544@vapier>
 <CAAhV-H5+kQm_qAz7DLV4Rk9EqB4xJjmu1NV7kKd46aneKFZO-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aTHdXM4WpLndGb15"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5+kQm_qAz7DLV4Rk9EqB4xJjmu1NV7kKd46aneKFZO-A@mail.gmail.com>
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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


--aTHdXM4WpLndGb15
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26 Feb 2015 15:47, Huacai Chen wrote:
> Please try the toolchain here:
> http://dev.lemote.com/files/resource/toolchain/cross-compile/

thanks, but that's kind of dodgy and kind of defeats what i'm going for ;)
 - looks like binary-only
 - they're x86_64 binaries (i'm doing everything native here, so mips/n32)
 - is pretty old (gcc-4.5 / gcc-4.6 / binutils-2.21 / binutils-2.22)

that said, i installed Debian/mipsel(o32) into a chroot.  building with the=
 same=20
sources & configs yielded a kernel that seems to be running OK -- i'm on=20
mainline linux-3.19 now.  it too has an old toolchain: binutils-2.22 and=20
gcc-4.6.4.  i guess there's a miscompilation / the kernel sources have prob=
lems=20
with newer gcc versions.

installing older binutils in Gentoo was pretty easy, but trying to do gcc-4=
=2E6=20
ran into an ICE while bootstrapping.  but at least it'll be easy to rule ou=
t=20
weird assembler/linker problems.

might try to put together a script to rebuild the objects one-by-one with t=
he=20
newer compiler to try and narrow down the problem in the source.
-mike

--aTHdXM4WpLndGb15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU7tXgAAoJEEFjO5/oN/WBNzgP/1LagKIJgZCiJNtV7/4ZWyvy
Nx/3YYxLCWERLeAbHKcZu19GhpPLELIvcQIZBtgsoDCBtbhbupCeKe78GEMt7tgB
JYtzZ53QmkCXCS4bkM7hRbr2dwaHVw19Q+dClsXGN5m4iE/HKbvxqsT4cVb4zzoH
Obc165ZcffxaNRuffESgKn/NH5SgZkBdzwkxIylumqMJJGQyPZN+L6gG34bi4ENS
fnQzjPNgNz654zUuho4UXg34/Xfoqo5qgA4dJrC1YkMBGGj2Wzp62TKrNBctD9SZ
lXjy+kvUCdZJ7tI1CNoUseSo0AW3n9sdsEoLwNhJ8k8b3flWt90SAvPUdJdlIGOE
d3FFmyRLk/mkzAOrXBed/VdP+L0u7WKHHBmuvPDPcqiZGysSS2NphDXUZ3AIR64F
s0lbjoT349Zq0QhmaxmnSGuAwqvuY2u/YxB6WByGeXjUR1TuFGuji2nL08asT+eX
ecf6GmfAhAPveQkhEyaNmSKmzgKE0vSl/GhJJ7v6iOscuX/T31CsdWblU5s7jNFx
X6HOhzS1pvx9h1k8q+TFwtEdSJsACIHBLHqAbYFeXOef5e91/9G0/wVumobLvzvQ
9fZa1AwQ3/Rxku3OEBsVhC/UbkA/aujwcbqAPaCUNy5EkL8qWJJoetcltztPiPB8
JYjWvtMJp8cjzH3G3Pu3
=IDpw
-----END PGP SIGNATURE-----

--aTHdXM4WpLndGb15--

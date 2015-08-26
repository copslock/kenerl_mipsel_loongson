Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 19:10:31 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:59486 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007866AbbHZRK3Swyts (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Aug 2015 19:10:29 +0200
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id A5238340B3F;
        Wed, 26 Aug 2015 17:10:17 +0000 (UTC)
Date:   Wed, 26 Aug 2015 13:10:17 -0400
From:   Mike Frysinger <vapier@gentoo.org>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     libc-alpha@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: siginfo.h: add SIGSYS details [BZ #18863]
Message-ID: <20150826171017.GD3116@vapier>
Mail-Followup-To: Joseph Myers <joseph@codesourcery.com>,
        libc-alpha@sourceware.org, linux-mips@linux-mips.org
References: <1440563342-5411-1-git-send-email-vapier@gentoo.org>
 <alpine.DEB.2.10.1508260918240.26898@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1508260918240.26898@digraph.polyomino.org.uk>
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49027
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


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26 Aug 2015 09:30, Joseph Myers wrote:
> On Wed, 26 Aug 2015, Mike Frysinger wrote:
> > Linux 3.13 added SIGSYS details to siginfo_t; update glibc's copy to
> > keep in sync with it.
> >=20
> > 2015-08-25  Mike Frysinger  <vapier@gentoo.org>
> >=20
> > 	[BZ #18863]
> > 	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h (siginfo_t): Add _sigsys.
> > 	(si_call_addr): Define.
> > 	(si_syscall): Define.
> > 	(si_arch): Define.
>=20
> OK.  CC to linux-mips because I see that the MIPS implementation of=20
> copy_siginfo_to_user32 doesn't handle __SI_SYS, unlike arm64 at least, so=
=20
> I suspect this won't in fact work for n32 or for o32 with a 64-bit kernel.

i'm getting reports of seccomp misbehavior on mips already which is what
started me down this glibc path.  i suspect the original port was tested
against o32 kernels only.
-mike

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3fL5AAoJEEFjO5/oN/WBwYUP/jF24AWcXXzo6k4d3kmuSTA+
oq/NGGNRq48GPWdb/u/aL6jdYbArAg9t9cjTbcmacNBOyvVTb5AEO/qQiBAZtPXK
h/y5NzujyhUd0VP+fS9OemsJ4JD3ZlWycdgFcQTbuFej833+X0fcvptfoQ7BofAX
E0H/UKp2IiS6j1Tmwp4TiYSnJeuEF1xw44U5rCuoZF0d0mL20e10yBGaimrAP+jN
DYw6ehcyHjNDay6DGURG8Ad8HnnJpz4ikD5h7zWHJv9lIO5W6M1mmJRviWVRv59h
XKONUth5LNDb5xgdmIEyezqGJh3Gx85LeUSaoKP3wgNdag19yloAvkdLfRDz3ROa
UPmrZUDmuqoyoRNIYbknFHjKXgEWvEdqted4PkWsf0H+WNr+TbFemgDkeJyA0kKP
4BV9j2qMHVUYWqhc2y8A6IfHkzbF6mHogztCo9isTu+YGefE62Vq9tZ4SpC3BOWW
mpGqBSh4LnWB7IIOuQOcvFabnvbjaLtBHLslfMh/UYlCaoMuXmV94Hj9595sd/wM
ZYQ+hVK2CXGs0nEWTgOgGanB2eMBNFn+n0W0lmq6Mk2Kr47ubIMHWHTH5MyXOv1E
UoKF3fNGxNGNyD8S9mXx4FJBHjtVkj4/MHQol3dcUkRTrruc64QUQ+LruTejI8Fz
bCiHR4bCQWqWNjhjIgFH
=dX7z
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

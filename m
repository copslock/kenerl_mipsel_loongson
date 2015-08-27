Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 00:09:20 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:34208 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007618AbbH0WJNv9708 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Aug 2015 00:09:13 +0200
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 8A331340AD7;
        Thu, 27 Aug 2015 22:09:04 +0000 (UTC)
Date:   Thu, 27 Aug 2015 18:09:04 -0400
From:   Mike Frysinger <vapier@gentoo.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Joseph Myers <joseph@codesourcery.com>, libc-alpha@sourceware.org,
        linux-mips@linux-mips.org, kumba@gentoo.org
Subject: Re: [PATCH] mips: siginfo.h: add SIGSYS details [BZ #18863]
Message-ID: <20150827220904.GD29734@vapier>
Mail-Followup-To: Markos Chandras <Markos.Chandras@imgtec.com>,
        Joseph Myers <joseph@codesourcery.com>, libc-alpha@sourceware.org,
        linux-mips@linux-mips.org, kumba@gentoo.org
References: <1440563342-5411-1-git-send-email-vapier@gentoo.org>
 <alpine.DEB.2.10.1508260918240.26898@digraph.polyomino.org.uk>
 <20150826171017.GD3116@vapier>
 <55DEC3B9.1070105@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <55DEC3B9.1070105@imgtec.com>
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49058
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


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Aug 2015 09:00, Markos Chandras wrote:
> On 08/26/2015 06:10 PM, Mike Frysinger wrote:
> > On 26 Aug 2015 09:30, Joseph Myers wrote:
> >> On Wed, 26 Aug 2015, Mike Frysinger wrote:
> >>> Linux 3.13 added SIGSYS details to siginfo_t; update glibc's copy to
> >>> keep in sync with it.
> >>>
> >>> 2015-08-25  Mike Frysinger  <vapier@gentoo.org>
> >>>
> >>> 	[BZ #18863]
> >>> 	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h (siginfo_t): Add _sigs=
ys.
> >>> 	(si_call_addr): Define.
> >>> 	(si_syscall): Define.
> >>> 	(si_arch): Define.
> >>
> >> OK.  CC to linux-mips because I see that the MIPS implementation of=20
> >> copy_siginfo_to_user32 doesn't handle __SI_SYS, unlike arm64 at least,=
 so=20
> >> I suspect this won't in fact work for n32 or for o32 with a 64-bit ker=
nel.
> >=20
> > i'm getting reports of seccomp misbehavior on mips already which is what
> > started me down this glibc path.  i suspect the original port was tested
> > against o32 kernels only.
> > -mike
> >=20
>=20
> I have recently tested mips64 n64/n32 with the testsuite from libseccomp
> and that led me to this fix
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D9f161439e4104b641a7bfb9b89581d801159fec8
>=20
> if you are aware of other problems (and perhaps a test to trigger them)
> that could be kernel related let me know

i was waiting on kumba to file a bug, and recover my mips box when i got
local access to it again to check another report.  but if libseccomp is
passing its unittests now as n64/n32 userland, i think that should cover
things.
-mike

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV34qAAAoJEEFjO5/oN/WBs6YQAIb/EIy7Xe3OWgdsuEdvdpBI
mV5l6PDGicoGoxVwiSDbcIsOaiGaTI4FHyet9FWV90C5P/pnUu5jCdCK/SgCnkjP
MIBZDwYsQVbo9P5wFATsMk4fZ1wX01sbi3YfbSgYw9ZZ9BSGZyJM1JXhaYWEnQ3x
hbvNRHAipw9IToXUJ59Vc8F+ZQKyUsgacbLy7ljL/7eAia93/sVklrAdo8Om/yBs
HF5RYngdMOY+FWKRxW3DcdXrh7RcWNydjooxKqI1HdI9TB/OspHBkU3wv7gY+/7E
0DMrE5irvsQggHGQhs87gWKdcyXoIgxLMsnc4GvnQx2vYK5tTCkjNY33d+gOaDAr
in9KD27nr7QkI6gn7UljN1m6REfCpmGm4ZzFx2jbFK9cMG8RaWzEqWKwnqTr3CnW
E257yHAESuDYZGPG+iG2fngSLJ1JcI5ZlqlFiiFffJt5DKOdyQ1AfNg7XJFgi9M8
bB8X//+4vGSYH9VrJndu6gSQ8CnWl6FLqrmZ4xyZ97P6q3iSBxZvFVz84hagHoyy
/v0biMUdKhUFfW+lwzJAY4pmLaDKyfvvkSFnBuA9/hkETGC6aDBTVnTE0OeY6yiN
OJ6x08hwz7mIOQ4qhTFYcL3q++554FZU8wRDOYv+NkfYrQuSOJMbsXfICvLxfVNX
6HhF6O0L7sCsfPypFIwm
=HDGg
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

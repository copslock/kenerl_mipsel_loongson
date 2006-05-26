Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 09:28:54 +0200 (CEST)
Received: from h081217049130.dyn.cm.kabsi.at ([81.217.49.130]:40417 "EHLO
	phobos.hvrlab.org") by ftp.linux-mips.org with ESMTP
	id S8133468AbWEZH2q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 09:28:46 +0200
Received: from mini.intra (dhcp-1432-30.blizz.at [213.143.126.4])
	(authenticated bits=0)
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-3sarge1) with ESMTP id k4Q7SfHv024024
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 26 May 2006 09:28:41 +0200
Subject: Re: how does these two instruction mean?
From:	Herbert Valerio Riedel <hvr@gnu.org>
To:	Bin Chen <binary.chen@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <5800c1cc0605252319l1fe2954amcd649fd4798259a2@mail.gmail.com>
References: <5800c1cc0605252319l1fe2954amcd649fd4798259a2@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Eq0C76xjlQzHa/aaVih+"
Organization: Free Software Foundation
Date:	Fri, 26 May 2006 09:20:40 +0200
Message-Id: <1148628040.2150.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-Virus-Scanned: ClamAV 0.88.2/1485/Thu May 25 21:29:05 2006 on phobos.hvrlab.org
X-Virus-Status:	Clean
Return-Path: <hvr@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@gnu.org
Precedence: bulk
X-list: linux-mips


--=-Eq0C76xjlQzHa/aaVih+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 at 14:19 +0800, Bin Chen wrote:
> In my program the gcc produce two lines of binary code:
>=20
> 100020e0:       ffc20000        sd      v0,0(s8)
> 100020e4:       dfc20000        ld      v0,0(s8)
>=20
> first store v0->[s8], then load from [s8]->v0, why?

without knowing the source-code that got compiled it's guessing...

and I'd guess that [s8] might have been marked as a volatile location
(assuming the compiler isn't set to dumb-mode wrt to optimization ;-)

e.g. a code like the following=20

extern int cb(void);

int set(volatile int *p)
{
  return *p =3D cb();
}

will lead to something similar to the fragment below (with s0 being the
pointer p):

[..]
  38:   ae020000        sw      v0,0(s0)
  3c:   8e020000        lw      v0,0(s0)
[..]

regards,
hvr

--=-Eq0C76xjlQzHa/aaVih+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEdqxHSYHgZIg/QUIRAmLNAJ9aYiVRSnr9F4A+LhZOVB8pSCYL1ACeIq48
Q+6zs8VJ6u0iNAVUEsVBupE=
=iTAC
-----END PGP SIGNATURE-----

--=-Eq0C76xjlQzHa/aaVih+--

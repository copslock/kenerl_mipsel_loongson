Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 08:12:20 +0000 (GMT)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:38157 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8224939AbTBMIMU>;
	Thu, 13 Feb 2003 08:12:20 +0000
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8CE3425E9C; Thu, 13 Feb 2003 09:12:18 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0110FB2AB; Thu, 13 Feb 2003 09:10:14 +0100 (CET)
Date: Thu, 13 Feb 2003 09:10:14 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030213081014.GA569@paradigm.rfc822.org>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com> <20030211224622.GC1186@paradigm.rfc822.org> <20030212050341.GI8408@pureza.melbourne.sgi.com> <20030212152620.GB7934@paradigm.rfc822.org> <20030212225823.GJ8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20030212225823.GJ8408@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2003 at 09:58:23AM +1100, Andrew Clausen wrote:
> On Wed, Feb 12, 2003 at 04:26:20PM +0100, Florian Lohoff wrote:
> > > Am I missing something?
> >=20
> > Yes - That you dont need all those objects in that archive.=20
>=20
> But how does that help?  It's painful to merely build the set
> of objects we need.  (That would involve e2fsprogs makefile hacking...
> i.e. not just reusing it out-of-the-box)  But it's absolutely necessary,
> because it's impossible to build all the other objects for mips64 today.
>=20
> So, are you doing the Makefile hacking, or what?
>=20

I havent got any mips64 equipment yet and even less time. I guess until
we have a real mips64-glibc we will need to put the kernel into the
volume-header.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+S1LmUaz2rXW+gJcRAiQZAKCgKyLl/rVNqLknH9rrvoVTeloHdACgueH7
+JQD2flKZh1CjqmkPb3zTHs=
=aKK0
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
